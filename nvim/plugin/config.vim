" All my personal tweaks

" Fuzzy-finder shortcuts
nnoremap <Space> :lua require"telescope.builtin".find_files({ hidden = true })<CR>
nnoremap <Leader>t :Telescope tags<CR>

nnoremap <Leader>i <Cmd>lua vim.lsp.buf.code_action()<CR>

set scrolloff=999 "Center the cursor vertically by default"

set formatoptions+=j  " Remove comment marker when joining lines
set formatoptions+=o  " Continue comment marker in new lines

set softtabstop=2     " Tabs are this many spaces
set shiftwidth=2      " Indentation amount for < and > commands
set smarttab          " Add spaces according to shiftwidth, <BS> kills sw spaces

set splitright " Focus new window after vertical splitting
set splitbelow " Focus new window after horizontal splitting

" Allow backspace to always delete
set backspace=eol,indent,start

" Switch buffers without saving
set hidden

set nobackup    " Don't create backup files
set writebackup " Only backup file while editing
set noswapfile  " No swap files

" Edit file in-place rather than duplicate + copy when saving.
" Potentially problematic if mulitiple actors editing file, but this allows us
" to edit a file mounted in a Docker container without changing the inode (and
" thus ensuring the changes are propagated into the container)
set backupcopy=yes

" Ask user before
" - Writing to a file that already exists (with :w)
" - Closing a buffer with unsaved changes (with :q)
" - Quitting vim when there any buffers with unsaved changes (with :qa)
set confirm

" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Handle common typo for saving
command! W w

" Save file with superuser privileges
command! WW w !sudo tee % > /dev/null

" Check for changes before attempting to write to file
autocmd CursorMoved,CursorMovedI,InsertEnter,InsertLeave * checktime

set wildmenu       " Tab-completion menu for command mode
set wildignore+=*.o,*.pyc,*/tmp/*,*.swp,*.zip,.git
set wildmode=list:longest,full

" Quick window splitting
nnoremap <C-_> <C-W>s
nnoremap <C-\> <C-W>v

" Quick window navigation
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Quick tab window creation/navigation
nnoremap <C-t> :tabnew<CR>
nnoremap <C-p> :tabprev<CR>
nnoremap <C-n> :tabnext<CR>

" Center cursor vertically
nnoremap <Leader>c :let &scrolloff=999-&scrolloff<CR><CR>

" Turn off search highlights until next search
nnoremap <Leader>h :nohlsearch<CR><CR>

" Show/hide line numbers
nnoremap <Leader>l :set number!<CR><CR>

" Toggle paste mode (which disables auto-indenting and line wrapping)
nnoremap <Leader>p :setlocal paste!<CR><CR>

" Enable/disable wrapping when line exceeds width of pane
nnoremap <Leader>w :set wrap!<CR><CR>

nnoremap <Leader>x :quit<CR>
nnoremap <Leader>xx :quit<CR>

" Fugitive shortcuts for working with git
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gl :Extradite<CR>
nnoremap <Leader>gw :GBrowse<CR>
vnoremap <Leader>gw :GBrowse<CR>

" Intuitive incr/decrement of numbers ('=' so we don't have to use Shift key)
nnoremap = <C-A>
nnoremap - <C-X>
