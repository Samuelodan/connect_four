# frozen_string_literal: true

class Game
  attr_reader :board, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def assign_symbol
    symbol_for_p1 = "\e[91m\u25CF\e[0m"
    symbol_for_p2 = "\e[37m\u25CF\e[0m"
    player1.set_symbol(symbol_for_p1)
    player2.set_symbol(symbol_for_p2)
  end
end
