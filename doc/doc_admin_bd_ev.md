![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de la base #

## Principes
* **généralités** :
La ville de Compiègne ayant souhaité réaliser un plan d'actions en faveur d'une gestion différenciée à objectif zéro pesticide sur ses espaces verts et minéraux, des relevés de terrains ont été effectués et ensuite cartographiés par la société ECOLOgiC.
Le travail de terrain a eu lieu sur le premier trimestre 2018. Les pratiques d'entretien renseignées dans les différentes tables attributaires (pratique intiale) sont celles qui étaient de mise à cette période.
La saisie graphique des éléments s'est faite à l'aide des référentiels suivants : Ortho GéoPicardie 2013, Ortho ARC 2012, PCI vecteur, Plan d'agglomération de l'ARC.
EPSG : 2154, RGF93 / Lambert 93.
Emprise : commune de Compiègne.

* **résumé fonctionnel** :
Les données shape d'origine fournies ont été restructuré lors de l'intégration dans la base de données afin d'être en cohérence avec les principes d'organisation établis au sein de l'Agglomération de la Région de Compiègne. Les données sont donc réordonnées en 2 tables alphanumériques (une table "principale" avec la typologie des objets et les informations génériques et une table concernant l'entretien et la gestion faisant chacune appel à des domaines de valeurs) et 3 tables géographiques contenant la géométrie des objets surfaciques, linéaires et ponctuels. Une dernière table spécifique sur les espèces invasives est intégrée de manière indépendante.

## Dépendances (non critiques)

Pas de dépendances critiques pour la gestion des données des espaces verts.

## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés dans le schéma m_espace_vert et celles aplicatives dans les schémas x_apps ou x_apps_public.

### classes d'objets de gestion :

`an_ev_type` : table des attributs sur la typologie et informations génériques des objets.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|identifiant unique|bigint| |
|type_ev|type d'espace vert|character varying(2)| |
|sstype_ev|sous-type d'espace vert|character varying(5)| |
|insee|code Insee|character varying(5)| |
|commune|nom de la commune|character varying(150)| |
|op_sai|opérateur de la dernière saisie en base de l'objet|character varying(80)| |
|date_int|date d'intégration de l'objet|timestamp without time zone| |
|date_sai|date de saisie de l'objet|timestamp without time zone| |
|date_maj|date de mise à jour de l'objet|timestamp without time zone| |
|src_geom|référentiel de saisie|character varying(2)| |
|observ|commentaires|character varying(254)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ id avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
* Une clé étrangère existe sur la table de valeur `lt_ev_type` (`r_objet.lt_src_geom` sur l'attribut `code`)
* Une clé étrangère existe sur la table de valeur `lt_ev_sstype` (`r_objet.lt_src_geom` sur l'attribut `code`)
---
