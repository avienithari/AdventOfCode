local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example03")
local numbers = aoc.read_file_to_table("./input03")

---@param data table
---@return table (grid)
local function make_grid(data)
  local grid = {}
  for i, v in ipairs(data) do
    grid[i] = {}
    for j = 1, #v do
      grid[i][j] = string.sub(v, j, j)
    end
  end

  return grid
end

---@param input table
---@return integer
local function part_1(input)
  local grid = make_grid(input)

  local column_bits = {}
  for col = 1, #grid[1] do
    local column = {}
    for row = 1, #grid do
      table.insert(column, grid[row][col])
    end
    table.insert(column_bits, column)
  end

  local gamma = {}
  for _, v in ipairs(column_bits) do
    local b, _ = aoc.get_most_common(v)
    table.insert(gamma, b)
  end

  local epsilon = {}
  for _, ch in ipairs(gamma) do
    if ch == "1" then
      table.insert(epsilon, 0)
    else
      table.insert(epsilon, 1)
    end
  end

  local gamma_result = tonumber(table.concat(gamma), 2)
  local epsilon_result = tonumber(table.concat(epsilon), 2)

  return gamma_result * epsilon_result
end

aoc.print(1, part_1(example), part_1(numbers))

---@param data table
---@param pos integer
---@param crit string ("oxygen" or "co2")
local function filter_bits(data, pos, crit)
  if #data == 1 then
    return data[1]
  end

  local zeros, ones = 0, 0
  for _, num in ipairs(data) do
    if string.sub(num, pos, pos) == "0" then
      zeros = zeros + 1
    else
      ones = ones + 1
    end
  end

  local target
  if crit == "oxygen" then
    target = (ones >= zeros) and "1" or "0"
  else
    target = (zeros <= ones) and "0" or "1"
  end

  local filtered = {}
  for _, num in ipairs(data) do
    if string.sub(num, pos, pos) == target then
      table.insert(filtered, num)
    end
  end

  return filter_bits(filtered, pos + 1, crit)
end

---@param input table
---@return integer
local function part_2(input)
  local oxygen = filter_bits(input, 1, "oxygen")
  local co2 = filter_bits(input, 1, "co2")

  return tonumber(oxygen, 2) * tonumber(co2, 2)
end

aoc.print(2, part_2(example), part_2(numbers))
