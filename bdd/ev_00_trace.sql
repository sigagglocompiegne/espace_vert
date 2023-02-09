/*ESPACE VERT V2.2.0*/
/*Suivi des modifications*/
/* init_db_ev.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */

/*
#################################################################### SUIVI CODE SQL ####################################################################

2021-03-30 : GB / initialisation du code du nouveau modèle de données pour un inventaire cartographique (dernière version fonctionnel)
2021-08-06 : FV / modification des vues de gestion (gabarit) avec ajout des attributs src_geom et src_date
2021-10-06 : GB / Renommage des vues d'exploitation et de gestion (pour cohérence d'organisation)
2021-10-06 : FB / Ajout des vues d'exploitation et de gestion des références non classées
2021-10-08 : GB / Ajout d'une classe contenant la délimitation des zones inventoriées par direction des espaces verts
2021-10-08 : GB / Ajout d'un trigger pour le calcul des X et Y sur la classe geo_ev_objet_pct
2021-10-08 : GB / Paramétrage du script d'initialisaition pour supprimer et insérer proprement les données sans clé étrangère et sans suppression des zones de gestion
2021-10-14 : GB / Ajout des commentaires des attributs sur la classe an_ev_vegetal_arbre
2021-10-14 : GB / Ajout d'une table de gestion des médias pour les objets d'espace vert (migration des médias existant)
2021-10-20 : GB / Ajout d'une table des secteurs d'intervention des prestataires de la ville de Compiègne
2022-08-xx : FN / Extension modèle de données EV
2022-12-07 : FV / suppression ressources obsolètes (vue geo_v_ev_arbre, attributs an_ev_vegetal_arbre (gnss_heigh, vert_prec, horz_prec, cplt_fic_1, cplt_fic_2, northing, easting, gps_date))
2022-12-08 : FV / ajout attributs admin+mesures géographiques dans les vues applicatives (arbre, massifarbustif, zoneboisee, espaceenherbe, massiffleuri, arbre_alignement, haie)
2022-12-12 : FV / ajout fonction/trigger et attributs admin+mesures geographiques dans certaines vues applicatives (arbusteisole, pointfleuri)
2022-12-12 : FV / intégration des attributs admin+mesure dans les vues des classes minérales, hydro, refnonclasse pct-lin-polygon
2022-12-13 : FV / suppression du domaine de valeur lt_ev_type_vegetation (et dépendance) qui permettait de définir un type de végétation arbre, arbustif et fleuri, pour des objets de massif arbustifs ou massif fleuri
2022-12-13 : FV / correctif et élargissement de domaines de valeur (lt_ev_vegetal_arbre_mode_conduite, lt_ev_vegetal_arbre_stade_dev, ...)
2022-12-13 : FV / modif fonction générique en écartant l'attribut position qui relève uniquement des objets de type végétal (an_ev_vegetal)
2022-12-13 : FV / intégration dans les fonctions trigger des vues des objets végétaux (arbreisole, arbre_alignement, pointfleuri, massiffleuri, espaceenherbe), de l'INSERT/update de l'attribut position
2022-12-14 : FV / intégration dans les fonctions trigger des vues des objets végétaux (zone boisée, arbusteisole, haie, massifarbustif), de l'INSERT/update de l'attribut position
2022-12-14 : FV / correctif de la fonction générique pour faire passer le typ1 en variable et supprimer le caractère fixe à la valeur 1 = objet végétal + corrections dans les fonctions pour les vues
2022-12-14 : FV / correctif vue geo_v_ev_pct qui excluait les arbres isolés (typ3 = 111)
2022-12-14 : FV / correction de la fonction générique pour faire passer le typ3 en variable lors d'une mise à jour de façon à permettre dans les cas qui le necessite, un changement de typ3 (ex : voie de circulation)
2022-12-14 : FV / extension des fonctions et trigger sur les objets minéraux (voiecirculation, circulation_zone, cloture, loisirisole)
2022-12-15 : FV / extension des fonctions et trigger sur les objets minéraux (espacedeloisirs, arriveedeau, eau_point, coursdeau, eau_etendue, refnonclassee_point-lin-polygon)
2022-12-20 : FV / suppression des attributs 'surface' et 'observatio' hérités des classes ev_objet et ev_'typegeom' dans les classes EV végétaux, les vues et fonctions trigger associées
2022-12-20 : FV / suppression de l'attribut danger de la classe an_ev_vegetal_arbre et du domaine de valeur lié (lt_ev_arbredanger) 
2022-12-20 : FV / ajout d'une vue stat pour calcul du nbr d'arbre par quartier
2022-12-20 : FV / attribut position des objets végétaux géré dans les triggers pour assurer la valeur 00 NR par défaut
2022-12-21 : FV / ajout domaine de valeur pour faux boolean pour arbre (protege, remarq, contrainte) et autres classes végétales (arros_auto, inv_faunis) et ajustements liés (fkey, fonctions trigger)
2022-12-23 : FV / suppression attributs inutiles et historiques de la table an_ev_vegetal_arbre (etat_gen, malad_obs, malad_nom, natur_sol, envnmt_obs, utilis_obs, natur_sol, forme)
2022-12-23 : FV / modif valeur du domaine lt_ev_vegetal_arbre_implant
2023-01-02 : FV / ajout du filtre sur les objets "actifs" pour la vue d'exploitation des chiffres clés
2023-01-03 : FV / changement de dénomination de plusieurs domaines de valeur
2023-01-03 : FV / refonte (extension, redénomination) des attributs de la classe an_ev_vegetal_arbre + fkey vers domaines de valeur considéré
2023-01-03 : FV / refonte dictionnaire botanique
2023-01-09 : FV / reprise du script sur les classes EV végétales, minérales, hydro et refnonclassee
2023-01-09 : FV / reprise du script suite aux décisions de la réunion projet du 06/01 (niv_allerg au niveau du référentiel bota, aménagement pied d'arbre en multivarié + ajout valeur du domaine, contrainte en multivarié + ajout valeur du domaine)
2023-01-13 : FV / reprise fonction trigger arbre pour mettre à NULL les commentaires lorsque les attributs boolean (remarq, proteg, contr, naiss) sont à NON (f)
2023-01-16 : FV / reprise classe d'intervention et correctifs
2023-01-19 : FV / correctif code de la liste lt_ev_intervention_freq_unite et lt_ev_intervention_periode
2023-01-27 : CS / créer la vue VUE an_v_lt_ev_objet_typ123
2023-01-31 : FV / suppression contrainte sur type anomalie de la table état sanitaire pour permettre à le passe en multivalué

*/
