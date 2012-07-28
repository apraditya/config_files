This is how I manage my config files.

## Requirements

This setup requires ruby and rake gem. Once ruby is installed, run `gem install rake`


## Installation
Alright, here we go:

1. Clone the repository

    `git clone git://github.com/apraditya/config_files.git`

2. Go to config_files and run `rake install`

    `cd config_files/`
    
    `rake install`
      
3. Optionally, if you use [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh/), you can manually link `zshrc_with_omz` to `~/.zshrc`

    `ln -s ~/path/to/config_files/zshrc_with_omz ~/.zshrc`

### Vim
Here are the vim plugins that I use most:

- [**Command-T**](https://github.com/wincent/Command-T). It provides an extremely fast, intuitive mechanism for
opening files and buffers with a minimal number of keystrokes.
- [**nerdtree**](https://github.com/scrooloose/nerdtree/). It allows you to explore your filesystem and to open files and directories. It presents the filesystem to you in the form of a tree which you manipulate with the keyboard and/or mouse. It also allows you to perform simple filesystem operations.
- [**vim-cucumber**](https://github.com/tpope/vim-cucumber). Vim [Cucumber](http://cukes.info/) runtime files
- [**vim-haml**](https://github.com/tpope/vim-haml/). Vim runtime files for [Haml](haml-lang.com), [Sass, and SCSS](http://sass-lang.com/)
- [**vim-ragtag**](https://github.com/tpope/vim-ragtag). ghetto HTML/XML mappings (formerly allml.vim)
- [**vim-rails**](https://github.com/tpope/vim-rails/). Ruby on Rails power tools
- [**vim-surround**](https://github.com/tpope/vim-surround/). It is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
- [**vip**](https://github.com/tobyS/vip/). It's a vim integration for PHP (formerly known as PDV)
- [**vim-pathogen**](https://github.com/tpope/vim-pathogen). It makes installing plugins and runtime files in their own private directories super easy!

#### Plugin Setup

To install all plugins above, simply run:

`rake vim:install_all_plugins`

To install a specific plugin, run `rake vim:install_plugin[plugin_name]`. For example:

`rake vim:install_plugin[vim-rails]`

Similarly for update the plugin, run `rake vim:update_all_plugins` to update all plugins from their respective repositories. And to update a specific plugin, run `rake vim:update_plugin[plugin_name]`.

#### NOTE
Soon I'll add [**snipmate.vim**](https://github.com/garbas/vim-snipmate/) as a git submodule. It's a vim script that implements some of TextMate's snippets features in Vim.