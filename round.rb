class Round
  CARD_VALUE_MAPPING = {
    "A": 14,
    "K": 13,
    "Q": 12,
    "J": 11
  }
  def initialize(player1, player2)
    # creates cards in play which keeps track of all the cards that will
    # go to one or the other player at the end of the round
    @cards_in_play = []
    @player1 = player1
    @player2 = player2
    play_cards
  end

  private

  def play_cards
    #players put their cards down - If either of them don't have cards
    # trigger a game over scenario
    player_one_card = @player1.play_card
    player_two_card = @player2.play_card

    #add those cards to the cards_in_play
    @cards_in_play.concat([player_one_card, player_two_card])

    case compare_cards(card_value(player_one_card), card_value(player_two_card))
    #if player one card higher, push both cards to player one's collection
    when 'one'
      puts "player one gets the cards"
      @player1.collect_cards(@cards_in_play)
    #if player two card is higher, push both cards to player two's collection
    when 'two'
      puts "player two gets the cards"
      @player2.collect_cards(@cards_in_play)
    #else war
    else
      puts "WAR!"
      discard_cards
      play_cards
    end
  end

  def discard_cards
    # the discarding cards part of war
    3.times {
      @cards_in_play.push(@player1.play_card)
      @cards_in_play.push(@player2.play_card)
    }
    puts "Cards in play!#{@cards_in_play}"
  end

  def compare_cards(player_one_card, player_two_card)
    # compares the cards in play
    puts "Player one cards #{player_one_card}"
    puts "Player two cards #{player_two_card}"
    if player_one_card > player_two_card
      return "one"
    elsif player_two_card > player_one_card
      return "two"
    else
      return "war"
    end
  end

  def card_value(card)
    # calculates the value of the card
    if card.to_i == 0
      card_value = CARD_VALUE_MAPPING[card[0].to_sym]
    else
      card_value = card.to_i
    end
    card_value
  end

end
