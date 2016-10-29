set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader='\\'
let maplocalleader=','

au BufNewFile,BufReadPost *.tidal set filetype=haskell.tidal
let g:tidal_default_config = {"socket_name": "tidal", "target_pane": "0:1"}

set t_Co=256
colorscheme Monokai
