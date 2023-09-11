let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'

Plug 'tpope/vim-dispatch'

Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'ray-x/lsp_signature.nvim'
Plug 'windwp/nvim-autopairs'

Plug 'wfxr/protobuf.vim'

Plug 'lervag/vimtex'
Plug 'RRethy/vim-illuminate'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

set title
set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Vimux default view
    let g:VimuxRunnerType = "window"
" VimTex
    filetype plugin indent on
    let g:vimtex_view_method = 'zathura'
    let g:maplocalleader = ","
    let g:vimtex_complete_enabled = 1
    let g:vimtex_complete_close_braces = 1
" Gruvbox colorscheme
    let g:gruvbox_italic=1
    colorscheme gruvbox
" Rainbow brackets
    let g:rainbow_active = 1
" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright
" Opens fuzzy search
    map <leader>z :GFiles <CR>
    map <leader>x :Files <CR>
    map <leader>Z :Rg <CR>

" Tabs for different filetypes
    " Function to set tab width to n spaces
    function! SetTab(n)
      let &tabstop=a:n
      let &shiftwidth=a:n
      let &softtabstop=a:n
      set expandtab
      set autoindent
      set smartindent
    endfunction

    command! -nargs=1 SetTab call SetTab(<f-args>)

    autocmd BufRead,BufNewFile *.md setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.c setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.h setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.cpp setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.cc setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.cxx setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.hpp setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.py setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.proto setlocal colorcolumn=80
    autocmd BufRead,BufNewFile *.c SetTab 4
    autocmd BufRead,BufNewFile *.h SetTab 4
    autocmd BufRead,BufNewFile *.cpp SetTab 4
    autocmd BufRead,BufNewFile *.hpp SetTab 4
    autocmd BufRead,BufNewFile *.py SetTab 4

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif


" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "%:p"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout "%:p"<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Remap arrow keys to resize window
	nnoremap <Up>    :resize -2<CR>
	nnoremap <Down>  :resize +2<CR>
	nnoremap <Left>  :vertical resize -2<CR>
	nnoremap <Right> :vertical resize +2<CR>

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex<CR>
	let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
    autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
    autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Go autocomplete
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" Load command shortcuts generated from bm-dirs and bm-files via shortcuts script.
" Here leader is ";".
" So ":vs ;cfz" will expand into ":vs /home/<user>/.config/zsh/.zshrc"
" if typed fast without the timeout.
silent! source ~/.config/nvim/shortcuts.vim

lua <<EOF
require("nvim-autopairs").setup {}

  -- Set up nvim-cmp.

local cmp = require'cmp'
local feedkeys = require'cmp.utils.feedkeys'

local t = function (str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

require("cmp_nvim_ultisnips").setup{}
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
      ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }) })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Completion options
  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig').gopls.setup {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    capabilities = capabilities
  }
  require('lspconfig')['ltex'].setup {
    capabilities = capabilities
  }
  require('lspconfig').clangd.setup{
  on_attach = on_attach,
  cmd = {
    "/usr/bin/clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed",
  },
  filetypes = {"c", "cpp", "objc", "objcpp"},
  root_dir = require('lspconfig').util.root_pattern("src"),
  init_option = { fallbackFlags = {  "-std=c++2a", "-std=c11" } },
  capabilities = capabilities
}

require "lsp_signature".setup({
bind = true, -- This is mandatory, otherwise border config won't get registered.
handler_opts = {
  border = "rounded"
}
})

EOF
