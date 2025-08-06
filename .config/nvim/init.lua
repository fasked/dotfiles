vim.opt.nu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.completeopt = "menuone,fuzzy,noinsert,popup,preview"

if vim.g.neovide then
    vim.o.guifont = "MesloLGLDZ Nerd Font Mono:h10"
    vim.g.neovide_cursor_animation_length = 0
end

-- Enable LSP 
vim.lsp.enable({"clangd", "neocmake", "jedi_language_server", "tsserver"})

-- Completion
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- Diagnostics 
vim.diagnostic.config({
    virtual_text = true
})

require("lazy").setup({
    {
        "neanias/everforest-nvim",
        lazy = false,
        version = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("everforest")
        end
    },
    {
        "sindrets/diffview.nvim"
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "html", "python" },
                indent = { enable = true },
                highlight = { enable = true },
                incremental_selection = { enable = true }
            })
    	end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
})

vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<cr>', { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = "Help tags" })

