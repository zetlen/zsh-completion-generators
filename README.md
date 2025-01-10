# zsh-completion-generators

Problem: You have a new CLI tool `foo`, and it has a subcommand like `foo generate-completions --shell=zsh`. But you don't know where to put its output--or you _think_ you know, but it doesn't seem to work.

This is a very simple ZSH plugin which has a table of tool names and the commands for outputting completion scripts for those tools. Currently known tools are:

```csv
cli,to generate completion
zellij,zellij setup --generate-completion zsh
bw,bw completion --shell zsh
rustup,rustup completions zsh rustup
cargo,rustup completions zsh cargo
deno,deno completions zsh
gh,gh completion --shell zsh
mise,mise completion zsh
starship,starship completions zsh
docker,docker completion zsh
pnpm,pnpm completion zsh
```

Install this plugin with your favorite ZSH plugin manager, but be warned; you'll need to source this plugin _before_ calling `compinit`, so your favorite plugin manager may have special instructions for doing so.

Initial load of your first new shell after install may take a while, since it has to generate the completion files for each command that you have installed. However, it caches them, so subsequent loads will take no time.

## Notes

If you upgrade one of these tools and its completions change, this plugin won't know about it by default. The alias `zsh-completion-generators-rebuild <cli-name>` will rebuild completion for that command. Pass `--all` instead of a CLI name and it will delete and rebuild all of its completions.

After changing any CLI completions, you'll always benefit from deleting `$HOME/.zcompdump` and `$HOME/.zcompcache/` before starting your first new shell.

Some CLIs don't have `completion` commands that output shell scripts to stdout. Sometimes they want to automatically update your `.zshrc`, or place special configuration files elsewhere. **This plugin is not compatible with those approaches**.

