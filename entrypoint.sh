#!/bin/sh
is_renew=0
for arg in "$@"; do
  if [ "$arg" = "renew" ]; then
    is_renew=1
    break
  fi
done
if [ $is_renew -eq 1 ]; then
  set -- "$@" "--renew-hook=/on_renew.sh"
else
  set -- "$@" "--run-hook=/on_run.sh"
fi
/lego $@
ec=$?
echo "Exit code : $ec"
exit $ec