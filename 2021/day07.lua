local aoc = require("aoc-tools")

local example =
  aoc.string_numbers_to_table(aoc.read_file_to_string("./example07"))
local puzzle = aoc.string_numbers_to_table(aoc.read_file_to_string("./input07"))

---@param nums table
---@return number
local function median(nums)
  table.sort(nums)
  local med = 0

  if #nums % 2 == 0 then
    med = (nums[#nums / 2] + nums[(#nums / 2) + 1]) / 2
  else
    med = nums[#nums / 2] / 2
  end

  return med
end

---@param input table
---@return integer
local function part_1(input)
  local med = median(input)
  local fuel = 0

  for _, v in ipairs(input) do
    fuel = fuel + math.abs(v - med)
  end

  return fuel
end

aoc.print(1, part_1(example), part_1(puzzle))

---@param input table
---@return number
local function part_2(input)
  table.sort(input)
  local max = input[#input]
  local fuel = math.huge

  for i = 1, max do
    local req = 0
    for _, v in ipairs(input) do
      local dist = math.abs(i - v)
      local cost = dist * (dist + 1) / 2
      req = req + cost
    end

    fuel = math.min(fuel, req)
  end

  return fuel
end

aoc.print(2, part_2(example), part_2(puzzle))
