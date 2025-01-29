---@param cwd string
local function validate_django_project(cwd)
  local result = vim.fn.globpath(cwd, "**/manage.py", false, true)
  return #result > 0
end
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*/templates/*.html", "*/templates/*/*.html", "**/templates/**/*.html" },
  callback = function()
    local cwd = vim.fn.getcwd()
    if validate_django_project(cwd) then vim.opt_local.filetype = "htmldjango" end
  end,
})
