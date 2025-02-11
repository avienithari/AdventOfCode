local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example01")
local depths = aoc.read_file_to_table("./input01")

---@param input table
---@return integer
local function part_1(input)
  local result = 0
  local last = 0

  for i, v in ipairs(input) do
    local current = assert(tonumber(v), "Not a number")

    if i > 1 then
      if current > last then
        result = result + 1
      end
    end

    last = current
  end

  return result
end

aoc.print(1, part_1(example), part_1(depths))

---@param list table
---@param fn function
---@param init integer
---@return integer
local function reduce(list, fn, init)
  local acc = init

  for k, v in ipairs(list) do
    if 1 == k and not init then
      acc = v
    else
      acc = fn(acc, v)
    end
  end

  return acc
end

---@param input table
---@return integer
local function part_2(input)
  local result = 0
  local last = 0

  for i, v in ipairs(input) do
    local window = { v, input[i + 1], input[i + 2] }
    local current = reduce(window, function(a, b)
      return a + b
    end, 0)

    if i > 1 then
      if current > last then
        result = result + 1
      end
    end

    last = current
  end

  return result
end

aoc.print(2, part_2(example), part_2(depths))
