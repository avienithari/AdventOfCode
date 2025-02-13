---@diagnostic disable: unused-local
local aoc = require("aoc-tools")
local inspect = require("inspect")

--[[
  `1` - two segments
  `4` - four segments
  `7` - three segments
  `8` - seven segments
--]]

local example = aoc.read_file_to_string("./example08")
local puzzle = aoc.read_file_to_string("./input08")

---@param s string
---@return table
local function get_rhs(s)
  local signals = aoc.string_split(s, "\n")

  local rhs = {}
  for _, signal in ipairs(signals) do
    local r = aoc.string_split(signal, "|")[2]
    local sig = aoc.string_split(r, " ")
    for _, value in ipairs(sig) do
      table.insert(rhs, value)
    end
  end

  return rhs
end

---@param input string
---@return integer
local function part_1(input)
  local signals = get_rhs(input)

  local sum = 0
  for _, v in ipairs(signals) do
    if #v == 2 or #v == 3 or #v == 4 or #v == 7 then
      sum = sum + 1
    end
  end

  return sum
end

aoc.print(1, part_1(example), part_1(puzzle))
