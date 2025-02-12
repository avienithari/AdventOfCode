local aoc = require("aoc-tools")

local example = "3, 4, 3, 1, 2"
local puzzle = aoc.read_file_to_string("./input06")

---@param input string
---@return table
local function read(input)
  local tbl = {}
  for num in string.gmatch(input, "%d+") do
    table.insert(tbl, tonumber(num))
  end

  return tbl
end

---@param input string
---@return integer
local function part_1(input)
  local fish = read(input)

  for _ = 1, 80 do
    local n = #fish
    for j = 1, n do
      if fish[j] == 0 then
        fish[j] = 6
        table.insert(fish, 8)
      else
        fish[j] = fish[j] - 1
      end
    end
  end

  return #fish
end

aoc.print(1, part_1(example), part_1(puzzle))

---@param tbl table
---@return table
local function count_occurences(tbl)
  local map = {}

  for _, v in ipairs(tbl) do
    local key = tostring(v)
    if map[key] then
      map[key] = map[key] + 1
    else
      map[key] = 1
    end
  end

  return map
end

---@param input string
---@return integer
local function part_2(input)
  local fish = count_occurences(read(input))

  for _ = 1, 256 do
    local freq = {}
    for key, value in pairs(fish) do
      if key == 0 then
        freq[6] = (freq[6] or 0) + value
        freq[8] = value
      else
        freq[key - 1] = (freq[key - 1] or 0) + value
      end
    end
    fish = freq
  end

  local sum = 0
  for key, _ in pairs(fish) do
    sum = sum + fish[key]
  end

  return sum
end

aoc.print(2, part_2(example), part_2(puzzle))
