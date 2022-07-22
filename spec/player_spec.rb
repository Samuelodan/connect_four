#frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new }

  describe '#set_symbol' do
    context 'when argument is a string' do
      it 'changes @symbol to passed in symbol' do
        sym_arg = '\u2648'
        player.set_symbol(sym_arg)
        expect(player.symbol).to eq(sym_arg)
      end
    end
  end
end
