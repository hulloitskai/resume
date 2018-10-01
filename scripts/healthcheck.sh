#!/usr/bin/env sh

if ! OUT="$(wget --spider -S "${ENDPOINT}" 2>&1)"; then
  echo "$0: check failed: error during wget: $OUT" >&2
  exit 1;
fi

if ! STATUS="$(echo "$OUT" | egrep "HTTP/" | awk '{print $2}')"; then
  echo "$0: check failed: status extraction returned $?." >&2
  exit 1;
fi

if [ "$STATUS" -ne 200 ]; then
  echo "$0: check failed: got non-200 status of \"$STATUS\"" >&2
  exit 1
fi

## Passed check.
exit 0
