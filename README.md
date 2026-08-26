# Homebrew tap for Arco

[Arco](https://github.com/devmatheusmota/arco) — reveal the state of every agent,
shell, and project.

```bash
brew tap devmatheusmota/arco
brew install --cask arco
```

`brew upgrade` picks up new versions from here: the cask is updated by the Arco
release workflow as soon as the macOS installers are attached to a release.

The build is unsigned, so macOS quarantines everything inside the downloaded
`.dmg`. The cask clears that flag after installing — without it, terminals fail
to start with `posix_spawnp failed.`

Terminals run under the Node installed on the machine, which is why the cask
depends on the `node` formula.
