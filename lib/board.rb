# frozen_string_literal: true

class Board
  attr_reader :teams

  def initialize
    @board = empty_board
    @teams = Hash.new { Army.new }
    @teams[:white] = Army.new
    @teams[:black] = Army.new
  end

  # expects the positions given to be valid positions within the board
  def move(move)
    capture_square(move.to)
    capture_square(move.target)
    at(move.to).piece = at(move.from).piece
    at(move.to).piece.moved(move)
    at(move.from).clear_piece
    move_displacements(move.displacements)
  end

  def move_displacements(displacements)
    displacements.each do |hsh|
      hsh => { from:, to: }
      at(to).piece = at(from).piece
      at(from).clear_piece
      piece_at(to).moved(hsh)
    end
  end

  def capture_square(pos)
    @teams[piece_at(pos).color].piece_captured(piece_at(pos))
    at(pos).clear_piece
  end

  def at(pos)
    @board[pos]
  end

  def place_piece(pos, symbol)
    piece = Piece.parse(symbol, pos, self)
    at(pos).piece = piece
    @teams[piece.color].add_piece(piece)
  end

  def piece_at(pos)
    at(pos).piece
  end

  def destinations_for(pos)
    piece_at(pos).moves.map(&:to)
  end

  def self.parse_fen(fen_string)
    Fen.load(fen_string)
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