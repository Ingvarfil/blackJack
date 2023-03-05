class Person
  attr_accessor :money
  attr_reader :hand, :name

  def initialize
    @money = 100
    @hand = Hand.new
  end

  def take_card(card)
    @hand.cards << card
  end

  def show_money
    money.to_s
  end
end
