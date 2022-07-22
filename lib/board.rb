# frozen_string_literal: true

class Board
  def initialize
    @board = empty_board
  end

  # expects the positions given to be valid positions within the board
  def move(move)
    at(move.target).clear_piece
    at(move.to).piece = at(move.from).piece
    at(move.to).piece.pos = move.to
    at(move.from).clear_piece
  end

  def at(pos)
    @board[pos]
  end

  def place_piece(pos, symbol)
    at(pos).piece = Piece.parse(symbol, pos, self)
  end

  def piece_at(pos)
    at(pos).piece
  end

  def destinations_for(pos)
    piece_at(pos).moves.map { |move| move.to }
  end

  def self.parse_fen(fen_string)
    board = new
    fen_arr = fen_string.split
    piece_placement_arr = fen_arr[0].split('/').reverse
    (1..8).each do |row_idx|
      row_str = piece_placement_arr[row_idx - 1]
      ('a'..'h').each do |col|
        symbol = row_str[0]
        if symbol.match?(/[[:digit:]]/)
          digit = symbol.to_i
          row_str[0] = (digit - 1).to_s
          row_str[0] = '' if (digit - 1).zero?
        else
          pos = Position.parse("#{col}#{row_idx}")
          board.place_piece(pos, symbol)
          row_str[0] = ''
        end
      end
    end
    board
  end

  private

  def empty_board
    hsh = {}
    ('a'..'h').each do |col|
      (1..8).each do |row|
        pos = Position.parse(col + row.to_s)
        color =
          if (%i[a c e g].include?(pos.col) && pos.row.odd?) || (%i[b d f h].include?(pos.col) && pos.row.even?)
            :dark
          else
            :light
          end
        hsh[pos] = Square.new(color, pos)
      end
    end
    hsh
  end
end