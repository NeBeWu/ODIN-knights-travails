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
    @move_directions = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end

  def possible_move?(move, position = @position)
    return false if @board.[](*move).nil?

    (move.first - position.first).abs == 1 && (move.last - position.last).abs == 2 ||
      (move.first - position.first).abs == 2 && (move.last - position.last).abs == 1
  end

  def moves(position = @position)
    @move_directions.map do |direction|
      [position.first + direction.first, position.last + direction.last]
    end.select do |move|
      possible_move?(move, position)
    end
  end

  # This method uses recursion to implement a breadth first search on
  # the 'fictional' graph of paths to find a path between the origin
  # (represented in the path variable first method call) and the
  # destiny.
  def search_path(destiny, path = [@position], queue = [])
    return path if path.last == destiny

    possible_paths = moves(path.last).map { |move| path + [move] }

    queue.push(*possible_paths)

    search_path(destiny, queue.shift, queue)
  end

  def knight_moves(origin, destiny)
    search_path(destiny, [origin])
  end
end
