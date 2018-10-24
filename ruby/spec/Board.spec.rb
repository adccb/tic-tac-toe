require "minitest/autorun"
require_relative "../class/Board.rb"

describe "board" do
  before do
    @board = Board.new
  end
  
  it "sets values" do
    @board.set 2, 1, "hello"
    @board.set 1, 2, "world"

    assert_equal @board.board[1][2], "hello"
    assert_equal @board.board[2][1], "world"
  end

  it "gets rows" do
    @board.set 0, 0, 1
    @board.set 1, 0, 2
    @board.set 2, 0, 3

    assert_equal @board.get_row(0), [ 1, 2, 3 ]
    assert_equal @board.get_row(1), [ nil, nil, nil ]
  end

  it "gets columns" do
    @board.set 1, 0, 1
    @board.set 1, 1, 2
    @board.set 1, 2, 3

    assert_equal @board.get_col(1), [1, 2, 3]
    assert_equal @board.get_col(0), [nil, nil, nil]
  end

  it "errors on inputs out of range" do
    assert_raises IndexError do 
      @board.get_row 100
    end

    assert_raises IndexError do 
      @board.get_row -19
    end
    
    assert_raises IndexError do 
      @board.get_col 100
    end

    assert_raises IndexError do 
      @board.get_col -19
    end
  end

  it "gets a diagonal down" do
    @board.set 0, 0, 1
    @board.set 1, 1, 2
    @board.set 2, 2, 3
    assert_equal @board.get_diag(:down), [1, 2, 3]
  end

  it "gets a diagonal up" do
    @board.set 0, 2, 1
    @board.set 1, 1, 2
    @board.set 2, 0, 3
    assert_equal @board.get_diag(:up), [1, 2, 3]
  end

  it "determines if there's a win" do
    
  end
end
