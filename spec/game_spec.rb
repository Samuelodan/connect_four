# frozen_string_literal

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

RSpec.describe Game do
  subject(:game) { described_class.new(board, player1, player2) }
  let(:board) { Board.new }
  let(:player1) { Player.new }
  let(:player2) { Player.new }

  describe '#assign_symbol' do
    context 'for player1' do
      it "changes player1's symbol from nil" do
        desired_symbol = "\e[91m\u25CF\e[0m"
        expect { game.assign_symbol }.to change { game.player1.symbol }.from(nil).to(desired_symbol)
      end
    end
  end

  describe '#assign_symbol' do
    context 'for player1' do
      it "changes player2's symbol from nil" do
        desired_symbol = "\e[37m\u25CF\e[0m"
        expect { game.assign_symbol }.to change { game.player2.symbol }.from(nil).to(desired_symbol)
      end
    end
  end
end
