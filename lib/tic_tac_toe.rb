class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ]

  def display_board
  	puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  	puts "-----------"
  	puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  	puts "-----------"
  	puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(string)
    return string.to_i - 1
  end

  def move(index, player)
    return @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
  	puts "Please enter 1-9:"
    input = gets.strip
  	index = input_to_index(input)
  	if valid_move?(index)
      move(index, current_player)
  		display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |spot|
      if spot == "X" || spot == "O"
        counter += 1
      end
    end
    counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.detect do | win_combination | # win_combination is going to be on the first loop [0,1,2]
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      position_1 == position_2 && position_1 == position_3 && position_taken?(win_index_1)
    end
  end

  def full?
    @board.all? do |spot|
      spot == "X" || spot == "O"
    end
  end

  def draw?
    if won? == nil && full? == true
      return true
    else
      return false
    end
  end

  def over?
    if draw? || full?|| won?
      return true
    end
  end

  def winner
    win_combination = won? #[3,4,5]
    if win_combination == nil
      return nil
    end
    if @board[win_combination[0]] == "X"
      return "X"
    end
    if @board[win_combination[0]] == "O"
      return "O"
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations " + winner + "!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
