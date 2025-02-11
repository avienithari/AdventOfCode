local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example4") -- 4512 | 1924
local bingo = aoc.read_file_to_table("./input4") -- 74320 | 17884

---@param tbl table
---@param cols integer
---@return table (grid)
local function make_grid(tbl, cols)
  local grid = {}
  local row = {}

  for _, v in ipairs(tbl) do
    table.insert(row, tonumber(v))

    if #row == cols then
      table.insert(grid, row)
      row = {}
    end
  end

  if #row > 0 then
    table.insert(grid, row)
  end

  return grid
end

---@param present_number_board table
---@return boolean
local function check_win(present_number_board)
  local pnb = present_number_board
  if pnb[1] and pnb[2] and pnb[3] and pnb[4] and pnb[5] then
    return true
  elseif pnb[6] and pnb[7] and pnb[8] and pnb[9] and pnb[10] then
    return true
  elseif pnb[11] and pnb[12] and pnb[13] and pnb[14] and pnb[15] then
    return true
  elseif pnb[16] and pnb[17] and pnb[18] and pnb[19] and pnb[20] then
    return true
  elseif pnb[21] and pnb[22] and pnb[23] and pnb[24] and pnb[25] then
    return true
  elseif pnb[1] and pnb[6] and pnb[11] and pnb[16] and pnb[21] then
    return true
  elseif pnb[2] and pnb[7] and pnb[12] and pnb[17] and pnb[22] then
    return true
  elseif pnb[3] and pnb[8] and pnb[13] and pnb[18] and pnb[23] then
    return true
  elseif pnb[4] and pnb[9] and pnb[14] and pnb[19] and pnb[24] then
    return true
  elseif pnb[5] and pnb[10] and pnb[15] and pnb[20] and pnb[25] then
    return true
  else
    return false
  end
end

---@param number_to_check integer
---@param board table
---@param present_number_board integer
local function check_number(number_to_check, board, present_number_board)
  for i, number in ipairs(board) do
    if number == number_to_check then
      present_number_board[i] = true
      return
    end
  end
end

---@param input table
---@return integer
local function part_1(input)
  local game_numbers = aoc.string_split(input[1], ",")
  local bingo_numbers = {}
  for _, v in ipairs(game_numbers) do
    table.insert(bingo_numbers, tonumber(v))
  end

  local boards = make_grid(aoc.table_slice(input, 2), 25)
  local present_number_boards = {}
  for i = 1, #boards do
    present_number_boards[i] = {}
  end

  local win_board
  local win_number
  for _, number in ipairs(bingo_numbers) do
    for j, board in ipairs(boards) do
      check_number(number, board, present_number_boards[j])
    end

    for j, present_number_board in ipairs(present_number_boards) do
      if check_win(present_number_board) then
        win_board = j
        break
      end
    end

    if win_board then
      win_number = number
      break
    end
  end

  local sum = 0
  for i = 1, 25 do
    if not present_number_boards[win_board][i] then
      sum = sum + boards[win_board][i]
    end
  end

  return sum * win_number
end

aoc.print(1, part_1(example), part_1(bingo))
