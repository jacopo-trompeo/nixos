#!/usr/bin/env bash
set -uo pipefail

BOTTLE="Visual Novels"
VN_PROG="${1:?usage: vn <program-name>}"
BROWSER="${VN_BROWSER:-brave}"
HOOK_PAGE="https://renji-xd.github.io/texthooker-ui/"

j() { niri msg --json "$@"; }
current_ws() { j workspaces | jq -r '.[] | select(.is_focused) | .idx'; }

wait_window() {
  local re="$1" t="${2:-60}" i=0 lim
  lim=$(( t * 5 ))
  while [ "$i" -lt "$lim" ]; do
    id=$(j windows | jq -r --arg re "$re" \
      '.[] | select((.app_id//""|test($re;"i")) or (.title//""|test($re;"i"))) | .id' | head -1)
    [ -n "$id" ] && { echo "$id"; return 0; }
    sleep 0.2; i=$(( i + 1 ))
  done
}

move_down() {
  [ -n "$1" ] || return 0
  niri msg action move-window-to-workspace --window-id "$1" --focus false "$2" >/dev/null 2>&1 || true
}

READ_WS=$(current_ws)
DOWN_WS=$(( READ_WS + 1 ))

setsid "$BROWSER" --new-window "$HOOK_PAGE" >/dev/null 2>&1 &

if ! pgrep -x anki >/dev/null 2>&1; then
  setsid anki >/dev/null 2>&1 &
fi
move_down "$(wait_window 'anki' 45)" "$DOWN_WS"

FLAG="$(mktemp -u "${XDG_RUNTIME_DIR:-/tmp}/vn-textractor.XXXXXX")"
trap 'rm -f "$FLAG"' EXIT
BASELINE=$(j windows | jq -c '[.[].id]')

setsid bash -c '
  bottles-cli run -b "$1" -p "$2" >/dev/null 2>&1 &
  vnpid=$!
  i=0
  while [ ! -f "$3" ] && [ "$i" -lt 300 ]; do sleep 0.4; i=$(( i + 1 )); done
  bottles-cli run -b "$1" -p "Textractor" >/dev/null 2>&1 &
  wait "$vnpid"
' bash "$BOTTLE" "$VN_PROG" "$FLAG" >/dev/null 2>&1 &

VN_ID=""; i=0
while [ "$i" -lt 300 ]; do
  VN_ID=$(j windows | jq -r --argjson base "$BASELINE" \
    '.[] | select((.id | IN($base[]) | not))
         | select((.title//""|test("textractor";"i")) | not)
         | select(.is_floating == false) | .id' | head -1)
  [ -n "$VN_ID" ] && break
  sleep 0.3; i=$(( i + 1 ))
done
[ -n "$VN_ID" ] && sleep 1

touch "$FLAG"

TXT_ID=$(wait_window 'textractor' 120)
if [ -n "$TXT_ID" ]; then
  move_down "$TXT_ID" "$DOWN_WS"
  niri msg action set-window-width --id "$TXT_ID" "50%" >/dev/null 2>&1 || true
fi

if [ -n "$VN_ID" ]; then
  for _ in 1 2 3 4 5; do
    niri msg action focus-window --id "$VN_ID" >/dev/null 2>&1 || true
    sleep 0.4
  done
else
  niri msg action focus-workspace "$READ_WS" >/dev/null 2>&1 || true
fi
