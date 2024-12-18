--return {
--         {
--                 "anniehu17/strawberry",

--                         -- load the colorscheme here
--                         vim.cmd([[set background=light]])
--                         vim.cmd([[let g:solarized_termcolors=256]])
--                         vim.cmd([[colorscheme pinkberry]])
--                 end,
--         },
-- }
-- return {
-- "folke/tokyonight.nvim",
-- lazy = true,
-- opts = { style = "moon" },
-- }
return {
  { "EdenEast/nightfox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dawnfox",
    },
  },
}
