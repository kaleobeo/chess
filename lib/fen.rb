# frozen_string_literal: true

# tested in board_spec
class Fen
  attr_reader :board, :fen_arr

  def initialize(fen_string: '* * * * * *', board: nil)
    @board = board
    @board ||= Board.new
    @fen_string = fen_string
    @fen_arr = fen_string.split
  end

  def self.load(fen_string)
    fen = new(fen_string:)
    fen.place_pieces
    fen.place_en_passant
    fen.board
  end

  def place_pieces
    piece_placement_arr = fen_arr[0].split('/').reverse
    (1..8).each do |row_idx|
      row_str = piece_placement_arr[row_idx - 1]
      place_row_from_fen(row_idx, row_str)
    end
    self
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

  def self.board_to_fen(board)
    fen = new(board:)
    fen.set_piece_field
  end

  def set_piece_field
    board_arr = 8.downto(1).map { |row_num| board.row(row_num).map { |square| square.piece.fen_char} }
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
end