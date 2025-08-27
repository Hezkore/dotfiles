# Alacritty

My configuration for the [Alacritty](https://alacritty.org) terminal emulator.

## Installation

Symlink `hezkore.toml` to `$XDG_CONFIG_HOME/alacritty/hezkore.toml`.\
Or `%APPDATA%\alacritty\alacritty.toml` on Windows.\
Then add `import = [ "./hezkore.toml" ]` under `[general]` in your `alacritty.toml` file.

### Automatic Installation (Linux)

```bash
mkdir -p $XDG_CONFIG_HOME/alacritty
ln -fs $PWD/hezkore.toml $XDG_CONFIG_HOME/alacritty/hezkore.toml

# Only if you don't already have a [general] section in your alacritty.toml
echo '[general]' > $XDG_CONFIG_HOME/alacritty/alacritty.toml
echo 'import = [ "./hezkore.toml" ]' >> $XDG_CONFIG_HOME/alacritty/alacritty.toml
```
