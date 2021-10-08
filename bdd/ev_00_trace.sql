/*ESPACE VERT V1.0*/
/*Creation du fichier trace qui permet de suivre l'évolution du code*/
/* ev_00_trace.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Bodet Grégory */

/*  
 
  Liste des dépendances :
  schéma          | table                 | description                                                   | usage
*/

/*
#################################################################### SUIVI CODE SQL ####################################################################

2021-03-30 : GB / initialisation du code du nouveau modèle de données pour un inventaire cartographique (dernière version fonctionnel)
2021-08-06 : FV / modification des vues de gestion (gabarit) avec ajout des attributs srcgeom_sai et srcdate_sai
2021-10-06 : GB / Renommage des vues d'exploitation et de gestion (pour cohérence d'organisation)
2021-10-06 : FB / Ajout des vues d'exploitation et de gestion des références non classées
2021-10-08 : GB / Ajout d'une classe contenant la délimitation des zones inventoriées par direction des espaces verts
