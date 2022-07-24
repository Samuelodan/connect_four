#frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#found_four?' do
    context 'when there are 4 consecutive symbols' do
      it 'returns true' do
        symbol = "\u2648"
        line = ['bread', symbol, symbol, symbol, symbol, 'john']
        result = board.found_four?(symbol ,line)
        expect(result).to be(true)
      end
    end

    context 'when there are less than 4 consecutive symbols' do
      it 'returns false' do
        symbol = "\u2648"
        line = ['bread', symbol, symbol, 'judas', symbol, symbol]
        result = board.found_four?(symbol, line)
        expect(result).to be(false)
      end
    end
  end

  describe '#drop' do
    context 'when column 1 is empty' do
      it 'drops item into the grid' do
        symbol = "\u2648"
        column_no = 1
        board.drop(count: column_no, symbol: symbol)
        expect(board.grid[35]).to eq(symbol)
      end
    end

    context 'when column 1 has 4 symbols' do
      before do
        symbol = "\u2648"
        board.grid[35], board.grid[28],
        board.grid[21], board.grid[14] = Array.new(4, symbol)
      end

      it 'drops item into the grid' do
        symbol = "\u2648"
        column_no = 1
        board.drop(count: column_no, symbol: symbol)
        expect(board.grid[7]).to eq(symbol)
      end
    end
  end
end
