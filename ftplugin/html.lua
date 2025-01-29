local setlocal = vim.opt_local

---@param cwd string
local function validate_django_project(cwd)
  local result = vim.fn.globpath(cwd, "**/manage.py", false, true)

  return #result > 0
end

local cwd = vim.fn.getcwd()

if validate_django_project(cwd) then setlocal.filetype = "htmldjango" end
