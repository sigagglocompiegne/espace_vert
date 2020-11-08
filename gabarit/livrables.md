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

Le principe de fonctionnement de la base de données de gestion des espaces verts s'appuie sur la production cartographique d'objets constituant un espace à vocation récréative ou d'embellissement de la ville (schéma 1). Ces objets peuvent être représentés de façon surfacique (espace enherbé, parterre, bois...), linéaire (haie, accotement...) ou ponctuel (arbre en alignement, pot...). Ils sont intégrés à la fois dans un site cohérent (équipements publics, ensemble urbain, voie...) et dans une zone de gestion et/ou intervention.

Le principe du modèle de données (schéma 2) prend ainsi en compte la production initiale cartographique des objets en y intégrant des notions d'appartenance cohérente à des zones de gestion, d'intervention ou de production cartographique d'ensemble (site...). Il rend également possible l'affectation d'éléments de gestion de ce patrimoine cartographique au besoin du service dans un temps plus long.

(mettre ici principe de gestion des objets surfac, ligne, pojnt) 

![picto]()

Schéma 1 : principe fonctionnel de gestion des espaces verts

![picto](principe_modelisation.png)

Schéma 2 : principe de modélisation autour de 3 blocs de production

**Ce schéma montre la prise en compte dans le modèle de donnée de la périodicité d'intégration par le service "espace vert" des différents éléments lui permettant à terme de gérer l'ensemble de son patrimoine de données. La production cartographique des objets (partie 1) constituant les espaces verts étant le maillon de base, le modèle s'attachera . Les parties 2 et 3, même si elles sont évoquées et en partie intégrées dans cette première modélisation, seront développées dans un second temps.**

![picto]

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

