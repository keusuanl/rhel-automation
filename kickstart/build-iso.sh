#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
rm -f ks.iso
xorriso -as mkisofs -V OEMDRV -J -R -o ks.iso oemdrv/ 2>/dev/null
xorriso -indev ks.iso -pvd_info 2>&1 | grep -i 'volume id'
grep -c 'autoconnect-priority=100' oemdrv/ks.cfg
sha256sum ks.iso
