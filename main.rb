require_relative './lib/library'

def load_save
  puts 'Please enter a valid FEN string'
  Chess.new(Fen.load(gets.chomp)).start_game_loop
end

puts 'Welcome to Chess!'
loop do
  puts <<-HEREDOC
    Select an option:
      1. Play a game
      2. Load a game from FEN
      3. Exit
  HEREDOC
  case gets.chomp.to_i
  when 1
    Chess.new.start_game_loop
    sleep 3.0
  when 2
    load_save
    sleep 3.0
  when 3
    break
  end
  system 'clear'
end

puts 'Thanks for playing!'
