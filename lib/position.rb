# frozen_string_literal: true

# A central piece, used for representing a position on the board, as well as finding other positions by their
# relationship to it. It is used to generate Positions in horizontal, diagonal lines towards a target, as well as in all
# directions. Hash and equality methods are overridden to make Positions with the same row and col equal by ==, and usable as hash keys.
class Position
  attr_reader :row, :col

  def self.parse(str)
    unless str.is_a?(String) && ('a'..'h').to_a.include?(str[0]) && ('1'..'8').to_a.include?(str[1]) && str.length == 2
      return NullPosition.new
    end

    new(str[0], str[1])
  end

  def initialize(col, row)
    @row = row.to_i
    @col = col.to_sym
  end

  def notation
    "#{col}#{row}".to_sym
  end

  def up(dist = 1)
    self.class.parse("#{col}#{row + dist}")
  end

  def down(dist = 1)
    self.class.parse("#{col}#{row - dist}")
  end

  def left(dist = 1)
    left_pos_col = (col_ascii - dist).chr
    self.class.parse("#{left_pos_col}#{row}")
  end

  def right(dist = 1)
    right_pos_col = (col_ascii + dist).chr
    self.class.parse("#{right_pos_col}#{row}")
  end

  def horiz_line(dist)
    arr = []
    (-dist).upto(dist) do |d|
      arr.push(self.class.parse("#{(col_ascii + d).chr}#{row}"))
    end
    arr
  end

  def vert_line(dist)
    arr = []
    dist.downto(-dist) do |d|
      arr.push(self.class.parse("#{col}#{row + d}"))
    end
    arr
  end

  def diag_line_ne_sw(dist)
    arr = []
    dist.downto(-dist) do |d|
      arr.push(self.class.parse("#{(col_ascii + d).chr}#{row + d}"))
    end
    arr
  end

  def diag_line_nw_se(dist)
    arr = []
    dist.downto(-dist) do |d|
      arr.push(self.class.parse("#{(col_ascii - d).chr}#{row + d}"))
    end
    arr
  end

  def line_to(destination)
    dx = (col_ascii - destination.col_ascii).abs
    dy = (row - destination.row).abs
    if dx == dy
      diag_to(destination)
    elsif dx.zero?
      vert_to(destination)
    elsif dy.zero?
      horiz_to(destination)
    end
  end

  def col_ascii
    col.to_s.ord
  end

  def ==(other)
    self.class == other.class && notation == other.notation
  end

  def eql?(other)
    self.class == other.class && notation == other.notation
  end

  def hash
    notation.hash
  end

  private

  def diag_to(destination)
    arr = []
    vert_dir = destination.row <=> row
    horiz_dir = destination.col_ascii <=> col_ascii
    dy = (row - destination.row).abs
    1.upto(dy - 1) do |dist|
      arr.push(self.class.parse("#{(col_ascii + (dist * horiz_dir)).chr}#{row + (dist * vert_dir)}"))
    end
    arr
  end

  def horiz_to(destination)
    arr = []
    dx = (col_ascii - destination.col_ascii).abs
    horiz_dir = destination.col_ascii <=> col_ascii
    1.upto(dx - 1) do |dist|
      arr.push(self.class.parse("#{(col_ascii + (dist * horiz_dir)).chr}#{row}"))
    end
    arr
  end

  def vert_to(destination)
    arr = []
    dy = (row - destination.row).abs
    vert_dir = destination.row <=> row
    1.upto(dy - 1) do |dist|
      arr.push(self.class.parse("#{col}#{row + (dist * vert_dir)}"))
    end
    arr
  end
end
