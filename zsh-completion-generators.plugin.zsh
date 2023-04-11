i_have() {
	command -v "$1" &>/dev/null
}

MY_COMPDIR="${0:A:h}/build"

KNOWN_GENERATORS="${0:A:h}/generators.tsv"

mkdir -p "$MY_COMPDIR"

while IFS=$'\t' read -r CLI PRINT_COMPLETION; do
  GENERATED_COMPLETION="${MY_COMPDIR}/_${CLI}";
  if command -v "$CLI" &> /dev/null && [ -z "$_comps[$CLI]" ] && [ -n "$GENERATED_COMPLETION" ]; then
    eval "$PRINT_COMPLETION" > "$GENERATED_COMPLETION"
  fi
done < "$KNOWN_GENERATORS"

fpath+="$MY_COMPDIR"

