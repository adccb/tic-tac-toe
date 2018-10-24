class Board
  def initialize
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end
  
  def board() @board end

  def set x, y, v
    @board[y][x] = v
  end

  def get_row y
    raise IndexError if y > @board.length or y < 0
    @board[y]
  end

  def get_col x
    raise IndexError if x > @board[0].length or x < 0
    @board.map do |row| row[x] end
  end

  def get_diag dir
    raise ArgumentError if not [:up, :down].include? dir
    if dir == :down
      @board.map.with_index do |itm, idx| @board[idx][idx] end
    else
      @board.map.with_index do |itm, idx| @board[-idx - 1][idx] end
    end
  end
end
