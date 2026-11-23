#!/bin/sh
# Default world backup: tar.gz of worlds/ into backups/, keep last $BACKUP_KEEP.
set -eu
cd "${BEDROCK_DIR:?}"
[ -d worlds ] || exit 0
mkdir -p backups
f="backups/worlds-$(date +%Y%m%d-%H%M%S).tar.gz"
tar czf "$f" worlds
ls -1t backups/worlds-*.tar.gz 2>/dev/null | tail -n +"$(( ${BACKUP_KEEP:-10} + 1 ))" | while read -r old; do rm -f -- "$old"; done
