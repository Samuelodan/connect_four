# frozen_string_literal: true

module Display
  ERROR_MESSAGES = {
    invalid_column: "\e[31menter a valid column number between 1 and 7\e[0m",
    column_full: "\e[93mthis column is full. Try another column\e[0m"
  }.freeze

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
    
    #{player1.symbol} #{player1.name} ::VS:: #{player2.name} #{player2.symbol}
      
    HEREDOC
  end

  def declare_win(name)
    puts <<~HEREDOC
      \e[92m
      *****************************
      YAY!! #{name} won this round.
      Good game.
      \e[0m
    HEREDOC
  end

  def declare_tie
    puts <<~HEREDOC
    \e[93m
    G A M E O V E R!

    That was one tough game for sure.
    Match ended in a tie.
    \e[0m
    HEREDOC
  end

  def error_message_for(error)
    puts ERROR_MESSAGES[error]
  end
end
