class Player
  def initialize(name, deck)
    @name = name
    @deck = deck
    @collection = []
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
