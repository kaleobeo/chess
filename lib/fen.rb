# frozen_string_literal: true

# tested in board_spec
class Fen
  attr_reader :board
  attr_reader :fen_arr

  def initialize(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    @board = Board.new
    @fen_string = fen_string
    @fen_arr = fen_string.split
  end

  def self.load(fen_string)
    fen = new(fen_string)
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
    en_passant_field = fen_arr[3]
    dir = en_passant_field[1].to_i > 4 ? -1 : 1
    pawn_pos = Position.parse(en_passant_field).up(dir)
    @board.piece_at(pawn_pos).moved(Move.new(pawn_pos, pawn_pos, [Rules::ON_START_POSITION]))
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
end