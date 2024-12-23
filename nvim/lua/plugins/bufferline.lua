return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Alternar Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Eliminar Buffers no Fijados" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Eliminar Buffers a la Derecha" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Eliminar Buffers a la Izquierda" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer Anterior" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer Siguiente" },
    { "(b", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer Anterior" },
    { ")b", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer Siguiente" },
    { "(B", "<cmd>BufferLineMovePrev<cr>", desc = "Mover Buffer Anterior" },
    { ")B", "<cmd>BufferLineMoveNext<cr>", desc = "Mover Buffer Siguiente" },
  },
  opts = {
    options = {
      separator_style = "slant",
      numbers = function(opts)
        return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = LazyVim.config.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      ---@param opts bufferline.IconFetcherOpts
      get_element_icon = function(opts)
        return LazyVim.config.icons.ft[opts.filetype]
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
