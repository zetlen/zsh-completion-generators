KNOWN_GENERATORS="${0:A:h}/generators.tsv"

while IFS=$'\t' read -r CLI PRINT_COMPLETION; do
  GENERATED_COMPLETION="_${CLI}";
  if command -v "$CLI" &> /dev/null && [ -z "$_comps[$CLI]" ] && [ -n "$GENERATED_COMPLETION" ]; then
    eval "$PRINT_COMPLETION" > "$GENERATED_COMPLETION"
  fi
done < "$KNOWN_GENERATORS"

