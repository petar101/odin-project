require 'yaml'

class Update

def save_game(game, filename = "save.yaml")
  File.write(filename, YAML.dump(game))
  puts "Game saved!"
end

def load_game(filename = "save.yaml")
  YAML.safe_load(
    File.read(filename),
    permitted_classes: [Game, Symbol],
    aliases: true
  ) if File.exist?(filename)
end

end