local MY_DIR="${0:A:h}"
local KNOWN_GENERATORS="${MY_DIR}/generators.tsv"

while IFS=$'\t' read -r CLI PRINT_COMPLETION; do
  local GENERATED_COMPLETION="${MY_DIR}/_${CLI}";
  if command -v "$CLI" &> /dev/null && [ -z "$_comps[$CLI]" ] && [ -n "$GENERATED_COMPLETION" ]; then
    eval "$PRINT_COMPLETION" > "$GENERATED_COMPLETION"
  fi
done < "$KNOWN_GENERATORS"

