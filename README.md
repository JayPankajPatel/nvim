# nvim
## Prerequisites
You need `python`, `python<your-python-version>-venv` `npm`, and `git` installed on your system, if you need something with fewer dependencies check out my `.vim` repo. 
Make sure you have a nerd font installed, its not necessary however the nice symbols won't work if you don't.
### Examples
#### Ubuntu/Debian
```
sudo apt install python python3.10-venv git
# For nvm which is the recommended way of installing nodejs and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source $HOME/.bashrc
nvm install node
```
## Installation
This is my neovim setup based of NvChad
1) Install Neovim, if you need help go to their installation guide from source [here](https://github.com/neovim/neovim/wiki/Building-Neovim)
2) Be sure to backup any previous configurations before installing this one.
3) Install my configuration in the following directory: `$HOME/.config`
   
   `git clone https://github.com/JayPankajPatel/nvim.git --depth=1 $HOME/.config`
7) open nvim and use the command `:MasonInstallAll` to install the lsps I have, you can edit which tools you want under `lspconfig.lua` and `null-ls.lua`
8) Syntax highlighting comes using a tool called Treesitter we must install them individually for each language we want using `:TSInstall <your_language>`
   Example: `:TSInstall python` `:TSInstall c`

## Tips
If you hit <leader\> ch in Normal Mode there is a cheatsheet with all of the possible options and also there is which key functionality to help you keep track key actions
Leader is the space key but you can change the mappings in custom/init.lua.

If you want to customize anything please change anything you want using under the custom directory. 
If you aren't sure please read the NvChad documentation.

This configuration is based off of NvChad, for more details on customization, visit their documentation [here.](https://nvchad.com/docs/quickstart/install)  

A more detailed documentation is on the way. 
