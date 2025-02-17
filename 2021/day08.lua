---@diagnostic disable: need-check-nil
local aoc = require("aoc-tools")
local Set = require("Set")

local example_one_line = "./example_one_line"
local example = aoc.read_file_to_string("./example08")
local puzzle = aoc.read_file_to_string("./input08")
local puzzle_part_2 = "./input08"

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

---@param lhs table
---@return table
---@return table
local function find_numbers(lhs)
  local rhs = {}

  for i = 1, 4, 1 do
    rhs[i] = lhs[10 + i]
    lhs[10 + i] = nil
  end

  -- Find 1, 4, 7, 8:
  local digits = {}
  for _, number in ipairs(lhs) do
    if #number.string == 2 then
      digits[1] = number
    elseif #number.string == 3 then
      digits[7] = number
    elseif #number.string == 4 then
      digits[4] = number
    elseif #number.string == 7 then
      digits[8] = number
    end
  end

  -- Find other:
  for _, number in ipairs(lhs) do
    if #number.string == 5 then
      if (number.set - digits[1].set):len() == 3 then
        digits[3] = number
      elseif (number.set - digits[4].set):len() == 2 then
        digits[5] = number
      else
        digits[2] = number
      end
    elseif #number.string == 6 then
      if (number.set + digits[1].set):len() == 7 then
        digits[6] = number
      elseif (number.set - digits[4].set):len() == 3 then
        digits[0] = number
      else
        digits[9] = number
      end
    end
  end

  return digits, rhs
end

---@param input string
---@return integer
local function part_2(input)
  local file = io.open(input, "r")

  local sum = 0

  for line in file:lines() do
    local lhs = {}

    for word in line:gmatch("(%w+)") do
      local set = Set:new()
      for char in word:gmatch("(%w)") do
        set:add(char)
      end

      table.insert(lhs, { string = word, set = set })
    end

    local digits, numbers = find_numbers(lhs)

    local str_number = ""
    for _, number in ipairs(numbers) do
      for i = 0, 9 do
        if
          (number.set - digits[i].set):len() == 0
          and (digits[i].set - number.set):len() == 0
        then
          str_number = str_number .. tostring(i)
        end
      end
    end
    sum = sum + tonumber(str_number)
  end

  file:close()

  return sum
end

aoc.print(2, part_2(example_one_line), part_2(puzzle_part_2))
