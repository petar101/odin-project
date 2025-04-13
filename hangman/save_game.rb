# frozen_string_literal: true

require 'yaml'

class Update
  def save_game(game, filename = 'save.yaml')
    File.write(filename, YAML.dump(game))
    puts 'Game saved!'
  end

  def load_game(filename = 'save.yaml')
    return unless File.exist?(filename)

    YAML.safe_load(
      File.read(filename),
      permitted_classes: [Game, Symbol],
      aliases: true
    )
  end
end
