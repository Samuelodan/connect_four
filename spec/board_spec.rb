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
end
