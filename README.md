# homebrew-vzt

Homebrew tap for [VZT Flow](https://github.com/vonzelle-vzt/vzt-flow), local
on-device voice dictation for macOS.

## Install

```bash
brew install --cask vonzelle-vzt/vzt/vzt-flow
```

or, tap first:

```bash
brew tap vonzelle-vzt/vzt
brew install --cask vzt-flow
```

The cask installs `VZT Flow.app` to `/Applications`. It picks the Apple
Silicon or Intel `.dmg` automatically based on your Mac's architecture.

See `brew info --cask vzt-flow` after install for first-run notes
(permissions, model downloads, the unsigned-app Gatekeeper step). Full docs:
[docs/USAGE-macOS.md](https://github.com/vonzelle-vzt/vzt-flow/blob/main/docs/USAGE-macOS.md)
in the main repo.

## Update

```bash
brew update
brew upgrade --cask vzt-flow
```

## Uninstall

```bash
brew uninstall --cask vzt-flow
# or, to also remove config/models/state:
brew uninstall --zap --cask vzt-flow
```
