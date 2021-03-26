![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions spécifiques (locales) pour la gestion des espaces verts

# Documentation du standard

# Changelog

- 19/03/2021 : finalisation du gabarit et de la modélisation pour un inventaire cartographique
- 16/11/2020 : description initiale du gabarit de production des espaces verts

# Livrables

Le gabarit présenté ci-après s'organise autour de la production d'un inventaire cartographique des espaces verts. Il peut être utilisé pour la saisie :
 * des espaces verts situés dans le domaine public,
 * des espaces verts compris dans des espaces privés fermés relevant de la propriété de la collectivité, 
 * des espaces verts compris dans des espaces privés ouverts et accessibles depuis l'espace public.
 
En les typant par une nomenclature simple et compréhensible, cet inventaire peut-être produit par un non spécialiste.

Néanmoins pour les besoins d'un service gérant les espaces verts, ce gabarit a été pensé pour deux autres usages : l'un permettant de détailler ces objets d'un point de vue métier et l'autre dans une optique d'engagement de gestion des espaces verts (tableau de bord, interventions....).

Cet inventaire sera ainsi intégré à la base de données de la collectivité et pourra être également complété et mis à jour par le service métier à moyen et long terme.

## Gabarits

- Fichier gabarit Qgis 3.1x (vierge) complet à télécharger

## Principe fonctionnel

Le principe de fonctionnement de la base de données devant intégrer l'inventaire des espaces verts s'appuie sur la production cartographique d'objets métiers définis comme un espace d'agrément planté de fleurs, d'arbustes, d'arbres ou engazonné. 

Ces objets peuvent être représentés de façon surfacique (espace enherbé, planté ...), linéaire (haie, chemin ...) ou ponctuel (arbre, pot ...). 

Dans les sites cohérents (parc, square, coulée verte urbaine ...), les objets "espace vert" sont complétés par des parties minérales ou hydrographiques. En dehors, seuls les objets spécifiques aux espaces verts sont saisis.

L'inventaire cartographique ne s'attachera pas à la définition des sites cohérents et des zones de gestion, et ne devra pas tenir compte des règles topologiques liées à ces données.

Tous les objets saisis sont typés à partir d'une nomenclature métier d'objets "espace vert" afin de les définir individuellement.

![picto]() à refaire

Schéma 1 : une représentation des objets d'un inventaire cartographique


## Règle de modélisation

### Règles générales

Les objets constituant l'inventaire cartographique initial sont organisés autour des 3 primitives géographiques de base : polygones, lignes et points. **La saisie des objets de type multi n'est pas autorisée.**

La saisie de ces objets doit permettre une restitution de l'ordre du 1/1000e.

Les objets produits dans le cadre de cet inventaire devront être en cohérence topologique avec la précision des référentiels utilisés.

L'inventaire cartographique se fera préférentiellement :
- soit par numérisation sur des référentiels cartographiques (intégrés aux gabarits),
- soit par un levé de terrain.

### La modélisation

Les règles de modélisation consiste à présenter la façon dont les objets doivent être saisis et restitués dans le gabarit.

La modélisation choisie est la non prise en compte des ruptures sous forme surfacique pour conserver l'homogénéisation d'usage des objets.
Ces ruptures, dans un site cohérent ou non, venant interrompre cette homogénéisation sont représentées sous forme linéaire avec des attributs les qualifiant ( largeur, type de saisie ...). 
Ces attributs complémentaires propres aux objets des espaces verts permettent ainsi de réaliser plus facilement des calculs d'exploitation (linéaire de haies, ...).

Cette orientation assumée, est censée être plus proche d'une gestion de service mais ne permet pas une restitution graphique exacte des objets "espace vert". La production d'un inventaire cartographique et de sa mise à jour (interne ou non) est jugée plus rapide. A contrario, l'exploitation des données devra prendre en compte les particularités de cette modélisation pour restituer au mieux une réalité en terme de surface.
Pour rappel, c'est cette approche qui a été utilisée pour un premier inventaire réalisé en 2018 mais sans intégrer cette notion d'attributs complémentaires. Celui-ci devant être corrigé pour être intégré à la nouvelle base de données, cette option est la moins impactante.

#### Présentation simplifiée de la nomenclature 

![picto](nomenclature_ev_v2.png)

#### Modélisation simplifiée des objets à saisir

Les objets d'espaces verts disposent d'attributs complémentaires. Ils sont indiqués dans les colonnes A+ du tableau ci-dessous pour chaque type de géométrie.

|Objets|Point|A+|Ligne|A+|Surface|A+|
|:---|:---|:---|:---|:---|:---|:---|
|arbre|arbre isolé|position,entretien|alignement d'arbres|position,entretien|zone boisée|entretien|
|arbuste|arbuste isolé|position,entretien|haie|position,entretien,largeur,type de saisie|massif arbustif|position,entretien|
|fleur|pot, bac, jardinière|position,entretien|||massif fleuri|position,entretien|
|pelouse|||||espace enherbé|position,entretien|
|allée|||voie|largeur|||
|piste cyclable|||voie|largeur|||
|place/parvis|||||espace de circulation||
|clôture, mur|||clôture||||
|parking|||||stationnement||
|aire de jeux|||||équipement||
|bassin|point d'eau||||étendue d'eau||
|fontaine|point d'eau||||||
|arrivée d'eau|point d'eau||||||
|ru, rivière|||cours d'eau|largeur|||


#### Modélisation détaillée des objets à saisir


|Classe d'objets|Type d'objets|Représentation|Définition|Règle de modélisation particulière|
|:---|:---|:---|:---|:---|
|PONCTUEL Espace vert|Arbre(1)|POINT|L'objet identifié sur le terrain est un arbre entretenu, localisé en diffus, en alignement, dans un contenant artificiel ou dans une zone boisée aménagée et entretenue.|L'objet restitué doit correspondre au centre de celui-ci.|
|PONCTUEL Espace vert|Ponctuel fleuri hors sol|POINT|L'objet identifié sur le terrain est un espace fleuri hors sol dans un contenant artificiel (Bacs, pots, jardinière, suspension ...) inférieur à 5m².|L'objet restitué doit correspondre au centre de celui-ci.|
|PONCTUEL Espace vert|Ponctuel fleuri au sol|POINT|L'objet identifié sur le terrain est un massif fleuri ou arbustif inférieur à 5m².|L'objet restitué doit correspondre au centre du polygone non saisie.|
|PONCTUEL Hydrographique|Ponctuel points d'eau|POINT|L'objet identifié sur le terrain est un équipement hydrographique (fontaine, point d'eau ...) contenus dans un site cohérent (parc, square ...). Les bassins ou étendues d'eau sont représentés ici si ils sont inférieurs à 5m². |L'objet restitué doit correspondre au centre de celui-ci.|
|LINEAIRE Espace vert|Alignement d'arbres(1)|LINEAIRE|L'objet identifié sur le terrain est une bande arborée, composée d'une série d'arbres entretenus continus (au moins 4), le long d'un axe routier ou piéton.|Le linéaire saisi correspond au centre de l'emprise de l'alignement. Les ruptures de voirie devront être respectées. Chaque alignement doit être identifié. Se référer au schéma n°1 ci-dessous.|
|LINEAIRE Espace vert|Haie|LINEAIRE|L'objet identifié sur le terrain est une bande arbustive d'un seul tenant intégrée ou non à une espace enherbé d'une largeur inférieure à 5m sinon il s'agit d'un espace planté. Les ruptures de cohérence devront être respectées (se référer au schéma n°3). Une largeur est obligatoirement renseignée.|Le tracé de la ligne est saisi au centre de l'emprise au sol de l'objet ou à défaut sur une bordure en précisant si la largeur doit être prise en compte dans le sens de saisie. Une information de largeur est obligatoirement renseignée. Les ruptures de voirie devront être respectées. Se référer au schéma n°2 ci-dessous.|
|LINEAIRE Minéral|Circulation douce|LINEAIRE|L'objet identifié sur le terrain est un axe de circulation doux (allée, piste cyclable ...) homogène (piéton ou 2 roues) décomposant un espace enherbé ou planté d'une largeur inférieure à 5 mètres en moyenne, sinon il s'agit d'un espace minéral. Une largeur est obligatoirement renseignée.|Le tracé de la ligne est obligatoirement saisi au centre de l'emprise au sol de l'objet.|
|LINEAIRE Minéral|Clôture|LINEAIRE|L'objet identifié sur le terrain est une délimitation non naturelle (mur, grillage, palissade ...) fermant un site cohérent (parc, square ...) ou un sous-ensemble (aire de jeux dans un parc ...) . |Le tracé de la ligne est obligatoirement au pied de l'emprise au sol de l'objet.|
|SURFACE Espace vert|Zone boisée|POLYGONE|L'objet identifié sur le terrain est un ensemble d'arbres naturels sur un espace ne faisant pas l'objet d'un entretien.|Pour rappel, Les boisements denses dans un site cohérent sont entretenus donc la modélisation des arbres doit s'appliquer sur un espace enherbé délimité.|
|SURFACE Espace vert|Espace enherbé|POLYGONE|L'objet identifié sur le terrain est un ensemble enherbé, homogène, entretenu et de même type, d'une surface supérieure à 25m².|Pour rappel, Les objets intégrant cet espace (circulation douce, haie ...) de forme linéaire, créant ainsi des ruptures, sont saisis sous forme de linéaire.|
|SURFACE Espace vert|Espace planté|POLYGONE|L'objet identifié sur le terrain est un massif fleuri ou arbustif au sol ou hors sol supérieur à 5m².|Pour rappel, si la surfaces est inféreure à 5m², cet espace est représenté par un ponctuel fleuri.|
|SURFACE Espace vert|Espace naturel|POLYGONE|L'objet identifié sur le terrain est un ensemble non arboré naturel correspondant à une friche végétale supérieur à 25m².||
|SURFACE Espace minéral|Espace minéral|POLYGONE|L'objet identifié sur le terrain est une zone minérale (parking, parvis/place, aire de jeux ...) intégrant un espace cohérent d'espace vert (parc, square ...). |Pas de surface minimum, tout objet doit-être saisi. Pour rappel les éléments minéraux de rupture (circulation douce ...) sont saisi en linéaire.|
|SURFACE Espace hydrographique|Etendue d'eau|POLYGONE|L'objet identifié sur le terrain est une surface en eau supérieure à 5m² (bassin, marre, étang ...) intégrant un espace cohérent d'espace vert (parc, square ...). |Pour rappel, si leur surface est inférieure à 5m², ils sont représentés en ponctuel.|


(1) Les arbres en alignement font l'objet d'une double saisie, ponctuel et linéaire
(2) niveau de la nomenclature

La saisie des objets linéaires répond à des particularités décrites ci-dessous.

![picto] à refaire

Schéma n°1 : Règle de saisie des alignements d'arbres

![picto] à refaire

Schéma n°2 : Règle de saisie des haies

**Exemples d'applications de la modélisation**

**Dans un site cohérent (parc, square ...) :** 

![picto](à refaire)


**En dehors d'un site cohérent (espace végétalisé diffus, trottoir végétalisé, accotement ...) :** 

![picto](à refaire)


Les objets de cet inventaire cartographique doivent répondre également aux règles topologiques présentées ci-après.


### Topologie

La cohérence topologique impose le partage de géométrie et donc l’utilisation des outils « d’accroches ».

- Tous les objets sont nécessairement inclus dans une emprise communale.
- Tous les objets sont inclus dans un site cohérent ou non (équipement public, voie ...). 
- Les objets devront être découpés avec les limites communales et les zones de gestion existantes.

- Tous les objets de type "surface" sont des polygones fermés, et s'ils sont adjacents, ils devront être topologiques (absence de chevauchements et de micro-trous). 

![picto](topo_poly_1.png) ![picto](topo_poly_3.png)

- Un polygone contenant un autre polygone devra être découpé avec celui-ci.

![picto](topo_poly_2.png)

- Les linéraires doivent être connectés entre eux s'ils sont contiguës dans la réalité du dessin saisi.

![picto](topo_line_1.png)

- Les arcs de cercle ou ellipses devront être numérisés sous forme de polyligne suffisamment détaillée pour en reproduire la forme.

### Système de coordonnées

Les coordonnées seront exprimées en mètres avec trois chiffres après la virgule dans le système national en vigueur.
Sur le territoire métropolitain s'applique le système géodésique français légal RGF93 associé au système altimétrique IGN69. La projection associée Lambert 93 France (epsg:2154) sera à utiliser pour la livraison des données.

## Format des fichiers

Les fichiers sont disponibles au format ESRI Shape (.SHP) contenant la géométrie.
L'encodage des caractères est en UTF8. Les différents supports sont téléchargeables dans la rubrique Gabarits.

## Description des classes d'objets

|Nom fichier|Définition|Catégorie|Géométrie|
|:---|:---|:---|:---|
|||Inventaire cartographique|Ponctuel|


## Implémentation informatique

### Patrimoine

Ensemble des données décrivant les objets composant l'inventaire cartographique des espaces verts. 

`[SHAPE NAME]` : fichier contenant les objets "[NAME]" de type [GEOM]

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|


### Liste de valeurs

`lt_ev_type` : liste des valeurs de la nomenclature de niveau 1 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|10|Végétal|
|20|Minéral|
|30|Hydrographique|
|99|Référence non classée|

`lt_ev_sstype` : liste des valeurs de la nomenclature de niveau 2 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|10-00|Arbre isolé|
|10-10|Arbre en alignement|
|10-20|Zone boisée|
|10-30|Espace enherbé|
|10-40|Espace planté|
|10-50|Ponctuel fleuri|
|10-51|Bacs|
|10-52|Pots|
|10-53|Jardinière|
|10-54|Suspension|
|10-59|Autre contenant artificiel|
|10-60|Espace naturel|
|10-99|Autre végétal|
|20-10|Circulation douce|
|20-11|Piste cyclable|
|20-12|Allée|
|20-20|Espace minéral|
|20-21|Place/Parvis|
|20-22|Stationnement|
|20-30|Clôture|
|20-31|Mur|
|20-32|Grillage|
|20-33|Palissade|
|20-40|Equipements|
|20-41|Aire de jeux|
|20-99|Autre minéral|
|30-10|Ponctuel hydrographique|
|30-11|Fontaine|
|30-12|Point d'eau|
|30-20|Etendue d'eau|
|30-21|Bassin|
|30-22|Marre|
|30-23|Etang|
|30-99|Autre hydrographique|
|99-99|Référence non classée|

`lt_ev_typsaihaie` : liste des valeurs décrivant le type de saisie de la sous-classe de précision des objets espace vert de type haie

|Code|Valeur|
|:---|:---|
|10|Largeur à appliquer au centre du linéaire|
|20|Largeur à appliquer dans le sens de saisie|
|30|Largeur à appliquer dans le sens inverse de saisie|

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



