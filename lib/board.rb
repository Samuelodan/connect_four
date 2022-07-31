# frozen_string_literal: true

require_relative 'grid_lines'

class Board
  include GridLines

  attr_reader :grid

  def initialize
    @grid = Array.new(42, ' ')
  end

  def display
    system('clear')
    puts '  1   2   3   4   5   6   7'
    puts '+———+———+———+———+———+———+———+'
    ROWS.each do |row|
      print '|'
      row.each do |idx|
        print " #{grid[idx]} |"
      end
      puts "\n"
      puts '+———+———+———+———+———+———+———+'
    end
    puts '  1   2   3   4   5   6   7'
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
      if grid[position] == ' '
        grid[position] = symbol
        return
      end
    end
  end

  def column_full?(column:)
    col_array = COLUMNS[column - 1].map { |index| grid[index] }
    col_array.none?(' ')
  end

  def moves_left?
    grid.any?(' ')
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

  def reset
    grid.each_index do |idx|
      grid[idx] = ' '
    end
  end
end
