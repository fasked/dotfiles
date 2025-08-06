---@brief
---
--- https://github.com/regen100/cmake-language-server
---
--- CMake LSP Implementation
vim.lsp.config.neocmake = {
    cmd = { 'neocmakelsp', '--stdio' },
    root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
    filetypes = { 'cmake' },
    single_file_support = true,
    settings = {
        format = {
            enable = true
        },
        lint = {
            enable = true
        },
    }
}
