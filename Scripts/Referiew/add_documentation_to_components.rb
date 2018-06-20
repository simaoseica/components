#!/usr/bin/ruby
#encoding: utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'erb'
require 'uri'
require 'pathname'

class Component

  attr_accessor :name, :project_path, :file_path, :snapshots_path, :test_cases, :github_snapshots_url

  def initialize(project_path, snapshot_folder, github_snapshots_url)

    self.project_path = project_path

    self.name = File.basename(snapshot_folder)

    self.test_cases = test_cases_in(snapshot_folder)

    self.file_path = _file_path

    self.snapshots_path = snapshot_folder

    self.github_snapshots_url = github_snapshots_url
  end

  def valid?
    !name.to_s.empty? && test_cases.any? && !file_path.to_s.empty?
  end

  def x_code_url_line_for test_case
    "[#{test_case}]: #{github_snapshots_url}/#{name}/test#{test_case}@2x.png \"#{test_case}\""
  end

  private

  def test_cases_in(snapshot_folder)
    component = File.basename(snapshot_folder)

    Dir.glob("#{snapshot_folder}/*").map do |snapshot|
      n = File.basename(snapshot, '@2x.png')
      n_without_same_name = n.gsub("test", "").gsub(self.name, "")

      if n_without_same_name.empty? 
        n
      else
        n_without_same_name 
      end
    end
  end

  def _file_path
    Dir.glob("#{project_path}/Shopfloor/**/#{self.name}.swift").first
  end

end

class AddDocumentationToComponents

  TEMPLATE_FILE = "component_header_doc_template.erb"

  attr_accessor :project_path, :github_snapshots_url, :snapshot_folders, :renderer

  def initialize options

    5.times { p "#{'!' * 23}#{'!' * self.class.name.length}#{'!' * 23}" }
    p "#{'!' * 23} #{self.class.name} #{'!' * 23}"
    5.times { p "#{'!' * 23}#{'!' * self.class.name.length}#{'!' * 23}" }

    self.project_path = options[:project_path]

    snapshots_dir = "#{project_path}/#{options[:snapshots_path]}"

    self.github_snapshots_url = "#{options[:github_repo_branch]}/#{options[:snapshots_path]}"

    self.snapshot_folders = Dir.glob("#{snapshots_dir}/*")

    self.renderer = template_renderer "#{Dir.pwd}/scripts/Referiew/#{TEMPLATE_FILE}"
  end

  def process

    snapshot_folders.each do |snapshot_folder|
      handle snapshot_folder
    end
  end

  private

  def handle snapshot_folder

    @component = Component.new(project_path, snapshot_folder, github_snapshots_url)

    return unless @component.valid?

    result = @renderer.result(binding)

    temp_file_name = "./temp_file"
    create_temp_file_with_updated_docs temp_file_name, result, @component

    File.open(@component.file_path, 'w') do |f|
       f.write(File.read(temp_file_name))
    end

    File.delete(temp_file_name)
  end

  def create_temp_file_with_updated_docs temp_file_name, docs, component

    File.open(temp_file_name, "w") do |temp_file|

      read_and_update(temp_file, component, docs)
    end
  end

  def read_and_update file, component, docs

    state = "BEFORE_DOCS"

    File.foreach("#{component.file_path}").each_with_index do |line, line_number|

      if line.include?("// DOC")
        state = "IN_DOCS"
        next
      end

      if line.include?("class #{component.name}")
        file.puts docs
        state = "AFTER_DOCS"
      end

      next if state == "IN_DOCS"

      file.puts line

    end

  end

  def template_renderer(file)
    ERB.new(File.read(file))
  end
end
