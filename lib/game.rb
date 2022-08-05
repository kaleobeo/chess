# frozen_string_literal: true

class Game
  include Display
  def initialize(board)
    @board = board
    @players = []
    @move_validator = MoveValidator.new(@board)
    set_players
  end

  def set_players
    @players.push(Player.new(prompt_name(1), :white))
    @players.push(Player.new(prompt_name(2), :black))
  end

  def current_player
    @players[0]
  end

  def rotate_players
    @players.push(@players.shift)
  end

  def play_turn
    move_str = prompt_move
    move = find_move(move_str)
    @board.move(move)
    rotate_players
  end

  def prompt_move
    loop do
      player = current_player
      display_move_gui(player.color)
      player_input = gets.chomp
      case player_input.length
      when 4
        from = player_input[0..1]
        to = player_input[2..3]
        next unless valid_coordinate?(from) && valid_coordinate?(to)
        return "#{from}#{to}" if find_move(from + to) && can_move?(Position.parse(from), player)
      when 2
        next unless valid_coordinate?(player_input) && can_move?(Position.parse(player_input), player)

        from = player_input
        to = prompt_destination(from)
        return "#{from}#{to}" if valid_coordinate?(from) && valid_coordinate?(to)
      end
    end
  end

  private

  def find_move(move_str)
    from = Position.parse(move_str[0..1])
    to = Position.parse(move_str[2..3])
    @move_validator.valid_moves_from(from).find { |move| move.to == to }
  end

  def prompt_destination(from)
    loop do
      system 'clear'
      display_destination_gui(@move_validator.valid_moves_from(Position.parse(from)).map(&:to), current_player.color)
      to = gets.chomp
      next unless valid_coordinate?(to) || to == 'exit'
      return to if to == 'exit' || legal_destination(from, to)
    end
  end

  def legal_destination(from, to)
    @move_validator.valid_moves_from(Position.parse(from)).map { |move| move.to.notation.to_s }.include?(to)
  end

  def can_move?(dest, player)
    @board.piece_at(dest).color == player.color && !@move_validator.valid_moves_from(dest).empty?
  end

  def valid_coordinate?(str)
    return false unless str.length == 2

    ('a'..'h').cover?(str[0]) && ('1'..'8').cover?(str[1])
  end
end