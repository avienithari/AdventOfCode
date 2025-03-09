local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example12")
local puzzle = aoc.read_file_to_table("./input12")

---@param data table
---@return table
local function split_caves(data)
  local caves = {}

  local delimiter = "-"
  for _, cave in ipairs(data) do
    local path = {}
    for match in (cave .. delimiter):gmatch("(.-)" .. delimiter) do
      table.insert(path, match)
    end

    table.insert(caves, path)
  end

  return caves
end

---@param cave string
---@return boolean
local function is_small(cave)
  if cave == string.lower(cave) then
    return true
  end

  return false
end

---@param cave string
---@param adj table
---@param visited table
---@return integer
local function dfs(cave, adj, visited)
  if cave == "end" then
    return 1
  end

  if is_small(cave) and visited[cave] then
    return 0
  end

  if is_small(cave) then
    visited[cave] = true
  end

  local count = 0
  for _, nbr in ipairs(adj[cave]) do
    if nbr ~= "start" then
      count = count + dfs(nbr, adj, visited)
    end
  end

  if is_small(cave) then
    visited[cave] = nil
  end

  return count
end

---@param input table
---@return integer
local function part_1(input)
  local visited = {}
  local adj = aoc.defaultdict(function()
    return {}
  end)

  local caves = split_caves(input)
  for _, pair in ipairs(caves) do
    local a, b = pair[1], pair[2]
    table.insert(adj[a], b)
    table.insert(adj[b], a)
  end

  return dfs("start", adj, visited)
end

aoc.print(1, part_1(example), part_1(puzzle))

---@param cave string
---@param adj table
---@param visited table
---@param visited_twice integer
---@return integer
---@diagnostic disable-next-line: redefined-local
local function dfs(cave, adj, visited, visited_twice)
  if cave == "end" then
    return 1
  end

  if is_small(cave) then
    visited[cave] = (visited[cave] or 0) + 1

    if visited[cave] == 2 then
      visited_twice = visited_twice + 1
    end

    if visited[cave] > 2 or visited_twice > 1 then
      visited[cave] = visited[cave] - 1
      return 0
    end
  end

  local count = 0
  for _, nbr in ipairs(adj[cave]) do
    if nbr ~= "start" then
      count = count + dfs(nbr, adj, visited, visited_twice)
    end
  end

  if is_small(cave) then
    visited[cave] = visited[cave] - 1
  end

  return count
end

---@param input table
---@return integer
local function part_2(input)
  local visited = aoc.defaultdict(function()
    return 0
  end)
  local adj = aoc.defaultdict(function()
    return {}
  end)

  local caves = split_caves(input)
  for _, pair in ipairs(caves) do
    local a, b = pair[1], pair[2]
    table.insert(adj[a], b)
    table.insert(adj[b], a)
  end

  return dfs("start", adj, visited, 0)
end

aoc.print(2, part_2(example), part_2(puzzle))
