__zcg_dir="${0:A:h}"
__zcg_name="${__zcg_dir:t}"
__zcg_user_config="${XDG_CONFIG_HOME:-$HOME/.config}/zsh-completion-generators/generators.csv"

__zcg_process_generators() {
  local csv_file="$1"
  [[ -f "$csv_file" ]] || return 0

  tail -n +2 "$csv_file" | while IFS=$',' read -r cli print_cmd; do
    # skip empty lines
    [[ -z "$cli" ]] && continue

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
}

# Process built-in generators
__zcg_process_generators "${__zcg_dir}/generators.csv"

# Process user-local generators (survives plugin updates)
__zcg_process_generators "$__zcg_user_config"

zsh-completion-generators-rebuild() {
  rm -f ${__zcg_dir}/_*
  echo "[$__zcg_name] Deleted generated completions. They will regenerate on next shell login." >&2
  echo "[$__zcg_name] You may want to delete the completion cache:" >&2
  rm -ri ~/.zcompdump
  echo "[$__zcg_name] Restart your shell to regenerate completions." >&2
}
