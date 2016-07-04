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

  def play_card
    if @deck.empty?
      shuffle_collection
      #if the collection is empty after shuffling, trigger game_end
    end

    @deck.shift
  end

  def shuffle_collection
    if @collection.empty?
      return []
    else
      get_shuffled_collection
    end
  end

  def get_shuffled_collection
    #makes request to server for shuffled deck
  end

  def collect_cards(cards)
    @collection.concat(cards)
  end
end
