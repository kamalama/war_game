require 'net/http'
class Player
  def initialize(name, game_data)
    @name = name
    @deck = game_data[name]
    @collection = []
    @game_id = game_data["id"]
  end

  def name
    return @name
  end

  def deck
    return @deck
  end

  def collection
    return @collection
  end

end
