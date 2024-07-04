return {
  "f-person/git-blame.nvim",
  event = "User AstroGitFile",
  cmd = {
    "GitBlameToggle",
    "GitBlameEnable",
    "GitBlameOpenCommitURL",
    "GitBlameCopyCommitURL",
    "GitBlameOpenFileURL",
    "GitBlameCopyFileURL",
    "GitBlameCopySHA",
  },
  opts = {
    enabled = true,
    -- date_format = "%c",
    date_format = "%r",
    message_template = "  <author> 󰔠 <date> 󰈚 <summary>  <sha>",
    message_when_not_committed = "  Not Committed Yet",
  },
}
