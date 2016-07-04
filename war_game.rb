require 'net/http'
require './player'
require 'json'

class WarGame
  def initialize
    #request data for new game
    @game_data = create_new_game

    #create players with names and their deck
    @player1 = create_player("one")
    @player2 = create_player("two")


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


game = WarGame.new
