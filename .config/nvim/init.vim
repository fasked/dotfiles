vim.opt.nu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

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
        "neovim/nvim-lspconfig",
        config = function()
            local lsp_config = require("lspconfig")
            lsp_config.zk.setup({})
            lsp_config.lua_ls.setup({})
            lsp_config.pyright.setup({})
            lsp_config.clangd.setup({
                on_attach = function(client, buffer)
                    vim.keymap.set("n", "<F4>", ":ClangdSwitchSourceHeader<CR>", {  desc = "Switch Source/Header File" })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to Reference" })
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
                    vim.keymap.set("n", "<leader>f",  function()
                        vim.lsp.buf.format({ async = false })
                    end, { desc = "Format Code" })
                end
            })
    	end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end
                },
                sources = cmp.config.sources({ 
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" }
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                })
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
