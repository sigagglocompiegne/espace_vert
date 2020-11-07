![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions spécifiques (locales) pour la gestion des espaces verts

# Documentation du standard

# Changelog

- 09/11/2020 : description initiale du gabarit de production et de mise à jour des espaces verts

# Livrables


## Gabarits

- Fichier hors gabarit des espaces verts à télécharger au format shape (géographique)
- Fichier gabarit Qgis 3.x (vierge) complet à télécharger

## Principe fonctionnel

Le principe de fonctionnement de la base de données des Points d'Apport Volontaire Verre s'appuie sur le lieu de collecte. Ce lieu est un point unique disposant de n conteneurs, qu'ils soient à usage Verre ou TLC. 

(mettre ici principe de gestion des objets surfac, ligne, pojnt) 

Schéma 1 : principe fonctionnel de gestion des espaces verts

![picto]()

Schéma 2 : principe de modélisation autour de 3 blocs de production

![picto]()

Schéma 3 : restitution conceptuelle dans la base de données

## Règle de modélisation
==> indiquer ici les modalite de production (règle de modélisation) (cf PDF GeoPal)

*Important :*
-	le gabarit Qgis proposé, 
- le gabarit permet de créer ou 
-	l'attribut 
- L'attribut 

Un gabarit de saisi, sous le logiciel SIG QGIS 3.x, est disponible et permet de disposer des fonds de plan géographiques nécessaires à la localisation des espaces verts. D'autres fonds de plan peuvent ajoutés si le prodcuteur en dispose.

## Système de coordonnées

Les coordonnées seront exprimées en mètre avec trois chiffres après la virgule dans le système national en vigueur.
Sur le territoire métropolitain s'applique le système géodésique français légal RGF93 associé au système altimétrique IGN69. La projection associée Lambert 93 France (epsg:2154) sera à utiliser pour la livraison des données.

## Topologie

- Tout objet est nécessairement inclu dans l'emprise de la commune de Compiègne et dans les zones d'aménagement (ZAE) gérées par l'Agglomération de la Région de Compiègne.

## Format des fichiers

Les fichiers sont disponibles au format ESRI Shape (.SHP) contenant la géométrie.
L'encodage des caractères est en UTF8. Les différents supports sont téléchargeables dans la rubrique Gabarits.

## Description des classes d'objets

|Nom fichier|Définition|Catégorie|Géométrie|
|:---|:---|:---|:---|
|(table)|def|Patrimoine|Ponctuel|
(table)|def|Patrimoine|sans objet|

## Implémentation informatique

### Patrimoine

Ensemble des données décrivant les objets composant 

`table` : nom

|Nom attribut|Définition|Type|Valeurs|Contraintes|
|:---|:---|:---|:---|:---|
|attribut|||||


### Les identifiants

Les identifiants des objets des espaces verts sont des identifiants non signifiants (un simple numéro incrémenté de 1 à chaque insertion).

### Liste de valeurs

Le contenu des listes de valeurs est disponible dans la documentation complète de la base de données en cliquant [ici](/bdd/doc_admin_bd_tri.md) dans la rubrique `Liste de valeurs`.

