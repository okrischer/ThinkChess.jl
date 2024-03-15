abstract type Piece end

mutable struct King <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
end

mutable struct Queen <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
end

mutable struct Rook <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
end

mutable struct Knight <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
end

mutable struct Bishop <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
end

mutable struct Pawn <: Piece
  const white::Bool
  value::Int
  row::Int
  col::Int
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

function isValid(pc::King, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  to = bd[r,c]
  valid = abs(pc.row - r) <= 1 && abs(pc.col - c) <= 1
  return valid && (ismissing(to) || to.white != pc.white)
end

function isValid(pc::Knight, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  to = bd[r,c]
  valid = (abs(pc.row - r) == 1 && abs(pc.col - c) == 2) ||
          (abs(pc.row - r) == 2 && abs(pc.col - c) == 1)
  return valid && (ismissing(to) || to.white != pc.white)
end

function isValid(pc::Rook, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  to = bd[r,c]
  valid = pc.row == r || pc.col == c
  valid || return false

  if pc.row == r # same row
    if c < pc.col # left to Rook
      for cc = c+1:pc.col-1
        ismissing(bd[r,cc]) || return false
      end
    else # right to Rook
      for cc = pc.col+1:c-1
        ismissing(bd[r,cc]) || return false
      end
    end
  end # same row

  if pc.col == c # same column
    if r < pc.row # up to Rook
      for rr = r+1:pc.row-1
        ismissing(bd[rr,c]) || return false
      end
    else # down to Rook
      for rr = pc.row+1:r-1
        ismissing(bd[rr,c]) || return false
      end
    end
  end # same column

  return valid && (ismissing(to) || to.white != pc.white)
end

function isValid(pc::Bishop, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  to = bd[r,c]
  valid = r-c == pc.row - pc.col || r+c == pc.row+pc.col
  valid || return false

  if r-c == pc.row-pc.col # same major diagonal
    if r < pc.row # upper
      for rr = r+1:pc.row-1
        for cc = c+1:pc.col-1
          if rr-cc == pc.row - pc.col
            ismissing(bd[rr,cc]) || return false
          end
        end
      end
    else # lower
      for rr = pc.row+1:r-1
        for cc = pc.col+1:c-1
          if rr-cc == pc.row - pc.col
            ismissing(bd[rr,cc]) || return false
          end
        end
      end
    end
  end

  if r+c == pc.row+pc.col # same minor diagonal
    if r < pc.row # upper
      for rr = r+1:pc.row-1
        for cc = pc.col+1:c-1
          if rr+cc == pc.row + pc.col
            ismissing(bd[rr,cc]) || return false
          end
        end
      end
    else # lower
      for rr = pc.row+1:r-1
        for cc = c+1:pc.col-1
          if rr+cc == pc.row + pc.col
            ismissing(bd[rr,cc]) || return false
          end
        end
      end
    end
  end

  return valid && (ismissing(to) || to.white != pc.white)
end

function isValid(pc::Queen, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  rook = Rook(true, 500, pc.row, pc.col)
  bishop = Bishop(true, 300, pc.row, pc.col)
  return isValid(rook, r, c, bd) || isValid(bishop, r, c, bd)
end

function isValid(pc::Pawn, r::Int, c::Int, bd::Matrix{Union{Missing, Piece}})
  to = bd[r,c]

  if pc.white # white Pawn
    # move
    (r == pc.row-1 && c == pc.col) && ismissing(to) && return true
    # capture
    (r == pc.row-1 && (c == pc.col-1 || c == pc.col+1)) &&
      (!ismissing(to) && to.white != pc.white) &&
      return true
    # initial move
    if (r == pc.row-2 && c == pc.col)
      one = bd[pc.row-1, c]
      (ismissing(one) && ismissing(to)) && return true
    end
  else # black Pawn
    # move
    (r == pc.row+1 && c == pc.col) && ismissing(to) && return true
    # capture
    (r == pc.row+1 && (c == pc.col-1 || c == pc.col+1)) &&
      (!ismissing(to) && to.white != pc.white) &&
      return true
    # initial move
    if (r == pc.row+2 && c == pc.col)
      one = bd[pc.row+1, c]
      (ismissing(one) && ismissing(to)) && return true
    end
  end

  return false
end