# frozen_string_literal: true

require_relative 'board'
require_relative './player'

class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(
    board: Board.new,
    player1: Player.new,
    player2: Player.new
  )
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end
  
  def assign_attributes
    assign_names
    assign_symbol
  end

  def play
    assign_attributes
    while board.moves_left?
      system('clear')
      board.display
      make_move
      break if board.find_win?(symbol: current_player.symbol)
      change_turn
    end
    get_winner
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
    puts "#{current_player.name}, enter a column number between 1 and 7"
    print '>> '
    input = gets.chomp.to_i
    until input.between?(1, 7)
      puts 'enter a valid column number between 1 and 7'
      print '>> '
      input = gets.chomp.to_i
    end
    while board.column_full?(column: input)
      puts 'this column is full. Try another column'
      print '>> '
      input = gets.chomp.to_i
    end
    input
  end

  def make_move
    input = get_input
    board.drop(column: input, symbol: current_player.symbol)
  end

  def get_winner
    result = board.find_win?(symbol: current_player.symbol)
    system('clear')
    board.display
    declare_win(current_player.name) if result
    declare_tie unless result
    ask_play_again
  end

  def declare_win(name)
    puts <<~HEREDOC
      Yay! #{name} won this round. Good game.
    HEREDOC
  end

  def declare_tie
    puts <<~HEREDOC

    G A M E O V E R!

    That was one tough match for sure.
    Match ended in a tie.

    HEREDOC
  end
    
  def ask_play_again
    puts <<~HEREDOC
      If you want to play again, enter 'y', otherwise, enter any other key...
    HEREDOC
    print '>> '
    response = gets.chomp.downcase
    board.reset if response == 'y'
    play if response == 'y'
    puts 'Thank you for playing' unless response == 'y'
  end
end
