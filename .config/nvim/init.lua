vim.opt.nu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.completeopt = "menuone,fuzzy,longest,noselect"

-- Clang
vim.lsp.config.clangd = {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
}

-- Typescript
vim.lsp.config.tsserver = {
    cmd = { 'typescript-language-server', '--stdio' },
    root_markers = { 'package.json' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    }
}

-- Enable LSP
vim.lsp.enable({'clangd', 'tsserver'})

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
  -- Use the default configuration
  virtual_lines = true
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
    }
})
