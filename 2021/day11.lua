local aoc = require("aoc-tools")

local example = aoc.read_file_to_table("./example11")
local puzzle = aoc.read_file_to_table("./input11")

---@param tbl table
---@return table
local function make_grid(tbl)
  local grid = {}

  for i, num in ipairs(tbl) do
    grid[i] = {}
    for char in num:gmatch(".") do
      table.insert(grid[i], tonumber(char))
    end
  end

  return grid
end

---@return table
local function flashed_table()
  local flashed = {}
  for i = 1, 10 do
    flashed[i] = {}
    for j = 1, 10 do
      flashed[i][j] = false
    end
  end

  return flashed
end

---@param octos table
---@return table
local function increment_energy(octos)
  for i = 1, 10 do
    for j = 1, 10 do
      octos[i][j] = octos[i][j] + 1
    end
  end

  return octos
end

---@param octos table
---@return integer
local function radiation(octos)
  local flashed = flashed_table()

  local function flash(i, j)
    if flashed[i][j] then
      return
    end

    flashed[i][j] = true
    octos[i][j] = 0

    for ii = -1, 1 do
      for jj = -1, 1 do
        local di, dj = i + ii, j + jj
        if
          di >= 1
          and di <= 10
          and dj >= 1
          and dj <= 10
          and not flashed[di][dj]
        then
          octos[di][dj] = octos[di][dj] + 1
          if octos[di][dj] > 9 then
            flash(di, dj)
          end
        end
      end
    end
  end

  for i = 1, 10 do
    for j = 1, 10 do
      if octos[i][j] > 9 then
        flash(i, j)
      end
    end
  end

  local flash_count = 0
  for i = 1, 10 do
    for j = 1, 10 do
      if flashed[i][j] then
        flash_count = flash_count + 1
      end
    end
  end

  return flash_count
end

---@param input table
---@return integer
local function part_1(input)
  local octos = make_grid(input)
  local ans = 0

  for _ = 1, 100 do
    local step = increment_energy(octos)
    local count = radiation(step)
    ans = ans + count
  end

  return ans
end

aoc.print(1, part_1(example), part_1(puzzle))
