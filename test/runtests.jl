using ThinkChess
using Test

@testset "pieces.jl" begin
  # test board setup
  board = ThinkChess.initialize_board()
  bQ = board[1,4]
  wQ = board[8,4]
  @test typeof(bQ) == ThinkChess.Queen && !bQ.white && bQ.value == 900 && bQ.row == 1 && bQ.col == 4
  @test typeof(wQ) == ThinkChess.Queen &&  wQ.white && wQ.value == 900 && wQ.row == 8 && wQ.col == 4
  pieces = collect(skipmissing(board))
  @test count(p -> (typeof(p) == ThinkChess.King), pieces) == 2
  @test count(p -> (typeof(p) == ThinkChess.Queen), pieces) == 2
  @test count(p -> (typeof(p) == ThinkChess.Rook), pieces) == 4
  @test count(p -> (typeof(p) == ThinkChess.Bishop), pieces) == 4
  @test count(p -> (typeof(p) == ThinkChess.Knight), pieces) == 4
  @test count(p -> (typeof(p) == ThinkChess.Pawn && p.white), pieces) == 8
  @test count(p -> (typeof(p) == ThinkChess.Pawn && !p.white), pieces) == 8

  # test valid moves
  # King
  @test !ThinkChess.isValid(board[1,5], 2, 5, board)
  board[2,5] = missing
  @test ThinkChess.isValid(board[1,5], 2, 5, board)
  board[2,5] = ThinkChess.Pawn(true, 100, 2, 5)
  @test ThinkChess.isValid(board[1,5], 2, 5, board)
  # Knight
  @test !ThinkChess.isValid(board[1,2], 3, 2, board)
  @test !ThinkChess.isValid(board[1,2], 2, 4, board)
  @test ThinkChess.isValid(board[1,2], 3, 3, board)
  board[3,3] = ThinkChess.Pawn(true, 100, 3, 3)
  @test ThinkChess.isValid(board[1,2], 3, 3, board)
  # Rook
  board = Matrix{Union{Missing, ThinkChess.Piece}}(missing, 8, 8)
  board[5,6] = ThinkChess.Rook(true, 500, 5, 6)
  board[5,3] = ThinkChess.Pawn(true, 100, 5, 3)
  board[5,1] = ThinkChess.Pawn(false, 100, 5, 1)
  board[2,6] = ThinkChess.Pawn(false, 100, 2, 6)
  @test ThinkChess.isValid(board[5,6], 2, 6, board)
  @test ThinkChess.isValid(board[5,6], 8, 6, board)
  @test ThinkChess.isValid(board[5,6], 5, 8, board)
  @test !ThinkChess.isValid(board[5,6], 6, 7, board)
  @test !ThinkChess.isValid(board[5,6], 5, 3, board)
  @test !ThinkChess.isValid(board[5,6], 5, 1, board)
  #Bishop
  board = Matrix{Union{Missing, ThinkChess.Piece}}(missing, 8, 8)
  board[5,6] = ThinkChess.Bishop(true, 300, 5, 6)
  board[4,7] = ThinkChess.Pawn(true, 100, 4, 7)
  board[3,8] = ThinkChess.Pawn(false, 100, 3, 8)
  board[2,3] = ThinkChess.Pawn(false, 100, 2, 3)
  @test ThinkChess.isValid(board[5,6], 2, 3, board)
  @test ThinkChess.isValid(board[5,6], 8, 3, board)
  @test ThinkChess.isValid(board[5,6], 7, 8, board)
  @test !ThinkChess.isValid(board[5,6], 4, 7, board)
  @test !ThinkChess.isValid(board[5,6], 3, 8, board)
  #Queen
  board = Matrix{Union{Missing, ThinkChess.Piece}}(missing, 8, 8)
  board[5,6] = ThinkChess.Queen(true, 900, 5, 6)
  board[5,3] = ThinkChess.Pawn(true, 100, 5, 3)
  board[4,7] = ThinkChess.Pawn(true, 100, 4, 7)
  board[2,3] = ThinkChess.Pawn(false, 100, 2, 3)
  board[2,6] = ThinkChess.Pawn(false, 100, 2, 6)
  board[3,8] = ThinkChess.Pawn(false, 100, 3, 8)
  @test ThinkChess.isValid(board[5,6], 2, 3, board)
  @test ThinkChess.isValid(board[5,6], 2, 6, board)
  @test ThinkChess.isValid(board[5,6], 8, 6, board)
  @test ThinkChess.isValid(board[5,6], 8, 3, board)
  @test ThinkChess.isValid(board[5,6], 8, 6, board)
  @test !ThinkChess.isValid(board[5,6], 5, 3, board)
  @test !ThinkChess.isValid(board[5,6], 4, 7, board)
  @test !ThinkChess.isValid(board[5,6], 3, 8, board)
  # Pawn
  board = Matrix{Union{Missing, ThinkChess.Piece}}(missing, 8, 8)
  board[7,5] = ThinkChess.Pawn(true, 100, 7, 5)
  board[6,4] = ThinkChess.Pawn(false, 100, 6, 4)
  @test ThinkChess.isValid(board[7,5], 6, 4, board)
  @test ThinkChess.isValid(board[7,5], 6, 5, board)
  @test ThinkChess.isValid(board[7,5], 5, 5, board)
  board[6,5] = ThinkChess.Pawn(false, 100, 6, 5)
  @test !ThinkChess.isValid(board[7,5], 6, 5, board)
  @test !ThinkChess.isValid(board[7,5], 5, 5, board)
  board[2,4] = ThinkChess.Pawn(false, 100, 2, 4)
  board[3,5] = ThinkChess.Pawn(true, 100, 3, 5)
  @test ThinkChess.isValid(board[2,4], 3, 5, board)
  @test ThinkChess.isValid(board[2,4], 3, 4, board)
  @test ThinkChess.isValid(board[2,4], 4, 4, board)
  board[3,4] = ThinkChess.Pawn(true, 100, 3, 4)
  @test !ThinkChess.isValid(board[2,4], 3, 4, board)
  @test !ThinkChess.isValid(board[2,4], 4, 4, board)

end
