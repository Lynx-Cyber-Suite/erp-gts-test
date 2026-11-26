// Lynx Observe (Lynx Track, SDK navigateur) — configuration injectée AU DÉPLOIEMENT (deploy/inject-observe.sh).
// Le jeton (source « erp-gts-test (SDK Lynx Track) », SSM /lynx/stg/GTS_OBSERVE_SDK_TOKEN) n'est jamais commité :
// vide ⇒ aucun envoi. L'origine du site est déclarée sur la source dans Lynx Observe (toute autre origine est refusée).
window.__lynxObserve = {
  endpoint: 'https://api-soc-stg.lynx-cyber.com/otlp',
  token: '',
  service: 'erp-gts-test',
  environment: 'prod',
};
