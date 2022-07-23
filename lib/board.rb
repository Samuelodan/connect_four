# frozen_string_literal: true

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(42)
  end

  def found_four?(choice, arr)
    count = 0
    arr.each_with_index do |item, idx|
      if item == choice && arr.at(idx + 1) == choice
        count += 1
      end
      count = 0 if item != choice
      return true if count == 3
    end
    false
  end
end
