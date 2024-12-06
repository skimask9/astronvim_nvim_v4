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
    display_virtual_text = false,
    -- date_format = "%c",
    date_format = "%r",
    -- message_template = "  <author> 󰔠 <date> 󰈚 <summary>  <sha>",
    message_template = "  <author> 󰔠 <date> 󰈚 <summary>",
    message_when_not_committed = "  Not Committed Yet",
  },
}
