# frozen_string_literal: true

class NullPosition
  def ==(other)
    other.is_a?(NullPosition)
  end

  def up
  end

  def left
  end

  def right
  end

  def down
  end
end