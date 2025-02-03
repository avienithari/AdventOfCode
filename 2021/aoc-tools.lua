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
function M.string_to_table(s)
  local smth = {}
  for line in s:gmatch("%S+") do
    table.insert(smth, line)
  end
  return smth
end

---@param path string
function M.read_file_to_table(path)
  return M.string_to_table(M.read_file_to_string(path))
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
