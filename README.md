# (Almost) debloated and (almost) based neovim config

- Native plugin manager
- Native lsp
- Good workflow
  - *Git*: Lazygit
  - *Autocompletion*: blink.cmp + luasnip
  - *File navigation*: oil.nvim + harpoon + telescope
  - *Task runner integration*: Just
- Additional colorschemes
  - Custom
    - jetBrains
  - Other
    - everforest

<img src="https://github.com/Gigores/My-Neovim-config/blob/main/screenshots/screenshot1.png" width="60%" alt="Screenshot">

## Supported languages

- Fully supported
  - *Lua*
  - *Java*
- Works, but likely requires tweaking custom colorschemes
  - *C*
  - *rust*
  - *javascript*
  - *python*
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
yay -S lazygit
```
And make sure you are using Neovim 0.12 or greater.
