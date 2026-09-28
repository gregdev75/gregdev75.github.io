#!/usr/bin/env bash
# Met l'adresse e-mail de support dans tout le site (textes et liens mailto).
#
# Première fois (remplace le jeton {{SUPPORT_EMAIL}}) :
#   scripts/set-email.sh contact@exemple.fr
# Changer d'adresse plus tard (remplace l'ancienne adresse par la nouvelle) :
#   scripts/set-email.sh nouvelle@exemple.fr ancienne@exemple.fr
#
# Fichiers traités : .html, .xml, .txt du site. README.md et scripts/ ne sont pas modifiés.
set -euo pipefail

TOKEN='{{SUPPORT_EMAIL}}'
new="${1:-}"
old="${2:-$TOKEN}"

if [[ -z "$new" ]]; then
  echo "Usage : scripts/set-email.sh adresse@exemple.fr [ancienne@exemple.fr]" >&2
  exit 1
fi
if ! [[ "$new" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
  echo "Adresse invalide : $new" >&2
  exit 1
fi

cd "$(dirname "$0")/.."

files=()
while IFS= read -r -d '' f; do
  files+=("$f")
done < <(find . -type f \( -name '*.html' -o -name '*.xml' -o -name '*.txt' \) \
  -not -path './scripts/*' -not -path './.git/*' -print0 | xargs -0 grep -lF --null -- "$old" 2>/dev/null || true)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "Rien à remplacer : « $old » n'apparaît dans aucun fichier du site." >&2
  exit 1
fi

count=$(cat "${files[@]}" | grep -oF -- "$old" | wc -l | tr -d ' ')
for f in "${files[@]}"; do
  OLD="$old" NEW="$new" perl -pi -e 's/\Q$ENV{OLD}\E/$ENV{NEW}/g' "$f"
done

left=$(grep -rlF --include='*.html' --include='*.xml' --include='*.txt' --exclude-dir=scripts -- "$old" . || true)
if [[ -n "$left" ]]; then
  echo "Attention, « $old » reste dans : $left" >&2
  exit 1
fi

echo "OK : $count occurrence(s) remplacée(s) par $new dans ${#files[@]} fichier(s)."
