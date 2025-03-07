local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example10")
local puzzle = aoc.read_file_to_table("./input10")

---@param line string
---@return integer
local function find_corrupted(line)
  local pairs = {
    { "(", ")" },
    { "[", "]" },
    { "{", "}" },
    { "<", ">" },
  }
  local points = {
    [")"] = 3,
    ["]"] = 57,
    ["}"] = 1197,
    [">"] = 25137,
  }

  local stack = {}
  for char in line:gmatch(".") do
    local is_good = false

    for _, pair in ipairs(pairs) do
      if char == pair[1] then
        table.insert(stack, char)
        is_good = true
      elseif char == pair[2] then
        if #stack > 0 and stack[#stack] == pair[1] then
          table.remove(stack)
          is_good = true
        end
      end
    end

    if is_good == false then
      return points[char]
    end
  end

  return 0
end

---@param input table
---@return integer
local function part_1(input)
  local points = 0
  for _, line in ipairs(input) do
    points = points + find_corrupted(line)
  end

  return points
end

aoc.print(1, part_1(example), part_1(puzzle))

---@param line string
---@return integer
local function complete_line(line)
  local pairs = {
    { "(", ")" },
    { "[", "]" },
    { "{", "}" },
    { "<", ">" },
  }
  local points = {
    ["("] = 1,
    ["["] = 2,
    ["{"] = 3,
    ["<"] = 4,
  }

  local stack = {}
  for char in line:gmatch(".") do
    for _, pair in ipairs(pairs) do
      if char == pair[1] then
        table.insert(stack, char)
      elseif char == pair[2] then
        if #stack > 0 and stack[#stack] == pair[1] then
          table.remove(stack)
        end
      end
    end
  end

  local score = 0
  for i = #stack, 1, -1 do
    score = score * 5
    score = score + points[stack[i]]
  end

  return score
end

---@param input table
---@return integer
local function part_2(input)
  local valid_data = {}

  for _, line in ipairs(input) do
    if find_corrupted(line) == 0 then
      table.insert(valid_data, line)
    end
  end

  local scores = {}
  for _, line in ipairs(valid_data) do
    table.insert(scores, complete_line(line))
  end

  table.sort(scores)
  return scores[math.floor(#scores / 2) + 1]
end

aoc.print(2, part_2(example), part_2(puzzle))
