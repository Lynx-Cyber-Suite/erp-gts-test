# erp-gts-test — image d'exécution DURCIE, sans aucun téléchargement depuis Internet pendant le build :
#  - image de base = image durcie Lynx lynx/nginx (non root, port 8080), ÉPINGLÉE PAR DIGEST (.lynx/images.lock) ;
#  - le site Angular (dist/) est construit AVANT, dans l'image durcie lynx/node (épinglée par digest), avec les paquets npm
#    servis UNIQUEMENT par le proxy de confiance npm-gts-proxy de Lynx Chain Guard (pare-feu de paquets, passeports) :
#    voir .lynx/ci.yaml / .lynx/cd.yaml (step « build ») et .lynx/harden.yaml (durcissement + push + signature) ;
#  - durcissement de la dernière étape (équivalent de « lynx-chain harden ») SANS réseau : bits setuid/setgid retirés,
#    gestionnaire de paquets apk supprimé, exécution non root (101) ; aucun secret dans une couche.
# Pas de directive « # syntax=… » : elle ferait tirer le frontal BuildKit depuis Docker Hub.
ARG NGINX_IMAGE=registry-stg.lynx-cyber.com/lynx/nginx@sha256:8271f0afe6319d1995c483c0acfed677c8a37af0beeedebb61b5b257df370e30
FROM ${NGINX_IMAGE}
ARG VERSION=1.0.0
ARG REVISION=unknown
LABEL org.opencontainers.image.source="https://github.com/Lynx-Cyber-Suite/erp-gts-test" \
      org.opencontainers.image.title="erp-gts-test" \
      org.opencontainers.image.vendor="GTS (tenant gts, Lynx Chain Guard)" \
      org.opencontainers.image.base.name="registry-stg.lynx-cyber.com/lynx/nginx" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${REVISION}"
USER root
RUN find / -xdev \( -perm -4000 -o -perm -2000 \) -type f -exec chmod a-s {} + 2>/dev/null || true; \
    rm -f /sbin/apk && rm -rf /var/cache/apk/*   # base de paquets /lib/apk/db conservée pour les scanners
COPY --chown=0:0 --chmod=0644 nginx.conf /etc/nginx/conf.d/default.conf
COPY --chown=0:0 dist/erp-gts-test/browser /usr/share/nginx/html
EXPOSE 8080
LABEL com.lynx-cyber.hardened="true" com.lynx-cyber.hardened.by="Dockerfile (équivalent lynx-chain harden, sans réseau)"
USER 101:101
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/healthz || exit 1
