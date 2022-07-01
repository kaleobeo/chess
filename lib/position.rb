# frozen_string_literal: true

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

  def up
    self.class.parse("#{col}#{row + 1}")
  end

  def down
    self.class.parse("#{col}#{row - 1}")
  end

  def left
    left_pos_col = (col.to_s.ord - 1).chr
    self.class.parse("#{left_pos_col}#{row}")
  end

  def right
    right_pos_col = (col.to_s.ord + 1).chr
    self.class.parse("#{right_pos_col}#{row}")
  end

  def horiz_line(dist)
    arr = []
    col_ascii = col.to_s.ord
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
    col_ascii = col.to_s.ord
    dist.downto(-dist) do |d|
      arr.push(self.class.parse("#{(col_ascii + d).chr}#{row + d}"))
    end
    arr
  end

  def diag_line_nw_se(dist)
    arr = []
    col_ascii = col.to_s.ord
    dist.downto(-dist) do |d|
      arr.push(self.class.parse("#{(col_ascii - d).chr}#{row + d}"))
    end
    arr
  end

  def ==(other)
    self.class == other.class && notation == other.notation
  end
end
