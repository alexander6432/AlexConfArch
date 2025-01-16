return {
  "norcalli/nvim-colorizer.lua",
  event = "LazyFile",
  config = function()
    require("colorizer").setup({
      "*",
      css = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "foreground",
      },
    }, { mode = "background" })
  end,
}
