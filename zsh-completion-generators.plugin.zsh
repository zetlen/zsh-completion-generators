__zcg_dir="${0:A:h}"
__zcg_name="${__zcg_dir:t}"

tail -n +2 "${__zcg_dir}/generators.csv" | while IFS=$',' read -r cli print_cmd; do

  local generated="${__zcg_dir}/_${cli}";

  # find command executable
  local cmd_path="$(whence -S "$cli" | cut -d'>' -f2 | xargs echo)"

  # skip if command isn't installed
  [[ -z "$cmd_path" ]] && continue

  local cmd_type="$(whence -w "$cmd_path" | cut -d' ' -f2)"

  if [[ "$cmd_type" == "command" ]]; then
    # we can check if the command is newer than the generated completion
    [[ "$generated" -nt "$cmd_path" ]] && continue
  else
    # we can only check if the completion exists already
    [[ -e "$generated" ]] && continue
  fi

  printf "[%s] Generating completion for %s..." $__zcg_name $cli >&2
  eval "$print_cmd" 2>/dev/null > "$generated"
  printf "Done.\n" >&2

done

zsh-completion-generators-rebuild() {
  rm -f ${__zcg_dir}/_*
  echo "[$__zcg_name] Rebuilding all completions on next shell login. You may want to delete completion cache:" >&2
  rm -ri ~/.zcompdump
  echo "[$__zcg_name] Restart your shell to regenerate completions." >&2
}
