# frozen_string_literal: true

class Fen
  attr_reader :board
  def initialize(fen_string)
    @board = Board.new
    @fen_string = fen_string
  end

  def self.load(fen_string)
    fen = new(fen_string)
    fen_arr = fen_string.split
    piece_placement_arr = fen_arr[0].split('/').reverse
    (1..8).each do |row_idx|
      row_str = piece_placement_arr[row_idx - 1]
      fen.place_row_from_fen(row_idx, row_str)
    end
    fen.board
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