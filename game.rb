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

  game = Game.new

  loop do
    game.start
    
  end

  def start
    @deck = Deck.new
    @gamer.hand.cards = []
    @dealer.hand.cards = []    
  end

  def validate_name
    raise 'Wrong name' if @gamer.name.nil? || @gamer.name.strip.empty?   
  end
  
end
