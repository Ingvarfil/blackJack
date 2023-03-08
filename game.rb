# frozen_string_literal: true

class Game
  BET = 10
  MAX_SUM = 21
  DEALER_MAX_SUM = 17
  WINING_MONEY = 20
  DRAW_MONEY = 10

  def initialize
    @interface = Interface.new
    @gamer = Gamer.new
    @dealer = Dealer.new
    @interface.ask_name
    @gamer.name = gets.chomp.strip.capitalize
    validate_name
  rescue StandardError => e
    puts e.message
    retry
  end

  def start
    @deck = Deck.new
    @gamer.hand.cards = []
    @dealer.hand.cards = []
  end

  def distribution
    2.times do
      @gamer.take_card(@deck.give_a_card)
      @dealer.take_card(@deck.give_a_card)
    end
    @dealer.hand.points
    @gamer.hand.points
  end

  def bet
    @gamer.money -= BET
    @dealer.money -= BET
    @interface.show_desk(@gamer.show_name, @gamer.hand.show_cards, @gamer.hand.score, @gamer.show_money)
    @interface.show_desk('Dealer', '***', '***', @dealer.show_money)
  end

  def result
    draw if @gamer.hand.score > MAX_SUM && @dealer.hand.score > MAX_SUM
    draw if @gamer.hand.score == @dealer.hand.score
    win if @gamer.hand.score > @dealer.hand.score && @gamer.hand.score <= MAX_SUM
    win if @dealer.hand.score > MAX_SUM && @gamer.hand.score <= MAX_SUM
    lose if @gamer.hand.score > MAX_SUM && @dealer.hand.score <= MAX_SUM
    lose if @dealer.hand.score > @gamer.hand.score && @dealer.hand.score <= MAX_SUM
    desk
  end

  def gamer_action
    begin
      @interface.action
    rescue StandardError => e
      puts e.message
      retry
    end
    @gamer.take_card(@deck.give_a_card) if @interface.input == 1
    @gamer.hand.points
    dealer_action
  end

  def dealer_action
    if @dealer.hand.score >= DEALER_MAX_SUM || @interface.input == 2
      nil
    else
      @dealer.take_card(@deck.give_a_card)
      @dealer.hand.points
    end
  end

  def desk
    @interface.show_desk(@gamer.show_name, @gamer.hand.show_cards, @gamer.hand.score, @gamer.show_money)
    @interface.show_desk(@dealer.name, @dealer.hand.show_cards, @dealer.hand.score, @dealer.show_money)
  end

  def end_game
    @interface.no_money(@gamer.show_name) if @gamer.money <= 0
    @interface.no_money(@dealer.name) if @dealer.money <= 0
    @interface.exit_game
  rescue StandardError => e
    puts e.message
    retry
  end

  def lose
    @dealer.money += WINING_MONEY
    @interface.lose
  end

  def win
    @gamer.money += WINING_MONEY
    @interface.win
  end

  def draw
    @dealer.money += DRAW_MONEY
    @gamer.money += DRAW_MONEY
    @interface.draw
  end

  def validate_name
    raise 'Wrong name' if @gamer.name.nil? || @gamer.name.strip.empty?
  end
end
