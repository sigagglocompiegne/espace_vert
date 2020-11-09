![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des espaces verts #

## Principes
 ### Généralité
 
Depuis 2014, le service des espaces verts a initié une démarche d'inventaire du patrimoine arboré de la ville de Compiègne. Cette démarche, toujours en cours en 2020, s'est accompagnée d'un premier recensement cartographique en 2018 sans réflexion globale en terme de gestion métier.

Afin de répondre aux problématiques métiers et de gestions, interventions du service, une nouvelle production cartographique est initiée fin 2020 s'appuyant sur les inventaires passés. Cette démarche s'appuie sur une vision en triptique partant d'un inventaire d'objets, sur lequel viendra se greffer des éléments de gestion, intervention d'un côté et de gestion patrimoniale des objets de l'autre. Le modèle de données produit en début de démarche a été construit dans ce sens, l'évolutivité.
 
 ### Résumé fonctionnel
 
Pour rappel des grands principes :

* les objets du patrimoine des espaces verts font l'objet de productions extérieures intégrées par le service SIG
* les zones de gestion, intervention ou de sites sont gérées par le service des espaces verts
* les attributs métiers, complémentaire à l'inventaire, sont gérés par le service des espaces verts

## Schéma fonctionnel

![schema_fonctionnel]()


## Dépendances

La base de données des espaces verts s'appuie sur des référentiels préexistants constituant autant de dépendances nécessaires pour l'implémentation de la base PEI.

|schéma | table | description | usage |
|:---|:---|:---|:---|   
|r_objet|lt_src_geom|domaine de valeur générique d'une table géographique|source du référentiel de saisies des objets|
|r_objet|lt_contrat|liste et caractéristiques des contrats de délégation ou d'entretien|Gestion des différents données ou s'apparentant un contrat ou un type d'entretien (interne ou non)|

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
|insee|Code insee de la commune d'appartenance|varchar(5)|valeur vide interdite|
|commune|Libellé de la commune d'appartenance|varchar(80)|valeur vide interdite|
|quartier|Libellé du quartier de la ville de Compiègne d'appartenance|varchar(80)||
|doma_d|Domanialité déduite|varchar(2)|00 (liste de valeurs `lt_ev_doma`)|
|doma_r|Domanialité réelle|varchar(2)|00 (liste de valeurs `lt_ev_doma`)|
|typ|Type d'espace vert|varchar(2)|valeur vide interdite (liste de valeurs `lt_ev_typ` attribut `code`)|
|sstyp|Sous-type d'espace vert|varchar(2)|valeur vide interdite (liste de valeurs `lt_ev_typ` attribut `sous_code`)|
|srcgeom_sai|Référentiel de saisies utilisé pour la production initiale cartographique|varchar(2)|valeur vide interdite (liste de valeurs `lt_src_geom`)|
|srcdate_sai|Année du référentiel de saisies utilisé pour la production initiale cartographique|integer||
|srcgeom_maj|Référentiel de saisies utilisé pour la mise à jour de la production cartographique|varchar(2)|00 (liste de valeurs `lt_src_geom`)|
|srcdate_maj|Année du référentiel de saisies utilisé pour la mise à jour de la production cartographique|integer||
|op_sai|Opérateur de saisie initial de l'objet|varchar(50)|valeur vide interdite|
|op_maj|Opérateur ayant mis à jour l'objet initial|varchar(50)||
|dat_sai|Date de saisie de l'objet|timestamp without time zone|valeur vide interdite|
|dat_maj|Date de mise à jour de l'objet|timestamp without time zone||
|observ|Commentaires divers|varchar(254)||


* triggers : sans objet


## Liste de valeurs

`lt_ev_doma` : Liste permettant de décrire les types domanialités

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code du |character varying(2)| |
|valeur|libellé |character varying(30)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  
|00|indéterminée|
|10|public|
|20|privée (non déterminé)|
|21|privée (communale)|
|22|privée (autre organisme public)|
|23|privée|

`lt_ev_typ` : Liste permettant de décrire les types principaux des objets d'espaces verts

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code du type générique de l'objet "espace vert" |character varying(2)| |
|sous_code|code du sous type de l'objet "espace vert" |character varying(2)| |
|valeur_t|libellé du type générique de l'objet "espace vert"|character varying(30)| |
|valeur_st|libellé du sous type de l'objet "espace vert"|character varying(30)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|code |sous_code|valeur_t|valeur_st|
|:---|:---|:---|:---|
|00|00|non renseigné|non renseigné|
|10|00|floral|non renseigné|
|10|01|floral|arbre|
|10|02|floral|arbuste|
|10|03|floral|bac, pot|
|10|04|floral|fleurissement (en accotement ?)|
|10|05|floral|massif|
|10|99|floral|autre|
|20|00|végétal|non renseigné|
|20|01|végétal|boisement|
|20|02|végétal|haie|
|20|03|végétal|HLM (sûrement espace enherbé en domanialité privé (autre organisme privé) à reclasser en espace enherbé et supprimer cette valeur ?|
|20|04|végétal|espace enherbé|
|20|05|végétal|privé (sûrement espace enherbé en domanialité privéà reclasser en espace enherbé et supprimer cette valeur ?|
|20|06|végétal|friche ou espace naturel|
|20|99|végétal|autre|
|30|00|minéral|non renseigné|
|30|01|minéral|gravier|
|30|02|minéral|enrobé bithumé ou béton|
|30|03|minéral|pavé, dalle|
|30|04|minéral|stabilisé, calcaire, terre...|
|30|99|minéral|autre|
|40|00|hydrographique|non renseigné|
|40|01|hydrographique|fontaine|
|40|02|hydrographique|point d'eau|
|40|03|hydrographique|bassin artificiel|
|40|04|hydrographique|étendue naturelle|
|40|05|hydrographique|cours d'eau|
|40|99|hydrographique|autre|
|99|00|Autre|non renseigné|

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

![mcd]()

