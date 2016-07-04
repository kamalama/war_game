require 'net/http'
require './player'
require './round'
require 'json'

class WarGame
  def initialize
    #request data for new game
    @game_data = create_new_game

    #create players with names and their deck
    @player1 = create_player("one")
    @player2 = create_player("two")
  end

  def play_game
    #add loop for continuously playing until player cant play anymore
    #a round is all the stuff that happens before the cards in play goes to one or the other of the players
    round = Round.new(@player1, @player2)
  end

  private

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
