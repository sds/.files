# Dot Files

My dot file configuration, optimized specifically for macOS using the [fish shell](https://fishshell.com/).

After using [zsh](https://zsh.sourceforge.io/) for over a decade, it was time to move on.
At the time of this decision, a rewrite of fish in Rust is [nearing completion](https://github.com/fish-shell/fish-shell/discussions/10123).
While that's nice, it's not the main reason.

The goal with this was simplification:
- Removed the [Dot framework](https://github.com/sds/dot) for configuration management since it was overengineered relative to what I personally needed.
- Fish is much easier to configure than zsh, and has an excellent suite of autocompletions already provided.
- Switching from [Vim](https://www.vim.org/) to [Neovim](https://neovim.io/) was on my list for a while, as most activity is happening on Neovim now.
- Switch from [iTerm2](https://iterm2.com/) to [Alacritty](https://alacritty.org/), which has much fewer knobs to tweak (though I am excited for [Ghostty 1.0](https://mitchellh.com/writing/ghostty-is-coming) to be released).

## Installation

Assuming you're on a brand-new machine, run:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sds/.files/HEAD/bootstrap.sh)"
```

## Configuration

The `./install` script ensures software we're expecting to be available is installed on the system.
This includes Homebrew formulae, casks, fish plugins, etc.
It also creates symlinks from your host back to files in this repository.
`./install` is meant to be idempotent, so it is safe to run many times.
When making changes to it, ensure it remains idempotent.
