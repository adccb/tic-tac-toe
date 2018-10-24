class Renderer
  def initialize kwargs
    @game = kwargs[:game]
    @board = kwargs[:board]
  end

  def lift itm
    itm ? itm : " "
  end

  def render
    top = "   A   B   C \n"
    board = @board.board.map.with_index { |row, idx|
      r = row.map { |itm| lift(itm) }
      (idx + 1).to_s + "  " + r.join(" | ") + " "
    }.join "\n  ---+---+---\n"
    puts "\n" + top + board
  end
end
