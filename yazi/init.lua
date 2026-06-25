local chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

require("mermaid"):setup({
  backend = "mmdc",
  format = "png",
  read_limit_mb = 8,
  mmdc_puppeteer_executable_path = chrome,
})

require("mdv-previewer"):setup({
  theme = "kanagawa",
  code_theme = "tokyonight",
  scroll_step = 3,
})
