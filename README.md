# zsh-completion-generators

<!-- inject-badge start -->
![56 tools supported](https://img.shields.io/badge/tools%20supported-56-blue)
<!-- inject-badge end -->

Problem: You have a new CLI tool `foo`, and it has a subcommand like `foo generate-completions --shell=zsh`. But you don't know where to put its output--or you _think_ you know, but it doesn't seem to work.

This is a very simple ZSH plugin which has a table of tool names and the commands for outputting completion scripts for those tools. Currently known tools are:

<!-- inject-markdown start -->
| Tool | Command to generate completion |
| --- | --- |
| `acli` | `acli completion zsh` |
| `argocd` | `argocd completion zsh` |
| `atuin` | `atuin gen-completions --shell zsh` |
| `bk` | `bk completion zsh` |
| `buf` | `buf completion zsh` |
| `bw` | `bw completion --shell zsh` |
| `cargo` | `rustup completions zsh cargo` |
| `chezmoi` | `chezmoi completion zsh` |
| `chronoctl` | `chronoctl completion zsh` |
| `codex` | `codex completion zsh` |
| `colima` | `colima completion zsh` |
| `deno` | `deno completions zsh` |
| `docker` | `docker completion zsh` |
| `doctl` | `doctl completion zsh` |
| `eksctl` | `eksctl completion zsh` |
| `fd` | `fd --gen-completions` |
| `fly` | `fly completion zsh` |
| `gh` | `gh completion --shell zsh` |
| `glab` | `glab completion -s zsh` |
| `golangci-lint` | `golangci-lint completion zsh` |
| `goreleaser` | `goreleaser completion zsh` |
| `gt` | `gt completion` |
| `hcloud` | `hcloud completion zsh` |
| `helm` | `helm completion zsh` |
| `hf` | `hf --show-completion` |
| `hugo` | `hugo completion zsh` |
| `jira` | `jira completion zsh` |
| `just` | `just --completions zsh` |
| `k9s` | `k9s completion zsh` |
| `kind` | `kind completion zsh` |
| `kubectl` | `kubectl completion zsh` |
| `minikube` | `minikube completion zsh` |
| `mise` | `mise completion zsh` |
| `nerdctl` | `nerdctl completion zsh` |
| `op` | `op completion zsh` |
| `opencode` | `opencode completion zsh` |
| `orbctl` | `orbctl completion zsh` |
| `pdm` | `pdm completion zsh` |
| `pixi` | `pixi completion --shell zsh` |
| `pnpm` | `pnpm completion zsh` |
| `podman` | `podman completion zsh` |
| `poetry` | `poetry completions zsh` |
| `pulumi` | `pulumi gen-completion zsh` |
| `pumas` | `pumas generate-completion zsh` |
| `rbw` | `rbw gen-completions zsh` |
| `rclone` | `rclone genautocomplete zsh -` |
| `restic` | `restic generate --zsh-completion -` |
| `rg` | `rg --generate=complete-zsh` |
| `rustup` | `rustup completions zsh rustup` |
| `rye` | `rye self completion -s zsh` |
| `starship` | `starship completions zsh` |
| `stern` | `stern --completion zsh` |
| `task` | `task --completion zsh` |
| `uv` | `uv generate-shell-completion zsh` |
| `yq` | `yq completion zsh` |
| `zellij` | `zellij setup --generate-completion zsh` |
<!-- inject-markdown end -->

On every shell load, it will filter that list for tools that
- you have installed (i.e. are on the `$PATH`)
- do not already have completions registered
- this plugin has not already generated completions for

It will run the completion command and save its output to a file `_<toolname>`. If the path of this repo is in `$fpath` _(see below)_, then completions should work immediately.

## Installation

This repo follows a zsh plugin convention established by oh-my-zsh. Most other plugin managers expect the same structure. Add `zetlen/zsh-completion-generators` using your chosen plugin manager's instructions. It will autoload the plugin, and put the plugin directory (and thus all generated completions) in the `fpath` variable, where zsh completions directories are listed.

### Manual installation

1. Clone this repo
2. Add to your `.zshrc`:
   ```sh
   export fpath=(/path/to/zsh-completion-generators/ $fpath)
   source /path/to/zsh-completion-generators/zsh-completion-generators.plugin.zsh
   compinit # this may already be called elsewhere
   ```

:warning: You'll need to source this plugin _before_ calling `compinit`, so your favorite plugin manager may have special instructions for doing so.

Initial load of your first new shell after install may take a while, since it has to generate the completion files for each command that you have installed. However, it caches them, so subsequent loads will take no time.

## Notes

**Automatic regeneration on upgrade:** When you upgrade a tool, this plugin automatically detects the newer binary and regenerates completions on the next shell load. The `zsh-completion-generators-rebuild` command is only needed if completions become corrupted or you want to force regeneration of all completions.

After regenerating completions, you may need to delete `$HOME/.zcompdump` and/or `$HOME/.zcompcache/` for changes to take effect.

Some CLIs don't have `completion` commands that output shell scripts to stdout. Sometimes they want to automatically update your `.zshrc`, or place special configuration files elsewhere. **This plugin is not compatible with those approaches**.

## Custom generators

You can add your own tool definitions without modifying this plugin by creating a user-local CSV file:

```
~/.config/zsh-completion-generators/generators.csv
```

Use the same format as the main `generators.csv`:

```csv
Tool,Command to generate completion
mytool,mytool completions zsh
```

This file will survive plugin updates.

