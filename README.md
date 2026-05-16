# (Almost) debloated and (almost) based neovim config

- Native plugin manager
- Native lsp
- Good workflow
  - *Git*: Lazygit
  - *Autocompletion*: blink.cmp + luasnip
  - *File navigation*: oil.nvim + harpoon + telescope
  - *Task runner integration*: Just
  - *Project setup wizards* for C
- Additional colorschemes
  - jetBrains

<img src="https://github.com/Gigores/My-Neovim-config/blob/main/screenshots/screenshot1.png" width="60%" alt="Screenshot">

## Supported languages

- Fully supported
  - *Lua*
  - *Java*
  - *C*
- Works, but likely requires tweaking custom colorschemes
  - *Rust*
  - *JavaScript*
  - *Python*
- May work, not tested at all
  - *C++*
  - *Objective C*
  - *TypeScript*

## Before installation

You need to install some **Language Severs**:
```bash
# On Arch linux with yay
yay -S jdtls lua-language-server llvm rust-analyzer pyright typescript-language-server
```
As well as some cli utilities:
```bash
yay -S unzip lazygit bear xxd
```
And make sure you are using Neovim 0.12 or greater.

## Keybinds

### Core

- `<space>d`: Delete without copying

- `<space>u`: Open undo tree
- `<space>g`: Open Lazygit
- `<space>t`: Open terminal

- `<space>S`: Project setup wizard

#### LSP

- `<space>ck`: Hover
- `<space>cK`: Signature help
- `<space>cr`: Rename
- `<space>ca`: Code action
- `<space>cR`: Find references
- `<space>cf`: Format

- `<space>c]`: Next diagnostic
- `<space>c[`: Previous diagnostic

- `gd`: Go to definition
- `gD`: Go to declaration
- `gi`: Go to implementation

#### Window manipulation

- `<space>w|`: Split window vertucally
- `<space>w-`: Split window horizontally
- `<space>w=`: Make windows equally sized
- `<space>wx`: Close current window
- `<C-h>`: Move focus to the left window
- `<C-j>`: Move focus to the lower window
- `<C-k>`: Move focus to the upper window
- `<C-l>`: Move focus to the right window

#### Just integration

- `<space>jc`: Choose and run
- `<space>jd`: Run "default" recipe

### Plugins

#### Markdown

- `<space>cm`: Toggle Markdown preview

#### Harpoon

- `<space><C-h>`: Open menu
- `<space>ha`: Add

- `<space>h1`: Open 1st
- `<space>h2`: Open 2nd
- `<space>h3`: Open 3rd
- `<space>h4`: Open 4th

- `<space>hk`: Open previous
- `<space>hj`: Open next

#### Telescope

- `<space><space>`: Search files
- `<space><space>` (Visual): Search selection
- `<space>/`: Search in files

#### oil.nvim

- `<space>e`: Open file explorer

- `H` (In file explorer): Open parent directory
- `L` (In file explorer): Open selected file/directory

#### mini.surround

These are the default mappings
- `sa`: Add surrounding
- `sd`: Delete surrounding
- `sr`: Replace surrounding
- `sf`: Find surrounding
- `sh`: Hightlight surrounding

#### nvim-toggler

- `<space>ct`: toggle

#### Treesitter-textobjects

- `af` (Visual & Operator-pending): Select around function
- `if` (Visual & Operator-pending): Select inside function
- `ac` (Visual & Operator-pending): Select around class
- `ic` (Visual & Operator-pending): Select inside class
- `aC` (Visual & Operator-pending): Select around comment
- `iC` (Visual & Operator-pending): Select inside comment
- `ap` (Visual & Operator-pending): Select around parameter
- `ip` (Visual & Operator-pending): Select inside parameter
- `al` (Visual & Operator-pending): Select around loop
- `il` (Visual & Operator-pending): Select inside loop
- `aF` (Visual & Operator-pending): Select around conditional
- `iF` (Visual & Operator-pending): Select inside conditional

- `as` (Visual & Operator-pending): Select local scope
