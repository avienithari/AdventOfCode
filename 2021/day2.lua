local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example2") -- 150
local instructions = aoc.read_file_to_table("./input2")

---@param input table
---@return integer
local function part_1(input)
  local forward = 0
  local depth = 0

  for i = 1, #input, 2 do
    local value = input[i + 1]

    if input[i] == "forward" then
      forward = forward + value
    elseif input[i] == "down" then
      depth = depth + value
    else
      depth = depth - value
    end
  end

  return forward * depth
end

aoc.print(1, part_1(example), part_1(instructions))

---@param input table
---@return integer
local function part_2(input)
  local forward = 0
  local depth = 0
  local aim = 0

  for i = 1, #input, 2 do
    local value = input[i + 1]

    if input[i] == "down" then
      aim = aim + value
    elseif input[i] == "up" then
      aim = aim - value
    else
      forward = forward + value
      depth = depth + aim * value
    end
  end

  return forward * depth
end

aoc.print(2, part_2(example), part_2(instructions))
