![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des espaces verts #

## Généralité
 
La démarche s'organise en 3 temps :
. inventaire cartrographique des espaces verts
. détaillé ces objets d'un point de vue métier
. optique d'engagement de gestions des espaces verts (tableau de bord, gestion et intervention).



## Schéma fonctionnel

![schema_fonctionnel]


## Dépendances

La base de données des espaces verts s'appuie sur des référentiels préexistants constituant autant de dépendances nécessaires pour l'implémentation de la base PEI.

|schéma | table | description | usage |
|:---|:---|:---|:---|   
|r_objet|lt_src_geom|domaine de valeur générique d'une table géographique|source du référentiel de saisies des objets|
|r_objet|lt_contrat|liste et caractéristiques des contrats de délégation ou d'entretien|Gestion des différents données ou s'apparentant un contrat ou un type d'entretien (interne ou non)|
|m_amenagement|geo_amt_zone_gestion|Table géographique délimitant les différentes zones de gestion entre la ville de Compiègne et l'Agglomération de la Région de Compigne|Déterminbation des zones d'aménagements et de gestion plus ou moins adaptées en fonction des types d'objets gérés permettant un rattachement à la table alphanumérique des contrats ou des services d'intervention|

---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_espace_vert, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

### Classe d'objet géographique et patrimoniale

`an_ev_objet` : table alphanumérique des métadonnées des objets des espaces verts.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|integer|nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass)|
|idzone|Identifiant de la zone de gestion, intervention d'appartenance|integer||
|idsite|Identifiant du site de production cartographique d'appartenance|integer||
|idcontrat|Identifiant du contrat s'appliquant à l'objet|integer|(liste de valeurs `r_objet.lt_contrat`)|
|insee|Code insee de la commune d'appartenance|varchar(5)|valeur vide interdite|
|commune|Libellé de la commune d'appartenance|varchar(80)|valeur vide interdite|
|quartier|Libellé du quartier de la ville de Compiègne d'appartenance|varchar(80)||
|doma_d|Domanialité déduite|varchar(2)|00 (liste de valeurs `lt_ev_doma`)|
|doma_r|Domanialité réelle|varchar(2)|00 (liste de valeurs `lt_ev_doma`)|
|typev1|Valeur de la nomenclature de niveau 1 décrivent l'objet "espace vert"|varchar(1)|valeur vide interdite (liste de valeurs `lt_ev_typev1` attribut `code`)|
|typev2|Valeur de la nomenclature de niveau 1 décrivent l'objet "espace vert"|varchar(3)|valeur vide interdite (liste de valeurs `lt_ev_typev2` attribut `code`)|
|typev3|Valeur de la nomenclature de niveau 3 décrivent l'objet "espace vert"|varchar(5)|valeur vide interdite (liste de valeurs `lt_ev_typev3` attribut `code`)|
|srcgeom_sai|Référentiel de saisies utilisé pour la production initiale cartographique|varchar(2)|valeur vide interdite (liste de valeurs `lt_src_geom`)|
|srcdate_sai|Année du référentiel de saisies utilisé pour la production initiale cartographique|integer||
|srcgeom_maj|Référentiel de saisies utilisé pour la mise à jour de la production cartographique|varchar(2)|00 (liste de valeurs `lt_src_geom`)|
|srcdate_maj|Année du référentiel de saisies utilisé pour la mise à jour de la production cartographique|integer||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer|valeur vide interdite|
|op_sai|Opérateur de saisie initial de l'objet|varchar(50)|valeur vide interdite|
|op_maj|Opérateur ayant mis à jour l'objet initial|varchar(50)||
|dat_sai|Date de saisie de l'objet|timestamp without time zone|valeur vide interdite|
|dat_maj|Date de mise à jour de l'objet|timestamp without time zone||
|observ|Commentaires divers|varchar(254)||


* triggers : sans objet


`geo_ev_point` : table géographique des objets des espaces verts saisis sous forme de ponctuel

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|x_l93|Coordonnée X du point saisi en Lambert 93|numeric(10,3)|valeur vide interdite|
|y_l93|Coordonnée Y du point saisi en Lambert 93|numeric(10,3)|valeur vide interdite|
|surf_e|Surface d'emprise au sol en m²|integer|(en fonction des choix de modélisation retenue)|
|geom|Attribut contenant la géométrie du point|geometry(point,2154)|valeur vide interdite|


`geo_ev_polygon` : table géographique des objets des espaces verts saisis sous forme de polygone

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idobjet|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|sup_m2|Surface de l'objet "espace vert" exprimée en mètre carré|integer|valeur vide interdite (issu du calcul SIG)|
|perimetre|Périmètre du polygone saisie en mètre|integer|valeur vide interdite (issu du calcul SIG)|
|geom|Attribut contenant la géométrie du polygone|geometry(polygon,2154)|valeur vide interdite|

`geo_ev_line` : table géographique des objets des espaces verts saisis sous forme de polyligne

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idobjet|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|long_m|Longueur de l'objet "espace vert" exprimée en mètre|integer|valeur vide interdite (issu du calcul SIG et arrondit au mètre)|
|larg_cm|Largeur de l'objet "espace vert" exprimée en centimètre|integer|valeur vide interdite et maximum de 100cm|
|geom|Attribut contenant la géométrie de la polyligne|geometry(linestring,2154)|valeur vide interdite|

`an_ev_arbre` : table alphanumérique du patrimoine des objets des espaces verts correspond aux arbres.

**Cette classe est issue de l'inventaire initié depuis 2014 et pourra faire l'objet d'une réadapation dans ce nouveau modèle. Le complément demandé lors de la production cartographique en 2020 sera uniquement de l'ordre du positionnement. Les attributs métiers seront renseignés par le service "espace vert" dans un second temps.**

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|nom|Libellé du nom de l'arbre en français|varchar(50)||
|genre|Libellé du genre de l'arbre (en latin)|varchar(20)||
|espece|Libellé d'espèce de l'arbre (en latin)|varchar(20)||
|hauteur|Classe de hauteur de l'arbre|varchar(2)|00 (liste de valeurs `lt_ev_arbrehauteur`)|
|circonf|Circonférence du tronc de l'arbre en centimètre|integer||
|forme|Classe de forme de l'arbre|varchar(2)|00 (liste de valeurs `lt_ev_arbreforme`)|
|etat_gen|Etat général l'arbre|varchar(2)|00 (non saisi à ce jour)|
|implant|Type d'implantation de l'arbre|varchar(2)|00 (liste de valeurs `lt_ev_arbreimplant`)|
|remarq|Arbre remarquable|boolean|false|
|malad|Maladie observée|boolean|false|
|malad|Maladie observée|boolean|false|
|nom_malad|Libellé de la maladie observée si connue|varchar(50)||
|danger|Information sur la dangeurisité de l'arbre|varchar(2)|00 (liste de valeurs `lt_ev_arbredanger`)|
|natur_sol|Nature du sol de l'arbre|varchar(2)|00 (liste de valeurs `lt_ev_arbresol`)|
|envnmt_obs|Observation environnementale diverse sur l'arbre|varchar(254)||
|utilis_obs|Observation de l'opérateur diverse sur l'arbre|varchar(254)||

**Il n'est pas prévu pour le moment une sous-classe métiers pour les objets ponctuels autre que les objets arbres.**


`geo_ev_zonegestion` : table géographique délimitant les zones de gestion/entretien interne du service espace vert

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idzone|Identifiant unique de la zone|integer||
|nom|Libellé du responable de l'entretien de la zone |varchar(50)||
|sup_m2|Surface de la zone exprimée en mètre carré|integer|valeur vide interdite (issu du calcul SIG)|
|geom|Attribut contenant la géométrie de la zone|geometry(multipolygon,2154)|valeur vide interdite|

* Particularité : attention à ne pas confondre les zones de gestion du service espace vert sur la ville de Compiègne pour un usage interne de gestion d'équipe et la table géographique des zones de gestion entre la ville et l'Agglomération (`geo_amt_zone_gestion`) listée dans les dépendances.

`geo_ev_site` : table géographique délimitant les sites de production cartographique

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idsite|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|nom|Libellé du site|varchar(100)|00 (liste de valeurs `lt_ev_typsite`)|
|typ|Typologie du site|varchar(2)||
|geom|Attribut contenant la géométrie du site|geometry(polygon,2154)|valeur vide interdite|

`an_ev_ptleve` : table alphanumérique de précision des points levés par un inventaire GPS (à garder ?)

|idobjet|Identifiant unique de l'objet|integer|valeur vide interdite (issu de la classe an_ev_objet)|
|gnss_heigh|Hauteur du point saisie par un GPS|double precision||
|vert_prec|Précision verticale du point saisie par un GPS|double precision||
|horz_prec|Précision verticale du point saisie par un GPS|double precision||

`an_ev_doc_media` : table alphanumérique des documents relatifs aux objets, aux sites des espaces verts (photos...).

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|gid|Identifiant unique de l'objet concerné|integer|nextval('m_espace_vert.an_ev_doc_media_gid_seq'::regclass)|
|id|Identifiant unique de l'objet concerné|integer|issu des classes d'objets|
|media|Libellé du fichier avec son extension|text||
|miniature|Miniature du média enregistré si celui-ci est une image|bytea||
|n_fichier|Libellé du fichier avec son extension|text||
|t_fichier|Type de fichier|text||
|op_sai|Opérateur ayant intégré le fichier|character varying(100)||
|date_sai|Date d'intégration du fichier|timestamp without time zone||
|d_photo|Date de prise de vue pour une photographie|timestamp without time zone||
|l_prec|Précision sur le document inséré|character varying(254)||


**La liste des sous-classes métiers sera complétée en fonction des besoins du service des espaces verts. Les classes correspondantes aux objets "d'habillage" des espaces verts, à savoir les objets hydrographiques et minérals n'ont pas fait l'objet d'implémentation de sous-classes métiers. Nous considérons à ce stade qu'elles doivent rester des productions cartographiques.**

## Liste de valeurs

`lt_ev_typev1` : Liste permettant de décrire la nomenclature de niveau 1 des objets d'espaces verts.

(en attente retour du service espace vert)

`lt_ev_typev3` : Liste permettant de décrire la nomenclature de niveau 1 des objets d'espaces verts.

(en attente retour du service espace vert)

`lt_ev_typev3` : Liste permettant de décrire la nomenclature de niveau 1 des objets d'espaces verts.

(en attente retour du service espace vert)

`lt_ev_typsite` : Liste permettant de décrire les types principaux des sites

**Proposition de classement des sites de lévé cartographique d'après le classement établis par le standard GeoPal. Pourra être adapté en fonction des besoins du service espace vert**

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code du type principal décrivant le site|character varying(2)| |
|valeur|libellé du type principal décrivant le site|character varying(30)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00|non renseigné|
|01|parc, jardin, square|
|02|accotements de voies|
|03|accompagnement de bâtiments publics|
|04|accompagnement d'habitations|
|05|accompagnement d'établissents industriels et commerciaux|
|06|enceinte sportive|
|07|Cimetière|
|11|espace naturel aménagé|
|12|arbre d'alignement|


`lt_ev_doma` : Liste permettant de décrire les types domanialités

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code du |character varying(2)| |
|valeur|libellé |character varying(30)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00|non renseigné|
|10|public|
|20|privée (non déterminé)|
|21|privée (communale)|
|22|privée (autre organisme public)|
|23|privée|


---


### classes d'objets applicatives de gestion :

Sans objet

---

### classes d'objets applicatives métiers sont classés dans le schéma x_apps :
 
Sans objet

---


### classes d'objets applicatives grands publics sont classés dans le schéma x_apps_public :

Sans objet

---

### classes d'objets opendata sont classés dans le schéma x_opendata :

Sans objet

---

## Log

(à traiter)

## Erreur

Sans objet

---

## Projet QGIS pour la gestion

Sans objet (uniquement un projet QGis pour le gabarit de mise à jour)

---

## Traitement automatisé mis en place (Workflow de l'ETL FME)

### Initialisation des données - Etat 0

(FME en préparation pour migrer les données existantes dans le nouveau modèle et gabarit de production.)

### Migration des données - Etat 1

(FME en préparation pour migrer les données existantes dans le nouveau modèle et gabarit de production.)

### Mise à jour des données

(FME à produire pour intégrer la production cartographique à venir)

---

## Export Grand Public

Sans objet

---

## Export Open Data

Sans objet

---

## Schéma fonctionnel

### Modèle conceptuel simplifié pour la gestion des espaces verts

(à venir après validation du modèle de données avec le service des espaces verts)


