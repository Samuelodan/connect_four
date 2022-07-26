# frozen_string_literal: true

class Player
  attr_reader :symbol, :name

  def initialize
    @symbol = nil
    @name = nil
  end

  def set_symbol(sym)
    return unless sym.is_a?(String)
    return if sym.is_a?(String) && !sym.match?(/^\W{2}/)

    @symbol = sym
  end

  def set_name(name)
    @name = name
  end
end
