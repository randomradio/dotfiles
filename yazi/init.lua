require("mermaid"):setup({
  backend = "auto",
  format = "png",
  timeout = 10,
  glow_timeout = 15,
  read_limit_mb = 8,
})

require("mdv-previewer"):setup({
  theme = "kanagawa",
  code_theme = "tokyonight",
  scroll_step = 3,
})
