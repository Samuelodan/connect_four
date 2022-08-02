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
    puts "  1   2   3   4   5   6   7\n+———+———+———+———+———+———+———+"
    ROWS.each do |row|
      print '|'
      row.each do |idx|
        print " #{grid[idx]} |"
      end
      puts "\n+———+———+———+———+———+———+———+"
    end
    puts '  1   2   3   4   5   6   7'
  end

  def found_four?(choice:, array:)
    array.each_cons(4) { |four| return true if four.all?(choice) }
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

  def column_valid?(column_number)
    last_col = COLUMNS.length
    column_number.between?(1, last_col)
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
