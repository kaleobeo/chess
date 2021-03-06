# frozen_string_literal: true

require_relative '../lib/library'

describe Position do
  describe '#parse' do
    context 'when a coordinate is created in the bounds of the board' do
      let(:in_bounds_pos) { described_class.parse('a4') }

      it 'has a position matching what it was instantiated with' do
        expect(in_bounds_pos.notation).to eq :a4
      end

      it 'has the proper row value' do
        expect(in_bounds_pos.row).to eq 4
      end

      it 'has the proper col value' do
        expect(in_bounds_pos.col).to eq :a
      end
    end

    context 'when parse is called with an invalid coordinate string' do
      it 'returns a NullPosition when string is too long' do
        pos = described_class.parse('a11')
        expect(pos).to be_a(NullPosition)
      end

      it 'returns a NullPosition when letter is invalid' do
        pos = described_class.parse('x4')
        expect(pos).to be_a(NullPosition)
      end

      it 'returns a NullPosition when number is too large' do
        pos = described_class.parse('a9')
        expect(pos).to be_a(NullPosition)
      end

      it 'returns a NullPosition when string contains other invalid characters' do
        pos = described_class.parse('?4')
        expect(pos).to be_a(NullPosition)
      end
    end
  end

  describe '#up' do
    context 'when called on a position in the middle of the board' do
      let(:up_middle_pos) { described_class.parse('d4') }

      it 'returns the position above it' do
        expect(up_middle_pos.up).to eq described_class.parse('d5')
      end
    end

    context 'when called on a position at the top of the board' do
      let(:invalid_up_pos) { described_class.parse('d8') }

      it 'returns a NullPosition' do
        expect(invalid_up_pos.up).to be_a(NullPosition)
      end
    end
  end

  describe '#down' do
    context 'when called on a position in the middle of the board' do
      let(:down_middle_pos) { described_class.parse('d4') }

      it 'returns the position below it' do
        expect(down_middle_pos.down).to eq described_class.parse('d3')
      end
    end

    context 'when called on a position at the bottom of the board' do
      let(:invalid_down_pos) { described_class.parse('d1') }

      it 'returns a NullPosition' do
        expect(invalid_down_pos.down).to be_a(NullPosition)
      end
    end
  end

  describe '#left' do
    context 'when called on a position in the middle of the board' do
      let(:left_middle_pos) { described_class.parse('d4') }

      it 'returns the position left of it' do
        expect(left_middle_pos.left).to eq described_class.parse('c4')
      end
    end

    context 'when called on a position at the left of the board' do
      let(:invalid_left_pos) { described_class.parse('a4') }

      it 'returns a NullPosition' do
        expect(invalid_left_pos.left).to be_a(NullPosition)
      end
    end
  end

  describe '#right' do
    context 'when called on a position in the middle of the board' do
      let(:right_middle_pos) { described_class.parse('d4') }

      it 'returns the position left of it' do
        expect(right_middle_pos.right).to eq described_class.parse('e4')
      end
    end

    context 'when called on a position at the right of the board' do
      let(:invalid_right_pos) { described_class.parse('h4') }

      it 'returns a NullPosition' do
        expect(invalid_right_pos.right).to be_a(NullPosition)
      end
    end
  end

  describe '#horiz_line' do
    context 'when asked for a line in the middle of the board' do
      subject(:middle_horiz_pos) { described_class.parse('d4') }

      it 'returns the proper line' do
        expected = [
          described_class.parse('b4'),
          described_class.parse('c4'),
          described_class.parse('d4'),
          described_class.parse('e4'),
          described_class.parse('f4')
        ]
        expect(middle_horiz_pos.horiz_line(2)).to eq expected
      end
    end

    context 'when asked for a line at an edge of the board' do
      subject(:left_horiz_pos) { described_class.parse('a4') }

      it 'returns the proper line, including NullPositions' do
        expected = [
          NullPosition.new,
          NullPosition.new,
          described_class.parse('a4'),
          described_class.parse('b4'),
          described_class.parse('c4')
        ]
        expect(left_horiz_pos.horiz_line(2)).to eq expected
      end
    end
  end

  describe '#vert_line' do
    context 'when asked for a line in the middle of the board' do
      subject(:middle_vert_pos) { described_class.parse('d4') }

      it 'returns the proper line' do
        expected = [
          described_class.parse('d6'),
          described_class.parse('d5'),
          described_class.parse('d4'),
          described_class.parse('d3'),
          described_class.parse('d2')
        ]
        expect(middle_vert_pos.vert_line(2)).to eq expected
      end
    end

    context 'when asked for a line at the top of the board' do
      subject(:middle_top_pos) { described_class.parse('d8') }

      it 'returns the proper line, including NullPositions' do
        expected = [
          NullPosition.new,
          NullPosition.new,
          described_class.parse('d8'),
          described_class.parse('d7'),
          described_class.parse('d6')
        ]
        expect(middle_top_pos.vert_line(2)).to eq expected
      end
    end
  end

  describe '#diag_line_ne_sw' do
    context 'when asked for a line in the middle of the board' do
      subject(:middle_diag_ne_sw_pos) { described_class.parse('d4') }

      it 'returns the proper line' do
        expected = [
          described_class.parse('f6'),
          described_class.parse('e5'),
          described_class.parse('d4'),
          described_class.parse('c3'),
          described_class.parse('b2')
        ]
        expect(middle_diag_ne_sw_pos.diag_line_ne_sw(2)).to eq expected
      end
    end

    context 'when asked for a line at an edge of the board' do
      subject(:right_diag_ne_sw_pos) { described_class.parse('h2') }

      it 'returns the proper line with NullPositions' do
        expected = [
          NullPosition.new,
          NullPosition.new,
          described_class.parse('h2'),
          described_class.parse('g1'),
          NullPosition.new
        ]
        expect(right_diag_ne_sw_pos.diag_line_ne_sw(2)).to eq expected
      end
    end

    context 'when asked for a line at the bottom right corner of the board' do
      subject(:corner_diag_ne_sw_pos) { described_class.parse('h1') }

      it 'returns the proper line with NullPositions' do
        expected = [
          NullPosition.new,
          NullPosition.new,
          described_class.parse('h1'),
          NullPosition.new,
          NullPosition.new
        ]
        expect(corner_diag_ne_sw_pos.diag_line_ne_sw(2)).to eq expected
      end
    end
  end

  describe '#diag_line_nw_se' do
    context 'when asked for a line in the middle of the board' do
      subject(:middle_diag_nw_se_pos) { described_class.parse('d4') }

      it 'returns the proper line' do
        expected = [
          described_class.parse('b6'),
          described_class.parse('c5'),
          described_class.parse('d4'),
          described_class.parse('e3'),
          described_class.parse('f2')
        ]
        expect(middle_diag_nw_se_pos.diag_line_nw_se(2)).to eq expected
      end
    end

    context 'when asked for a line at an edge of the board' do
      subject(:right_diag_nw_se_pos) { described_class.parse('h2') }

      it 'returns the proper line with NullPositions' do
        expected = [
          described_class.parse('f4'),
          described_class.parse('g3'),
          described_class.parse('h2'),
          NullPosition.new,
          NullPosition.new
        ]
        expect(right_diag_nw_se_pos.diag_line_nw_se(2)).to eq expected
      end
    end

    context 'when asked for a line at the top right corner of the board' do
      subject(:corner_diag_nw_se_pos) { described_class.parse('h8') }

      it 'returns the proper line with NullPositions' do
        expected = [
          NullPosition.new,
          NullPosition.new,
          described_class.parse('h8'),
          NullPosition.new,
          NullPosition.new
        ]
        expect(corner_diag_nw_se_pos.diag_line_nw_se(2)).to eq expected
      end
    end
  end

  describe '#line_to' do
    subject(:line_pos) { described_class.parse('d4') }

    context 'when drawing a diagonal line' do
      it 'to the ne, returns the proper line' do
        expected = [
          described_class.parse('e5'),
          described_class.parse('f6')
        ]

        expect(line_pos.line_to(described_class.parse('g7'))).to eq expected
      end

      it 'to the se, returns the proper line' do
        expected = [
          described_class.parse('e3'),
          described_class.parse('f2')
        ]

        expect(line_pos.line_to(described_class.parse('g1'))).to eq expected
      end

      it 'to the nw, returns the proper line' do
        expected = [
          described_class.parse('c5'),
          described_class.parse('b6')
        ]

        expect(line_pos.line_to(described_class.parse('a7'))).to eq expected
      end

      it 'to the sw, returns the proper line' do
        expected = [
          described_class.parse('c3'),
          described_class.parse('b2')
        ]

        expect(line_pos.line_to(described_class.parse('a1'))).to eq expected
      end
    end

    context 'when drawing a horizontal line' do
      it 'to the right, returns the proper line' do
        expected = [
          described_class.parse('e4'),
          described_class.parse('f4')
        ]

        expect(line_pos.line_to(described_class.parse('g4'))).to eq expected
      end

      it 'to the left, returns the proper line' do
        expected = [
          described_class.parse('c4'),
          described_class.parse('b4')
        ]

        expect(line_pos.line_to(described_class.parse('a4'))).to eq expected
      end
    end

    context 'when drawing a vertical line' do
      it 'upwards, returns the proper line' do
        expected = [
          described_class.parse('d5'),
          described_class.parse('d6')
        ]

        expect(line_pos.line_to(described_class.parse('d7'))).to eq expected
      end

      it 'downwards, returns the proper line' do
        expected = [
          described_class.parse('d3'),
          described_class.parse('d2')
        ]

        expect(line_pos.line_to(described_class.parse('d1'))).to eq expected
      end
    end
  end
end
