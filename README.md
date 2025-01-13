# zsh-completion-generators

Problem: You have a new CLI tool `foo`, and it has a subcommand like `foo generate-completions --shell=zsh`. But you don't know where to put its output--or you _think_ you know, but it doesn't seem to work.

This is a very simple ZSH plugin which has a table of tool names and the commands for outputting completion scripts for those tools. Currently known tools are:

<!-- inject-markdown start -->
| Tool | Command to generate completion |
| --- | --- |
| `bw` | `bw completion --shell zsh` |
| `cargo` | `rustup completions zsh cargo` |
| `deno` | `deno completions zsh` |
| `docker` | `docker completion zsh` |
| `fly` | `fly completion zsh` |
| `gh` | `gh completion --shell zsh` |
| `hugo` | `hugo completion zsh` |
| `mise` | `mise completion zsh` |
| `pnpm` | `pnpm completion zsh` |
| `rustup` | `rustup completions zsh rustup` |
| `starship` | `starship completions zsh` |
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

If you upgrade one of these tools and its completions change, this plugin won't know about it by default. The alias `zsh-completion-generators-rebuild` will manually delete all the generated completion files, and they will be regenerated on the next new shell.

After changing any CLI completions, you'll always benefit from deleting `$HOME/.zcompdump` and/or `$HOME/.zcompcache/` before starting your first new shell.

Some CLIs don't have `completion` commands that output shell scripts to stdout. Sometimes they want to automatically update your `.zshrc`, or place special configuration files elsewhere. **This plugin is not compatible with those approaches**.

