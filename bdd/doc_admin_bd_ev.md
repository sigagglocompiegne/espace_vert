![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des espaces verts #

## Principes
 ### Généralité
 
Depuis 2014, le service des espaces verts a initié une démarche d'inventaire du patrimoine arboré de la ville de Compiègne. Cette démarche, toujours en cours en 2020, s'est accompagnée d'un premier recensement cartographique en 2018 sans réflexion globale en terme de gestion métier.

Afin de répondre aux problématiques métiers et de gestions, interventions du service, une nouvelle production cartographique est initiée fin 2020 s'appuyant sur les inventaires passés. Cette démarche s'appuie sur une vision en triptique partant d'un inventaire d'objets, sur lequel viendra se greffer des éléments de gestion, intervention d'un côté et de gestion patrimoniale des objets de l'autre. Le modèle de données produit en début de démarche a été construit dans ce sens, l'évolutivité.
 
 ### Résumé fonctionnel
 
Pour rappel des grands principes :

* les objets du patrimoine des espaces verts font l'objet de production extérieure
* les zones de gestion, intervention ou de sites sont gérées par le service des espaces verts
* les attributs métiers, complémentaire à l'inventaire, sont gérés par le service des espaces verts

## Schéma fonctionnel

![schema_fonctionnel]()


## Dépendances

Sans objet

---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_espace_vert, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

### Classe d'objet géographique et patrimoniale

`table` : table alphanumérique des métadonnées des objets des espaces verts.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  


* triggers : sans objet

  
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

## Liste de valeurs

`table` : Liste permettant 

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code du |character varying(2)| |
|valeur|libellé |character varying(30)| |


Particularité(s) à noter : aucune

Valeurs possibles :

|code | valeur |
|:---|:---|  

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
