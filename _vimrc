set nocompatible

"显示行号
set number

"用空格代替tab
set expandtab
"一个tab是4个字符 
set tabstop=4
"缩进的字符个数
set shiftwidth=4
"自动缩进
set autoindent

set guifont=Consolas:h13:cANSI
set textwidth=0
set formatoptions+=t
set wrap
set lines=44 columns=125

set encoding=utf-8
"fileencodings需要注意顺序，前面的字符集应该比后面的字符集大
set fileencodings=ucs-bom,utf-8,cp936,gbk
let $LANG = 'en'  "set message language  
set langmenu=en   "set menu's language of gvim. no spaces beside '='

"语法高亮 
syntax on

"自动加载tags文件
"set tags=tags;/

"执行 Vim 缺省提供的 .vimrc 文件的示例，包含了打开语法加亮显示等最常用的功能 
"注意，这几个语句的位置是有上下文相关性的
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
"设置鼠标运行模式为WINDOWS模式
behave mswin

"mswin中重映射了一些windows下的组合按键功能
unmap <C-Y>
unmap <C-V>
unmap <C-F>
unmap <C-A>

"缺省不产生备份文件 
set nobackup
"no undo file .un~
set noundofile

colorscheme desert


" for Bundle start
set nocompatible        " be iMproved, required
filetype off            " required! 

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"set rtp+=$VIM/vimfiles/bundle/vundle/  
"call vundle#rc('$HOME/vimfiles/bundle/')  
set rtp+=$HOME/vimfiles/bundle/Vundle.vim/  
call vundle#begin('$HOME/vimfiles/bundle/')  

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <F8> :NERDTreeToggle<CR>

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on " required!
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" for Bundle end 



" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
