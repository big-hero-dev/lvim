-- Options
vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_browsex_viewer = "xdg-open"

-- Disable EditorConfig
vim.g.editorconfig = false

local opt = vim.opt -- for conciseness

-- Line number
opt.nu = true
opt.relativenumber = true

-- Tab & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor
opt.cursorline = true
opt.mouse = "a"
opt.guicursor = {
	"n-v-c:block",
	"i-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}
opt.swapfile = false
opt.backup = false
opt.compatible = false
opt.undofile = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.winblend = 0
opt.background = "dark"
opt.colorcolumn = "80"
opt.listchars:append({ eol = "", tab = "󰍟 ", trail = "·" })
opt.list = true
opt.title = true
opt.pumheight = 10

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

opt.updatetime = 50

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Disable nvim intro
opt.shortmess:append("sI")

-- Slit windows
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"

opt.timeoutlen = 400
opt.iskeyword:append("-")
-- Number of item show popup menu
opt.ph = 7

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Cs = "\e[4:0m"]])
vim.cmd("set path+=**")

opt.ruler = false
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 2 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 2
vim.o.foldenable = false
vim.wo.conceallevel = 2

opt.cmdheight = 0
opt.showcmd = true
opt.showcmdloc = "statusline"
opt.showmode = false

opt.laststatus = 2
opt.showtabline = 2
opt.syntax = "ON"

opt.completeopt = { "menu", "menuone", "noselect" }

-- Keymap
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
vim.g.toggle_colemark = true
vim.g.mapleader = " "

local function active_layout()
	if vim.g.toggle_colemark then
		-- Activate Colemak layout
		map("", "n", "j", opts)
		map("", "e", "k", opts)
		map("", "i", "l", opts)
		map("", "u", "i", opts)
		map("", "U", "I", opts)
		map("n", "vub", "vib", opts)
		map("n", "vuB", "viB", opts)
		map("n", "vut", "vit", opts)
		map("n", "vuw", "viw", opts)
		map("n", "l", "u", opts)
		map("x", "l", ":<C-U>undo<CR>", opts)
	else
		-- Reset to default layout
		map("", "n", "n", opts)
		map("", "e", "e", opts)
		map("", "i", "i", opts)
		map("", "u", "u", opts)
		map("", "U", "U", opts)
	end
	-- Safely refresh Lualine if it is loaded
	if package.loaded["lualine"] then
		require("lualine").refresh()
	else
		vim.defer_fn(function()
			if package.loaded["lualine"] then
				require("lualine").refresh()
			end
		end, 50) -- Retry after 50ms
	end
end

local function toggle_layout()
	vim.g.toggle_colemark = not vim.g.toggle_colemark
	active_layout()
end

-- Set the toggle keybinding
map("n", "<leader>lc", toggle_layout, { desc = "Toggle Colemak layout" })

map("n", "x", '"_x')
map("n", "<leader>w", "<cmd>:w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>:q<cr>", { desc = "Quit" })
-- map("n", "<leader>x", "<cmd>:bdelete<cr>", { desc = "Close buffer" })
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")
map("n", "ss", ":split<Return><C-w>w", { silent = true })
map("n", "sv", ":vsplit<Return><C-w>w", { silent = true })
map("n", "sh", "<C-w>h")
map("n", "sn", "<C-w>j")
map("n", "se", "<C-w>k")
map("n", "si", "<C-w>l")
map("n", "<A-n>", ":m .+1<CR>")
map("n", "<A-e>", ":m .-2<CR>")
map("i", "<A-n>", "<ESC>:m .+1<CR>==gi")
map("i", "<A-e>", "<ESC>:m .-2<CR>==gi")
map("v", "<A-n>", ":m '>+1<CR>gv=gv")
map("v", "<A-e>", ":m '<-2<CR>gv=gv")
map("n", "<ESC>", "<cmd>:noh<cr>", opts)
map("n", "m", "nzzzv")
map("n", "M", "Nzzzv")
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current text" })
map("c", "<C-e>", "<C-p>")
map("n", "<Tab>", vim.cmd.bn)
map("n", "<S-Tab>", vim.cmd.bp)
map("n", "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')
map("n", "s", "<Nop>")
map("v", "s", "<Nop>")

map("n", "H", function()
	return vim.lsp.buf.hover()
end)

map("n", "<leader>t", "<cmd>:ToggleTerm dir=%:p:h<CR>")
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

active_layout()

-- Autocmds
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"netrw",
		"Jaq",
		"qf",
		"git",
		"help",
		"man",
		"lspinfo",
		"oil",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"",
	},
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd("checktime")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		local diagnostics = vim.diagnostic.get(0)
		if #diagnostics > 0 then
			vim.diagnostic.setloclist({ open = false })
		end

		vim.diagnostic.setqflist({ open = false })
	end,
})

-- Remember folds
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*" },
	command = "if expand('%') != '' && &buftype != 'terminal' | mkview | endif",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	command = "if expand('%') != '' && &buftype != 'terminal' | silent! loadview | endif",
})

-- Helps

local ns = vim.api.nvim_create_namespace("filetype.help")
local function ts_query_get_ranges(parser, root, query_string)
	local line_range = {}
	local query = vim.treesitter.query.parse(parser:lang(), query_string)
	for _, matches, _ in query:iter_matches(root, 0) do
		for _, match in ipairs(matches) do
			local start, _, _, stop, _, _ = unpack(vim.treesitter.get_range(match))
			if start ~= stop then
				table.insert(line_range, { start, stop })
			end
		end
	end
	return line_range
end

local function extmark_render_box(ranges, hl)
	for _, range in ipairs(ranges) do
		local start, stop = unpack(range)
		local lines = vim.api.nvim_buf_get_lines(0, start, stop, true)
		local max_line_width = vim.iter(lines):fold(0, function(acc, line)
			return math.max(acc, vim.fn.strdisplaywidth(line) + 2)
		end)

		-- If dashes are already present above line, we reuse that line for top border
		local dashes_above = lines[1]:match("^-*$") or lines[1]:match("^=*$")
		local border_top = "╭" .. ("─"):rep(max_line_width) .. "╮"
		if dashes_above then
			vim.api.nvim_buf_set_extmark(0, ns, start, 0, {
				virt_text = { { border_top, hl } },
				virt_text_pos = "overlay",
			})
		else
			vim.api.nvim_buf_set_extmark(0, ns, start, 0, {
				virt_lines = { { { border_top, hl } } },
				virt_lines_above = true,
			})
		end

		-- Render bottom border
		local border_bottom = "╰" .. ("─"):rep(max_line_width) .. "╯"
		vim.api.nvim_buf_set_extmark(0, ns, stop, 0, {
			virt_lines = { { { border_bottom, hl } } },
			virt_lines_above = true,
		})

		-- Render left and right border
		for i = start, stop - 1 do
			if i ~= start or not dashes_above then
				vim.api.nvim_buf_set_extmark(0, ns, i, 0, {
					virt_text = { { "│ ", hl } },
					virt_text_pos = "inline",
				})
				vim.api.nvim_buf_set_extmark(0, ns, i, 0, {
					virt_text = { { "│", hl } },
					virt_text_win_col = max_line_width + 1,
				})
			end
		end
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("filetype.help", {}),
	pattern = "help",
	callback = function()
		local parser = vim.treesitter.get_parser()
		local tree = parser:parse(true)
		local root = tree[1]:root()

		local code_ranges = ts_query_get_ranges(parser, root, "(code) @v")
		local header_ranges = vim.iter({ "h1", "h2", "h3" }):fold({}, function(acc, type)
			return vim.list_extend(acc, ts_query_get_ranges(parser, root, string.format("(line . (%s)) @v", type)))
		end)

		-- If last line of buffer is present in ranges, you remove that range
		-- This is because, sometimes modeline is parsed as a heading
		header_ranges = vim.tbl_filter(function(range)
			return range[2] ~= vim.api.nvim_buf_line_count(0)
		end, header_ranges)

		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
		extmark_render_box(code_ranges, "Comment")
		extmark_render_box(header_ranges, "Identifier")
	end,
})

-- Theme
vim.cmd("colorscheme retrobox")
