"vimrc

scriptencoding utf-8
set encoding=utf-8

set fileencodings=guess,iso-2022-jp-3,cp932,euc-jisx0213,euc-jp,ucs-bom

"set statusline=%!MyStatusLine()  
function! MyStatusLine()
	return "%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P"
endfunction

set fileencodings=utf-8,cp932,latin1
set fileformats=unix,dos
set helplang=ja,en

syntax on
colorscheme koehler

set shell=bash
"set shellquote="\""
set shellslash                                  " /をディレクトリの区切りとして使えるようにする
set shellredir=>%s\ 2>&1                        " デフォルトは >%s 2>&1
set autoindent                                  " オートインデントON
set cindent                                     " cのインデント自動設定
set tabstop=4                                   " TAB幅
set shiftwidth=4                                " TAB幅
set softtabstop=0                               " TAB幅
set textwidth=160                               " テキスト領域幅
set nowrap                                      " 単語単位で改行
set nrformats-=octal                            " Ctrl-a で8進数の計算をさせない
set expandtab                                   " TABを展開する
set number                                      " 行番号表示
set ruler                                       " ステータス行に現在行や％表示
set title                                       " ウィンドウタイトルにファイル名などを表示
set diffexpr=MyDiff()                           " diffに使うプログラムを指定(上で定義してある)
set grepprg=grep\ -nHar                         " Grepを指定
set modeline

set backup                                      " バックアップを残す
set writebackup                                 " 書き込み前にバックアップを作る
set backupcopy=yes
set backupdir=./backup,~/backup,c:/backup      " バックアップディレクトリ
if version >= 703
set undodir=./undo,d:/undo                      " アンドゥディレクトリ
endif
set history=10000                               " コマンドヒストリ多め
set clipboard=unnamed                           " デフォルトのヤンク，ペーストでクリップボードを使う
set backspace=2                                 " 
set showcmd                                     " 入力途中のコマンドをコマンド行右端に表示
set laststatus=2                                " ステータス行は常に表示
set cmdheight=2                                 " コマンド行高さ
set wildmenu                                    " コマンド行での補完時にTabで移動できるメニューを表示
set ignorecase                                  " '/' コマンドでのサーチで大文字小文字を無視
if version >= 703
set wildignorecase
endif
set smartcase                                   " 全部小文字で指定した時だけ、大文字小文字区別なし

set incsearch                                   " インクリメンタルサーチON
set hlsearch                                    " サーチ文字列ハイライトON

set wrapscan                                    " サーチで下端まで行ったら上端に戻ってサーチ続行
set showmatch                                   " 対応するカッコを表示
set guioptions=gta                              " メニューやスクロールバーの設定
set statusline=%!MyStatusLine()                 " ステータス行の書式設定
set diffopt=filler,iwhite                       " 
"set confirm                                    " 分からない
"set formatoptions+=mM                          " テキスト挿入中の自動折り返しを日本語に対応させる
let format_allow_over_tw = 1	" ぶら下り可能幅" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
"set listchars=tab:>-                           " tabの後ろにカーソル表示する
"set list

set noshowmode

set completeopt=menuone

set nolist                                      " タブや改行を表示 (list:表示)
" EAST ASIAN ambiguous characters 対応
set ambiwidth=double

"●changelog.vim
let g:changelog_username = "his-ishi <his-ishi@example.com>"
let g:changelog_timeformat = "%Y-%m-%d"
" いつでも自分のChangeLogメモを開く
nn <Leader><Leader><Leader> :new ~/DropBox/my.changelog<cr>

let g:load_doxygen_syntax=1

" TTYで色を出力する設定
if &term =~ 'xterm'
  set t_Co=256
  if has('terminfo')
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
endif

nnoremap <silent> <F11> :set diff<cr>:set scb<cr>:set foldcolumn=2<cr>
nnoremap <silent> <F12> :set nodiff<cr>:set noscb<cr>:set foldcolumn=0<cr>

if exists("mydiff_loaded")
    delfun MyDiff
endif

function! MyDiff() 
    let opt = ''
    if &diffopt =~ 'icase' 
        let opt = opt . '-i ' 
    endif
    if &diffopt =~ 'iwhite'
        let opt = opt . '-b '
    endif 
    silent execute '!diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out

    let mydiff_loaded = 1
endfunction

"●Calender.vim
nn <F7> :Calendar<cr>
let g:calendar_erafmt = '平成,-1988'                                                     " 西暦の代わりに平成を使う
let g:calendar_mruler ='睦月,如月,弥生,卯月,皐月,水無月,文月,葉月,長月,神無月,霜月,師走' " 旧暦を使う
let g:calendar_wruler = '日 月 火 水 木 金 土 日'                                        " 曜日も漢字表記にする
let g:calendar_navi_label = '先月,今月,来月'                                             " ナビラベルも日本語表記

"●gtags.vim
let g:Gtags_JumpToFirstHit = 0
nn <silent> <C-l> :GtagsCursor<CR>
nn <silent> <C-s> :Gtags -r <c-r><c-w><CR>
nn <silent> <C-n> :cn<CR>zz
nn <silent> <C-p> :cp<CR>zz

"●Grep.vim ver.1.9
nnoremap <silent> <F3> :Grep<CR>
nnoremap <silent> <F4> :Rgrep<CR>
nnoremap <silent> <S-F3> :GrepAdd<CR>
nnoremap <silent> <S-F4> :RgrepAdd<CR>
nnoremap <silent> <F3><F3> :GrepAdd<CR>
nnoremap <silent> <F4><F4> :RgrepAdd<CR>
let Grep_Default_Filelist = '*.c *.h *.cpp'
let Grep_Default_Options = '-rHi'
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.vim.c .git*'
let Grep_Xargs_Options = '--null -s 20480'
let Grep_Cygwin_Find = 1
let Grep_Shell_Quote_Char = "'"
let Grep_Shell_Escape_Char = '\'
let Grep_Find_Path = 'find -L'

nn <C-UP>    <C-W>+
nn <C-DOWN>  <C-W>-
nn <C-RIGHT> <C-W>>
nn <C-LEFT>  <C-W><
nn <M-Up>    [c
nn <M-Down>  ]c
nn <silent>  <M-Right> :diffput<cr>
nn <silent>  <M-Left>  :diffget<cr>
nn <silent>  <M-l> :tabnext<cr>
nn <silent>  <M-h> :tabprevious<cr>

nnoremap <silent> <M-n> :lnext<cr>
nnoremap <silent> <M-p> :lprevious<cr>

cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

cnoremap <C-T> <C-R>=strftime("%Y%m%d")<cr>
cnoremap <C-X> <C-R>=expand("%:p:h")<cr>/

"今いる関数の名前を表示する
nn [f [[k:let t=getline(".")<CR>``:echo t<CR>

augroup vimrc
  autocmd!
  
  " *.changelogをchangelogタイプとして扱う
  autocmd BufNewFile,BufRead *.changelog setf changelog
  
  " koehler だとタブとtrailの色が赤くて見にくいので落ち着かせる
  autocmd BufEnter *.[ch] hi SpecialKey	 term=bold cterm=bold ctermfg=darkred    guifg=#202020
  autocmd BufEnter *.[ch] hi NonText     term=bold cterm=bold ctermfg=4 gui=bold guifg=darkblue
  
  " 大事なファイルは時単位バックアップ
  autocmd BufWritePre * let &bex = '~'
  autocmd BufWritePre my.changelog,priv.txt let &bex = '-' . strftime("%Y%b%d-%H") . '~'

  " msys上でQuickRunの結果がSJISで返ってきたときに改行文字が出ないようにする
  " autocmd BufReadCmd \[quickrun\ output\] set ff=dos

augroup END

" コマンドモードで代入を示す正規表現を呼び出す
cnoremap <c-^> \([\ \t]*\[[^]]*]\)*[\ \t]*[\|&+-]\?[\ \t]*=[^=]

" 開いているファイルの場所をエクスプローラで開く
nn <silent> ,,e :!start explorer.exe /e,%:p:h:gs?/?\\?<cr>
nn <silent> ,,f :!start explorer.exe %:p:h:gs?/?\\?<cr>

" time の出力は英語表記(Jan,Feb,...)にする
lan time C
let g:timfmt="time %d-%b-%Y.%T"

" quickrun
let g:quickrun_config = {}
" c++11 対応でコンパイルする
let g:quickrun_config['cpp'] = {
    \ 'cmdopt': '-s -std=c++11 -D__PCDEBUG__'
    \ }
"    \ 'cmdopt': '-std=c++11 -D__PCDEBUG__'
let g:quickrun_config['cs'] = {
    \ 'command' : 'csc',
    \ 'runmode' : 'simple',
    \ 'cmdopt'  : '/nologo',
    \ 'exec'    : ['%c %s', '"%S:p:r.exe" %a', ':call delete("%S:p:r.exe")'],
    \ 'tempfile': '{tempname()}.cs',
    \ }

let g:quickrun_config['vb'] = {
    \ 'command' : 'cscript',
    \ "hook/output_encode/encoding" : "sjis"
    \ }

let g:hybrid_use_Xresources = 1
"colorscheme hybrid

" ●電卓
" calmemo風
:ino <s-cr> <esc>0y$o<C-R>=<C-R>0<cr>

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" Capture
command!
\   -nargs=+ -complete=command
\   Capture
\   call s:cmd_capture(<q-args>)

function! s:cmd_capture(q_args) "{{{
    redir => output
    silent execute a:q_args
    redir END
    let output = substitute(output, '^\n\+', '', '')

    belowright new

    silent file `=printf('[Capture: %s]', a:q_args)`
    setlocal buftype=nofile bufhidden=unload noswapfile nobuflisted
    call setline(1, split(output, '\n'))
endfunction "}}}

"●Align.vim
"  Initialize: {{{1
"set nocp
if version >= 600
filetype plugin indent on
endif
let g:autoalign_mapleader='\'

" multibyte support
let g:Align_xstrlen=3

"●previm
let g:previm_enable_realtime=1

"  "●Chalice
"  set runtimepath+=~/vimfiles/runtime/chalice
"  let chalice_titlestring = "Chalice - gVim"

if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags;
endif

set tags=./tags;

let $PATH='/usr/local/bin:/mingw/bin:/usr/bin:/bin:' . $PATH

" vim-plug
call plug#begin('~/.vim/plugged')
"call plug#begin('~/vimfiles/plugged')
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'thinca/vim-quickrun'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/calendar.vim'
Plug 'fatih/vim-go'
Plug 'vim-jp/vimdoc-ja'
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'vim-scripts/a.vim'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdtree'
Plug 'gregsexton/VimCalc'
Plug 'yegappan/grep'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['fugitive', 'gitgutter', 'filename'],
      \   ],
      \   'right': [
      \     ['lineinfo', 'syntastic'],
      \     ['percent'],
      \     ['fileformat', 'fileencoding', 'filetype'],
      \   ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'charcode': 'MyCharCode',
      \   'gitgutter': 'MyGitGutter',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? "\u2b64" : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? "\u2b60" . " " . _ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

" control IME over ssh (Tera Term specific)
" let &t_SI.="\ePtmux;\e\e[<r\e\\"
" let &t_EI.="\ePtmux;\e\e[<s\e\\\ePtmux;\e\e[<0t\e\\"
" let &t_te.="\ePtmux;\e\e[<0t\e\\\ePtmux;\e\e[<s\e\\"
let &t_SI.="\e[<r"
let &t_EI.="\e[<s\e[<0t"
let &t_te.="\e[<0t\e[<s"
set ttimeoutlen=100

set rtp+=~/go/src/github.com/nsf/gocode/vim

nnoremap tn :tabnext<cr>
nnoremap tp :tabprevious<cr>

