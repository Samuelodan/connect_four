# frozen_string_literal: true

require_relative 'grid_lines'

class Board
  include GridLines

  attr_reader :grid

  def initialize
    @grid = Array.new(42)
  end

  def found_four?(choice:, array:)
    count = 0
    array.each_with_index do |item, idx|
      if item == choice && array.at(idx + 1) == choice
        count += 1
      end
      count = 0 if item != choice
      return true if count == 3
    end
    false
  end

  def drop(count:, symbol:)
    COLUMNS[count - 1].reverse_each do |position|
      unless grid[position]
        grid[position] = symbol
        return
      end
    end
  end

  def column_full?(column:)
    col_array = COLUMNS[column - 1].map { |index| grid[index] }
    col_array.length == col_array.compact.length
  end

  def moves_left?
    grid.any? { |item| item == nil }
  end
end
