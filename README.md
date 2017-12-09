# texcompletion
A Vim filetype plugin to complete TeX / LaTeX control sequences

## featrue
There are several plugins that help `Vimmer` to write Tex/LaTeX documents, such as
[Vim-Latex](https://github.com/vim-latex/vim-latex). Some of them are good but heavy,
every keystroke tends to be a mapping! Also you neet to spent time to learn
how to use those plugins.

`texcompletion` is light and simple, only one function is there, which help you to complete
the TeX/plain-Tex/LaTeX control sequences or commands, by typing `<C-X>u` or `<C-X><C-U>`
in insert-mode. 

This is something called `User defined completion`, and is a build-in feature of Vim. If you are
not familiar with that, see `:h ins-completion` for more infomation.


## installation
This plugin is desinged as a package of vim.

Just clone it into
- `~/.vim/pack` for unix-like system or
- `~/vimfiles/pack` for Windows system

and enable this plugin (see below).

## enable/disable plugin
Adding 
```vim-script
packadd! texcompletion
```
into your vimrc file to enable this plugin. You should know how to disable it now :)

## dependency
*required* vim version is >= 8.0.

Packages is introduced into vim from 8.0.
Lambda expresses are used in some functions, and this featrue is introduced from 8.0 too.

More about using vim packages see vim's document `:h packages`.
