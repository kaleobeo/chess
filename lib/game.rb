# frozen_string_literal: true

class Chess
  attr_reader :board

  include Display
  def initialize(fen = Fen.load)
    @board = fen.board
    @players = []
    @move_validator = MoveValidator.new(@board)
    @move_number = fen.fen_arr[5].to_i
    @save = false
    set_players
    rotate_players until current_color.to_s[0] == fen.fen_arr[1]
  end

  def set_players
    @players.push(Player.new(prompt_name(1), :white))
    @players.push(Player.new(prompt_name(2), :black))
  end

  def current_player
    @players[0]
  end

  def current_color
    current_player.color
  end

  def to_fen
    arr = Fen.board_to_fen_arr(@board)
    arr[1] = current_color.to_s[0]
    arr[5] = @move_number
    arr.join(' ')
  end

  def rotate_players
    @players.push(@players.shift)
  end

  def prev_player
    @players[-1]
  end

  def start_game_loop
    loop do
      if checkmate_or_stalemate?
        display_end_screen
        break
      end
      play_turn
      if @save
        puts to_fen
        break
      end
    end
  end

  def checkmate_or_stalemate?
    board_eval = Evaluation.new(@board)
    @game_end_message = 'CHECKMATE' if board_eval.in_checkmate?(current_color)
    @game_end_message = 'STALEMATE' if board_eval.in_stalemate?(current_color)
    board_eval.in_checkmate?(current_color) || board_eval.in_stalemate?(current_color)
  end

  def play_turn
    move_str = prompt_move
    if move_str == 'save'
      @save = true
      return
    end
    puts move_str
    sleep 3.0
    move = find_move(move_str)
    @board.move(move)
    @move_number += 1 if current_color == :black
    rotate_players
  end

  def prompt_move
    loop do
      player = current_player
      display_move_gui(player.color, Evaluation.new(@board).in_check?(player.color))
      player_input = gets.chomp
      return player_input if player_input == 'save'

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