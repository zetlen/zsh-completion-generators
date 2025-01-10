__zcg_dir="${0:A:h}"
__zcg_name="${__zcg_dir:t}"
__zcg_line1=1

while IFS=$',' read -r cli print_cmd; do
  # skip header row
  if [[ _zcg_line1 == 1 ]]; then
    __zcg_line1=0
    continue
  fi

  local generated="${__zcg_dir}/_${cli}";

  # only for commands that are actually installed
  command -v "$cli" &> /dev/null || continue

  # only if a completion doesn't already exist for it
  [ -z "$_comps[$cli]" ] || continue

  # only if the file doesn't already exist
  [ -f "$generated" ] && continue

  printf "[%s] Generating completion for %s..." $__zcg_name $cli >&2
  eval "$print_cmd" > "$generated"
  printf "Done.\n" >&2

done < "${__zcg_dir}/generators.csv"

zsh-completion-generators-rebuild() {
  rm -f ${__zcg_dir}/_*
  echo "[$__zcg_name] Rebuilding all completions on next shell login. You may want to delete completion cache:" >&2
  rm -ri ~/.zcompdump
  echo "[$__zcg_name] Restart your shell to regenerate completions." >&2
}
