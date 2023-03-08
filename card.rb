# frozen_string_literal: true

class Card
  SUITS = ['♠', '♥', '♣', '♦'].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 10, 'J', 'Q', 'K', 'A'].freeze
  POINTS_CARD_PICTURE = 10
  POINTS_CARD_A = 11

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def ace?
    value == 'A'
  end

  def point_card
    if value.is_a?(Integer)
      value
    elsif %w[J Q K].include?(value)
      POINTS_CARD_PICTURE
    else value == 'A'
      POINTS_CARD_A
    end
  end
end
