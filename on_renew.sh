#!/bin/sh
set -e
. /mktik.sh
echo renew cert
mktik_copy_certs
if [ -z "$MKTK_NO_IMPORT" ]; then
  mktik_import_certs
else
  echo "cert import disabled by MKTK_NO_IMPORT"
fi
sleep 2
if [ -z "$MKTK_RENEW_SCRIPT" ]; then
  echo "no renew script ( MKTK_RENEW_SCRIPT ) defined"
else
  mktik_run_script "$MKTK_RENEW_SCRIPT"
fi
