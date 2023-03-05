class Hand
  attr_accessor :cards
  attr_reader :score
  
  def initialize
    @cards = []
  end

  def points
    @score = @cards.map(&:point_card).sum
    aces_count = @cards.select(&:ace?).count
    if @score > 21
      case aces_count
      when 1
        @score -= 10
      when 2
        @score -= 10
        @score -= 10 if @score > 21
      when 3
        2.times { @score -= 10 }
      end
    end
    @score
  end

  def swow_cards
  end
  
end
