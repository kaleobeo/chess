# frozen_string_literal: true

module BoardDisplay
  def display_board(color)
    case color
    when :white
      white_side_board
    when :black
      black_side_board
    end
  end

  def white_side_board
    print "\n"
    8.downto(1).each { |row_num| puts row_string(row_num) }
    puts '   A  B  C  D  E  F  G  H '
  end

  def black_side_board
    puts '   A  B  C  D  E  F  G  H '
    1.upto(8).each { |row_num| puts row_string(row_num) }
  end

  def row_string(num)
    "#{num} #{row(num).map(&:to_s).join}\u001b[0m"
  end
end