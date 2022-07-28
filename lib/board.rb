# frozen_string_literal: true

require_relative 'grid_lines'

class Board
  include GridLines

  attr_reader :grid

  def initialize
    @grid = Array.new(42)
  end

  def to_s
    puts <<~HEREDOC
      +——+——+——+——+——+——+——+
      | #{grid[0]} | #{grid[1]} | #{grid[2]} | #{grid[3]} | #{grid[4]} | #{grid[5]} | #{grid[6]} |
      +——+——+——+——+——+——+——+
      | #{grid[7]} | #{grid[8]} | #{grid[9]} | #{grid[10]} | #{grid[11]} | #{grid[12]} | #{grid[13]} |
      +——+——+——+——+——+——+——+
      | #{grid[14]} | #{grid[15]} | #{grid[16]} | #{grid[17]} | #{grid[18]} | #{grid[19]} | #{grid[20]} |
      +——+——+——+——+——+——+——+
      | #{grid[21]} | #{grid[22]} | #{grid[23]} | #{grid[24]} | #{grid[25]} | #{grid[26]} | #{grid[27]} |
      +——+——+——+——+——+——+——+
      | #{grid[28]} | #{grid[29]} | #{grid[30]} | #{grid[31]} | #{grid[32]} | #{grid[33]} | #{grid[34]} |
      +——+——+——+——+——+——+——+
      | #{grid[35]} | #{grid[36]} | #{grid[37]} | #{grid[38]} | #{grid[39]} | #{grid[40]} | #{grid[41]} |
      +——+——+——+——+——+——+——+
    HEREDOC
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

  def drop(column:, symbol:)
    COLUMNS[column - 1].reverse_each do |position|
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

  def find_win?(symbol:)
    WINNING_COMBOS.each do |combo|
      board_line = []
      combo.each do |i|
        board_line << grid[i]
      end
      result = found_four?(choice: symbol, array: board_line)
      return true if result
    end
    false
  end
end
