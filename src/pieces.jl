abstract type Piece end

mutable struct King <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

mutable struct Queen <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

mutable struct Rook <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

mutable struct Knight <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

mutable struct Bishop <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

mutable struct Pawn <: Piece
  const white::Bool
  value::UInt16
  row::UInt8
  col::UInt8
end

function initialize_board()
  board = Matrix{Union{Missing, Piece}}(missing, 8, 8)

  board[1,1] = Rook(false, 500, 1, 1)
  board[1,2] = Knight(false, 300, 1, 2)
  board[1,3] = Bishop(false, 300, 1, 3)
  board[1,4] = Queen(false, 900, 1, 4)
  board[1,5] = King(false, 0, 1, 5)
  board[1,6] = Bishop(false, 300, 1, 6)
  board[1,7] = Knight(false, 300, 1, 7)
  board[1,8] = Rook(false, 500, 1, 8)

  board[2,1] = Pawn(false, 100, 2, 1)
  board[2,2] = Pawn(false, 100, 2, 2)
  board[2,3] = Pawn(false, 100, 2, 3)
  board[2,4] = Pawn(false, 100, 2, 4)
  board[2,5] = Pawn(false, 100, 2, 5)
  board[2,6] = Pawn(false, 100, 2, 6)
  board[2,7] = Pawn(false, 100, 2, 7)
  board[2,8] = Pawn(false, 100, 2, 8)

  board[7,1] = Pawn(true, 100, 7, 1)
  board[7,2] = Pawn(true, 100, 7, 2)
  board[7,3] = Pawn(true, 100, 7, 3)
  board[7,4] = Pawn(true, 100, 7, 4)
  board[7,5] = Pawn(true, 100, 7, 5)
  board[7,6] = Pawn(true, 100, 7, 6)
  board[7,7] = Pawn(true, 100, 7, 7)
  board[7,8] = Pawn(true, 100, 7, 8)

  board[8,1] = Rook(true, 500, 8, 1)
  board[8,2] = Knight(true, 300, 8, 2)
  board[8,3] = Bishop(true, 300, 8, 3)
  board[8,4] = Queen(true, 900, 8, 4)
  board[8,5] = King(true, 0, 8, 5)
  board[8,6] = Bishop(true, 300, 8, 6)
  board[8,7] = Knight(true, 300, 8, 7)
  board[8,8] = Rook(true, 500, 8, 8)

  return board
end