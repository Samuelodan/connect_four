# frozen_string_literal: true

require_relative 'board'
require_relative './player'

class Game
  attr_reader :board, :player1, :player2, :current_player, :quit

  def initialize(
    board: Board.new,
    player1: Player.new,
    player2: Player.new
  )
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @quit = false
  end
  
  def assign_attributes
    assign_names
    assign_symbol
  end

  def play
    introduce
    assign_attributes
    while board.moves_left?
      board.display
      display_player_sym
      make_move
      break if quit || board.find_win?(symbol: current_player.symbol)
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
    player1.set_name(collect_name('Player1'))
    player2.set_name(collect_name('Player2'))
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
    puts 'or enter `quit` to exit game.'

    loop do
      print '>> '
      input = gets.chomp
      break input if input == 'quit'
      input = input.to_i
      if !input.between?(1, 7)
        puts 'enter a valid column number between 1 and 7'
      elsif board.column_full?(column: input)
        puts 'this column is full. Try another column'
      end
      break input if input.between?(1, 7) && !board.column_full?(column: input)
    end
  end

  def make_move
    input = get_input
    return @quit = true if input == 'quit'
    board.drop(column: input, symbol: current_player.symbol)
  end

  def get_winner
    reset_quit
    result = board.find_win?(symbol: current_player.symbol)
    system('clear')
    board.display
    declare_win(current_player.name) if result
    declare_tie unless board.moves_left?
    ask_play_again
  end

  def introduce
    system('clear')
    puts <<~HEREDOC
      W E L C O M E  TO  C O N N E C T  F O U R

      YOU WIN THIS GAME BY BEING THE FIRST TO FORM AN UNBROKEN DIAGONAL,
      VERTICAL, OR HORIZONTAL LINE WITH 4 OF YOUR PIECES.
      YOU FORM THESE LINES BY DROPPING YOUR PIECES STRAIGHT INTO ANY ONE
      OF THE 7 COLUMNS.
      
      ALRIGHT, THAT SAID, LET THE GAME BEGIN!

      enter any key to continue...\n
    HEREDOC
    print '>> '
    gets.chomp
  end

  def display_player_sym
    puts <<-HEREDOC
    
    #{player1.name} is #{player1.symbol} :: #{player2.name} is #{player2.symbol}

      
    HEREDOC
  end

  def collect_name(player)
    system('clear')
    puts "#{player}, enter your name"
    print '>> '
    gets.chomp
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

  def reset_quit
    @quit = false
  end
end
