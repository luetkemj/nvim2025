return {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- using master to fix issues with deprecated to definition warnings
    -- '0.1.x' for stable ver.
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "andrew-george/telescope-themes",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        telescope.load_extension("fzf")
        telescope.load_extension("themes")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    },
                },
            },
            extensions = {
                themes = {
                    enable_previewer = true,
                    enable_live_preview = true,
                    persist = {
                        enabled = true,
                        path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
                    },
                },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>fWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Find Connected Words under cursor" })

        vim.keymap.set("n", "<leader>fths", "<cmd>Telescope themes<CR>",
            { noremap = true, silent = true, desc = "Theme Switcher" })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy find in files"})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep"})
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Fuzzy find old files"})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Fuzzy find in buffers"})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Fuzzy find in help"})
    end,
}
