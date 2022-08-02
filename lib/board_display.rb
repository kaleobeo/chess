# frozen_string_literal: true

module BoardDisplay
  def display_board
    8.downto(1).each { |row_num| puts row_string(row_num) }
    puts '   A  B  C  D  E  F  G  H '
  end

  def row_string(num)
    "#{num} #{row(num).map(&:to_s).join}\u001b[0m"
  end

  def row(num)
    @board.filter { |pos, square| pos.row == num }.values.sort_by { |square| square.pos.col }
  end
end