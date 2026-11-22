// Copie DÉRIVÉE de package-lock.json pour « lynx-chain verify lockfile » (CLI 0.6.4) : mêmes paquets, mêmes versions, mêmes
// empreintes d'intégrité — seules les PLAGES de dépendances (objets { nom: "^x.y" }) sont retirées, car le parseur de la CLI
// les attend comme des objets imbriqués et refuse tout lockfile npm v2/v3 réel (« invalid package-lock.json », bug produit
// documenté dans docs/deploiement). À supprimer dès que la CLI est corrigée.
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
const lock = JSON.parse(readFileSync('package-lock.json', 'utf8'));
for (const entry of Object.values(lock.packages ?? {})) {
  for (const k of ['dependencies', 'devDependencies', 'optionalDependencies', 'peerDependencies', 'peerDependenciesMeta']) delete entry[k];
}
mkdirSync('lynx-verify', { recursive: true });
writeFileSync('lynx-verify/package-lock.json', JSON.stringify(lock, null, 2));
console.log(`lynx-verify/package-lock.json : ${Object.keys(lock.packages).length - 1} entrées`);
