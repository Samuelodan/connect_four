# frozen_string_literal: true

require_relative 'board'
require_relative './player'
require_relative './display'

class Game
  include Display

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
    symbol_for_p1 = "\e[31m\u25CF\e[0m"
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

  def prompt_move
    puts "#{current_player.name}, enter a column number between 1 and 7"
    puts 'or enter `quit` to exit game.'
  end

  def get_input
    loop do
      print "\n>> "
      input = gets.chomp
      return input if input.downcase == 'quit'

      int_input = input.to_i
      return int_input if valid_move?(int_input)

      display_error_message(int_input)
    end
  end

  def valid_move?(input)
    board.column_valid?(input) && !board.column_full?(column: input)
  end

  def display_error_message(input)
    if !board.column_valid?(input)
      puts "\e[31menter a valid column number between 1 and 7\e[0m"
    elsif board.column_full?(column: input)
      puts "\e[93mthis column is full. Try another column\e[0m"
    end
  end

  def make_move
    prompt_move
    input = get_input
    return @quit = true if input.downcase == 'quit'
    board.drop(column: input, symbol: current_player.symbol)
  end

  def get_winner
    reset_quit
    result = board.find_win?(symbol: current_player.symbol)
    system('clear')
    board.display
    display_player_sym
    declare_win(current_player.name) if result
    declare_tie unless board.moves_left?
    ask_play_again
  end

  private

  def collect_name(player)
    system('clear')
    print "#{player}, enter your name\n\n >> "
    gets.chomp
  end
    
  def ask_play_again
    puts <<~HEREDOC
      If you want to play again, enter 'y', otherwise, enter any other key...
    HEREDOC
    print "\n>> "
    response = gets.chomp.downcase
    board.reset if response == 'y'
    play if response == 'y'
    puts 'Thank you for playing' unless response == 'y'
  end

  def reset_quit
    @quit = false
  end
end
