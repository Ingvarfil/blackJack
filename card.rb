class Card
  SUITS = ['♠', '♥', '♣', '♦']
  VALUES = [2, 3, 4, 5, 6, 7, 8, 10, 'J', 'Q', 'K', 'A']

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
end
