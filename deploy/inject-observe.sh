#!/bin/sh
# Injecte le jeton Lynx Observe (SDK navigateur) dans le build : LYNX_OBSERVE_TOKEN=soi_… deploy/inject-observe.sh dist/erp-gts-test/browser
# Le jeton vient de SSM /lynx/stg/GTS_OBSERVE_SDK_TOKEN (ou d'un secret du pipeline) ; il n'est jamais écrit dans le dépôt.
set -eu
DIR="${1:?dossier du build (ex. dist/erp-gts-test/browser)}"
: "${LYNX_OBSERVE_TOKEN:?LYNX_OBSERVE_TOKEN obligatoire (soi_…)}"
case "$LYNX_OBSERVE_TOKEN" in soi_*) ;; *) echo "jeton invalide" >&2; exit 1 ;; esac
sed -i.bak "s#token: ''#token: '$LYNX_OBSERVE_TOKEN'#" "$DIR/observe-config.js" && rm -f "$DIR/observe-config.js.bak"
echo "Lynx Observe : jeton injecté dans $DIR/observe-config.js"
