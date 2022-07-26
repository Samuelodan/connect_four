# frozen_string_literal: true

class Game
  attr_reader :board, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end
end
