#frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#found_four?' do
    context 'when there are 4 consecutive symbols' do
      it 'returns true' do
        symbol = "\e[91m\u25CF\e[0m"
        line = ['bread', symbol, symbol, symbol, symbol, 'john']
        result = board.found_four?(choice: symbol ,array: line)
        expect(result).to be(true)
      end
    end

    context 'when there are less than 4 consecutive symbols' do
      it 'returns false' do
        symbol = "\e[91m\u25CF\e[0m"
        line = ['bread', symbol, symbol, 'judas', symbol, symbol]
        result = board.found_four?(choice: symbol, array: line)
        expect(result).to be(false)
      end
    end
  end

  describe '#drop' do
    context 'when column 1 is empty' do
      it 'drops item into the grid' do
        symbol = "\e[91m\u25CF\e[0m"
        column_no = 1
        board.drop(column: column_no, symbol: symbol)
        expect(board.grid[35]).to eq(symbol)
      end

      it 'second slot is nil' do
        symbol = "\e[91m\u25CF\e[0m"
        column_no = 1
        board.drop(column: column_no, symbol: symbol)
        expect(board.grid[28]).to be(' ')
      end
    end

    context 'when column 1 has 4 symbols' do
      before do
        symbol = "\e[91m\u25CF\e[0m"
        board.grid[35], board.grid[28],
        board.grid[21], board.grid[14] = Array.new(4, symbol)
      end

      it 'drops item into the grid' do
        symbol = "\e[91m\u25CF\e[0m"
        column_no = 1
        board.drop(column: column_no, symbol: symbol)
        expect(board.grid[7]).to eq(symbol)
      end

      it 'top slot is empty' do
        symbol = "\e[91m\u25CF\e[0m"
        column_no = 1
        board.drop(column: column_no, symbol: symbol)
        expect(board.grid[0]).to be(' ')
      end
    end
  end

  describe '#column_full?' do
    context 'when column is not full' do
      before do
        symbol = "\e[91m\u25CF\e[0m"
        board.grid[36], board.grid[29],
        board.grid[22], board.grid[15] = Array.new(4, symbol)
      end

      it 'returns false' do
        result = board.column_full?(column: 2)
        expect(result).to be(false)
      end
    end

    context 'when column is full' do
      before do
        symbol = "\e[91m\u25CF\e[0m"
        board.grid[36], board.grid[29],
        board.grid[22], board.grid[15],
        board.grid[8], board.grid[1] = Array.new(6, symbol)
      end

      it 'returns true' do
        result = board.column_full?(column: 2)
        expect(result).to be(true)
      end
    end
  end

  describe '#moves_left?' do
    context 'when there are no moves left' do
      before do
        symbol = "\e[91m\u25CF\e[0m"
        board.grid.each_index do |index|
          board.grid[index] = symbol
        end
      end

      it 'returns false' do
        result = board.moves_left?
        expect(result).to be(false)
      end
    end

    context 'when there are moves left' do
      before do
        symbol = "\e[91m\u25CF\e[0m"
        board.grid.each_index do |index|
          board.grid[index] = symbol if index < board.grid.length - 1
        end
      end

      it 'returns true' do
        result = board.moves_left?
        expect(result).to be(true)
      end
    end
  end

  describe '#find_win?' do
    context 'when there are 4 successive symbols vertically' do
      before do
        current_player_sym = "\e[91m\u25CF\e[0m"
        board.grid[31], board.grid[24],
        board.grid[17], board.grid[10] = Array.new(4, current_player_sym)
      end

      it 'returns true' do
        current_player_sym = "\e[91m\u25CF\e[0m"
        result = board.find_win?(symbol: current_player_sym)
        expect(result).to be(true)
      end
    end

    context 'when there are 4 successive symbols horizontally' do
      before do
        current_player_sym = "\e[91m\u25CF\e[0m"
        board.grid[17], board.grid[18],
        board.grid[19], board.grid[20] = Array.new(4, current_player_sym)
      end

      it 'returns true' do
        current_player_sym = "\e[91m\u25CF\e[0m"
        result = board.find_win?(symbol: current_player_sym)
        expect(result).to be(true)
      end
    end

    context 'when there are 4 successive symbols diagonally' do
      before do
        current_player_sym = "\e[91m\u25CF\e[0m"
        board.grid[19], board.grid[25],
        board.grid[31], board.grid[37] = Array.new(4, current_player_sym)
      end

      it 'returns true' do
        current_player_sym = "\e[91m\u25CF\e[0m"
        result = board.find_win?(symbol: current_player_sym)
        expect(result).to be(true)
      end
    end

    context 'when there are < 4 successive symbols in any direction' do
      before do
        current_player_sym = "\e[91m\u25CF\e[0m"
        board.grid[1], board.grid[12],
        board.grid[13], board.grid[30] = Array.new(4, current_player_sym)
      end

      it 'returns false' do
        current_player_sym = "\e[91m\u25CF\e[0m"
        result = board.find_win?(symbol: current_player_sym)
        expect(result).to be(false)
      end
    end
  end

  describe '#reset' do
    before do
      symbol = "\e[91m\u25CF\e[0m"
      start_index = 0
      grid_size = board.grid.length
      board.grid[start_index, grid_size] = Array.new(grid_size, symbol)
    end

    it 'sets all slots to default value' do
      default = ' '
      board.reset
      result = board.grid.all?(default)
      expect(result).to be(true)
    end
  end
end
