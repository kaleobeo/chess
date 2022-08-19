# frozen_string_literal: true

module Display
  def display_move_gui(color)
    system 'clear'
    @board.display_board(color)
    puts "\n"
    puts "#{current_player.name}'s Turn:"
    puts "\n"
    puts <<-HEREDOC
      Input either the square you want to move from (will prompt for destination after), or the point of departure, then the destination. Ex:
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
end