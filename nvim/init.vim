"" My Vim Configuration
syntax on
filetype on
filetype plugin indent on
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set backspace=indent,eol,start
set relativenumber
set undofile
set modelines=0
set mouse=a
set autoindent
set shiftwidth=4
set number
set wrap
set formatoptions=qrn1
set cursorline
" set cursorcolumn
set swapfile
set dir=~/tmp
set cc=125

set autoread
au CursorHold * checktime

call plug#begin('~/.vim/plugged')

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'vim-airline/vim-airline'



" NERDTree
Plug 'preservim/nerdtree'

" Colorscheme
" Plug 'arcticicestudio/nord-vim'
Plug 'AhmedAbdulrahman/vim-aylin'
Plug 'kvrohit/mellow.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'olivercederborg/poimandres.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nyoom-engineering/oxocarbon.nvim'

" GLSL Highlighting
Plug 'tikhomirov/vim-glsl'

" vimtex
Plug 'lervag/vimtex'
let g:vimtex_fold_enabled = 1
let g:tex_flavor = 'latex'

" Intellisense
" Plug 'neoclide/coc.vim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

" dev icons
Plug 'ryanoasis/vim-devicons'

" Bar Bar for tabs
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

let bufferline = get(g:, 'bufferline', {})
let bufferline.maximum_padding = 4

" Language server completion (COC)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'tanvirtin/vgit.nvim'

" TODO comments
Plug 'folke/todo-comments.nvim'

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Toggle Terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

call plug#end()

" GIT
lua << EOF
    require('vgit').setup {}
EOF

" Todo Comments
lua << EOF
  require("todo-comments").setup {
      signs = true,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
  }
EOF

" Toggle Terminal
lua require("toggleterm").setup{}

" Poimandres theme
lua << EOF
  require('poimandres').setup {}
EOF

" Telescope
lua << EOF
    require('telescope').setup {}
EOF

" Lualine
lua << END
    require('lualine').setup()
END

" Enable Color Theme
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  " set termguicolors
endif

" Auto remove line numbers from terminal buffers.
autocmd TermOpen * setlocal nonumber norelativenumber

autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

set background=dark
colorscheme oxocarbon 

au FocusLost * :wa
let setleader = ","
nnoremap ; :
nmap ,c :e ~/.config/nvim/init.vim<Enter>
nmap ,x \ll
nmap ,f <cmd>Telescope find_files<cr>
nmap ,b <cmd>Telescope buffers<cr>
nmap ,g <cmd>Telescope live_grep<cr>
nmap ,n :NERDTree<Enter>
nnoremap / :BLines<Enter>
nnoremap ,u :source $MYVIMRC<CR> 

tnoremap ,<Esc> <C-\><C-n>

