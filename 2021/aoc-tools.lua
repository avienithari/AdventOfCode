M = {}

---@param path string
function M.read_file_to_string(path)
  local file, err = io.open(path, "rb")
  if not file then
    return err
  end

  ---@diagnostic disable-next-line: redefined-local
  local content, err = file:read("*a")
  file:close()
  if not content then
    return err
  else
    return content
  end
end

---@param s string
---@return table
function M.string_to_table(s)
  local tbl = {}
  for line in s:gmatch("%S+") do
    table.insert(tbl, line)
  end

  return tbl
end

---@param path string
function M.read_file_to_table(path)
  return M.string_to_table(M.read_file_to_string(path))
end

---extracts numbers from string and appends them to table
---@param s string
---@return table
function M.string_numbers_to_table(s)
  local tbl = {}

  for num in string.gmatch(s, "%d+") do
    table.insert(tbl, tonumber(num))
  end

  return tbl
end

---@param nums table
---@return number
function M.count_median(nums)
  table.sort(nums)
  local med = 0

  if #nums % 2 == 0 then
    med = (nums[#nums / 2] + nums[(#nums / 2) + 1]) / 2
  else
    med = nums[#nums / 2] / 2
  end

  return med
end

---@param collection table
---@return any, integer
function M.get_most_common(collection)
  local counts = {}
  local max_element, max_count = nil, 0

  for _, v in ipairs(collection) do
    counts[v] = (counts[v] or 0) + 1
    if counts[v] > max_count then
      max_count = counts[v]
      max_element = v
    end
  end

  return max_element, max_count
end

---@param tbl table
---@param first? integer default: 1
---@param last? integer default: #tbl
---@return table
function M.table_slice(tbl, first, last)
  local slice = {}
  for i = first or 1, last or #tbl do
    table.insert(slice, tbl[i])
  end
  return slice
end

---@param str string
---@param sep string
---@return table
function M.string_split(str, sep)
  if sep == nil then
    sep = "%s"
  end

  local t = {}
  for s in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(t, s)
  end

  return t
end

---@param tbl table
---@param cols integer
---@return table (grid)
function M.make_grid(tbl, cols)
  local grid = {}
  local row = {}

  for _, v in ipairs(tbl) do
    table.insert(row, tonumber(v))

    if #row == cols then
      table.insert(grid, row)
      row = {}
    end
  end

  if #row > 0 then
    table.insert(grid, row)
  end

  return grid
end

---return a copy of the array collapsed into one dimension.
---@param grid table
---@return table
function M.reduce_matrix_dimentions(grid)
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

---@param part integer
---@param example integer
---@param solution integer
function M.print(part, example, solution)
  print(
    "==========\n"
      .. "  "
      .. "PART "
      .. part
      .. "\n=========="
      .. "\n"
      .. "Example: "
      .. example
      .. "\nSolution: "
      .. solution
  )
end

return M
