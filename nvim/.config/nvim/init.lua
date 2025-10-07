-- Install lazy automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -------------------------
    -- General enhancements
    -------------------------
    -- Filetree
    { "nvim-tree/nvim-tree.lua", opts = {} },
    -- Commenting
    { "numToStr/Comment.nvim", opts = {} },
    -- Better syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- Auto pairs for brackets etc.
    "windwp/nvim-autopairs",
    -- Git diffs in sign column
    "lewis6991/gitsigns.nvim",
    -- Telescope (fuzzy finder)
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- Quickly toggle terminal while editing
    "akinsho/toggleterm.nvim",
    -- Git UI
    "NeogitOrg/neogit",
    "sindrets/diffview.nvim",
    -------------------------
    -- LSP & Completion
    -------------------------
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "saghen/blink.cmp",
        version = "v0.*",
        opts = {
            keymap = {
                -- Simple tab complete
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { enabled = true },
            completion = {
                menu = {
                    auto_show = function(ctx)
                        return ctx.mode ~= "cmdline"
                    end,
                },
            },
        },
        opts_extend = { "sources.default" },
    },
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "nvimtools/none-ls.nvim",
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    -------------------------
    -- Visual enhancements & themes
    -------------------------
    -- Status line
    "nvim-lualine/lualine.nvim",
    -- Standalone UI for nvim-lsp progress
    { "j-hui/fidget.nvim", opts = {} },
    -- Icons
    "nvim-tree/nvim-web-devicons",
    -- Modified gruvbox
    "sainnhe/gruvbox-material",
    -- Github theme
    "projekt0n/github-nvim-theme",
}

require("lazy").setup(plugins)

-------------------------------------------------
-- Settings
-------------------------------------------------

local o = vim.opt
local g = vim.g

-- Use space as leader key
g.mapleader = " "

-- Enable syntax highlighting
o.syntax = "enable"

-- Do not wrap long lines
o.wrap = false

-- Allow hidden buffers
o.hidden = true

-- Use utf-8
o.encoding = "utf-8"
o.fileencoding = "utf-8"

-- Better display for messages
o.cmdheight = 1

-- Faster diagnostic messages
o.updatetime = 300

-- Enable mouse usage (all modes) in terminals
o.mouse = "a"

-- Sane splits
o.splitbelow = true
o.splitright = true

-- Tabs as 4 spaces
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true

-- Auto indent
o.smartindent = true
o.autoindent = true

-- Show line numbers
o.number = true
o.relativenumber = true

-- Show column
o.colorcolumn = "80"

-- Prevent buffer moving when adding/deleting sign.
o.signcolumn = "yes"

-- Indicate that a dark background should be used
o.background = "dark"

-- Enable colors in the terminal UI
o.termguicolors = true

-- Decent wildmenu
o.wildmenu = true
o.wildmode = "list:longest"

-- Show whitespace characters
o.listchars = {
    space = "⋅",
    tab = "» ",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "_",
}
o.list = true

-- Don't highlight searches
o.hlsearch = false

-- Ignore case when searching
o.ignorecase = true

-- Case sensitive search if uppercase
o.smartcase = true

-- Permanent undo
o.undodir = os.getenv("HOME") .. "/.vimdid"
o.undofile = true

-- Don't continue comments when using o/O
o.formatoptions:remove("o")

-- Preselect first completion
o.completeopt = { "menu", "menuone", "noselect" }

-- Plugin settings
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
-- Ignore default mappings, define own
g.vimtex_mappings_enabled = 0

-------------------------------------------------
-- Keymaps
-------------------------------------------------

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Standard operations
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>c", ":bdelete!<CR>", opts)

-- Quickly insert an empty new line without entering insert mode
keymap("n", "<Leader>o", "o<Esc>", opts)
keymap("n", "<Leader>O", "O<Esc>", opts)

-- Copy-paste
keymap("x", "<leader>p", '"_dP', opts)
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+y$', opts)

-- Cycle buffers
keymap("n", "<S-l>", ":bn<CR>", opts)
keymap("n", "<S-h>", ":bp<CR>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Center cursor when going up/down
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- Telescope
local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

keymap("n", "<C-p>", builtin.git_files, opts)
keymap("n", "<leader>sf", builtin.find_files, opts)
keymap("n", "<leader>sh", builtin.help_tags, opts)
keymap("n", "<leader>sg", function(grep_opts)
    grep_opts = grep_opts or {}
    grep_opts.cwd = grep_opts.cwd and vim.fn.expand(grep_opts.cwd) or vim.loop.cwd()
    local custom_grep = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end
            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }

            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end
            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end
            ---@diagnostic disable-next-line: deprecated
            return vim.tbl_flatten({
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            })
        end,
        entry_maker = make_entry.gen_from_vimgrep(grep_opts),
        cwd = grep_opts.cwd,
    })
    pickers
        .new(grep_opts, {
            debounce = 100,
            prompt_title = "Live MultiGrep",
            finder = custom_grep,
            previewer = conf.grep_previewer(grep_opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end, opts)
keymap("n", "<leader>sd", builtin.diagnostics, opts)
keymap("n", "<leader><space>", builtin.buffers, opts)
keymap("n", "<leader>s.", builtin.oldfiles, opts)
keymap("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, opts)

--Surround
keymap("v", "<leader>'", "<Esc>`>a'<Esc>`<i'<Esc>", opts)
keymap("v", '<leader>"', '<Esc>`>a"<Esc>`<i"<Esc>', opts)
keymap("v", "<leader>(", "<Esc>`>a)<Esc>`<i(<Esc>", opts)
keymap("v", "<leader>[", "<Esc>`>a]<Esc>`<i[<Esc>", opts)
keymap("v", "<leader>{", "<Esc>`>a}<Esc>`<i{<Esc>", opts)

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Neogit & Diffview
keymap("n", "<leader>gg", ":Neogit<CR>", opts)
keymap("n", "<leader>gl", ":Neogit log<CR>", opts)
keymap("n", "<leader>gp", ":Neogit push<CR>", opts)
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>gD", ":DiffviewOpen main<CR>", opts)

-- Spell-check
keymap("n", "<leader>spe", ":setlocal spell! spelllang=en_us<CR>", opts)
keymap("n", "<leader>sps", ":setlocal spell! spelllang=sv<CR>", opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-------------------------------------------------
-- Plugin setups
-------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local map = function(keys, func, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf })
        end
        map("K", vim.lsp.buf.hover)
        map("<leader>f", vim.lsp.buf.format)
        map("gd", vim.lsp.buf.implementation)
        map("<leader>gr", vim.lsp.buf.references)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>a", vim.lsp.buf.code_action)
        map("<leader>e", vim.diagnostic.open_float)
    end,
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            completion = {
                autoimport = {
                    enable = true,
                },
            },
        },
    },
})

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
        "bashls",
        "clangd",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "ts_ls",
    },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    },
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
})

require("telescope").setup({
    extensions = {
        fzf = {},
    },
})
require("telescope").load_extension("fzf")

require("nvim-autopairs").setup({
    check_ts = true, -- treesitter integration
    disable_filetype = { "TelescopePrompt" },
})

vim.cmd([[
  let g:gruvbox_material_background = 'hard'
  colorscheme gruvbox-material
]])

require("gitsigns").setup()

require("lualine").setup({
    options = {
        theme = "gruvbox-material",
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
    },
})
local ls = require("luasnip")
local _ = require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,
    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",
})

require("neogit").setup({
    disable_commit_confirmation = true,
    integrations = {
        diffview = true,
    },
})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local sources = {
    formatting.prettier.with({
        extra_args = { "--tab-width", "4" },
    }),
    formatting.black,
    formatting.shfmt.with({
        extra_args = { "-i", "4", "-sr", "-ci" },
    }),
    formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces" },
    }),
}
null_ls.setup({ sources = sources })

require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    open_mapping = [[<c-\>]],
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "python", "lua", "html", "javascript", "c", "rust" },
    auto_install = true,
    highlight = {
        enable = true,
    },
    autopairs = {
        enable = true,
    },
})
