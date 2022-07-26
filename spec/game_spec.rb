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
      it "sends #set_symbol to player1" do
        desired_symbol = "\e[91m\u25CF\e[0m"
        expect(player1).to receive(:set_symbol).with(desired_symbol)
        game.assign_symbol
      end
    end
  end

  describe '#assign_symbol' do
    context 'for player2' do
      it "sends #set_symbol to player2" do
        desired_symbol = "\e[37m\u25CF\e[0m"
        expect(player2).to receive(:set_symbol).with(desired_symbol)
        game.assign_symbol
      end
    end
  end

  describe '#assign_names' do
    context 'for player 1' do
      it "sends #set_name to player1" do
        desired_name = 'Player1'
        expect(player1).to receive(:set_name).with(desired_name)
        game.assign_names
      end
    end

    context 'for player 2' do
      it "sends #set_name to player2" do
        desired_name = 'Player2'
        expect(player2).to receive(:set_name).with(desired_name)
        game.assign_names
      end
    end
  end

  describe '#change_turn' do
    context 'when current_player is player1' do
      it 'makes player2 the current_player' do
        expect { game.change_turn }.to change { game.current_player }. from(game.player1).to(game.player2)
      end
    end
  end
end
