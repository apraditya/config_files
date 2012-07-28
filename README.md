This is how I manage my config files.

### Requirements

This setup requires ruby and rake gem. Once ruby is installed, run `gem install rake`


### Installation
Alright, here we go:

1. Clone the repository

    `git clone git://github.com/apraditya/config_files.git`

2. Go to config_files and run `rake install`

    `cd config_files/`
    
    `rake install`
      
3. Optionally, if you use [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh/), you can manually link `zshrc_with_omz` to `~/.zshrc`

    `ln -s ~/path/to/config_files/zshrc_with_omz ~/.zshrc`