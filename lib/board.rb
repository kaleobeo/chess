# frozen_string_literal: true

# A data structure that holds a hash of Square objects mapped to
# Position keys, as well as additional methods to interact with the Army
# objects holding the pieces. Facilitates movement and capture of
# pieces using Move objects to give directions. It also includes the
# half move clock. This is likely not truly of Board's concern, but it
# was most convenient due to the information needed when resetting/
# incrementing its value. Additionally hold some intermediary methods
# to do things like grab moves from a piece by its position, instead of
# asking directly.

class Board
  attr_reader :teams
  attr_accessor :half_move_clock

  include BoardDisplay

  def initialize
    @board = empty_board
    @teams = { white: Army.new, black: Army.new }
    @half_move_clock = 0
  end

  # expects the positions given to be valid positions within the board
  def move(move)
    update_half_move_clock(piece_at(move.from))
    capture_square(move.to)
    capture_square(move.target)
    at(move.to).piece = at(move.from).piece
    at(move.to).piece.moved(move)
    at(move.from).clear_piece
    move_displacements(move.displacements)
  end

  def update_half_move_clock(piece)
    piece.is_a?(Pawn) ? @half_move_clock = 0 : @half_move_clock += 1
  end

  def capture_square(pos)
    piece = piece_at(pos)
    return if piece.is_a?(NullPiece)

    @teams[piece.color].piece_captured(piece)
    at(pos).clear_piece
    @half_move_clock = 0
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

  def moves_for(pos)
    piece_at(pos).moves
  end

  def self.parse_fen(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    Fen.load(fen_string).board
  end

  def row(num)
    @board.filter { |pos, _square| pos.row == num }.values.sort_by { |square| square.pos.col }
  end

  def highlight_squares(arr)
    arr.each { |pos| at(pos).highlight }
  end

  def clear_highlights
    @board.values.each(&:remove_highlight)
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

  def move_displacements(displacements)
    displacements.each do |hsh|
      hsh => { from:, to: }
      at(to).piece = at(from).piece
      at(from).clear_piece
      piece_at(to).moved(hsh)
    end
  end
end
