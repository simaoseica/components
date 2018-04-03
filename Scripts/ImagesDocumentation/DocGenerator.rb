require 'erb'
require 'uri'

class DocGenerator

  GITHUB_PROJ_PATH = "https://github.com/Farfetch/ff-os-shopfloor/blob/dev"

  def initialize(erb_file)
    @erb_file = erb_file

    @current_path = Dir.pwd
    @componentSnapshotsFolder = File.expand_path("../../../ShopfloorSnapshotTests/Common/Images/Expected_64/", @current_path)
    @componentsFolder = File.expand_path("../../../Shopfloor/", @current_path)

  end

  def process

    @erb_file = 'images.html.erb'
    html_file = File.basename(@erb_file, '.erb')

    erb_str = File.read(@erb_file)

    Dir.chdir(@componentSnapshotsFolder)

    folders = Dir.glob('*').select do |f|
      File.directory? f
    end

    @components = folders.sort.map do |folder|
      {
        name: folder,
        images: images_for(folder),
        code_path: github_path_for(folder)
      }
    end

    Dir.chdir(@current_path)
    renderer = ERB.new(erb_str)
    result = renderer.result(binding)

    File.open(html_file, 'w') do |f|
      f.write(result)
    end
  end

  def images_for folder
    github_url = "#{GITHUB_PROJ_PATH}/ShopfloorSnapshotTests/Common/Images/Expected_64/"

    Dir.chdir(@componentSnapshotsFolder)

    images = Dir.glob("#{folder}/*.png")

    images.map do |i| {
      name: i.partition('/').last.partition('@2x.png').first,
      path: "#{github_url}#{i}?raw=true",
    }
    end
  end

  def github_path_for component

    Dir.chdir(@componentsFolder)

   #  p Dir.glob("**/#{component}.swift").first.partition('/').last.partition('/').last

   # "#{GITHUB_PROJ_PATH}/Shopfloor/Components/Title/TitleComponent.swift"


    path = URI::encode(Dir.glob("**/#{component}.swift").last)
    "#{GITHUB_PROJ_PATH}/Shopfloor/#{path}"

  end
end

DocGenerator.new('images.html.erb').process








