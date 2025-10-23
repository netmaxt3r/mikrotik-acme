#!/bin/sh
set -e
source /mktik.sh
echo new cert
mktik_copy_certs
if [ -z "$MKTK_NO_IMPORT" ]; then
  mktik_import_certs
else
  echo "cert import disabled by MKTK_NO_IMPORT"
fi

if [ -z "$MKTK_NEW_SCRIPT" ]; then
  echo "no new script ( MKTK_NEW_SCRIPT ) defined"
else
  mktik_run_script "$MKTK_NEW_SCRIPT"
fi
