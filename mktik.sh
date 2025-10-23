#!/bin/sh
mktik_run_script() {
  if [ -z "${MKTK_EP}" ]; then
    echo "Error: The MKTK_EP environment variable is not set." >&2
    exit 1
  fi
  script_name=$1
  echo "try to run script $script_name on $MKTK_EP"
  script_id=$(curl -s -u "$MKTK_USER:$MKTK_PASS" "$MKTK_EP"rest/system/script | jq -r '.[] | select(.name=="'$script_name'") | .".id"')
  #echo "script id $script_id"
  data=$(jq -n --arg script "$script_id" '{ ".id": ($script) }')
  curl -s -u "$MKTK_USER:$MKTK_PASS" "$MKTK_EP"rest/system/script/run -H 'Content-Type: application/json' -d "$data"
}
mktik_exec_script() {
    if [ -z "${MKTK_EP}" ]; then
      echo "Error: The MKTK_EP environment variable is not set." >&2
      exit 1
    fi
    data=$(jq -n --arg script "$1" '{ "script": ($script) }')
    curl -s -u "$MKTK_USER:$MKTK_PASS" "$MKTK_EP"rest/execute -H 'Content-Type: application/json' -d "$data"
}

mktik_copy_certs() {
  cp "$LEGO_CERT_KEY_PATH" /mkdata/
  cp "$LEGO_CERT_PATH" /mkdata/
}
mktik_import_certs() {
  if [ -z "$KEEP_OLD_CERT" ]; then
     mktik_exec_script "/certificate/remove $LEGO_CERT_DOMAIN"
  fi
  mktik_exec_script "/certificate/import file-name=aceme-tmp/${LEGO_CERT_DOMAIN}.crt name=$LEGO_CERT_DOMAIN"
  mktik_exec_script "/certificate/import file-name=aceme-tmp/${LEGO_CERT_DOMAIN}.key name=$LEGO_CERT_DOMAIN"
}