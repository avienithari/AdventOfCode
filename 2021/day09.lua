local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example09")
local puzzle = aoc.read_file_to_table("./input09")

---@param data table
---@return table
local function parse_data(data)
  local grid = {}

  for _, number in ipairs(data) do
    local row = {}

    for j = 1, #number do
      local str = string.sub(number, j, j)
      table.insert(row, tonumber(str))
    end

    table.insert(grid, row)
  end

  return grid
end

---@param input table
---@return integer
local function part_1(input)
  local data = parse_data(input)

  local rows = #data
  local cols = #data[1]
  local sum = 0

  for row = 1, rows do
    for col = 1, cols do
      local low = true

      for _, d in ipairs({ { 0, 1 }, { 0, -1 }, { -1, 0 }, { 1, 0 } }) do
        local rr = row + d[1]
        local cc = col + d[2]

        if rr >= 1 and rr <= rows and cc >= 1 and cc <= cols then
          if data[rr][cc] <= data[row][col] then
            low = false
            break
          end
        end
      end

      if low then
        sum = sum + data[row][col] + 1
      end
    end
  end

  return sum
end

aoc.print(1, part_1(example), part_1(puzzle))
