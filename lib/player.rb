# frozen_string_literal: true

# Data storage object for representing a player
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end
end
