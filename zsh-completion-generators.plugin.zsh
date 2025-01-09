local MY_DIR="${0:A:h}"
local KNOWN_GENERATORS="${MY_DIR}/generators.tsv"

while IFS=$'\t' read -r CLI PRINT_COMPLETION; do

  local GENERATED_COMPLETION="${MY_DIR}/_${CLI}";

  # only for commands that are actually installed
  command -v "$CLI" &> /dev/null || continue

  # only if a completion doesn't already exist for it
  [ -z "$_comps[$CLI]" ] || continue

  # only if the file doesn't already exist
  [ -f "$GENERATED_COMPLETION" ] && continue

  eval "$PRINT_COMPLETION" > "$GENERATED_COMPLETION"
done < "$KNOWN_GENERATORS"

