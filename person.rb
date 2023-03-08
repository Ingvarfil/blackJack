# frozen_string_literal: true

require_relative 'hand'

class Person
  MONEY = 100
  attr_accessor :money
  attr_reader :hand, :name

  def initialize
    @money = MONEY
    @hand = Hand.new
  end

  def take_card(card)
    @hand.cards << card
  end

  def show_money
    money.to_s
  end
end
