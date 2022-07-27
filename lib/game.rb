# frozen_string_literal: true

class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def assign_symbol
    symbol_for_p1 = "\e[91m\u25CF\e[0m"
    symbol_for_p2 = "\e[37m\u25CF\e[0m"
    player1.set_symbol(symbol_for_p1)
    player2.set_symbol(symbol_for_p2)
  end

  def assign_names
    name_for_p1 = 'Player1'
    name_for_p2 = 'Player2'
    player1.set_name(name_for_p1)
    player2.set_name(name_for_p2)
  end

  def change_turn
    if current_player == player1
      @current_player = player2
    else
      @current_player = player1
    end
  end

  def get_input
    input = gets.chomp.to_i
    until input.between?(1, 7) do
      puts 'enter a valid column number between 1 and 7'
      input = gets.chomp.to_i
    end
    while board.column_full?(column: input)
      puts 'this column is full. Try another column'
      input = gets.chomp.to_i
    end
    input
  end

  def make_move
    input = get_input
    board.drop(column: input, symbol: current_player.symbol)
  end
end
