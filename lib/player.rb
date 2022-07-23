#frozen_string_literal: true

class Player
  attr_reader :symbol

  def initialize
    @symbol = nil 
  end

  def set_symbol(sym)
    return unless sym.is_a?(String)
    return if sym.is_a?(String) && !sym.match?(/^\W{1}/)

    @symbol = sym
  end
end
