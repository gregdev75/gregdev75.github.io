# Mochi Studio : site web

Site vitrine et pages officielles (confidentialité, support) des applis Mochi Studio.
HTML et CSS statiques : aucun JavaScript, aucun framework, aucun outil de build.
Prévu pour GitHub Pages, dépôt `gregdev75.github.io` (la racine du site est la racine du dépôt).

## Adresses du site

| Page | Français | Anglais |
| --- | --- | --- |
| Accueil Mochi Studio | https://gregdev75.github.io/ | https://gregdev75.github.io/en/ |
| Cacaboom | https://gregdev75.github.io/cacaboom/ | https://gregdev75.github.io/en/cacaboom/ |
| Confidentialité | https://gregdev75.github.io/cacaboom/confidentialite/ | https://gregdev75.github.io/en/cacaboom/privacy/ |
| Support | https://gregdev75.github.io/cacaboom/support/ | https://gregdev75.github.io/en/cacaboom/support/ |

## Liens à donner à Apple (App Store Connect)

Pour chaque langue de la fiche App Store :

- **URL de la politique de confidentialité** : `/cacaboom/confidentialite/` (français) ou `/en/cacaboom/privacy/` (anglais)
- **URL d'assistance** : `/cacaboom/support/` ou `/en/cacaboom/support/`
- **URL marketing** (facultative) : `/cacaboom/` ou `/en/cacaboom/`

Toujours avec `https://gregdev75.github.io` devant.
Dans « Confidentialité de l'app », la réponse cohérente avec la politique est : **aucune donnée collectée**
(Game Center est un service d'Apple, il n'entre pas dans cette déclaration).

## Arborescence

```
index.html                     accueil (FR)
en/index.html                  accueil (EN)
cacaboom/index.html            présentation du jeu (FR)
cacaboom/confidentialite/      politique de confidentialité (FR)
cacaboom/support/              aide et FAQ (FR)
cacaboom/img/                  icône, cacas du jeu, image de partage (og)
en/cacaboom/…                  mêmes pages en anglais (privacy/ au lieu de confidentialite/)
404.html                       page introuvable (FR + EN)
assets/css/site.css            toute la mise en page
assets/fonts/                  Fredoka 400 et 500 (auto-hébergée)
assets/img/                    logo mochi, favicon, étincelle, image de partage du studio
favicon.ico, apple-touch-icon.png, robots.txt, sitemap.xml, .nojekyll
scripts/set-email.sh           met l'adresse e-mail de support partout
```

## Mettre l'adresse e-mail de support

Toutes les pages utilisent le jeton `{{SUPPORT_EMAIL}}` (texte et liens `mailto:`).
Depuis le dossier du site :

```
scripts/set-email.sh contact@exemple.fr
```

Pour changer d'adresse plus tard : `scripts/set-email.sh nouvelle@exemple.fr ancienne@exemple.fr`.
Le script ne touche ni à ce README ni au dossier `scripts/`.

## Mettre le lien App Store (quand l'appli est publiée)

Le bouton « Bientôt sur l'App Store » est un simple badge, pas un lien.
Il apparaît dans 4 fichiers : `index.html`, `en/index.html`, `cacaboom/index.html`, `en/cacaboom/index.html`
(repère : le commentaire `<!-- App Store : … -->` juste au-dessus).

Dans chaque fichier :

1. remplacer `<span class="store store--soon">` par `<a class="store" href="https://apps.apple.com/app/idXXXXXXXXXX">` ;
2. remplacer le `</span>` final du bloc (juste après `</strong></span>`) par `</a>` ;
3. changer le petit texte : « Bientôt sur » devient « Télécharger dans » (FR), « Coming soon to » devient « Download on » (EN).

En option, dans le `<head>` des pages Cacaboom : `<meta name="apple-itunes-app" content="app-id=XXXXXXXXXX">`
(bannière App Store automatique dans Safari sur iPhone).

## Ajouter une nouvelle appli

1. Copier `cacaboom/` en `nom-appli/` et `en/cacaboom/` en `en/nom-appli/`.
2. Remplacer les images de `nom-appli/img/` : `icon-256.jpg` (icône 256 x 256),
   `og-…png` (image de partage 1200 x 630) et les illustrations.
3. Dans les 6 pages copiées, adapter :
   - les textes, le nom de l'appli et tous les chemins `/cacaboom/` (liens, `canonical`, `hreflang`, `og:url`, `og:image`) ;
   - la **politique de confidentialité** selon ce que la nouvelle appli fait vraiment
     (données, réseau, publicité, achats), avec une nouvelle date de mise à jour ;
   - la FAQ du support.
4. Sur les deux accueils (`index.html`, `en/index.html`), dupliquer le bloc `<article class="card app-card">`
   et l'adapter (la carte « La suite se prépare » peut rester ou partir).
5. Si besoin, ajouter l'appli dans le pied de page de toutes les pages (liens).
6. Ajouter les 6 nouvelles adresses dans `sitemap.xml`.
7. Tester en local : `python3 -m http.server 8000` dans le dossier du site, puis ouvrir http://localhost:8000/.
8. Liens à donner à Apple : `https://gregdev75.github.io/nom-appli/confidentialite/` et `https://gregdev75.github.io/nom-appli/support/`
   (versions anglaises sous `/en/nom-appli/`).

## Mise en ligne (plus tard)

Avant de pousser : lancer `scripts/set-email.sh` (sinon les pages affichent `{{SUPPORT_EMAIL}}` et Apple refusera l’URL d’assistance sans contact valide).

Créer le dépôt public `gregdev75.github.io`, y pousser le contenu de ce dossier, puis
Settings > Pages > Deploy from a branch > `main` / `(root)`. Le fichier `.nojekyll` évite tout traitement Jekyll.

## Charte

- Couleurs : crème `#FFF4E3`, rose `#FF7BAC`, jaune `#FFD166`, texte brun `#4A2C17`, contours `#3B2413`.
- Police : Fredoka 400 (texte) et 500 (titres, boutons).
- Style : contours bruns épais et arrondis, ombre pleine sous les cartes et boutons, surlignage jaune sur un mot clé.
- Règles d'écriture : pas de tiret cadratin ni demi-cadratin ; tutoiement sur les pages de jeu et d'aide,
  vouvoiement dans la politique de confidentialité ; le nom réel du développeur n'apparaît nulle part.
