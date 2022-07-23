# frozen_string_literal: true

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(42)
  end
end
