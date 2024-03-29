# frozen_string_literal: true

# Module that contains most of the printing to console for Chess
module Display
  def display_move_gui(color, check: false)
    system 'clear'
    @board.display_board(color)
    puts "\n"
    puts "#{current_player.name}'s turn, #{color} to move:"
    puts <<-HEREDOC
      #{if check
          "\u001b[38;5;210mCHECK\u001b[0m\n      #{current_player.name}, your king is under attack, you must protect it!"
        end
      }
      Input either the square you want to move from (will prompt for destination after), or the point of departure, then the destination, or, type 'save' to exit and view the FEN string for this position. Ex:
        'd2', 'd4'
        OR
        'd2d4'
    HEREDOC
  end

  def display_destination_gui(moves, color)
    system 'clear'
    @board.highlight_squares(moves)
    @board.display_board(color)
    @board.clear_highlights
    puts "\n"
    puts "#{current_player.name}'s Turn:"
    puts "\n"
    puts <<-HEREDOC
      Input the coordinate of the square you would like to move to, or type 'exit' to abort the move
    HEREDOC
  end

  def prompt_name(num)
    puts "Choose a name for Player #{num}"
    gets.chomp
  end

  def prompt_promotion_piece(color)
    puts "What would you like to turn your pawn into? #{color == :black ? 'r/b/n/q' : 'R/B/N/Q'}"
  end

  def display_end_screen
    @board.highlight_squares([@board.teams[current_color].king.pos]) if Evaluation.new(@board).in_check?(current_color)
    system 'clear'
    @board.display_board(:white)
    puts @game_end_message
  end
end
