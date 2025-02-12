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
