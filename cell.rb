require "rspec"

class Cell
  attr_reader :alive

  def initialize(alive:)
    @alive = alive
  end

  def alive?
    @alive
  end
end
