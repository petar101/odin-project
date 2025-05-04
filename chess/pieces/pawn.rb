class Pawn < Piece
  def symbol 
    color == :white ? '♙' : '♟'
  end

  def direction 
    color == :white ? -1 : 1 
  end

  def move(board)
    moves = []

    # One step forward
    new_row = row + direction
    if on_board?(new_row, col) && board[new_row][col].nil?
      moves << [new_row, col]
    end

    # Diagonal captures (left and right)
    [-1, 1].each do |dc|
      new_col = col + dc
      if on_board?(new_row, new_col)
        target = board[new_row][new_col]
        if target && target.color != color
          moves << [new_row, new_col]
        end
      end
    end

    moves
  end
end