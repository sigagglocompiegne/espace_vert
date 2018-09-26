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
|id|identifiant unique de l'objet|bigint| nextval('m_espace_vert.an_ev_type_id_seq'::regclass)|
|type_ev|type d'espace vert|character varying(2)| |
|sstype_ev|sous-type d'espace vert|character varying(5)| |
|insee|code Insee|character varying(5)| |
|commune|nom de la commune|character varying(150)| |
|op_sai|opérateur de la dernière saisie en base de l'objet|character varying(80)| |
|date_sai|date de saisie de l'objet|timestamp without time zone| |
|date_maj|date de mise à jour de l'objet|timestamp without time zone| |
|src_geom|référentiel de saisie|character varying(2)| |
|observ|commentaires|character varying(254)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
* Une clé étrangère existe sur la table de valeur `lt_ev_type` sur l'attribut `code` (`m_espace_vert.lt_ev_type`)
* Une clé étrangère existe sur la table de valeur `lt_ev_sstype` sur l'attribut `code` (`m_espace_vert.lt_ev_sstype`)
* Un trigger :
   `m_espace_vert.ft_an_ev_type_type_ev()` : fonction permettant de renseigner le type d'espace vert à partir du sous-type.
---

`an_ev_entretien` : table des attributs sur l'entretien et la gestion des espaces verts.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|identifiant unique de l'objet|bigint| |
|prat_ini|pratique d'entretien initiale appliquée lors du diagnostic|character varying(5)| |
|preco|préconisation d'entretien conseillée à l'avenir|character varying(5)| |
|gestion|maitrise d'oeuvre de l'entretien|character varying(2)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
* Une clé étrangère existe sur la table de valeur `lt_ev_entretien` sur l'attribut `code` (`m_espace_vert.lt_ev_entretien`)
* Une clé étrangère existe sur la table de valeur `lt_ev_gestion` sur l'attribut `code` (`m_espace_vert.lt_ev_gestion`)
---

`geo_ev_s` : table géographique des objets espaces verts surfaciques.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|identifiant unique de l'objet|bigint| |
|sup_m2|superficie de l'objet en m²|integer| |
|geom|géométrie de l'objet|MultiPolygon| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
---

`geo_ev_l` : table géographique des objets espaces verts linéaires.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|identifiant unique de l'objet|bigint| |
|long_m|longueur de l'objet en mètres|integer| |
|geom|géométrie de l'objet|MultiLineString| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
---

`geo_ev_p` : table géographique des objets espaces verts ponctuels.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|identifiant unique de l'objet|bigint| |
|geom|géométrie de l'objet|Point| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` avec une séquence d'incrémentation automatique `m_espace_vert.an_ev_type_id_seq`
---

## Liste de valeurs

`m_espace_vert.lt_ev_type` : liste des valeurs permettant de décrire le type d'espace vert.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code de la liste énumérée relative au type d'espace vert|character varying(2)| |
|valeur|valeur de la liste énumérée relative au type d'espace vert|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `code` 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|non renseigné|
|01|floral|
|02|végétal|
|03|minéral|
|99|autre|

---

`m_espace_vert.lt_ssev_type` : liste des valeurs permettant de décrire le sous-type d'espace vert.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code de la liste énumérée relative au sous-type d'espace vert|character varying(2)| |
|valeur|valeur de la liste énumérée relative au sous-type d'espace vert|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `code` 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00-00|non renseigné|
|01-00|non renseigné|
|01-01|arbre|
|01-02|arbuste|
|01-03|bac, pot|
|01-04|fleurissement|
|01-05|massif|
|01-99|autre|
|02-00|non renseigné|
|02-01|boisement|
|02-02|haie|
|02-03|HLM|
|02-04|pelouse, herbe|
|02-05|privé|
|02-06|zone naturelle|
|02-99|autre|
|03-00|non renseigné|
|03-01|bicouche gravier|
|03-02|enrobé abimé|
|03-03|enrobé, béton, pavé|
|03-04|pave autobloquant, dalle|
|03-05|pavé autre|
|03-06|stabilisé, calcaire, gravier, terre, schiste|
|03-99|autre|

---

`r_objet.lt_src_geom` : liste des valeurs permettant de décrire le référentiel géographique utilisé pour la saisie des données.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|code de la liste énumérée relative au référentiel de saisie utilisé pour la saisie de l'objet|character varying(2)| |
|valeur|valeur de la liste énumérée relative au référentiel de saisie utilisé pour la saisie de l'objet|character varying(254)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `code` 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|10|Cadastre|
|11|PCI vecteur|
|12|BD Parcellaire|
|13|RPCU|
|20|Ortho-images|
|21|Orthophotoplan IGN|
|22|Orthophotoplan partenaire|
|23|Orthophotoplan local|
|30|Filaire voirie|
|31|Route BDTopo|
|32|Route OSM|
|40|Cartes|
|41|Scan25|
|50|Lever|
|51|Plan topographique|
|52|PCRS|
|53|Trace GPS|
|60|Geocodage|
|61|Base Adresse Locale|
|70|Plan masse|
|71|Plan masse vectoriel|
|72|Plan masse redessiné|
|80|Thématique|
|81|Document d'urbanisme|
|82|Occupation du sol|
|83|Thèmes BDTopo|
|99|Autre|

---
