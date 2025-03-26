# frozen_string_literal: true

require 'erb'

class LetterGenerator
  def initialize(template_file)
    # Read the template file
    template_content = File.read(template_file)
    # Create ERB template
    @template = ERB.new(template_content)
  end

  def generate_letter(name, legislators)
    # ERB will look for these variables when rendering
    @name = name
    @legislators = legislators
    # Generate the letter using ERB
    @template.result(binding)
  end
end
