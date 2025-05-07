# frozen_string_literal: true

module CheckRules
  require_relative 'pieces/king'

  def in_check?(color)
    king_pos = nil

    # Step 1: find the king's position
    @board.grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        if piece.is_a?(King) && piece.color == color
          king_pos = [r, c]
          break
        end
      end
    end

    # Step 2: check if any enemy piece can move to the king's position
    @board.grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color == color

        return true if piece.move(@board.grid).include?(king_pos)
      end
    end

    false
  end

  def checkmate?(color)
    return false unless in_check?(color) # If not in check, can't be checkmate

    @board.grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next if piece.nil? || piece.color != color

        piece.move(@board.grid).each do |to_row, to_col|
          # Save state
          from_square = @board.grid[r][c]
          to_square = @board.grid[to_row][to_col]
          old_row = piece.row
          old_col = piece.col

          # Make the move
          @board.grid[to_row][to_col] = piece
          @board.grid[r][c] = nil
          piece.row = to_row
          piece.col = to_col

          # Check if that move stops the check
          unless in_check?(color)
            # Undo the move
            @board.grid[r][c] = from_square
            @board.grid[to_row][to_col] = to_square
            piece.row = old_row
            piece.col = old_col
            return false
          end

          # Undo the move
          @board.grid[r][c] = from_square
          @board.grid[to_row][to_col] = to_square
          piece.row = old_row
          piece.col = old_col
        end
      end
    end

    true  # No legal moves stop the check
  end
end
