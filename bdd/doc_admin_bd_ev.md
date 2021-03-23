![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des espaces verts #

## Généralité
 
La démarche s'organise en 3 temps :
. inventaire cartrographique des espaces verts
. détaillé ces objets d'un point de vue métier
. optique d'engagement de gestions des espaces verts (tableau de bord, gestion et intervention).


## Modèle relationnel simplifié

(à venir)

## Schéma fonctionnel

(à venir)


## Dépendances

La base de données des espaces verts s'appuie sur des référentiels préexistants constituant autant de dépendances nécessaires pour l'implémentation de la base PEI.

|schéma | table | description | usage |
|:---|:---|:---|:---|   
|r_objet|lt_src_geom|domaine de valeur générique d'une table géographique|source du référentiel de saisies des objets|
|r_objet|lt_contrat|liste et caractéristiques des contrats de délégation ou d'entretien (non opérationnel à ce jour)|Gestion des différents données ou s'apparentant un contrat ou un type d'entretien (interne ou non)|

---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_espace_vert, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

### Classe d'objet géographique et patrimoniale

`an_ev_objet` : table alphanumérique des métadonnées des objets des espaces verts.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|bigint|nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass)|
|idzone|Identifiant de la zone de gestion, intervention d'appartenance|integer||
|idsite|Identifiant du site de production cartographique d'appartenance|integer||
|idcontrat|Identifiant du contrat s'appliquant à l'objet (non encore opérationnel à ce jour)|character varying(2)|(liste de valeurs `r_objet.lt_contrat`)|
|insee|Code insee de la commune d'appartenance|character varying(5)|valeur vide interdite|
|commune|Libellé de la commune d'appartenance|character varying(80)|valeur vide interdite|
|quartier|Libellé du quartier de la ville de Compiègne d'appartenance|character varying(80)||
|doma_d|Domanialité déduite|character varying(2)|00 (liste de valeurs `lt_ev_doma`)|
|doma_r|Domanialité réelle|character varying(2)|00 (liste de valeurs `lt_ev_doma`)|
|typ|Valeur de la nomenclature de niveau 1 décrivent l'objet "espace vert"|character varying(2)|valeur vide interdite (liste de valeurs `lt_ev_typ` attribut `code`)|
|sstyp|Valeur de la nomenclature de niveau 2 décrivent l'objet "espace vert"|character varying(5)|valeur vide interdite (liste de valeurs `lt_ev_sstyp` attribut `code`)|
|srcgeom_sai|Référentiel de saisies utilisé pour la production initiale cartographique|character varying(2)|valeur vide interdite (liste de valeurs `lt_src_geom`)|
|srcdate_sai|Année du référentiel de saisies utilisé pour la production initiale cartographique|integer||
|srcgeom_maj|Référentiel de saisies utilisé pour la mise à jour de la production cartographique|character varying(2)|00 (liste de valeurs `lt_src_geom`)|
|srcdate_maj|Année du référentiel de saisies utilisé pour la mise à jour de la production cartographique|integer||
|op_sai|Opérateur de saisie initial de l'objet|character varying(50)|valeur vide interdite|
|op_maj|Opérateur ayant mis à jour l'objet initial|character varying(50)||
|dat_sai|Date de saisie de l'objet|timestamp without time zone|valeur vide interdite|
|dat_maj|Date de mise à jour de l'objet|timestamp without time zone||
|observ|Commentaires divers|character varying(254)||


* triggers : sans objet


`geo_ev_pct` : table géographique des objets des espaces verts saisis sous forme de ponctuel

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|bigint|valeur vide interdite (issu de la classe an_ev_objet)|
|x_l93|Coordonnée X du point saisi en Lambert 93|numeric(10,3)|valeur vide interdite|
|y_l93|Coordonnée Y du point saisi en Lambert 93|numeric(10,3)|valeur vide interdite|
|surf_e|Surface d'emprise au sol en m²|integer|(en fonction des choix de modélisation retenue)|
|geom|Attribut contenant la géométrie du point|geometry(point,2154)|valeur vide interdite|


`geo_ev_polygon` : table géographique des objets des espaces verts saisis sous forme de polygone

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idobjet|Identifiant unique de l'objet|bigint|valeur vide interdite (issu de la classe an_ev_objet)|
|sup_m2|Surface de l'objet "espace vert" exprimée en mètre carré|integer|valeur vide interdite (issu du calcul SIG)|
|perimetre|Périmètre du polygone saisie en mètre|integer|valeur vide interdite (issu du calcul SIG)|
|geom|Attribut contenant la géométrie du polygone|geometry(multipolygon,2154)|valeur vide interdite|

`geo_ev_line` : table géographique des objets des espaces verts saisis sous forme de polyligne

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|idobjet|Identifiant unique de l'objet|bigint|valeur vide interdite (issu de la classe an_ev_objet)|
|long_m|Longueur de l'objet "espace vert" exprimée en mètre|integer|valeur vide interdite (issu du calcul SIG et arrondit au mètre)|
|larg_cm|Largeur de l'objet "espace vert" exprimée en centimètre|integer|valeur vide interdite et maximum de 100cm|
|geom|Attribut contenant la géométrie de la polyligne|geometry(multilinestring,2154)|valeur vide interdite|

`an_ev_arbre` : table alphanumérique du patrimoine des objets des espaces verts correspond aux arbres.

**Cette classe est issue de l'inventaire initié depuis 2014 et pourra faire l'objet d'une réadapation dans ce nouveau modèle. Le complément demandé lors de la production cartographique en 2020 sera uniquement de l'ordre du positionnement. Les attributs métiers seront renseignés par le service "espace vert" dans un second temps.**

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idobjet|Identifiant unique de l'objet|bigint|valeur vide interdite (issu de la classe an_ev_objet)|
|nom|Libellé du nom de l'arbre en français|character varying(50)||
|genre|Libellé du genre de l'arbre (en latin)|character varying(20)||
|espece|Libellé d'espèce de l'arbre (en latin)|character varying(20)||
|hauteur|Classe de hauteur de l'arbre|character varying(2)|00 (liste de valeurs `lt_ev_arbrehauteur`)|
|circonf|Circonférence du tronc de l'arbre en centimètre|integer||
|forme|Classe de forme de l'arbre|character varying(2)|00 (liste de valeurs `lt_ev_arbreforme`)|
|etat_gen|Etat général l'arbre|character varying(2)|00 (non saisi à ce jour)|
|implant|Type d'implantation de l'arbre|character varying(2)|00 (liste de valeurs `lt_ev_arbreimplant`)|
|remarq|Arbre remarquable|character varying(3)||
|malad_obs|Maladie observée|character varying(3)||
|malad_nom|Libellé de la maladie observée si connue|character varying(80)||
|danger|Information sur la dangeurisité de l'arbre|character varying(2)|00 (liste de valeurs `lt_ev_arbredanger`)|
|natur_sol|Nature du sol de l'arbre|character varying(2)|00 (liste de valeurs `lt_ev_arbresol`)|
|envnmt_obs|Observation environnementale diverse sur l'arbre|character varying(254)||
|utilis_obs|Observation de l'opérateur diverse sur l'arbre|character varying(254)||
|plt_fic_1|| character(230)||
|cplt_fic_2|| character(230)||
|gps_date|Date du levé GPS| date||
|gnss_heigh||double precision||
|vert_prec|| double precision||
|horz_prec|| double precision||
|northing|| double precision||
|easting|| double precision||
    
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


## Liste de valeurs

`lt_ev_type` : Liste permettant de décrire la nomenclature de niveau 1 des objets d'espaces verts.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code du type principal des objets espaces verts|character varying(2)| |
|valeur|Valeur du type principal des objets espaces vertsleur|character varying(50)| |

|code | valeur |
|:---|:---| 
|00|Non renseigné|
|01|Floral|
|02|Végétal|
|03|Minéral|
|04|Hydrographie|
|99|Référence non classée|

`lt_ev_sstype` : Liste permettant de décrire la nomenclature de niveau 1 des objets d'espaces verts.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code du sous-type principal des objets espaces verts|character varying(5)| |
|valeur|Valeur du sous-type principal des objets espaces verts|character varying(100)| |

|code | valeur |
|:---|:---| 
|00-00|Non renseigné|
|01-00|Non renseigné|
|01-01|Arbre|
|01-02|Arbuste|
|01-03|Contenant artificiel (bac, pot, suspension, jardinière ...)|
|01-04|Fleurissement|
|01-05|Massif|
|01-99|Autre|
|02-00|Non renseigné|
|02-01|Zone boisée|
|02-02|Haie|
|02-04|Pelouse, herbe|
|02-05|Privé|
|02-06|Zone naturelle|
|02-99|Autre|
|03-00|Non renseigné|
|03-01|Bicouche gravier|
|03-02|Enrobé abimé|
|03-03|Enrobé, béton, pavé|
|03-04|Pavé autobloquant, dalle|
|03-05|Pavé autre|
|03-06|Stabilisé, calcaire, gravier, terre, schiste|
|03-99|Autre|
|04-00|Non renseigné|
|04-01|Fontaine|
|04-02|Bassin|
|04-99|Autre|
|99-00|Non renseigné|
|99-99|Autre|


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

`lt_ev_entretien` : Liste permettant de décrire la pratique d''entretien des espaces verts

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la liste énumérée relative à la pratique d'entretien des espaces verts|character varying(5)| |
|valeur|Valeur de la liste énumérée relative à la pratique d'entretien des espaces verts|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00-00|Non renseigné|
|01-00|Non renseigné|
|01-01|Annuel|
|01-02|Arbustif|
|01-03|Couvre-sol|
|01-04|Herbe|
|01-05|Mixte|
|01-06|Paillage|
|01-07|Terre à nue|
|01-08|Vivace|
|01-09|Vivace, couvre-sol, paillage|
|01-99|Autre|
|01-XX|Aucun|
|01-ZZ|Non concerné|
|02-00|Non renseigné|
|02-01|Ecopaturage|
|02-02|Entretien écologique|
|02-03|Fauche tardive|
|02-04|Tonte 2x/semaine|
|02-05|Tonte différenciée|
|02-06|Tonte régulière|
|02-07|Tonte très régulière|
|02-99|Autre|
|02-XX|Aucun|
|02-ZZ|Non concerné|
|03-00|Non renseigné|
|03-01|Chimique|
|03-02|Débroussaillage, tonte|
|03-03|Enherbement|
|03-04|Manuel|
|03-05|Mécanique|
|03-06|Nettoyeur haute pression|
|03-07|Thermique|
|03-08|Tolérance et gestion de la flore spontanée|
|03-99|autre|
|03-XX|Aucun|
|03-ZZ|Non concerné|

`lt_ev_gestion` : Liste permettant de décrire la maitrise d''oeuvre de l''entretien des espaces verts

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la liste énumérée relative à la maitrise d'oeuvre de l'entretien des espaces verts|character varying(2)| |
|valeur|Valeur de la liste énumérée relative à la maitrise d'oeuvre de l'entretien des espaces verts|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00|Non renseigné|
|01|Régie|
|02|Sous-traitance|
|99|Autre|


`lt_ev_arbrehauteur` : Liste permettant de décrire la classe de hauteur de chaque objet arbre

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la classe de hauteur des objets ponctuels arbre|character varying(2)| |
|valeur|Valeur de la classe de hauteur des objets ponctuels arbre|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00|Non renseigné|
|01|Moins de 1 mètre|
|02|1 à 2 mètres|
|03|2 à 5 mètres|
|04|5 à 10 mètres|
|05|10 à 15 mètres|
|06|15 à 20 mètres|
|07|Plus de 20 mètres|

`lt_ev_arbreforme` : Liste permettant de décrire la classe de forme de chaque objet arbre

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la classe de forme des objets ponctuels arbre|character varying(2)| |
|valeur|Valeur de la classe de forme des objets ponctuels arbre|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---| 
|00|Non renseigné|
|01|Rideau|
|02|Taille de contrainte|
|03|Taille douce|
|04|Libre|
|05|Tête de chat|

`lt_ev_arbreimplant` : Liste permettant de décrire la classe d'implantation de chaque objet arbre

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la classe d'implantation des objets ponctuels arbre|character varying(2)| |
|valeur|Valeur de la classe d'implantation des objets ponctuels arbre|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|
|00|Non renseigné|
|01|Alignement|
|02|Groupe/Bosquet|
|03|Solitaire|

`lt_ev_arbredanger` : Liste permettant de décrire la classe de dangerosité de chaque objet arbre

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la classe de dangerosité des objets ponctuels arbre|character varying(2)| |
|valeur|Valeur de la classe de dangerosité des objets ponctuels arbre|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|
|00|Non renseigné|
|01|Aucun|
|02|Dangereux|
|03|Moyenne dangereux|
|04|Faiblement dangereux|

`lt_ev_arbresol` : Liste permettant de décrire la classe de nature de sol de chaque objet arbre

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la classe de nature de sol des objets ponctuels arbre|character varying(2)| |
|valeur|Valeur de la classe de nature de sol des objets ponctuels arbre|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|
|00|Non renseigné|
|01|Gazon|
|02|Minéral|
|03|Paillage|
|04|Synthétique|
|05|Terre|
|06|Végétalisé|
|99|Autre|

`lt_contrat` : Liste permettant de décrire les contrats pour les objets métiers

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|code|Code de la liste énumérée relative au numéro de contrat pour l'entretien et/ou le contrôle de réseau public par la ville ou l'ARC|character varying(2)| |
|valeur|Valeur de la référence du marché du contrat pour l'entretien et/ou le contrôle de réseau public par la ville ou l'ARC|character varying(80)| |
|presta|Nom du prestataire retenu par le contrat pour l'entretien et/ou le contrôle de réseau public par la ville ou l'ARC|character varying(254)| |
|ddebut|Date de début du contrat|timestamp without time zone| |
|dfin|Date de fin du contrat|timestamp without time zone| |
|definition|Definition du contrat pour l'entretien et/ou le contrôle de réseau public par la ville ou l'ARC|character varying(254)| |

Particularité(s) à noter : aucune

Valeurs possibles :

Pour des raisons de confidentialités la liste des valeurs n'est pas disponible dans cette documentation.

---


### classes d'objets applicatives de gestion :

`geo_v_ev_line` : vue de gestion permettant la saisie des objets "espace vert" de type ligne

* Fonction triggers : sans objet

`geo_v_ev_point` : vue de gestion permettant la saisie des objets "espace vert" de type ponctuel (hors arbre)

* Fonction triggers : sans objet

`geo_v_ev_arbre` : vue de gestion permettant la saisie des objets "espace vert" der nature arbre

* Fonction triggers : sans objet

`geo_v_ev_polygon` : vue de gestion permettant la saisie des objets "espace vert" de type polygone. L'automatisation des valeurs liées aux géométries (surface et périmètre) sera intégrée après l'intégration de l'inventaire cartographique dans une optique de gestion interne des objets par le service métier.

* Fonction triggers : sans objet

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

Sans objet (uniquement un projet QGis pour le gabarit de mise à jour de l'inventaire cartographique [rubrique Gabarit du standard](https://github.com/sigagglocompiegne/espace_vert/blob/master/gabarit/livrables.md)

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






