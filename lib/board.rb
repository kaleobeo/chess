# frozen_string_literal: true

class Board
  def initialize
    @board = empty_board
  end

  def at(pos)
    @board[pos.notation]
  end

  private

  def empty_board
    hsh = {}
    ('a'..'h').each do |col|
      (1..8).each do |row|
        pos = Position.parse(col + row.to_s)
        color =
          if %i[a c e g].include?(pos.col) && pos.row.odd?
            :dark
          else
            :light
          end
        hsh[pos.notation] = Square.new(color, pos)
      end
    end
    hsh
  end
end