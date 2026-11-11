<div align="center">

<h1>dotfiles</h1>

Configs and scripts for macOS and Linux.

[![Wezterm](./scrots/wezterm.png)](./home/.config/wezterm/)

</div>

## macOS & Linux

- Git
  - [.gitconfig](./home/.gitconfig)
  - [Git scripts](./home/.config/git/scripts)
  - Delta [↗](https://github.com/dandavison/delta)
- [Kitty](./home/.config/kitty)
  - [kitty.conf](./home/.config/kitty/kitty.conf)
  - [nerdyman kitty theme](./home/.config/kitty/themes/nerdyman.conf)
  - [Kity GPU shaders](./home/.config/kitty/shaders)
  - Kitty Kitten Search [↗](https://github.com/trygveaa/kitty-kitten-search)
- [Starship](./home/.config/starship)
  - [starship.toml](./home/.config/starship/starship.toml)
- [WezTerm](./home/.config/wezterm)
  - [wezterm.lua](./home/.config/wezterm/wezterm.lua)
  - [colors/nerdyman.toml](./home/.config/wezterm/colors/nerdyman.toml) My WezTerm theme
- [Zed](./home/.config/zed)
  - [keymap.json](./home/.config/zed/keymap.json)
  - [settings.json](./home/.config/zed/settings.json)
- [zsh](./home/.zshrc)
  - [.zshrc](./home/.zshrc)
  - [aliases](./home/.config/aliases)
  - fnm [↗](https://github.com/Schniz/fnm)
  - pnpm-shell-completion [↗](https://github.com/g-plane/pnpm-shell-completion)
  - zsh-syntax-highlighting [↗](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Custom Scripts](./home/.local/bin/)

## macOS

- [AeroSpace](./home/.config/aerospace/aerospace.toml)
- [macOS mods](./macos-mods.sh) configures macOS how I like it
- [Keyboard dict for home/end, start/end key bindings](./home/Library/KeyBindings)
- [Actual working UK keyboard layouts](./home/Library/Keyboard%20Layouts) taken from [http://liyang.hu/osx-british.xhtml](http://liyang.hu/osx-british.xhtml)

### Install Dependencies

[Homebrew](https://brew.sh/) is used to install dependencies, you should already have it installed.

```sh
bash install-deps.sh
```

### Applying Mods

```sh
# Flags can be combined, e.g. `./macos-mods.sh --skip-privacy --skip-keybindings-dict`
./macos-mods.sh                         # Run everything
./macos-mods.sh --hostname example      # Run everything and set a custom hostname
./macos-mods.sh --skip-privacy          # Run everything except for privacy.sexy commands
./macos-mods.sh --skip-keybindings-dict # Run everything except for the keybindings dict
./macos-mods.sh --skip-keyboard-layouts # Run everything except for the keyboard layouts
```

## Linux

- [Arch Linux Install Scripts](./archinstall/)
- [Gnome mods](./gnome-mods.sh)

## Fonts

- [Hasklig Monospace↗](https://github.com/i-tu/Hasklig)
- [Mona Sans↗](https://github.com/github/mona-sans)

## Other Stuff

Not actively used.

- [Atom](./home/.atom)
- [Cursor](./home/.config/Cursor)
  - [keybindings.json](./home/.config/Cursor/User/keybindings.json)
  - [settings.json](./home/.config/Cursor/User/settings.json)
- [Karabiner](./home/.config/karabiner/karabiner.json)
- [Gerbera UPnP server Docker config](./home/Documents/configs/gerbera/) for sharing remote folders with my TV
- [i3wm (gaps)](./home/.config/i3)
- [Visual Studio Code](./home/.config/Code)
  - [keybindings.json](./home/.config/Code/User/keybindings.json)
  - [settings.json](./home/.config/Code/User/settings.json)
