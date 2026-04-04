local sep = package.config:sub(1, 1) == "\\" and ";" or ":"
local home = vim.env.HOME or ""
local nvm_dir = vim.env.NVM_DIR or (home ~= "" and (home .. "/.nvm") or nil)

local function exists(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function read_first_line(path)
  if not exists(path) then
    return nil
  end

  local lines = vim.fn.readfile(path, "", 1)
  return lines[1]
end

local function normalize_node_version(version)
  if not version or version == "" then
    return nil
  end

  if version:sub(1, 1) ~= "v" then
    return "v" .. version
  end

  return version
end

local function list_node_bins(base)
  if not exists(base) then
    return {}
  end

  local bins = {}
  for name, kind in vim.fs.dir(base) do
    if kind == "directory" then
      local bin = base .. "/" .. name .. "/bin"
      if exists(bin .. "/node") then
        bins[#bins + 1] = bin
      end
    end
  end
  table.sort(bins)
  return bins
end

local function resolve_node_bin()
  if not nvm_dir then
    return nil
  end

  local alias = normalize_node_version(read_first_line(nvm_dir .. "/alias/default"))
  if alias then
    local aliased_bin = nvm_dir .. "/versions/node/" .. alias .. "/bin"
    if exists(aliased_bin .. "/node") then
      return aliased_bin
    end
  end

  local bins = list_node_bins(nvm_dir .. "/versions/node")
  return bins[#bins]
end

local path_entries = vim.split(vim.env.PATH or "", sep, { plain = true, trimempty = true })
local filtered = {}
local seen = {}

for _, entry in ipairs(path_entries) do
  local is_missing_nvm_bin = nvm_dir and entry:match("^" .. vim.pesc(nvm_dir) .. "/versions/node/.+/bin$") and not exists(entry)
  if entry ~= "" and not is_missing_nvm_bin and not seen[entry] then
    filtered[#filtered + 1] = entry
    seen[entry] = true
  end
end

local node_bin = resolve_node_bin()
if node_bin and not seen[node_bin] then
  table.insert(filtered, 1, node_bin)
end

vim.env.PATH = table.concat(filtered, sep)

if node_bin then
  vim.env.NVM_BIN = node_bin
end
