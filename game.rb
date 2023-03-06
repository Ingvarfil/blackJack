require_relative 'card'
require_relative 'deck'
require_relative 'person'
require_relative 'interface'
require_relative 'dealer'
require_relative 'gamer'

class Game
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
    @gamer.money -= 10
    @dealer.money -= 10
    @interface.show_desk(@gamer.show_name, @gamer.hand.show_cards, @gamer.hand.score, @gamer.show_money)
    @interface.show_desk('Dealer', '***', '***', @dealer.show_money)
  end

  def result
    draw if @gamer.hand.score > 21 && @dealer.hand.score > 21
    draw if @gamer.hand.score == @dealer.hand.score
    win if @gamer.hand.score > @dealer.hand.score && @gamer.hand.score <= 21
    win if @dealer.hand.score > 21 && @gamer.hand.score <= 21
    lose if @gamer.hand.score > 21 && @dealer.hand.score <= 21
    lose if @dealer.hand.score > @gamer.hand.score && @dealer.hand.score <= 21
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
    if @dealer.hand.score >= 17 || @interface.input == 2
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
    @dealer.money += 20
    @interface.lose
  end

  def win
    @gamer.money += 20
    @interface.win
  end

  def draw
    @dealer.money += 10
    @gamer.money += 10
    @interface.draw
  end
  
  def validate_name
    raise 'Wrong name' if @gamer.name.nil? || @gamer.name.strip.empty?   
  end  
end

game = Game.new

loop do
  game.start
  game.distribution
  game.bet
  game.gamer_action
  game.result
  game.end_game   
end
