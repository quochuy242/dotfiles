# dotfiles

This version is for only cli tools configuration

To enable fzf, you should download the latest using git 

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

To enable tmux, you should remove all servers of old tmux

```bash
tmux kill-server && rm -rf /tmp/tmux-*
```

Start tmux and press `prefix + r` and `prefix + I` to enable all extensions 