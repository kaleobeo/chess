require_relative './library'

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
  when 2
    load_save
  when 3
    break
  end
  system 'clear'
end

puts 'Thanks for playing!'
