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
    context 'when argument is invalid (not a string)' do
      it 'does nothing' do
        sym_arg = 35
        expect { player.set_symbol(sym_arg) }.to_not change { player.symbol }
      end
    end
  end
end
