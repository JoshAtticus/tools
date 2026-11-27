# shellcheck shell=bash
# Prints MAYA_API_KEY from the .env next to these scripts (empty if unset). Parsed, never sourced.
read_dotenv_key() {
  local f="${SCRIPT_DIR}/.env" line val
  [ -f "$f" ] || return 0
  line="$(grep -E '^[[:space:]]*(export[[:space:]]+)?MAYA_API_KEY=' "$f" | tail -n 1 || true)"
  [ -n "$line" ] || return 0
  val="${line#*=}"
  val="${val%$'\r'}"
  val="${val#"${val%%[![:space:]]*}"}"
  val="${val%"${val##*[![:space:]]}"}"
  if [ "${#val}" -ge 2 ]; then
    case "$val" in
      \"*\"|\'*\') val="${val:1:${#val}-2}" ;;
    esac
  fi
  printf '%s' "$val"
}
