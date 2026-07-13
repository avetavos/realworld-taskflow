#!/usr/bin/env bash
#
# TaskFlow API smoke test — exercises the whole REST surface end to end with curl + jq.
# Bring the stack up first (`docker compose up`), then run:  bash taskflow-smoke.sh
#
# Requires: curl, jq.  Override the base URL with:  BASE=http://localhost:8080 bash taskflow-smoke.sh
set -euo pipefail

BASE="${BASE:-http://localhost:8080}"
EMAIL="demo+$(date +%s)@taskflow.dev"   # unique each run so re-runs don't hit "email taken"
PASSWORD="password123"

say() { printf '\n\033[1;32m▶ %s\033[0m\n' "$1"; }

say "Register ($EMAIL)"
TOKEN=$(curl -s -X POST "$BASE/auth/register" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\",\"display_name\":\"Demo User\"}" \
  | jq -r '.token')
[ -n "$TOKEN" ] && [ "$TOKEN" != "null" ] || { echo "register failed"; exit 1; }
echo "token: ${TOKEN:0:24}…"

AUTH=(-H "Authorization: Bearer $TOKEN")
JSON=(-H 'Content-Type: application/json')

say "Create board"
BOARD_ID=$(curl -s -X POST "$BASE/boards" "${AUTH[@]}" "${JSON[@]}" -d '{"title":"Smoke Test Board"}' | jq -r '.id')
echo "board_id: $BOARD_ID"

say "Create columns (To Do, In Progress)"
TODO=$(curl -s -X POST "$BASE/boards/$BOARD_ID/columns" "${AUTH[@]}" "${JSON[@]}" -d '{"title":"To Do"}' | jq -r '.id')
DOING=$(curl -s -X POST "$BASE/boards/$BOARD_ID/columns" "${AUTH[@]}" "${JSON[@]}" -d '{"title":"In Progress"}' | jq -r '.id')
echo "todo: $TODO  doing: $DOING"

say "Create cards in To Do"
CARD_A=$(curl -s -X POST "$BASE/columns/$TODO/cards" "${AUTH[@]}" "${JSON[@]}" -d '{"title":"Card A"}' | jq -r '.id')
CARD_B=$(curl -s -X POST "$BASE/columns/$TODO/cards" "${AUTH[@]}" "${JSON[@]}" -d '{"title":"Card B","description":"has a description"}' | jq -r '.id')
echo "card_a: $CARD_A  card_b: $CARD_B"

say "Move Card B into In Progress"
curl -s -X PATCH "$BASE/cards/$CARD_B/move" "${AUTH[@]}" "${JSON[@]}" \
  -d "{\"target_column_id\":\"$DOING\"}" | jq -c '{id, column_id, position}'

say "Label: create + attach to Card A"
LABEL_ID=$(curl -s -X POST "$BASE/boards/$BOARD_ID/labels" "${AUTH[@]}" "${JSON[@]}" -d '{"name":"urgent","color":"#CE422B"}' | jq -r '.id')
curl -s -o /dev/null -w 'attach → %{http_code}\n' -X POST "$BASE/cards/$CARD_A/labels/$LABEL_ID" "${AUTH[@]}"

say "Fetch the board tree"
curl -s "$BASE/boards/$BOARD_ID" "${AUTH[@]}" \
  | jq '{title, columns: [.columns[] | {title, cards: [.cards[].title]}]}'

say "Done ✅  (board $BOARD_ID)"
