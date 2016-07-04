require 'net/http'
require './player'
require 'json'

class WarGame
  CARD_VALUE_MAPPING = {
    "A": 14,
    "K": 13,
    "Q": 12,
    "J": 11
  }

  def initialize
    #request data for new game
    @game_data = create_new_game

    #create players with names and their deck
    @player1 = create_player("one")
    @player2 = create_player("two")
  end

  def play_game
    #add loop for continuously playing until player cant play anymore
    play_round
  end

  private

  #a round is all the stuff that happens before the cards in play goes to one or the other of the players
  def play_round
    #players put their cards down
    player_one_card = @player1.play_card
    player_two_card = @player2.play_card
    # cards currently in play
    cards_in_play = []

    cards_in_play.concat([player_one_card, player_two_card])

    case compare_cards(card_value(player_one_card), card_value(player_two_card))
    #if player one card higher, push both cards to player one's collection
    when 'one'
      @player1.collect_cards(cards_in_play)
    #if player two card is higher, push both cards to player two's collection
    when 'two'
      @player2.collect_cards(cards_in_play)
    #else war
    else
      puts "WAR!"
      # todo: implement war
    end
  end

  def compare_cards(player_one_card, player_two_card)
    puts "Player one and two cards #{player_one_card}, #{player_two_card}"
    if player_one_card > player_two_card
      return "one"
    elsif player_two_card > player_one_card
      return "two"
    else
      return "war"
    end
  end

  def card_value(card)
    if card.to_i == 0
      card_value = CARD_VALUE_MAPPING[card[0].to_sym]
    else
      card_value = card.to_i
    end
    card_value
  end

  def create_player(name)
    return Player.new(name, @game_data["data"])
  end

  def create_new_game
    user_info = {
      "name": "kamla kasichainula",
      "email": "kasikamla@gmail.com"
    }
    uri = URI('http://war.learnup.com/games')
    req = Net::HTTP::Post.new(uri)
    req.body = user_info.to_json
    req.content_type = 'application/json'

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      return JSON.parse(res.body)
    else
      puts res.value
    end
  end
end


game = WarGame.new.play_game
