#!/usr/bin/ruby
#encoding: utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'erb'
require 'uri'

class DocGenerator

  attr_accessor :project_path, :template_file, :snapshots_path, :github_path, :snapshots_reference_path

  def initialize(options)
    @template_file = "#{options[:project_path]}/#{options[:template_path]}"
    @snapshots_path = "#{options[:project_path]}/#{options[:snapshots_path]}"
    @snapshots_reference_path = options[:snapshots_path]
    @github_path = options[:github_repo_branch]
    @project_path = options[:project_path]
  end

  def process

    Dir.chdir(snapshots_path)
    component_folders = all_folders_in_directory

    @components = component_folders.sort.map do |component_folder|
      {
        name: component_folder,
        images: images_for(component_folder),
        code_path: github_path_for(component_folder)
      }
    end

    create_html
  end

  private

  def all_folders_in_directory

    Dir.glob('*').select { |f| File.directory? f }
  end

  def images_for folder
    github_url = "#{github_path}/#{snapshots_reference_path}/"

    Dir.chdir(snapshots_path)

    images = all_png_in folder

    images.map do |i| {
      name: i.partition('/').last.partition('@2x.png').first,
      path: "#{github_url}#{i}?raw=true",
    }
    end
  end

  def all_png_in folder
    Dir.glob("#{folder}/*.png")
  end

  def github_path_for component
    p component
    p swift_files_named component

    p "ColorsTests.ColorViewSnapshots"
    p



    Dir.chdir(project_path)
    path = URI::encode((swift_files_named component.sub("ColorsTests.", "").sub("Snapshots", "")).last)
    "#{github_path}/#{path}"
  end

  def swift_files_named name
    Dir.glob("**/#{name}.swift")
  end

  def create_html

    erb_str = File.read(template_file)

    renderer = ERB.new(File.read(template_file))
    result = renderer.result(binding)

    template = File.basename(template_file, '.erb')

    File.open("#{File.dirname(template_file)}/../html/#{template}", 'w') do |f|
      f.write(result)
    end
  end
end
