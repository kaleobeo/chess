# frozen_string_literal: true

# High level object that collaborates with Board, FEN, Players,
# MoveValidator, and Evaluation. Faciliates standard gameflow of chess,
# as well as player interaction via private methods and the Display
# module.

class Chess
  attr_reader :board

  include Display
  def initialize(fen = Fen.load)
    @board = fen.board
    @players = []
    @history = []
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
      add_position_to_history
      if game_over?
        conclusion = draw_by_repetition? ? :repetition : Evaluation.new(@board).conclusion(current_color)
        @game_end_message = ConclusionMessage.new(conclusion, prev_player).message
        display_end_screen
        break
      end
      play_turn
      if @save
        display_save_str
        break
      end
    end
  end

  def add_position_to_history
    state = Fen.board_to_repetition_fen_arr(@board)
    state[1] = 'w'
    @history.push(state.join(' '))
  end

  def draw_by_repetition?
    @history.tally.values.max >= 3
  end

  def game_over?
    board_eval = Evaluation.new(@board)
    board_eval.in_checkmate?(current_color) || board_eval.in_stalemate?(current_color) || board_eval.fifty_move_clock_exceeded? || draw_by_repetition? || board_eval.insufficient_material?
  end

  def play_turn
    move_str = prompt_move
    if move_str == 'save'
      @save = true
      return
    end
    move = find_move(move_str)
    @board.move(move)
    promote_pawns
    @move_number += 1 if current_color == :black
    @board.teams[current_color].clear_en_passant
    rotate_players
  end

  def prompt_move
    loop do
      player = current_player
      display_move_gui(player.color, check: Evaluation.new(@board).in_check?(player.color))
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

  def promote_pawns
    pawn_to_promote = Evaluation.new(@board).find_promotable_pawn(current_color)
    return unless pawn_to_promote

    promotion_input = gets_promo_input
    @board.capture_square(pawn_to_promote.pos)
    @board.place_piece(pawn_to_promote.pos, promotion_input)
  end

  # done with clearing of past incompatible inputs
  def gets_promo_input
    prompt_promotion_piece(current_color)
    puts 'placeholder'
    loop do
      print "\r\e[A\e[K"
      promotion_input = gets.chomp
      return promotion_input if valid_promotion_input?(promotion_input)
    end
  end

  def valid_promotion_input?(promo_input)
    { white: %w[R B N Q], black: %w[r b n q] }[current_color].include?(promo_input)
  end

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

  def display_save_str
    puts to_fen
    puts 'enter any key to continue'
    gets.chomp
  end
end
