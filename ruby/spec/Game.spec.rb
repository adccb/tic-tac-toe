require "minitest/autorun"
require_relative "../class/Game.rb"
require_relative "../class/Board.rb"

describe "Game" do
  it "moves the player correctly" do
    game = Game.new :board => nil
    
    assert_equal game.current_player, "x"

    game.change_player
    assert_equal game.current_player, "o"

    game.change_player
    assert_equal game.current_player, "x"
  end

  it "tells the board when someone has moved" do
    mock_board = Minitest::Mock.new
    @game = Game.new :board => mock_board

    mock_board.expect :set, nil, [1, 2, 3]
    mock_board.expect :get_row, [], [2]
    mock_board.expect :get_col, [], [1]
    mock_board.expect :get_diag, nil, [:up]
    mock_board.expect :get_diag, nil, [:down]

    @game.move 1, 2, 3
  end

  it "identifies a win horizontally, vertically, and diagonally" do
    # horizontally
    board = Board.new
    board.set 0, 0, 'x'
    board.set 1, 0, 'x'
    board.set 2, 0, 'x'

    assert Game.new(:board => board).win? 0, 2

    # vertically
    board = Board.new
    board.set 0, 0, 'x'
    board.set 0, 1, 'x'
    board.set 0, 2, 'x'

    assert Game.new(:board => board).win? 2, 0

    # diag :up
    board = Board.new
    board.set 2, 0, 'x'
    board.set 1, 1, 'x'
    board.set 0, 2, 'x'

    assert Game.new(:board => board).win? 1, 1

    # diag :down
    board = Board.new
    board.set 0, 0, 'x'
    board.set 1, 1, 'x'
    board.set 2, 2, 'x'

    assert Game.new(:board => board).win? 0, 2
  end
end

