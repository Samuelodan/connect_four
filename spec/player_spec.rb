#frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  subject(:player) { described_class.new }

  describe '#set_symbol' do
    context 'when argument is a valid string' do
      it 'changes @symbol to passed in symbol' do
        sym_arg = "\e[91m\u25CF\e[0m"
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

    context 'when argument is invalid (starts with word characters)' do
      it 'does nothing' do
        sym_arg = '33'
        expect { player.set_symbol(sym_arg) }.to_not change { player.symbol }
      end
    end
  end

  describe '#set_name' do
    it 'sets player name to passed-in name' do
      argument = 'Player2'
      player.set_name(argument)
      expect(player.name).to eq(argument)
    end
  end
end
