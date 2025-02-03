local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example3")
local numbers = aoc.read_file_to_table("./input3")

local function part_1(input)
  local grid = {}
  for i, v in ipairs(input) do
    grid[i] = {}
    for j = 1, #v do
      grid[i][j] = string.sub(v, j, j)
    end
  end

  local helper = {}
  for col = 1, #grid[1] do
    local column = {}
    for row = 1, #grid do
      table.insert(column, grid[row][col])
    end
    table.insert(helper, column)
  end

  local gamma = {}
  for _, v in ipairs(helper) do
    local b, _ = aoc.get_most_common(v)
    table.insert(gamma, b)
  end

  local epsilon = {}
  for _, ch in ipairs(gamma) do
    print(ch)
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
