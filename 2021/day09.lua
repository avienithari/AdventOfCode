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
      local is_low = true

      for _, direction in ipairs({ { 0, 1 }, { 0, -1 }, { -1, 0 }, { 1, 0 } }) do
        local rr = row + direction[1]
        local cc = col + direction[2]

        if rr >= 1 and rr <= rows and cc >= 1 and cc <= cols then
          if data[rr][cc] <= data[row][col] then
            is_low = false
            break
          end
        end
      end

      if is_low then
        sum = sum + data[row][col] + 1
      end
    end
  end

  return sum
end

aoc.print(1, part_1(example), part_1(puzzle))

---@param data table
---@param start_row integer
---@param start_col integer
---@param visited table
---@return integer
local function bfs(data, start_row, start_col, visited)
  local queue = {}
  local size = 0
  local directions = { { 0, 1 }, { 0, -1 }, { -1, 0 }, { 1, 0 } }

  table.insert(queue, { start_row, start_col })
  visited[start_row][start_col] = true

  while #queue > 0 do
    local current = table.remove(queue, 1)
    local row, col = current[1], current[2]
    size = size + 1

    for _, dir in ipairs(directions) do
      local new_row = row + dir[1]
      local new_col = col + dir[2]

      if
        new_row >= 1
        and new_row <= #data
        and new_col >= 1
        and new_col <= #data[1]
      then
        if not visited[new_row][new_col] and data[new_row][new_col] < 9 then
          visited[new_row][new_col] = true
          table.insert(queue, { new_row, new_col })
        end
      end
    end
  end

  return size
end

---@param data table
---@return table
local function find_basins(data)
  local visited = {}
  for i = 1, #data do
    visited[i] = {}
  end

  local sizes = {}
  for row = 1, #data do
    for col = 1, #data[1] do
      if data[row][col] < 9 and not visited[row][col] then
        local size = bfs(data, row, col, visited)
        table.insert(sizes, size)
      end
    end
  end

  return sizes
end

---@param input table
---@return integer
local function part_2(input)
  local data = parse_data(input)
  local sizes = find_basins(data)

  table.sort(sizes)
  local ans = 1
  for i = #sizes - 2, #sizes do
    ans = ans * sizes[i]
  end

  return ans
end

aoc.print(2, part_2(example), part_2(puzzle))
