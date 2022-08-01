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

  def get_input
    puts "#{current_player.name}, enter a column number between 1 and 7"
    puts 'or enter `quit` to exit game.'

    loop do
      print '>> '
      input = gets.chomp
      break input if input == 'quit'
      input = input.to_i
      if !input.between?(1, 7)
        puts "\e[31menter a valid column number between 1 and 7\e[0m"
      elsif board.column_full?(column: input)
        puts "\e[33mthis column is full. Try another column\e[0m"
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
    display_player_sym
    declare_win(current_player.name) if result
    declare_tie unless board.moves_left?
    ask_play_again
  end

  private

  def collect_name(player)
    system('clear')
    puts "#{player}, enter your name"
    print '>> '
    gets.chomp
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
