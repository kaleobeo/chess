# frozen_string_literal: true

# tested in board_spec
class Fen
  attr_reader :board, :fen_arr

  CASTLE_OFFSETS = {
    K: 3,
    Q: -4,
    k: 3,
    q: -4
  }

  def initialize(fen_string: '* * * * * *', board: nil)
    @board = board
    @board ||= Board.new
    @fen_string = fen_string
    @fen_arr = fen_string.split
  end

  def self.load(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    fen = new(fen_string:)
    fen.place_pieces
    fen.place_en_passant
    fen.revoke_castling_rights
    fen.set_half_move_clock
    fen
  end

  def fen_string
    @fen_arr.join(' ')
  end

  def set_half_move_clock
    @board.half_move_clock = @fen_arr[4].to_i
  end

  def place_pieces
    piece_placement_arr = fen_arr[0].split('/').reverse
    (1..8).each do |row_idx|
      row_str = piece_placement_arr[row_idx - 1]
      place_row_from_fen(row_idx, row_str)
    end
    self
  end

  def revoke_castling_rights
    return if fen_arr[2].nil? || !@board.teams.values.all?(&:king)

    castle_rights_string = fen_arr[2]
    rights_to_revoke = %w[K Q k q].difference(castle_rights_string.chars)
    rights_to_revoke.each do |letter|
      rook_pos = board.teams[castle_letter_to_color(letter)].king.pos.right(castle_letter_to_rook_pos(letter))
      next if rook_pos.is_a?(NullPosition)
      
      board.piece_at(rook_pos).moved(Move.new(from: rook_pos, to: rook_pos))
    end
  end

  def castle_letter_to_rook_pos(letter)
    CASTLE_OFFSETS[letter.to_sym]
  end

  def castle_letter_to_color(letter)
    letter == letter.upcase ? :white : :black
  end

  def place_en_passant
    en_passant_field = fen_arr.fetch(3, '-')
    return if en_passant_field == '-'

    dir = en_passant_field[1].to_i > 4 ? -1 : 1
    pawn_pos = Position.parse(en_passant_field).up(dir)
    @board.piece_at(pawn_pos).moved(Move.new(from: pawn_pos, to: pawn_pos, rules: [Rules::ON_START_POSITION]))
  end

  def place_row_from_fen(row_num, row_str)
    ('a'..'h').each do |col|
      place_piece_and_modify_row_str(row_str, row_num, col)
    end
  end

  def place_piece_and_modify_row_str(row_str, row_num, col)
    symbol = row_str[0]
    if symbol.match?(/[[:digit:]]/)
      digit = symbol.to_i
      row_str[0] = (digit - 1).to_s
      row_str[0] = '' if (digit - 1).zero?
    else
      pos = Position.parse("#{col}#{row_num}")
      @board.place_piece(pos, symbol)
      row_str[0] = ''
    end
  end

  # methods around turning board into fen string

  def self.board_to_fen_arr(board)
    fen = new(board:)
    fen.set_piece_field
    fen.set_castle_field
    fen.set_en_passant_field
    fen.fen_arr[4] = fen.board.half_move_clock
    fen.fen_arr
  end

  # reasoning for replacing en passant with total moves explained in README

  def self.board_to_repetition_fen_arr(board)
    fen = new(board:)
    fen.set_piece_field
    fen.set_castle_field
    fen.fen_arr[3] = fen.board.teams.values.sum { |team| team.moves.length }
    fen.fen_arr
  end

  def set_piece_field
    board_arr = 8.downto(1).map { |row_num| board.row(row_num).map { |square| square.piece.fen_char } }
    pieces_string = board_arr.map do |row_arr|
      compact_row_arr(row_arr)
    end.join('/')
    @fen_arr[0] = pieces_string
  end

  def compact_row_arr(row_arr)
    row_arr.chunk { |char| char }.map do |chunk|
      if chunk[0] == '*'
        chunk[1].length
      else
        chunk[1].join
      end
    end.join
  end

  def castle_rights_based_on_rook_motion
    castle_string = ''
    CASTLE_OFFSETS.each do |letter, offset|
      king_pos = @board.teams[castle_letter_to_color(letter)].king.pos
      next unless @board.at(king_pos.right(offset))
      castle_string += letter.to_s unless @board.piece_at(king_pos.right(offset)).has_moved?
    end
    castle_string
  end

  def filter_castle_string_based_on_king_motion(string)
    string.chars.filter do |char|
      !@board.teams[castle_letter_to_color(char)].king.has_moved?
    end.join
  end

  def set_castle_field
    castle_string = filter_castle_string_based_on_king_motion(castle_rights_based_on_rook_motion)
    fen_arr[2] = castle_string.length.zero? ? '-' : castle_string
  end

  def set_en_passant_field
    pos = @board.teams.values.find(&:en_passant_square)&.en_passant_square&.notation
    fen_arr[3] = (pos || '-').to_s
  end
end