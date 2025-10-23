#!/bin/sh
set -e
source /mktik.sh
echo renew cert
mktik_copy_certs
mktik_import_certs
if [ -z "$MKTK_RENEW_SCRIPT" ]; then
  echo "no renew script ( MKTK_RENEW_SCRIPT ) defined"
else
  mktik_run_script "$MKTK_RENEW_SCRIPT"
fi
