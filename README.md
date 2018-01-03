This is how I manage my config files.

## Requirements

This setup requires ruby and rake gem. Once ruby is installed, run `gem install rake`. It also requires [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh/), so please install it first.


## Installation
Alright, here we go:

1. Clone the repository

    `git clone git://github.com/apraditya/config_files.git`

2. Go to config_files and run `rake install`

    `cd config_files/`

    `rake install`

3. Run `vim` to install the plugins

4. If you want to use NeoVim, link `nvim-bootstrap.vim` to `~/.config/nvim/init.vim` and run `nvim` to install the plugins

5. Optionally (but recommended), install Oh-My-Zsh custom plugins:
  - [base16-shell](https://github.com/chriskempson/base16-shell)
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### NOTES

1. To get completion for `git flow` working (on MacOS), install `git` with Homebrew without the completions, `brew install git --without-completions`
