require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    deck_new
  end

  def deck_new
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @deck << Card.new(value, suit)
      end
    end
    @deck.shuffle!  
  end

  def give_a_casd
    @deck.pop
  end  
end
