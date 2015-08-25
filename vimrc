set nocompatible

let g:syntastic_mode_map = { 'mode' : 'active',
                    \ 'active_filetypes': [],
                    \ 'passive_filetypes': [] }

filetype off

set mouse=a

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction


set cul
"hi CursorLine term=none cterm=none ctermbg=3
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
filetype plugin indent on
set ignorecase
set hlsearch
set showmatch
set noerrorbells
set background=dark
set ruler
set more
set number
set hidden
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set backspace=2
syntax on

