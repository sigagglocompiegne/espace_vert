![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions spécifiques (locales) pour la gestion des espaces verts

# Documentation du standard

# Changelog

- 16/11/2020 : description initiale du gabarit de production des espaces verts

# Livrables

Le gabarit présenté ci-après s'organise autour de la production d'un inventaire cartographique des espaces verts géré par la collectivité. 
L'objectif principal est bien de recenser l'ensemble des objets participant à la structuration 
des espaces verts. En les typant par une nomenclature simple et compréhensible, cet inventaire peut-être
produit par un nom spécialiste.
Néanmoins pour les besoins d'un service gérant les espaces verts, ce gabarit a été pensé pour deux autres usages : l'un permettant
de détailler ces objets d'un point de vue métier et un autre dans une optique d'engagement de gestion des espaces verts (tableau de bord, intervention....).
Cet inventaire sera ainsi intégré à la base de données de la collectivité et pourra être également complété et mis à jour par le service métier à moyen et long terme.


## Gabarits

- Fichier hors gabarit des espaces verts à télécharger au format shape (géographique)
- Fichier gabarit Qgis 3.x (vierge) complet à télécharger

## Principe fonctionnel

Le principe de fonctionnement de la base de données devant intégrer l'inventaire des espaces verts s'appuie sur la production cartographique
d'objets métiers définit comme un espace d'agrément planté de fleurs, d'arbustes, d'arbres ou engazonné. 
Il peut être, dans certains cas, complété par des parties minérales ou hydrographiques. Il doit être ouvert au public et facilement accessible par des modes doux. 

Ces objets peuvent être représentés de façon surfacique (espace enherbé, planté...), linéaire (haie...) ou ponctuel (arbre...). Ils sont intégrés à la fois dans un site cohérent (équipements publics, ensemble urbain, voie...) et dans une zone de gestion et/ou intervention.

Tous les objets saisis sont typés à partir d'une nomenclature métier d'objets "espace vert" afin de les définir individuellement.

![picto](objets_pro_carto.png)

Schéma 1 : une représentation des objets d'un inventaire cartographique


## Règle de modélisation

### Règles générales

Les objets constituant l'inventaire cartographique initial sont organisés autour des 3 primitives géographiques de base : polygones, lignes et points. **La saisie des objets de type multi n'est pas autorisée.**

La saisie de ces objets doit permettre une restitution de l'ordre du 1 000ème.

Les objets produits dans le cadre de cet inventaire devront être en cohérence topologique avec la précision des référentiels utilisés.

L'invetaire cartographique se fera préférentiellement :
- soit par numérisation sur des référentiels cartographiques,
- soit par un levé de terrain.

### La modélisation

Les règles de modélisation consiste à présenter la façon dont les objets doivent être saisis et restitués dans le gabarit.

2 options se présentent en terme de modélisation, après l'analyse d'autres standards ou de productions cartographiques (Cannes, GéoVendée, Dunkerque).

* **OPTION 1 : réaliser un inventaire cartographique en respectant l'emprise exacte de chaque objet** en terme d'occupation du sol à l'exception des objets ponctuels (arbre, pot, suspension...).

Cette solution consiste à détourer chaque emprise des objets "espace vert" au sol et à respecter les ruptures. Ces ruptures peuvent être d'usages variées et appartenir ou non à la thématique "espace vert" : mode doux aménagé, allée, haie, bassin...
Dans un site cohérent, tel un parc urbain par exemple, tous les objets doivent être intégrés à l'inventaire pour une meilleure compréhension et analyse. Ainsi les objets de ruptures sont également détourés. Cette modélisation, sous forme de polygone, revient à réaliser une mini-occupation du sol.
En dehors de ces sites, seuls les objets spécifiques "espace vert" doivent être intégrés. Il sont toujours représentés sous forme polygone.

Des règles de modélisation peuvent ainsi être édictées pour ce scénario (exemple ici ) :

- aucun objet n'est représenté sous forme linéaire,
- les objets ponctuels représentant un arbre, correspondent à une localisation isolée ou en alignement. Tous les autres objets pontuels représentent leur implantation exacte au sol,
- les espaces boisés denses, avec un sous-bois sans autre usage "espace vert" sont représentés sous forme surfaciques,
- les objets surfaciques sont représentés si leur emprise au sol est supérieure à x m².


**Conclusion** : cette option a l'avantage de présenter les espaces verts dans une réalité certaine et de produire des plans d'occupation réaliste. Cependant, dans une optique de gestion ou de mise à jour interne, cette solution semble moins "abordable" du fait de multiplicité d'objets détourés se prêtant moins à l'usage recherché de gestion et d'intervention.

* **OPTION 2 : réaliser un inventaire cartographique représentant des entités cohérentes surfaciques** d'objets "espace vert". 

La différence avec l'option 1, est la non prise en compte des ruptures sous forme surfacique pour conserver l'homogénéisation d'usages des objets.
Ces ruptures, dans un site cohérent ou non, venant interrompres cette homogénéisation sont représentées sous forme linéaires avec des attributs les qualifiants (longueur, largeur...). 
Ces attributs complémentaires permettent ainsi de réaliser plus facilement des calculs d'exploitation (linéaire de haies, ...)

Des règles de modélisation peuvent ainsi être édictées pour ce scénario (exemple ici ) :

- les objets ponctuels de compositions (arbre, pot, suspension, bac, fontaine...) sont représentés sous forme de point sans limite d'emprise au sol,
- un objet représenté par un polygone, pour une surface identifiée sur le terrain, celle-ci doit être supérieure à x m² et d’une largeur supérieure à x1 m.
- un objet représenté par un linéaire, pour une surface identifiée sur le terrain, celle-ci doit être de forme linéaire et de largeur inférieure à x1 m. Un linéaire saisit est un ensemble homogène dans sa nomenclature et sa largeur. Le tracé de la ligne est saisi au centre de l'emprise au sol de l'objet. Une information de largeur est obligatoirement saisie.

**Conclusion** : cette option est plus proche d'une gestion de service mais ne permet pas une restitution graphique exacte des objets "espace vert". La production d'un inventaire cartographique et de sa mise à jour (interne ou non) est jugée plus rapide. A contrario, l'exploitation des données devra prendre en compte les particularités de cette modélisation pour restituer au mieux une réalité en terme de surfaces.
Pour rappel, c'est cette approche qui a été utilisée pour un premier inventaire réalisé en 2018 mais sans intégrer cette notion d'attributs complémentaires. Celui-ci devant être ré-intégré à la nouvelle base de données, cette option est la moins impactante. Seuls les attributs qualitatifs de longueurs ou de largeurs devront être complétés, ce qui pourra être réalisés par le service métier.


**Synthèses**

**Dans un site cohérent :** 

![picto](options_sites.png)


**En dehors d'un site cohérent :** 

![picto](options_diffus.png)

**Quelque soit l'option retenue, des choix de numérisation devront être opérés concernant des emprises minimums d'objets à prendre en compte, en surface ou en largeur.**


Les objets de cet inventaire cartographique doivent répondre aux conditions de saisies présent ci-après.
(à rédiger après l'option retenue).


### Topologie

La cohérence topologique impose le partage de géométrie et donc l’utilisation des outils « d’accroches ».

- Tous les objets sont nécessairement inclu dans une emprise communale, 
- Ils sont également inclus dans un site (équipement public, une voie...),
- Les objets devront être découpés avec les limites communales et les zones de gestion existantes.

Ces deux derniers éléments seront intégrés dans une phase ultérieure à l'inventaire cartographique initial.

- Tous les objets de type "surface" sont des polygones fermés, et si ils sont adjacents, ils devront être topologique (absence de chevauchements et de micro-trous). 

![picto](topo_poly_1.png) ![picto](topo_poly_3.png)

- Un polygone contenant un autre polygone devra être découpé avec celui-ci.

![picto](topo_poly_2.png)

- Les linéraires doivent être connectés entre eux si ils sont contiguës dans la réalité du dessin saisi.

![picto](topo_line_1.png)

- Les arcs de cercle ou ellipse devront être numérisés sous forme de polyligne suffisamment détaillée pour en reproduire la forme.

### Système de coordonnées

Les coordonnées seront exprimées en mètre avec trois chiffres après la virgule dans le système national en vigueur.
Sur le territoire métropolitain s'applique le système géodésique français légal RGF93 associé au système altimétrique IGN69. La projection associée Lambert 93 France (epsg:2154) sera à utiliser pour la livraison des données.

## Format des fichiers

Les fichiers sont disponibles au format ESRI Shape (.SHP) contenant la géométrie.
L'encodage des caractères est en UTF8. Les différents supports sont téléchargeables dans la rubrique Gabarits.

## Description des classes d'objets

|Nom fichier|Définition|Catégorie|Géométrie|
|:---|:---|:---|:---|
|geo_v_ev_point|Localisation des objets "espace vert" de représentation ponctuelle|Inventaire cartographique|Ponctuel|
|geo_v_ev_polygon|Délimitation des objets "espace vert" de représentation surfacique|Inventaire cartographique|Polygone|
|geo_v_ev_line|Tracé des objets "espace vert" de représentation rectiligne|Inventaire cartographique|Linéaire|

## Implémentation informatique

### Patrimoine

Ensemble des données décrivant les objets composant l'inventaire cartographique des espaces verts. 

`geo_v_ev_point` : fichier contenant les objets "espace vert" de type ponctuel

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL|Valeur calculée automatiquement à la saisie|
|observ|Commentaires divers |character varying(254)||||
|surf_e|Surface d'emprise au sol en m²|integer|||(en fonction des choix de modélisation retenue)|


`geo_v_ev_polygon` : fichier contenant les objets "espace vert" de type surfacique

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL||
|observ|Commentaires divers |character varying(254)||||
|sup_m²|Surface du polygone saisie en mètre carré|integer|$area|NOT NULL|Valeur calculée automatiquement à la saisie|
|perimetre|Périmètre du polygone saisie en mètre|integer|$perimetre|NOT NULL|Valeur calculée automatiquement à la saisie|

`geo_v_ev_line` : fichier contenant les objets "espace vert" de type linéaire

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL||
|observ|Commentaires divers |character varying(254)||||
|long_m|Longueur du tracé saisie en mètre|integer|$length|NOT NULL|Valeur calculée automatiquement à la saisie|
|larg_cm|Largeur du tracé saisie en centimètre|integer||NOT NULL||

### Liste de valeurs

Le contenu des listes de valeurs est disponible dans la documentation complète de la base de données en cliquant [ici](/bdd/doc_admin_bd_ev.md) dans la rubrique `Liste de valeurs`.

Cependant, pour des questions de compréhension, la nomenclature définissant le type des objets "espace vert" est présentée ci-dessous. Pour l'inventaire cartographique, seuls les 2 premiers niveaux de nomenclature sont imposés.


`lt_ev_typev1` : liste des valeurs de la nomenclature de niveau 1 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|1|Végétal|
|2|Minéral|
|3|Hydrographie|
|9|Référence non classée|

`lt_ev_typev2` : liste des valeurs de la nomenclature de niveau 2 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|101|Arbre|
|102|Espace enherbé|
|103|Espace planté|
|104|Ponctuel fleuri|
|105|Haie, mur|
|106|Friche|
|201|Allée|
|202|Clôture|
|203|Zone de rencontre|
|204|Accès|
|205|Equipement|
|301|Bassin|
|302|Points d'eau|
|303|Cours d'eau|
|999|Référence non classée|

`lt_src_geom` : liste des valeurs des référentiels de saisis disponibles
|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|20|Ortho-images|
|22|Orthophotoplan partenaire|
|50|Lever|
|51|Plan topographique|
|53|Trace GPS|
|99|Autre|

### Les identifiants

Les identifiants des objets des espaces verts sont des identifiants non signifiants (un simple numéro incrémenté de 1 à chaque insertion).



