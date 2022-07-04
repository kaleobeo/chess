# frozen_string_literal: true

class Board
  def initialize
    @board = empty_board
  end

  def at(pos)
    @board[pos]
  end

  def place_piece(pos, val)
    at(pos).piece = val
  end

  def piece_at(pos)
    at(pos).piece
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