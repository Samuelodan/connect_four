#frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#found_four?' do
    context 'when there are 4 consecutive symbols' do
      before do
        symbol = "\u2648"
        board.grid[8],
        board.grid[16],
        board.grid[24],
        board.grid[32] = Array.new(4, symbol)
      end

      it 'returns true' do
        result = board.found_four?
        expect(result).to be(true)
      end
    end

    context 'when there are less than 4 consecutive symbols' do
      before do
        symbol = "\u2648"
        board.grid[8],
        board.grid[15],
        board.grid[24],
        board.grid[18] = Array.new(4, symbol)
      end

      it 'returns false' do
        result = board.found_four?
        expect(result).to be(false)
      end
    end
  end
end
