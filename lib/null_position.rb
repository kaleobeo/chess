# frozen_string_literal: true

class NullPosition
  def ==(other)
    other.is_a?(NullPosition)
  end

  def horiz_line(dist)
    Array.new((dist * 2) + 1) { self.class.new }
  end

  def vert_line(dist)
    Array.new((dist * 2) + 1) { self.class.new }
  end

  def diag_line_ne_sw(dist)
    Array.new((dist * 2) + 1) { self.class.new }
  end

  def diag_line_nw_se(dist)
    Array.new((dist * 2) + 1) { self.class.new }
  end

  def up(_dist = 0)
    NullPosition.new
  end

  def left(_dist = 0)
    NullPosition.new
  end

  def right(_dist = 0)
    NullPosition.new
  end

  def down(_dist = 0)
    NullPosition.new
  end

  def notation
    nil
  end

  def row
    nil
  end

  def col
    nil
  end
end