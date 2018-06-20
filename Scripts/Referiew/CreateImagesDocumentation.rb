#!/usr/bin/env ruby
#encoding: utf-8

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require_relative 'lib/ConsoleInputArguments/processor'
require_relative 'lib/DocGenerator'
require_relative 'add_documentation_to_components'

$options = {}

if ENV["CREATE_IMAGE_DOCS"]
	ConsoleInputArguments::Processor.new(ARGV)

	DocGenerator.new($options).process

	AddDocumentationToComponents.new($options).process
end