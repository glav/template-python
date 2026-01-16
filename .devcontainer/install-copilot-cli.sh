#!/usr/bin/env bash

set -e
set -o pipefail

## Optional Environment Variables:

SKIP_INSTALL_COPILOT_CLI="${SKIP_INSTALL_COPILOT_CLI:-}" # Set to 'true' to skip installing Copilot CLI
COPILOT_CLI_VERSION="${COPILOT_CLI_VERSION:-}"           # Optional version (ex. 'v0.0.369'); defaults to latest when unset
COPILOT_CLI_PREFIX="${COPILOT_CLI_PREFIX:-}"             # Optional install prefix; defaults per official installer

log() {
	printf "========== %s ==========%s" "$1" $'\n'
}

err() {
	printf "[ ERROR ]: %s%s" "$1" $'\n' >&2
	exit 1
}

require_downloader() {
	if command -v curl &>/dev/null; then
		echo "curl"
		return 0
	fi

	if command -v wget &>/dev/null; then
		echo "wget"
		return 0
	fi

	err "Either 'curl' or 'wget' is required to install Copilot CLI"
}

install_copilot_cli() {
	if [[ ${SKIP_INSTALL_COPILOT_CLI,,} == "true" ]]; then
		log "Skipping Copilot CLI install"
		return 0
	fi

	local downloader
	downloader="$(require_downloader)"

	log "Installing Copilot CLI (standalone)"

	if [[ $downloader == "curl" ]]; then
		if [[ $COPILOT_CLI_VERSION || $COPILOT_CLI_PREFIX ]]; then
			VERSION="$COPILOT_CLI_VERSION" PREFIX="$COPILOT_CLI_PREFIX" curl -fsSL https://gh.io/copilot-install | bash
		else
			curl -fsSL https://gh.io/copilot-install | bash
		fi
	else
		if [[ $COPILOT_CLI_VERSION || $COPILOT_CLI_PREFIX ]]; then
			VERSION="$COPILOT_CLI_VERSION" PREFIX="$COPILOT_CLI_PREFIX" wget -qO- https://gh.io/copilot-install | bash
		else
			wget -qO- https://gh.io/copilot-install | bash
		fi
	fi

	if [[ ! $COPILOT_CLI_PREFIX ]]; then
		export PATH="$HOME/.local/bin:$PATH"
	else
		export PATH="$COPILOT_CLI_PREFIX/bin:$PATH"
	fi

	if ! command -v copilot &>/dev/null; then
		err "Copilot CLI install completed but 'copilot' is not on PATH"
	fi

	copilot --version || true
	log "Copilot CLI is available via 'copilot'"
}

install_copilot_cli
