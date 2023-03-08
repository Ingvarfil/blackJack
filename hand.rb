# frozen_string_literal: true

class Hand
  attr_accessor :cards
  attr_reader :score

  POINTS_COUNT_A = 10
  MAX_SUM = 21

  def initialize
    @cards = []
  end

  def points
    @score = @cards.map(&:point_card).sum
    aces_count = @cards.select(&:ace?).count
    if @score > MAX_SUM
      case aces_count
      when 1
        @score -= POINTS_COUNT_A
      when 2
        @score -= POINTS_COUNT_A
        @score -= POINTS_COUNT_A if @score > MAX_SUM
      when 3
        2.times { @score -= POINTS_COUNT_A }
      end
    end
    @score
  end

  def show_cards
    @cards.map { |card| "#{card.value}#{card.suit}" }.join(' ')
  end
end
