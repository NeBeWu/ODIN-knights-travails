# frozen_string_literal: true

# This class models a chessboard, it has a method to check
# if a given position is occupied.
class GameBoard
  def initialize
    @squares = Array.new(8) { Array.new(8, false) }
  end

  def [](horizontal_position, vertical_position)
    return nil if horizontal_position.negative? || vertical_position.negative? ||
                  horizontal_position > 7 || vertical_position > 7

    @squares[horizontal_position][vertical_position]
  end
end

# This class models a knight chess piece, it has a method
# to check possible moves.
class Knight
  def initialize(board, position = [0, 0])
    @board = board
    @position = position
  end

  def possible_move?(position)
    return false if @board.[](*position).nil?

    (position.first - @position.first).abs == 1 && (position.last - @position.last).abs == 2 ||
      (position.first - @position.first).abs == 2 && (position.last - @position.last).abs == 1
  end
end
