# frozen_string_literal: true

require_relative 'person'

class Gamer < Person
  attr_writer :name

  def initialize
    @name = nil
    super
  end

  def show_name
    name.to_s
  end
end
