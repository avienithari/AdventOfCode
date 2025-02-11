local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example5") -- 5 |
local puzzle = aoc.read_file_to_table("./input5") -- 7085 |

---@param tbl table
---@return table
local function make_points(tbl)
  local points = {}
  for _, v in ipairs(tbl) do
    if v ~= "->" then
      local s_point = aoc.string_split(v, ",")
      local point = {}
      for i, c in ipairs(s_point) do
        table.insert(point, i, tonumber(c))
      end
      table.insert(points, point)
    end
  end

  return points
end

---@param tbl table
---@return table
local function make_pairs(tbl)
  local pairs = {}
  local point_pair = {}
  for _, point in ipairs(tbl) do
    for _, c in ipairs(point) do
      table.insert(point_pair, c)
    end

    if #point_pair == 4 then
      table.insert(pairs, point_pair)
      point_pair = {}
    end
  end

  return pairs
end

---@param points table
---@return table
local function get_dimentions(points)
  local max_x = 0
  local max_y = 0
  for _, point in ipairs(points) do
    if point[1] > max_x then
      max_x = point[1]
    end
    if point[2] > max_y then
      max_y = point[2]
    end
  end

  return { max_x + 1, max_y + 1 }
end

---@param point_pairs table
---@return table
local function filter_lines(point_pairs)
  local lines = {}
  for _, point_pair in ipairs(point_pairs) do
    if point_pair[1] == point_pair[3] or point_pair[2] == point_pair[4] then
      table.insert(lines, point_pair)
    end
  end

  return lines
end

---@param size table
---@return table
local function generate_canvas(size)
  local rows = size[1]
  local cols = size[2]
  local zeros = {}
  for _ = 1, cols do
    local row = {}
    for _ = 1, rows do
      table.insert(row, 0)
    end
    table.insert(zeros, row)
  end

  return zeros
end

---@param n integer
---@param m integer
---@return integer
---@return integer
local function range(n, m)
  if m > n then
    return n, m
  end

  return m, n
end

---@param coordinates table
---@param points table
---@return table
local function draw_lines(coordinates, points)
  local canvas = generate_canvas(get_dimentions(points))

  for _, line in ipairs(coordinates) do
    local x1 = line[1] + 1
    local y1 = line[2] + 1
    local x2 = line[3] + 1
    local y2 = line[4] + 1
    if x1 == x2 then
      local start, stop = range(y1, y2)
      for j = start, stop do
        canvas[j][x1] = canvas[j][x1] + 1
      end
    elseif y1 == y2 then
      local start, stop = range(x1, x2)
      for j = start, stop do
        canvas[y1][j] = canvas[y1][j] + 1
      end
    end
  end

  return canvas
end

---return a copy of the array collapsed into one dimension.
---@param grid table
---@return table
local function flatten(grid)
  local tbl = {}

  local function rec(sub_tbl)
    for _, value in ipairs(sub_tbl) do
      if type(value) == "table" then
        rec(value)
      else
        table.insert(tbl, value)
      end
    end
  end

  rec(grid)

  return tbl
end

---@param tbl table
---@return integer
local function count_overlap(tbl)
  local sum = 0
  local crosses = flatten(tbl)
  for _, v in ipairs(crosses) do
    if v >= 2 then
      sum = sum + 1
    end
  end

  return sum
end

---@param input table
---@return integer
local function part_1(input)
  local points = make_points(input)
  local pairs = make_pairs(points)
  local lines = filter_lines(pairs)
  local canvas = draw_lines(lines, points)
  local solution = count_overlap(flatten(canvas))

  return solution
end

aoc.print(1, part_1(example), part_1(puzzle))
