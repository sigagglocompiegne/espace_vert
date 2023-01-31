/*ESPACE VERT V2.2.0*/
/*Creation du fichier complet*/
/* init_db_ev.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Fabien Nicollet (Business Geografic) */

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


/*
ToDo :
- vérifier fonction de découpe (ou comment se faire l'intersection si plusieurs zonage) des objets hors arbre (enherbé, arbustif, minéraux, hydro, non classés), depuis les découpages admin
(A VERIFIER SI FAIT > - absence INSERT update du champ largeur larg_cm de la class geoline utilisée pour les haies et voies de circulation
- attributs ev_objet avec plusieurs valeur par défaut à vérifier (src_geom ...)
- fonction générique pour calcul périmètre objet surfacique
- arbre : voir pour ajout champ à surveiller dépendant si un état sanitaire (le dernier en date ???) indique la nécessité de surveillance à OUI
- arbre : voir pour ajout date d'abattage de l'arbre rempli en auto en fonction de la date d'intervention arbre de type abattage
?? : zonage inventaire à reintégrer ?
- manque calcul sup_m2 sur geo_ev_zone_site et geo_ev_zone_equipe
-- fonction de rappel sans aucun déclencheur dessus (?)
-- avec changement des codes des mois de 01 à 12 et non plus de 00 à 11 dans lt_ev_intervention_periode, voir impact potentiel sur fonction de rappel
-- voir pour prévoir 'ZZ' pour periode et freq_unité par défaut pour inter/demande inter en cas de non récurrent !
*/


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ##VUE
-- stats
DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_arbre_quartier;
DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_arbre_alignement;
DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_fleuri;
DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_chiffre_cle_tab;
-- vegetal
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre_alignement;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre_bois;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste_haie;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste_massif;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_fleuri;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_fleuri_massif;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_herbe;
-- mineral
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_circulation_voie;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_circulation_zone;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_cloture;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_loisir_equipement;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_loisir_zone;
-- hydro
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_arrivee;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_point;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_cours;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_etendue;
-- nonref
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_point;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_line;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_polygon;
-- type geom
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_pct;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_line;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_polygon;

-- ## CONTRAINTES
-- an_ev_objet
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_typ1_fkey;
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_typ2_fkey;
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_typ3_fkey;
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_etat_fkey;
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_doma_fkey;
ALTER TABLE IF EXISTS m_espace_vert.an_ev_objet DROP CONSTRAINT IF EXISTS lt_ev_objet_qualdoma_fkey;
-- geo_ev_objet_pct
ALTER TABLE IF EXISTS m_espace_vert.geo_ev_objet_pct DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- geo_ev_objet_line
ALTER TABLE IF EXISTS m_espace_vert.geo_ev_objet_line DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- geo_ev_objet_polygon
ALTER TABLE IF EXISTS m_espace_vert.geo_ev_objet_polygon DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_arbre
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbre DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_arbre_etat_sanitaire
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_arbuste_haie
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbuste_haie DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_arbuste_massif
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbuste_massif DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_fleuri_massif
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_fleuri_massif DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- an_ev_vegetal_herbe
ALTER TABLE IF EXISTS m_espace_vert.an_ev_vegetal_herbe DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- lt_ev_intervention_inter_type
ALTER TABLE IF EXISTS m_espace_vert.lt_ev_intervention_inter_type DROP CONSTRAINT IF EXISTS lt_ev_intervention_objet_type_fkey;
-- lk_ev_intervention_objet
ALTER TABLE IF EXISTS m_espace_vert.lk_ev_intervention_objet DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;
-- geo_ev_intervention
ALTER TABLE IF EXISTS m_espace_vert.geo_ev_intervention DROP CONSTRAINT IF EXISTS lt_ev_intervention_ress_affec_fkey;
-- geo_ev_intervention_demande
ALTER TABLE IF EXISTS m_espace_vert.geo_ev_intervention_demande DROP CONSTRAINT IF EXISTS lt_ev_demande_intervention_ress_affec_fkey;
-- an_ev_media
ALTER TABLE IF EXISTS m_espace_vert.an_ev_media DROP CONSTRAINT IF EXISTS an_ev_objet_fkey;

-- ## CLASSE
-- objet
DROP TABLE IF EXISTS m_espace_vert.an_ev_objet;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_objet_pct;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_objet_line;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_objet_polygon;
DROP TABLE IF EXISTS m_espace_vert.an_ev_objet_line_largeur;
-- vegetal
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal;
-- arbre
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbre;
-- etat sanitaire arbre
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire;
-- arbuste
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbuste_haie;
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_arbuste_massif;
-- fleuri
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_fleuri_massif;
-- espaceenherbe
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_herbe;
-- zonage
DROP TABLE IF EXISTS m_espace_vert.geo_ev_zone_gestion;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_zone_site;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_zone_equipe;
-- referentiel
DROP TABLE IF EXISTS m_espace_vert.an_ev_vegetal_ref_bota;
-- intervention
DROP TABLE IF EXISTS m_espace_vert.geo_ev_intervention_demande;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_intervention;

-- relation
DROP TABLE IF EXISTS m_espace_vert.lk_ev_intervention_objet;
-- media
DROP TABLE IF EXISTS m_espace_vert.an_ev_media;
-- log
DROP TABLE IF EXISTS m_espace_vert.an_ev_log;


-- ## DOMAINE DE VALEUR
-- objet
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_typ1;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_typ2;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_typ3;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_boolean;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_etat;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_doma;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_objet_qualdoma;
-- zonage
DROP TABLE IF EXISTS m_espace_vert.lt_ev_zone_site_type;
-- objet vegetaux
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_position;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_niveau_allergisant;
-- espaceenherbe, massif_fleuri, massif_arbustif
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arrosage_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_espace_type;
-- arbre
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_etatarbre;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_mode_conduite;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_periode_plantation;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_stade_dev;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_contr_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_sol_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_arbre_implant;
-- haie
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_haie_sai_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_haie_veget_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_vegetal_haie_paillage_type;
-- intervention
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_objet_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_inter_type;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_src_demand;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_freq_unite;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_statut;
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_periode;
-- entreprise
DROP TABLE IF EXISTS m_espace_vert.lt_ev_equipe_specialisation;

-- ## SEQUENCE
-- ev
DROP SEQUENCE IF EXISTS m_espace_vert.an_ev_objet_idobjet_seq;
DROP SEQUENCE IF EXISTS m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq;
DROP SEQUENCE IF EXISTS m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq;
-- zonage
DROP SEQUENCE IF EXISTS m_espace_vert.geo_ev_zone_gestion_idgestion_seq;
DROP SEQUENCE IF EXISTS m_espace_vert.geo_ev_zone_site_idsite_seq;
DROP SEQUENCE IF EXISTS m_espace_vert.geo_ev_zone_equipe_idequipe_seq;
-- inter
DROP SEQUENCE IF EXISTS m_espace_vert.geo_ev_intervention_idinter_seq;
-- relation
DROP SEQUENCE IF EXISTS m_espace_vert.lk_ev_intervention_objet_idlk_seq;
-- media
DROP SEQUENCE IF EXISTS m_espace_vert.an_ev_media_gid_seq;
-- log
DROP SEQUENCE IF EXISTS m_espace_vert.an_ev_log_idlog_seq;

-- ## FONCTIONS
-- objet patrimoniaux EV
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_process_generic_info(text,text,geometry,integer,text,text,text,text,text,text,text,text);
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_intervention_get_next_date_rappel(date,integer,text,integer,text,text);
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbre();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbre_alignement();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbre_bois();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbuste();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbuste_haie();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_arbuste_massif();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_fleuri();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_fleuri_massif();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_vegetal_herbe();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_mineral_circulation_voie();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_mineral_circulation_zone();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_mineral_cloture();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_mineral_loisir_equipement();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_mineral_loisir_zone();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_hydro_eau_arrivee();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_hydro();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_hydro_eau_cours();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_refnonclassee();
-- gestion intervention
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_intervention_purge_on_delete();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_intervention_add_objets();
-- mise à jour objet en cas de mise à jour des zonages
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_zone_gestion_set();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_zone_site_set();
DROP FUNCTION IF EXISTS m_espace_vert.ft_m_ev_zone_equipe_set();


-- ##SCHEMA
DROP SCHEMA IF EXISTS m_espace_vert;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       SCHEMA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- SCHEMA: m_espace_vert

-- DROP SCHEMA m_espace_vert;

CREATE SCHEMA m_espace_vert;

COMMENT ON SCHEMA m_espace_vert IS 'Base de données métiers sur le thème des espaces verts';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE  DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# lt_ev_objet_typ1 ###############################################

-- Table: m_espace_vert.lt_ev_objet_typ1

-- DROP TABLE m_espace_vert.lt_ev_objet_typ1;

CREATE TABLE m_espace_vert.lt_ev_objet_typ1
(
    code character varying(1) NOT NULL,
    valeur character varying(50),
    CONSTRAINT lt_ev_objet_typ1_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_typ1 IS 'Domaine de valeur de l''attribut code nomenclature niveau 1 des espaces verts ';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ1.code IS 'Code du type principal des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ1.valeur IS 'Valeur du type principal des objets espaces verts';
COMMENT ON CONSTRAINT lt_ev_objet_typ1_pkey ON m_espace_vert.lt_ev_objet_typ1 IS 'Clé primaire de la table lt_ev_objet_typ1';

INSERT INTO m_espace_vert.lt_ev_objet_typ1(
            code, valeur)
    VALUES
  ('0','Non renseigné'),    
  ('1','Végétal'),
  ('2','Minéral'),
  ('3','Hydrographie'),
  ('9','Référence non classée');

-- ################################################################# lt_ev_objet_typ2 ###############################################

-- Table: m_espace_vert.lt_ev_objet_typ2

-- DROP TABLE m_espace_vert.lt_ev_objet_typ2;

CREATE TABLE m_espace_vert.lt_ev_objet_typ2
(
    code character varying(2) NOT NULL,
    valeur character varying(100),
    CONSTRAINT lt_ev_objet_typ2_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_typ2 IS 'Domaine de valeur de l''attribut code nomenclature niveau 2 des espaces verts ';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ2.code IS 'Code du sous-type de niveau 2 principal des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ2.valeur IS 'Valeur du sous-type de niveau 2 principal des objets espaces verts';
COMMENT ON CONSTRAINT lt_ev_objet_typ2_pkey ON m_espace_vert.lt_ev_objet_typ2 IS 'Clé primaire du domaine de valeur lt_ev_objet_typ2';
 
INSERT INTO m_espace_vert.lt_ev_objet_typ2(
            code, valeur)
    VALUES
  ('00','Non renseigné'),      
  ('11','Arboré'),
  ('12','Arbustif'),
  ('13','Fleuri'),
  ('14','Enherbé'),
  ('21','Circulation'),
  ('22','Clôture'),
  ('23','Loisirs'),
  ('31','Arrivée d''eau'),
  ('32','Espace en eau'),
  ('99','Référence non classée');

-- ################################################################# lt_ev_objet_typ3 ###############################################

-- Table: m_espace_vert.lt_ev_objet_typ3

-- DROP TABLE m_espace_vert.lt_ev_objet_typ3;

CREATE TABLE m_espace_vert.lt_ev_objet_typ3
(
    code character varying(3) NOT NULL,
    valeur character varying(100),
    CONSTRAINT lt_ev_objet_typ3_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_typ3 IS 'Domaine de valeur de l''attribut code nomenclature niveau 3 des espaces verts ';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ3.code IS 'Code du sous-type de niveau 3 principal des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_typ3.valeur IS 'Valeur du sous-type de niveau 3 principal des objets espaces verts';
COMMENT ON CONSTRAINT lt_ev_objet_typ3_pkey ON m_espace_vert.lt_ev_objet_typ3 IS 'Clé primaire du domaine de valeur lt_ev_objet_typ3';

INSERT INTO m_espace_vert.lt_ev_objet_typ3(
            code, valeur)
    VALUES
  ('000','Non renseigné'),      
  ('111','Arbre isolé'),
  ('112','Arbre en alignement'),
  ('113','Zone boisée'),
  ('121','Arbuste isolé'),
  ('122','Haie arbustive'),
  ('123','Massif arbustif'),
  ('131','Point fleuri'),
  ('132','Massif fleuri'),
  ('141','Pelouse, gazon'),
  ('211','Allée'),
  ('212','Piste cyclable'),
  ('213','Parking matérialisé'),
  ('214','Espace de stationnement libre'),
  ('215','Parvis, place'),
  ('219','Autre circulation'),
  ('221','Mur'),
  ('222','Grillage'),
  ('223','Palissage'),
  ('229','Autre clôture'),
  ('231','Loisirs isolé'),
  ('232','Surface de loisirs'),
  ('311','Fontaine'),
  ('312','Robinet'),
  ('319','Autre arrivée d''eau'),
  ('321','Rivière'),
  ('322','Ru'),
  ('323','Bassin'),
  ('324','Marre'),
  ('325','Etang'),
  ('329','Autre espace en eau'),
  ('999','Référence non classée');

-- ################################################################# lt_ev_boolean ###############################################

-- Table: m_espace_vert.lt_ev_boolean

-- DROP TABLE m_espace_vert.lt_ev_boolean;

CREATE TABLE m_espace_vert.lt_ev_boolean
(
    code character varying(1) NOT NULL,
    valeur character varying(30),
    CONSTRAINT lt_ev_boolean_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_boolean IS 'Code permettant de décrire l''état d''un attribut boolean';
COMMENT ON COLUMN m_espace_vert.lt_ev_boolean.code IS 'Code de la liste énumérée relative à l''état d''un attribut boolean';
COMMENT ON COLUMN m_espace_vert.lt_ev_boolean.valeur IS 'Valeur de la liste énumérée relative à l''état d''un attribut boolean';
COMMENT ON CONSTRAINT lt_ev_boolean_pkey ON m_espace_vert.lt_ev_boolean IS 'Clé primaire du domaine de valeur lt_ev_boolean';

INSERT INTO m_espace_vert.lt_ev_boolean(
            code, valeur)
    VALUES
  ('0','Non renseigné'),
  ('f','Non'),
  ('t','Oui'),
  ('z','Non concerné');


-- ################################################################# lt_ev_objet_etat ###############################################

-- ajout de la table de liste "lt_ev_objet_etat"

CREATE TABLE  m_espace_vert.lt_ev_objet_etat
(
	code character varying(1) NOT NULL,
	valeur character varying(80) NOT NULL,
	CONSTRAINT lt_ev_objet_etat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_etat IS 'Liste permettant de décrire les différents états des objets EV';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_etat.code IS 'Code de la liste énumérée relative à l''état des objets EV';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_etat.valeur IS 'Valeur de la liste énumérée relative à l''état des objets EV';
COMMENT ON CONSTRAINT lt_ev_objet_etat_pkey ON m_espace_vert.lt_ev_objet_etat IS 'Clé primaire du domaine de valeur lt_ev_objet_etat';

INSERT INTO m_espace_vert.lt_ev_objet_etat(
            code, valeur)
    VALUES
  ('0','Non renseigné'),
  ('1','Projet'),  
  ('2','Existant'),
  ('3','Supprimé');


-- ################################################################# lt_ev_objet_doma ###############################################
    
-- Table: m_espace_vert.lt_ev_objet_doma 

-- DROP TABLE m_espace_vert.lt_ev_objet_doma ;

CREATE TABLE m_espace_vert.lt_ev_objet_doma 
(
    code character varying(2) NOT NULL,
    valeur character varying(50),
    CONSTRAINT lt_ev_objet_doma_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_doma IS 'Domaine de valeur de la domanialité';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_doma.code IS 'code du type de domanialité';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_doma.valeur IS 'valeur du type de domanialité';
COMMENT ON CONSTRAINT lt_ev_objet_doma_pkey ON m_espace_vert.lt_ev_objet_doma IS 'Clé primaire du domaine de valeur lt_ev_objet_doma';

INSERT INTO m_espace_vert.lt_ev_objet_doma(
            code, valeur)
    VALUES
  ('00','Non renseignée'),
	('10','Publique'),
	('20','Privée (non déterminé)'),
	('21','Privée (communale)'),
	('22','Privée (autre organisme public, HLM, ...)'),
	('23','Privée');  
	
-- ################################################################# lt_ev_objet_qualdoma ###############################################
    
-- Table: m_espace_vert.lt_ev_objet_qualdoma 

-- DROP TABLE m_espace_vert.lt_ev_objet_qualdoma ;

CREATE TABLE m_espace_vert.lt_ev_objet_qualdoma 
(
    code character varying(2) NOT NULL,
    valeur character varying(50) ,
    CONSTRAINT lt_ev_objet_qualdoma_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_objet_qualdoma IS 'Domaine de valeur sur la qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_qualdoma.code IS 'Code de la qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.lt_ev_objet_qualdoma .valeur IS 'valeur de la qualité de l''information liée à la domanialité';
COMMENT ON CONSTRAINT lt_ev_objet_qualdoma_pkey ON m_espace_vert.lt_ev_objet_qualdoma IS 'Clé primaire du domaine de valeur lt_ev_objet_qualdoma';

INSERT INTO m_espace_vert.lt_ev_objet_qualdoma(
            code, valeur)
    VALUES
  ('00','Non renseignée'),
	('10','Déduite'),
	('20','Déclarative');  


-- ################################################################# lt_ev_zone_site_type ###############################################
  
-- Table: m_espace_vert.lt_ev_zone_site_type

-- DROP TABLE m_espace_vert.lt_ev_zone_site_type;

CREATE TABLE m_espace_vert.lt_ev_zone_site_type
(
  code character varying(2) NOT NULL, -- code du type de site intégrant les objets des espaces verts
  valeur character varying(100), -- libellé du type de site intégrant les objets des espaces verts
  CONSTRAINT lt_ev_zone_site_type_pkey PRIMARY KEY (code) -- Clé primaire de la table lt_ev_zone_site_type
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_zone_site_type IS 'Liste de valeurs des codes du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_zone_site_type.code IS 'code du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_zone_site_type.valeur IS 'libellé du type de site intégrant les objets des espaces verts';
COMMENT ON CONSTRAINT lt_ev_zone_site_type_pkey ON m_espace_vert.lt_ev_zone_site_type IS 'Clé primaire du domaine de valeur lt_ev_zone_site_type';

INSERT INTO m_espace_vert.lt_ev_zone_site_type(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Parc, jardin, square'),
  ('02','Accotements de voies'),
  ('03','Accompagnement de bâtiments publics'),
  ('04','Accompagnement d''habitations'),
  ('05','Accompagnement d''établissements industriels et commerciaux'),
  ('06','Enceinte sportive'),
  ('07','Cimetière'),
  ('11','Espace naturel aménagé');


-- ################################################################# lt_ev_vegetal_position ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_position

-- DROP TABLE m_espace_vert.lt_ev_vegetal_position;

CREATE TABLE m_espace_vert.lt_ev_vegetal_position
(
  code character varying(2) NOT NULL,
  valeur character varying(80),
  CONSTRAINT lt_ev_vegetal_position_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_position IS 'Liste des valeurs décrivant la position des objets "espace vert" de type végétal';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_position.code IS 'Code de la classe décrivant la position des objets "espace vert" de type végétal';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_position.valeur IS 'Valeur de la classe décrivant la position des objets "espace vert" de type végétal';
COMMENT ON CONSTRAINT lt_ev_vegetal_position_pkey ON m_espace_vert.lt_ev_vegetal_position IS 'Clé primaire du domaine de valeur lt_ev_vegetal_position';

INSERT INTO m_espace_vert.lt_ev_vegetal_position(
            code, valeur)
    VALUES
  ('00','Non renseigné'),    
  ('10','Sol'),
  ('20','Hors-sol (non précisé)'),
  ('21','Pot'),
  ('22','Bac'),
  ('23','Jardinière'),
  ('24','Suspension'),
  ('29','Hors-sol (autre)');


-- ################################################################# lt_ev_vegetal_espace_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_espace_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_espace_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_espace_type
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_espace_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_espace_type IS 'Liste permettant de décrire le "Type d''espace" des espaces végétalisés';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_espace_type.code IS 'Code de la classe décrivant le "Type d''espace" des espaces végétalisés';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_espace_type.valeur IS 'Valeur de la classe décrivant le "Type d''espace" des espaces végétalisés';
COMMENT ON CONSTRAINT lt_ev_vegetal_espace_type_pkey ON m_espace_vert.lt_ev_vegetal_espace_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_espace_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_espace_type(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Ambiance fleuries/horticoles'),
  ('02','Ambiance végétale/ornementales'),
  ('03','Ambiance champêtre'),
  ('04','Ambiance de nature');


-- ################################################################# lt_ev_vegetal_arrosage_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arrosage_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arrosage_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arrosage_type
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_arrosage_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arrosage_type IS 'Liste permettant de décrire le "Type d''arrosage automatique" des espaces végétalisés';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arrosage_type.code IS 'Code de la classe décrivant le "Type d''arrosage automatique" des espaces végétalisés';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arrosage_type.valeur IS 'Valeur de la classe décrivant le "Type d''arrosage automatique" des espaces végétalisés';
COMMENT ON CONSTRAINT lt_ev_vegetal_arrosage_type_pkey ON m_espace_vert.lt_ev_vegetal_arrosage_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arrosage_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_arrosage_type(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Arrosage à jet rotatif'),
  ('02', 'Arrosage goutte à goutte ou localisé'),
  ('03', 'Arrosage en surface - asperseur'),
  ('04', 'Arrosage enterré'),
  ('05', 'Tuyaux poreux'),
  ('06', 'Arroseur oscillant'),
  ('07', 'Arroseur canon'),
  ('08', 'Tuyaux à goutteurs intégrés');


-- ################################################################# lt_ev_vegetal_arbre_etatarbre ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_etatarbre

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_etatarbre_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre IS 'Liste permettant de décrire l''état des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_etatarbre.code IS 'Code de la classe décrivant l''état des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_etatarbre.valeur IS 'Valeur de la classe décrivant l''état des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_etatarbre_pkey ON m_espace_vert.lt_ev_vegetal_arbre_etatarbre IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_etatarbre';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_etatarbre(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('10', 'Projet'),
  ('20', 'Existant'),
  ('21', 'Abattu'),
  ('22', 'Désouché'),
  ('30', 'Supprimé');
  

-- ################################################################# lt_ev_vegetal_arbre_mode_conduite ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_mode_conduite

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_mode_conduite_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite IS 'Liste permettant de décrire le "Mode de conduite" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_mode_conduite.code IS 'Code de la classe décrivant le "Mode de conduite" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_mode_conduite.valeur IS 'Valeur de la classe décrivant le "Mode de conduite" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_mode_conduite_pkey ON m_espace_vert.lt_ev_vegetal_arbre_mode_conduite IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_mode_conduite';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_mode_conduite(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Tête de chat'),
  ('02', 'Mauvais suivi'),
  ('03', 'Rideaux'),
  ('04', 'Port libre'),
  ('05', 'Semi libre'),
  ('06', 'Accompagnement'),
  ('99', 'Autre');

-- ################################################################# lt_ev_vegetal_arbre_amenagement_pied ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_amenagement_pied_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied IS 'Liste permettant de décrire l''"aménagement du pied" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied.code IS 'Code de la classe décrivant l''"aménagement du pied" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied.valeur IS 'Valeur de la classe décrivant l''"aménagement du pied" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_amenagement_pied_pkey ON m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_amenagement_pied';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Grille'),
  ('02', 'Fleuri'),
  ('03', 'Paillage'),
  ('99', 'Autre');

-- ################################################################# lt_ev_vegetal_niveau_allergisant ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_niveau_allergisant

-- DROP TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant;

CREATE TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_niveau_allergisant_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant IS 'Liste permettant de décrire le niveau allergène';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_niveau_allergisant.code IS 'Code de la classe décrivant le niveau allergène';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_niveau_allergisant.valeur IS 'Valeur de la classe décrivant le niveau allergène';
COMMENT ON CONSTRAINT lt_ev_vegetal_niveau_allergisant_pkey ON m_espace_vert.lt_ev_vegetal_niveau_allergisant IS 'Clé primaire du domaine de valeur lt_ev_vegetal_niveau_allergisant';

INSERT INTO m_espace_vert.lt_ev_vegetal_niveau_allergisant(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Faible'),
  ('02', 'Moyen'),
  ('03', 'Elevé');

-- ################################################################# lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ IS 'Liste permettant de décrire le "Type d''anomalie" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ.code IS 'Code de la classe décrivant le "Type d''anomalie" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ.valeur IS 'Valeur de la classe décrivant le "Type d''anomalie" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ_pkey ON m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Descente de cime'),
  ('02', 'Champignon'),
  ('03', 'Ravageur'),
  ('04', 'Pourriture'),
  ('05', 'Défaut mécanique (écorce incluse)'),
  ('06', 'Racine altérée'),
  ('99', 'Autre');


-- ################################################################# lt_ev_vegetal_arbre_periode_plantation ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_periode_plantation

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_periode_plantation_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation IS 'Liste permettant de décrire la "Période de plantation" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_periode_plantation.code IS 'Code de la classe décrivant la "Période de plantation" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_periode_plantation.valeur IS 'Valeur de la classe décrivant la "Période de plantation" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_periode_plantation_pkey ON m_espace_vert.lt_ev_vegetal_arbre_periode_plantation IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_periode_plantation';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_periode_plantation(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'avant 1900'),
  ('02', '1900 à 1909'),
  ('03', '1910 à 1919'),
  ('04', '1920 à 1929'),
  ('05', '1930 à 1939'),
  ('06', '1940 à 1949'),
  ('07', '1950 à 1959'),
  ('08', '1960 à 1969'),
  ('09', '1970 à 1979'),
  ('10', '1980 à 1989'),
  ('11', '1990 à 1999'),
  ('12', '2000 à 2009'),
  ('13', '2010 à 2019'),
  ('14', '2020 à 2029');

-- ################################################################# lt_ev_vegetal_arbre_date_plantation_saison ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_date_plantation_saison_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison IS 'Liste permettant de décrire la "Date de plantation (saison)" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison.code IS 'Code de la classe décrivant la "Date de plantation (saison)" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison.valeur IS 'Valeur de la classe décrivant la "Date de plantation (saison)" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_date_plantation_saison_pkey ON m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_date_plantation_saison';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Hiver'),
  ('02', 'Printemps'),
  ('03', 'Eté'),
  ('04', 'Automne');


-- ################################################################# lt_ev_vegetal_arbre_stade_dev ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_stade_dev

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_stade_dev_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev IS 'Liste permettant de décrire le "Stade de développement" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_stade_dev.code IS 'Code de la classe décrivant le "Stade de développement" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_stade_dev.valeur IS 'Valeur de la classe décrivant le "Stade de développement" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_stade_dev_pkey ON m_espace_vert.lt_ev_vegetal_arbre_stade_dev IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_stade_dev';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_stade_dev(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Jeune'),
  ('02', 'Adulte'),
  ('03', 'Mature');


-- ################################################################# lt_ev_vegetal_arbre_contr_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_contr_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_contr_type_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type IS 'Liste permettant de décrire le "Type de contrainte" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_contr_type.code IS 'Code de la classe décrivant le "Type de contrainte" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_contr_type.valeur IS 'Valeur de la classe décrivant le "Type de contrainte" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_contr_type_pkey ON m_espace_vert.lt_ev_vegetal_arbre_contr_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_contr_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_contr_type(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Cohabitation'),
  ('02', 'Candélabre'),
  ('03', 'Bâtiment'),
  ('04', 'Feu de signalisation'),
  ('05', 'Cable aérien'),
  ('99', 'Autre');


-- ################################################################# lt_ev_vegetal_arbre_sol_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_sol_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type
(
  code varchar(2) NOT NULL,
	valeur varchar(80),
  CONSTRAINT lt_ev_vegetal_arbre_sol_type_pkey PRIMARY KEY (code)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type IS 'Liste permettant de décrire le "Type de sol" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_sol_type.code IS 'Code de la classe décrivant le "Type de sol" des arbres';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_sol_type.valeur IS 'Valeur de la classe décrivant le "Type de sol" des arbres';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_sol_type_pkey ON m_espace_vert.lt_ev_vegetal_arbre_sol_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_sol_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_sol_type(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Mauvais'),
  ('02', 'Moyen'),
  ('03', 'Bon');  


-- ################################################################# lt_ev_vegetal_arbre_hauteur_cl ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_arbre_hauteur_cl_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl IS 'Liste permettant de décrire la classe de hauteur des objets ponctuels arbre';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl.code IS 'Code de la classe décrivant la hauteur des objets ponctuels arbre';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl.valeur IS 'Valeur de la classe décrivant la hauteur des objets ponctuels arbre';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_hauteur_cl_pkey ON m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_hauteur_cl';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Moins de 1 mètre'),
  ('02','1 à 2 mètres'),
  ('03','2 à 5 mètres'),
  ('04','5 à 10 mètres'),
  ('05','10 à 15 mètres'),
  ('06','15 à 20 mètres'),
  ('07','Plus de 20 mètres');


-- ################################################################# lt_ev_vegetal_arbre_implant ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_arbre_implant

-- DROP TABLE m_espace_vert.lt_ev_vegetal_arbre_implant;

CREATE TABLE m_espace_vert.lt_ev_vegetal_arbre_implant
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_arbre_implant_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_implant IS 'Liste permettant de décrire l''implantation des objets ponctuels arbre';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_implant.code IS 'Code de la classe décrivant l''implantation des objets ponctuels arbre';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_arbre_implant.valeur IS 'Valeur de la classe décrivant l''implantation des objets ponctuels arbre';
COMMENT ON CONSTRAINT lt_ev_vegetal_arbre_implant_pkey ON m_espace_vert.lt_ev_vegetal_arbre_implant IS 'Clé primaire du domaine de valeur lt_ev_vegetal_arbre_implant';

INSERT INTO m_espace_vert.lt_ev_vegetal_arbre_implant(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Isolé'),
  ('02','Alignement'),
  ('03','Bois');
  

-- ################################################################# lt_ev_vegetal_haie_sai_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_haie_sai_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_haie_sai_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type IS 'Liste permettant de décrire le type de saisie de la sous-classe de précision des objets espace vert de type haie';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_sai_type.code IS 'Code de la classe du type de saisie de la sous-classe de précision des objets espace vert de type haie';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_sai_type.valeur IS 'Valeur de la classe du type de saisie de la sous-classe de précision des objets espace vert de type haie';
COMMENT ON CONSTRAINT lt_ev_vegetal_haie_sai_type_pkey ON m_espace_vert.lt_ev_vegetal_haie_sai_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_haie_sai_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_haie_sai_type(
            code, valeur)
    VALUES
  ('10','Largeur à appliquer au centre du linéaire'),
  ('20','Largeur à appliquer dans le sens de saisie'),
  ('30','Largeur à appliquer dans le sens inverse de saisie');
  

-- ################################################################# lt_ev_vegetal_haie_veget_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_haie_veget_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_haie_veget_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type IS 'Liste permettant de décrire le "Type végétation" des haies';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_veget_type.code IS 'Code de la classe décrivant le "Type végétation" des haies';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_veget_type.valeur IS 'Valeur de la classe décrivant le "Type végétation" des haies';
COMMENT ON CONSTRAINT lt_ev_vegetal_haie_veget_type_pkey ON m_espace_vert.lt_ev_vegetal_haie_veget_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_haie_veget_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_haie_veget_type(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Haie monospécifique'),
  ('02','Haie mixte');


-- ################################################################# lt_ev_vegetal_haie_paillage_type ###############################################

-- Table: m_espace_vert.lt_ev_vegetal_haie_paillage_type

-- DROP TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type;

CREATE TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_vegetal_haie_paillage_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type IS 'Liste permettant de décrire le "Type paillage" des haies';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_paillage_type.code IS 'Code de la classe décrivant le "Type paillage" des haies';
COMMENT ON COLUMN m_espace_vert.lt_ev_vegetal_haie_paillage_type.valeur IS 'Valeur de la classe décrivant le "Type paillage" des haies';
COMMENT ON CONSTRAINT lt_ev_vegetal_haie_paillage_type_pkey ON m_espace_vert.lt_ev_vegetal_haie_paillage_type IS 'Clé primaire du domaine de valeur lt_ev_vegetal_haie_paillage_type';

INSERT INTO m_espace_vert.lt_ev_vegetal_haie_paillage_type(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Paillage organique'),
  ('02','Paillage minéral');


-- ################################################################# lt_ev_intervention_objet_type ###############################################

-- Table: m_espace_vert.lt_ev_intervention_objet_type

-- DROP TABLE m_espace_vert.lt_ev_intervention_objet_type;

CREATE TABLE m_espace_vert.lt_ev_intervention_objet_type
(
    code character varying(3) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_objet_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_objet_type IS 'Liste permettant de décrire le "Type d''objet" des interventions';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_objet_type.code IS 'Code de la classe décrivant le "Type d''objet" des interventions';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_objet_type.valeur IS 'Valeur de la classe décrivant le "Type d''objet" des interventions';
COMMENT ON CONSTRAINT lt_ev_intervention_objet_type_pkey ON m_espace_vert.lt_ev_intervention_objet_type IS 'Clé primaire du domaine de valeur lt_ev_intervention_objet_type';

INSERT INTO m_espace_vert.lt_ev_intervention_objet_type(
            code, valeur)
    VALUES
  ('000', 'Non renseigné'),
  ('111', 'Arbres'),
  ('113', 'Zones boisées'),
  ('122', 'Haies'),
  ('123', 'Massifs arbustifs'),
  ('132', 'Massifs fleuris'),
  ('141', 'Engazonnements');


-- ################################################################# lt_ev_intervention_inter_type ###############################################

-- Table: m_espace_vert.lt_ev_intervention_inter_type

-- DROP TABLE m_espace_vert.lt_ev_intervention_inter_type;

CREATE TABLE m_espace_vert.lt_ev_intervention_inter_type
(
    code character varying(5) NOT NULL,
    objet_type character varying(3) NOT NULL,    
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_inter_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_inter_type IS 'Liste permettant de décrire le type d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_inter_type.code IS 'Code de la classe décrivant le type d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_inter_type.valeur IS 'Valeur de la classe décrivant le type d''intervention';
COMMENT ON CONSTRAINT lt_ev_intervention_inter_type_pkey ON m_espace_vert.lt_ev_intervention_inter_type IS 'Clé primaire du domaine de valeur lt_ev_intervention_inter_type';

INSERT INTO m_espace_vert.lt_ev_intervention_inter_type(
            code, objet_type, valeur)
    VALUES
  ('00000', '000', 'Non renseigné'),    
-- arbre
  ('11100', '111', 'Non renseigné'),
  ('11101', '111', 'Abattage'),
  ('11102', '111', 'Dessouchage'),  
  ('11103', '111', 'Tête de chat'),
  ('11104', '111', 'Cohabitation'),
  ('11105', '111', 'Sanitaire'),
  ('11106', '111', 'Sélection'),
  ('11107', '111', 'Démontage'),
  ('11108', '111', 'Remontée de couronne'),
  ('11109', '111', 'Formation'),
  ('11110', '111', 'Branche cassée'),
  ('11111', '111', 'Branche en suspension'),  
  ('11112', '111', 'Arbre accidenté'),
--         
  ('11301', '113', 'Abattage'),
  ('11302', '113', 'Coupe'),
  ('11303', '113', 'Elagage'),
  ('12201', '122', 'Abattage'),
  ('12202', '122', 'Coupe'),
  ('12203', '122', 'Elagage'),
  ('12301', '123', 'Tonte'),
  ('12302', '123', 'Traitement'),
  ('13201', '132', 'Tonte'),
  ('13202', '132', 'Traitement'),    
  ('14101', '141', 'Tonte'),
  ('14102', '141', 'Traitement');


-- ################################################################# lt_ev_intervention_src_demand ###############################################

-- Table: m_espace_vert.lt_ev_intervention_src_demand

-- DROP TABLE m_espace_vert.lt_ev_intervention_src_demand;

CREATE TABLE m_espace_vert.lt_ev_intervention_src_demand
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_src_demand_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_src_demand IS 'Liste permettant de décrire la source d''une demande d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_src_demand.code IS 'Code de la classe décrivant la source d''une demande d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_src_demand.valeur IS 'Valeur de la classe décrivant la source d''une demande d''intervention';
COMMENT ON CONSTRAINT lt_ev_intervention_src_demand_pkey ON m_espace_vert.lt_ev_intervention_src_demand IS 'Clé primaire du domaine de valeur lt_ev_intervention_src_demand';

INSERT INTO m_espace_vert.lt_ev_intervention_src_demand(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Interne'),
  ('02', 'Riverain');


-- ################################################################# lt_ev_intervention_freq_unite ###############################################

-- Table: m_espace_vert.lt_ev_intervention_freq_unite

-- DROP TABLE m_espace_vert.lt_ev_intervention_freq_unite;

CREATE TABLE m_espace_vert.lt_ev_intervention_freq_unite
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_freq_unite_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_freq_unite IS 'Liste permettant de décrire les unités pour la fréquence des demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_freq_unite.code IS 'Code de la classe décrivant les unités pour la fréquence des demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_freq_unite.valeur IS 'Valeur de la classe décrivant les unités pour la fréquence des demandes d''intervention';
COMMENT ON CONSTRAINT lt_ev_intervention_freq_unite_pkey ON m_espace_vert.lt_ev_intervention_freq_unite IS 'Clé primaire du domaine de valeur lt_ev_intervention_freq_unite';

INSERT INTO m_espace_vert.lt_ev_intervention_freq_unite(
            code, valeur)
    VALUES
--  ('00', 'Non renseigné'),    
  ('01', 'Jours'),
  ('02', 'Semaines'),
  ('03', 'Mois'),
  ('04', 'Ans');


-- ################################################################# lt_ev_intervention_statut ###############################################

-- Table: m_espace_vert.lt_ev_intervention_statut

-- DROP TABLE m_espace_vert.lt_ev_intervention_statut;

CREATE TABLE m_espace_vert.lt_ev_intervention_statut
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_statut_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_statut IS 'Liste permettant de décrire les unités pour le statut des demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_statut.code IS 'Code de la classe décrivant les unités pour le statut des demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_statut.valeur IS 'Valeur de la classe décrivant les unités pour le statut des demandes d''intervention';
COMMENT ON CONSTRAINT lt_ev_intervention_statut_pkey ON m_espace_vert.lt_ev_intervention_statut IS 'Clé primaire du domaine de valeur lt_ev_intervention_statut';

INSERT INTO m_espace_vert.lt_ev_intervention_statut(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Terminée'),
  ('02', 'Annulée'),
  ('03', 'Suspendue');


-- ################################################################# lt_ev_intervention_periode ###############################################

-- Table: m_espace_vert.lt_ev_intervention_periode

-- DROP TABLE m_espace_vert.lt_ev_intervention_periode;

CREATE TABLE m_espace_vert.lt_ev_intervention_periode
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_intervention_periode_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_intervention_periode IS 'Liste permettant de décrire les mois de l''année';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_periode.code IS 'Code de la classe décrivant les mois de l''année';
COMMENT ON COLUMN m_espace_vert.lt_ev_intervention_periode.valeur IS 'Valeur de la classe décrivant les mois de l''année';
COMMENT ON CONSTRAINT lt_ev_intervention_periode_pkey ON m_espace_vert.lt_ev_intervention_periode IS 'Clé primaire du domaine de valeur lt_ev_intervention_periode';

INSERT INTO m_espace_vert.lt_ev_intervention_periode(
            code, valeur)
    VALUES
--  ('00', 'Non renseigné'),
  ('01', 'Janvier'),
  ('02', 'Février'),
  ('03', 'Mars'),
  ('04', 'Avril'),
  ('05', 'Mai'),
  ('06', 'Juin'),
  ('07', 'Juillet'),
  ('08', 'Août'),
  ('09', 'Septembre'),
  ('10', 'Octobre'),
  ('11', 'Novembre'),
  ('12', 'Décembre');


-- ################################################################# lt_ev_equipe_specialisation ###############################################

-- Table: m_espace_vert.lt_ev_equipe_specialisation

-- DROP TABLE m_espace_vert.lt_ev_equipe_specialisation;

CREATE TABLE m_espace_vert.lt_ev_equipe_specialisation
(
    code character varying(2) NOT NULL,
    valeur character varying(80),
    CONSTRAINT lt_ev_equipe_specialisation_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lt_ev_equipe_specialisation IS 'Liste permettant de décrire la liste des spécialisations des entreprises';
COMMENT ON COLUMN m_espace_vert.lt_ev_equipe_specialisation.code IS 'Code de la classe décrivant la liste des spécialisations des entreprises';
COMMENT ON COLUMN m_espace_vert.lt_ev_equipe_specialisation.valeur IS 'Valeur de la classe décrivant la liste des spécialisations des entreprises';
COMMENT ON CONSTRAINT lt_ev_equipe_specialisation_pkey ON m_espace_vert.lt_ev_equipe_specialisation IS 'Clé primaire du domaine de valeur lt_ev_equipe_specialisation';

INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(
            code, valeur)
    VALUES
  ('00', 'Non renseigné'),
  ('01', 'Taille en rideau'),
  ('02', 'Tonte'),
  ('03', 'Désherbage'),
  ('04', 'Taille');



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# Séquence sur TABLE an_ev_objet ###############################################

-- SEQUENCE: m_espace_vert.an_ev_objet_idobjet_seq

-- DROP SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq;

CREATE SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;

-- ################################################################# Séquence sur TABLE an_ev_vegetal_arbre_etat_sanitaire ###############################################

-- SEQUENCE: m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq

-- DROP SEQUENCE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq;

CREATE SEQUENCE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;
    
-- ################################################################# Séquence sur TABLE an_ev_vegetal_ref_bota ###############################################

-- SEQUENCE: m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq

-- DROP SEQUENCE m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq;

CREATE SEQUENCE m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;
    
-- ################################################################# Séquence sur TABLE geo_ev_zone_site ###############################################

-- SEQUENCE: m_espace_vert.geo_ev_zone_site_idsite_seq

-- DROP SEQUENCE m_espace_vert.geo_ev_zone_site_idsite_seq;

CREATE SEQUENCE m_espace_vert.geo_ev_zone_site_idsite_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;
    
-- ################################################################# Séquence sur TABLE geo_ev_zone_gestion ###############################################

-- SEQUENCE: m_espace_vert.geo_ev_zone_gestion_idgestion_seq

-- DROP SEQUENCE m_espace_vert.geo_ev_zone_gestion_idgestion_seq;

CREATE SEQUENCE m_espace_vert.geo_ev_zone_gestion_idgestion_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;

-- ################################################################# Séquence sur TABLE geo_ev_zone_equipe ###############################################

-- SEQUENCE: m_espace_vert.geo_ev_zone_equipe_idequipe_seq

-- DROP SEQUENCE m_espace_vert.geo_ev_zone_equipe_idequipe_seq;

CREATE SEQUENCE m_espace_vert.geo_ev_zone_equipe_idequipe_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;                  


-- ################################################################# Séquence sur TABLE lk_ev_intervention_objet ###############################################

-- SEQUENCE: m_espace_vert.lk_ev_intervention_objet_idlk_seq

-- DROP SEQUENCE m_espace_vert.lk_ev_intervention_objet_idlk_seq;

CREATE SEQUENCE m_espace_vert.lk_ev_intervention_objet_idlk_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;    

-- ################################################################# Séquence sur TABLE geo_ev_intervention ###############################################

-- SEQUENCE: m_espace_vert.geo_ev_intervention_idinter_seq

-- DROP SEQUENCE m_espace_vert.geo_ev_intervention_idinter_seq;

CREATE SEQUENCE m_espace_vert.geo_ev_intervention_idinter_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;    


-- ################################################################# Séquence sur TABLE an_ev_media ###############################################

-- SEQUENCE: m_espace_vert.an_ev_media_gid_seq

-- DROP SEQUENCE m_espace_vert.an_ev_media_gid_seq;

CREATE SEQUENCE m_espace_vert.an_ev_media_gid_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;    
    
-- ################################################################# Séquence sur TABLE an_ev_log ###############################################

-- SEQUENCE: m_espace_vert.an_ev_log_idlog_seq

-- DROP SEQUENCE m_espace_vert.an_ev_log_idlog_seq;

CREATE SEQUENCE m_espace_vert.an_ev_log_idlog_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;        

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE an_ev_objet ###############################################

-- DROP TABLE m_espace_vert.an_ev_objet;

CREATE TABLE m_espace_vert.an_ev_objet
(
  idobjet bigint NOT NULL DEFAULT nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass),
  idgestion integer,
  idsite integer,
  idequipe integer,  
  idcontrat character varying(2),
  insee character varying(5),
  commune character varying(80),
  quartier character varying(80),
  typ1 character varying(1) NOT NULL,
  typ2 character varying(2) NOT NULL,
  typ3 character varying(3) NOT NULL,
  etat character varying(1) NOT NULL DEFAULT '0',  
  doma character varying(2),
  qualdoma character varying(2),
  op_sai character varying(80),  
  date_sai timestamp without time zone,
  src_geom character varying(2),
  src_date integer,    
  op_att character varying(80),
  date_maj_att timestamp without time zone,	    
  op_maj character varying(80),  
  date_maj timestamp without time zone,
  observ character varying(254),
  CONSTRAINT an_ev_objet_pkey PRIMARY KEY (idobjet) 
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_objet IS 'Classe des métadonnées des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.an_ev_objet.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_objet.observ IS 'Observations diverses';
COMMENT ON CONSTRAINT an_ev_objet_pkey ON m_espace_vert.an_ev_objet IS 'Clé primaire de la classe an_ev_objet';

-- ################################################################# TABLE geo_ev_objet_pct ###############################################

-- DROP TABLE m_espace_vert.geo_ev_objet_pct;
  
CREATE TABLE m_espace_vert.geo_ev_objet_pct
(
  idobjet bigint NOT NULL,
  x_l93 numeric(10,3),
  y_l93 numeric(10,3),
  geom geometry(point,2154),
  CONSTRAINT geo_ev_objet_pct_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_objet_pct IS 'Table géographique de la classe des objets points des espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_pct.idobjet IS 'Identifiant des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_pct.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_pct.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_pct.geom IS 'Géométrie des objets espaces verts';
COMMENT ON CONSTRAINT geo_ev_objet_pct_pkey ON m_espace_vert.geo_ev_objet_pct IS 'Clé primaire de la classe geo_ev_objet_pct';


-- ################################################################# TABLE geo_ev_objet_line ###############################################

-- DROP TABLE m_espace_vert.geo_ev_objet_line;
  
CREATE TABLE m_espace_vert.geo_ev_objet_line      
(
  idobjet bigint NOT NULL,
  long_m integer,
  geom geometry(linestring,2154),
  CONSTRAINT geo_ev_objet_line_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_objet_line IS 'Table géographique de la classe des objets linéaires des espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_line.idobjet IS 'Identifiant des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_line.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_line.geom IS 'Géométrie des objets espace vert';
COMMENT ON CONSTRAINT geo_ev_objet_line_pkey ON m_espace_vert.geo_ev_objet_line IS 'Clé primaire de la classe geo_ev_objet_line';


-- ################################################################# TABLE an_ev_objet_line_largeur ###############################################

-- DROP TABLE m_espace_vert.an_ev_objet_line_largeur;

CREATE TABLE m_espace_vert.an_ev_objet_line_largeur
(
    idobjet bigint NOT NULL,
    larg_cm integer,
    CONSTRAINT an_ev_objet_line_largeur_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_objet_line_largeur IS 'Classe de précision des objets de l''inventaire de type linéaire nécessitant des précisions de largeur';
COMMENT ON COLUMN m_espace_vert.an_ev_objet_line_largeur.idobjet IS 'Identifiant unique de les objets concernés';
COMMENT ON COLUMN m_espace_vert.an_ev_objet_line_largeur.larg_cm IS 'Largeur des objets en cm';
COMMENT ON CONSTRAINT an_ev_objet_line_largeur_pkey ON m_espace_vert.an_ev_objet_line_largeur IS 'Clé primaire de la classe an_ev_objet_line_largeur';



-- ################################################################# TABLE geo_ev_objet_polygon ###############################################

-- DROP TABLE m_espace_vert.geo_ev_objet_polygon;

CREATE TABLE m_espace_vert.geo_ev_objet_polygon
(
  idobjet bigint NOT NULL,
  sup_m2 integer,
  perimetre integer,
  geom geometry(polygon,2154),
  CONSTRAINT geo_ev_objet_polygon_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_objet_polygon IS 'Table géographique de la classe des objets polygones des espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_polygon.idobjet IS 'Identifiant des objets espaces verts';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_polygon.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_polygon.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_ev_objet_polygon.geom IS 'Géométrie des objets espace vert';
COMMENT ON CONSTRAINT geo_ev_objet_polygon_pkey ON m_espace_vert.geo_ev_objet_polygon IS 'Clé primaire de la classe geo_ev_objet_polygon';


-- ################################################################# TABLE an_ev_vegetal ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal;

CREATE TABLE m_espace_vert.an_ev_vegetal
(
    idobjet bigint NOT NULL,
    "position" character varying(2) NOT NULL DEFAULT '10',
    CONSTRAINT an_ev_vegetal_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal IS 'Classe de précision générique des objets "espace vert" de type "végétal"';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal.idobjet IS 'Identifiant unique de les objets concernés';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal."position" IS 'Position des objets';
COMMENT ON CONSTRAINT an_ev_vegetal_pkey ON m_espace_vert.an_ev_vegetal IS 'Clé primaire de la classe an_ev_vegetal_pkey';



-- ################################################################# TABLE an_ev_vegetal_arbre ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_arbre;

CREATE TABLE m_espace_vert.an_ev_vegetal_arbre
(
-- designation
    idobjet bigint NOT NULL,
    famille character varying(20),
    genre character varying(20),
    espece character varying(20),
    cultivar character varying(20),
    nomlatin character varying(80),
    nomcommun character varying(80),
    niv_allerg character varying(2) NOT NULL DEFAULT '00',       
-- proprio
    hauteur_cl character varying(2) NOT NULL DEFAULT '00',
    circonf integer,
    diam_houpp integer,    
    implant character varying(2) NOT NULL DEFAULT '00',
    mode_cond character varying(2) NOT NULL DEFAULT '00',   
-- historique
    date_pl_an integer,
    date_pl_sa character varying(2) NOT NULL DEFAULT '00',
    periode_pl character varying(2) NOT NULL DEFAULT '00',
    stade_dev character varying(2) NOT NULL DEFAULT '00',
-- divers
    sol_type character varying(2) NOT NULL DEFAULT '00',
    amena_pied character varying(80),   
--    
    remarq character varying(1) NOT NULL DEFAULT '0',
    remarq_com character varying(254),
    proteg character varying(1) NOT NULL DEFAULT '0',
    proteg_com character varying(254),
    contr character varying(1) NOT NULL DEFAULT '0',
    contr_type character varying(80),
    naiss character varying(1) NOT NULL DEFAULT '0',     
    naiss_com character varying(254),        
-- etat    
    etatarbre character varying(2),
    CONSTRAINT an_ev_vegetal_arbre_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);
 
COMMENT ON TABLE m_espace_vert.an_ev_vegetal_arbre IS 'Classe patrimoniale spécialisée des arbres';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.idobjet IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.famille IS 'Nom de la famille de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.genre IS 'Nom du genre de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.espece IS 'Nom de l''espèce de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.cultivar IS 'Nom du cultivar de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.nomlatin IS 'Libellé scientifique complet du nom de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.nomcommun IS 'Libellé du nom commun/vernaculaire de l''arbre (en français)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.niv_allerg IS 'Niveau allergisant';
--
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.hauteur_cl IS 'Classe de hauteur de l''arbre en mètre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.circonf IS 'Circonférence du tronc en centimètre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.diam_houpp IS 'Diamètre houppier en mètre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.implant IS 'Type d''implantation de l''arbre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.mode_cond IS 'Mode de conduite, assimilé à « port de taille » ou forme taillée';
--
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.date_pl_an IS 'Date de plantation (année)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.date_pl_sa IS 'Date de plantation (saison)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.periode_pl IS 'Période de plantation approx. (Décennie)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.stade_dev IS 'Stade de développement';
--
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.sol_type IS 'Type de sol';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.amena_pied IS 'Aménagement pied de l''arbre';
--
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.remarq IS 'Arbre remarquable (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.remarq_com IS 'Commentaires arbre remarquable';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.proteg IS 'Arbre protégé (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.proteg_com IS 'Commentaires arbre protégé';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.contr IS 'Contrainte (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.contr_type IS 'Type(s) de contrainte(s)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.naiss IS 'Programme naissance (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.naiss_com IS 'Commentaire arbre du programme naissance';
--
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre.etatarbre IS 'Etat de l''arbre';
COMMENT ON CONSTRAINT an_ev_vegetal_arbre_pkey ON m_espace_vert.an_ev_vegetal_arbre IS 'Clé primaire de la classe an_ev_vegetal_arbre';


-- ################################################################# TABLE an_ev_vegetal_arbre_etat_sanitaire ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire;

CREATE TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire
(
    idetatsan integer NOT NULL DEFAULT nextval('m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq'::regclass),
    idobjet bigint NOT NULL,
    date_const timestamp without time zone,
    anomal character varying(1) NOT NULL DEFAULT '0',
    anomal_typ character varying(80) NOT NULL DEFAULT '00', -- multivalué, longueur de champ >2, prévoir ZZ du coup si pas d'anomalie
    surveil character varying(1) NOT NULL DEFAULT '0',
    CONSTRAINT an_ev_vegetal_arbre_etat_sanitaire_pkey PRIMARY KEY (idetatsan)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire IS 'Table contenant la liste des états sanitaires des arbres';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.idetatsan IS 'Identifiant de l''état';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.idobjet IS 'Identifiant de l''arbre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.date_const IS 'Date du constat de l''état sanitaire de l''arbre';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.anomal IS 'Arbre présentant des anomalies (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.anomal_typ IS 'Type(s) d''anomalie(s) relevées';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire.surveil IS 'Arbre à surveiller (O/N)';
COMMENT ON CONSTRAINT an_ev_vegetal_arbre_etat_sanitaire_pkey ON m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire IS 'Clé primaire de la classe an_ev_vegetal_arbre_etat_sanitaire';


-- ################################################################# TABLE an_ev_vegetal_arbuste_haie ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_arbuste_haie;

CREATE TABLE m_espace_vert.an_ev_vegetal_arbuste_haie
(
    idobjet bigint NOT NULL,
    sai_type character varying(2),
    veget_type character varying(2),
    hauteur numeric,
    espac_type character varying(2),
    surface numeric,
    paill_type character varying(2),
    biodiv character varying(254),
    CONSTRAINT an_ev_vegetal_arbuste_haie_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_arbuste_haie IS 'Classe de précision des objets de l''inventaire des objets haies';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.idobjet IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.sai_type IS 'Type de saisie de l''objet linéaire haie';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.veget_type IS 'Type végétation';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.hauteur IS 'Hauteur';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.surface IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.paill_type IS 'Type de paillage';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_haie.biodiv IS 'Biodiversité';
COMMENT ON CONSTRAINT an_ev_vegetal_arbuste_haie_pkey ON m_espace_vert.an_ev_vegetal_arbuste_haie IS 'Clé primaire de la classe an_ev_vegetal_arbuste_haie';



-- ################################################################# TABLE an_ev_vegetal_arbuste_massif ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_arbuste_massif;

CREATE TABLE m_espace_vert.an_ev_vegetal_arbuste_massif
(
    idobjet bigint NOT NULL,
    espac_type character varying(2) DEFAULT '00',
    arros_auto character varying(1) NOT NULL DEFAULT '0',    
    arros_type character varying(2) DEFAULT '00',
    biodiv character varying(254),
    inv_faunis character varying(1) NOT NULL DEFAULT '0',
    CONSTRAINT an_ev_vegetal_arbuste_massif_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_arbuste_massif IS 'Table contenant les attributs complémentaires pour les massifs arbustifs';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.idobjet IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_arbuste_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';
COMMENT ON CONSTRAINT an_ev_vegetal_arbuste_massif_pkey ON m_espace_vert.an_ev_vegetal_arbuste_massif IS 'Clé primaire de la classe an_ev_vegetal_arbuste_massif';


-- ################################################################# TABLE an_ev_vegetal_fleuri_massif ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_fleuri_massif;

CREATE TABLE m_espace_vert.an_ev_vegetal_fleuri_massif
(
    idobjet bigint NOT NULL,
    espac_type character varying(2) DEFAULT '00',
    arros_auto character varying(1) NOT NULL DEFAULT '0',    
    arros_type character varying(2) DEFAULT '00',
    biodiv character varying(254),
    inv_faunis character varying(1) NOT NULL DEFAULT '0',
    CONSTRAINT an_ev_vegetal_fleuri_massif_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_fleuri_massif IS 'Table contenant les attributs complémentaires pour les massifs fleuris';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.idobjet IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_fleuri_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';
COMMENT ON CONSTRAINT an_ev_vegetal_fleuri_massif_pkey ON m_espace_vert.an_ev_vegetal_fleuri_massif IS 'Clé primaire de la classe an_ev_vegetal_fleuri_massif';


-- ################################################################# TABLE an_ev_vegetal_herbe ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_herbe;

CREATE TABLE m_espace_vert.an_ev_vegetal_herbe
(
    idobjet bigint NOT NULL,
    espac_type character varying(2) DEFAULT '00',
    arros_auto character varying(1) NOT NULL DEFAULT '0',
    arros_type character varying(2) DEFAULT '00',
    biodiv character varying(254),
    inv_faunis character varying(1) NOT NULL DEFAULT '0',
    CONSTRAINT an_ev_vegetal_herbe_pkey PRIMARY KEY (idobjet)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_herbe IS 'Table contenant les attributs complémentaires pour les espaces enherbés';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.idobjet IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_herbe.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';
COMMENT ON CONSTRAINT an_ev_vegetal_herbe_pkey ON m_espace_vert.an_ev_vegetal_herbe IS 'Clé primaire de la classe an_ev_vegetal_herbe';




-- ################################################################# TABLE an_ev_vegetal_ref_bota ###############################################

-- DROP TABLE m_espace_vert.an_ev_vegetal_ref_bota;

CREATE TABLE m_espace_vert.an_ev_vegetal_ref_bota
(
    idref_bota bigint NOT NULL DEFAULT nextval('m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq'::regclass),
    typ2 character varying(2),
    typ3 character varying(3),         
    famille character varying(20),
    genre character varying(20),
    espece character varying(20),
    cultivar character varying(80),
    nomlatin character varying(80),
    nomcommun character varying(80),
    niv_allerg character varying(2) NOT NULL DEFAULT '00', 
    CONSTRAINT an_ev_vegetal_ref_bota_pkey PRIMARY KEY (idref_bota)      
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_vegetal_ref_bota IS 'Référentiel botanique';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.idref_bota IS 'Identifiant de la référence botanique';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.famille IS 'Nom de la famille(en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.genre IS 'Nom du genre(en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.espece IS 'Nom de l''espèce (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.cultivar IS 'Nom du cultivar (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.nomlatin IS 'Libellé scientifique complet (en latin)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.nomcommun IS 'Libellé du nom commun/vernaculaire (en français)';
COMMENT ON COLUMN m_espace_vert.an_ev_vegetal_ref_bota.niv_allerg IS 'Niveau allergisant';
COMMENT ON CONSTRAINT an_ev_vegetal_ref_bota_pkey ON m_espace_vert.an_ev_vegetal_ref_bota IS 'Clé primaire de la classe an_ev_vegetal_ref_bota';


-- ################################################################# TABLE geo_ev_zone_site ###############################################

-- DROP TABLE m_espace_vert.geo_ev_zone_site;

CREATE TABLE m_espace_vert.geo_ev_zone_site
(
    idsite bigint NOT NULL DEFAULT nextval('m_espace_vert.geo_ev_zone_site_idsite_seq'::regclass),
    nom character varying(100),
    typ character varying(2),
    sup_m2 bigint,    
    geom geometry(MultiPolygon,2154),
    CONSTRAINT geo_ev_zone_site_pkey PRIMARY KEY (idsite)      
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_zone_site IS 'Table géographique des sites d''espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_site.idsite IS 'Identifiant du site';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_site.nom IS 'Nom du site';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_site.typ IS 'Type de site';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_site.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_site.geom IS 'Géométrie surfacique';
COMMENT ON CONSTRAINT geo_ev_zone_site_pkey ON m_espace_vert.geo_ev_zone_site IS 'Clé primaire de la classe geo_ev_zone_site';


-- ################################################################# TABLE geo_ev_zone_gestion ###############################################

-- DROP TABLE m_espace_vert.geo_ev_zone_gestion;

CREATE TABLE m_espace_vert.geo_ev_zone_gestion
(
    idgestion bigint NOT NULL DEFAULT nextval('m_espace_vert.geo_ev_zone_gestion_idgestion_seq'::regclass),
    nom character varying(100),
    gestion character varying(80),
    sup_m2 bigint,
    geom geometry(MultiPolygon,2154),
    CONSTRAINT geo_ev_zone_gestion_pkey PRIMARY KEY (idgestion)      
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_zone_gestion IS 'Table géographique des zones d''intervention des gestionnaires en espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_gestion.idgestion IS 'Identifiant du site';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_gestion.nom IS 'Nom de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_gestion.gestion IS 'Nom du gestionnaire';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_gestion.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_gestion.geom IS 'Géométrie surfacique';
COMMENT ON CONSTRAINT geo_ev_zone_gestion_pkey ON m_espace_vert.geo_ev_zone_gestion IS 'Clé primaire de la classe geo_ev_zone_gestion';


-- ################################################################# TABLE geo_ev_zone_equipe ###############################################

-- DROP TABLE m_espace_vert.geo_ev_zone_equipe;

CREATE TABLE m_espace_vert.geo_ev_zone_equipe
(
    idequipe bigint NOT NULL DEFAULT nextval('m_espace_vert.geo_ev_zone_equipe_idequipe_seq'::regclass),
    nom character varying(100),
    equipe character varying(80),
    sup_m2 bigint,
    geom geometry(MultiPolygon,2154),
    CONSTRAINT geo_ev_zone_equipe_pkey PRIMARY KEY (idequipe)      
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_zone_equipe IS 'Table géographique des secteurs d''intervention des equipes';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_equipe.idequipe IS 'Identifiant d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_equipe.nom IS 'Nom de la zone de equipe';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_equipe.equipe IS 'Nom du equipenaire';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_equipe.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_ev_zone_equipe.geom IS 'Géométrie surfacique';
COMMENT ON CONSTRAINT geo_ev_zone_equipe_pkey ON m_espace_vert.geo_ev_zone_equipe IS 'Clé primaire de la classe geo_ev_zone_equipe';



-- ################################################################# TABLE geo_ev_intervention_demande ###############################################

-- DROP TABLE m_espace_vert.geo_ev_intervention_demande;

CREATE TABLE m_espace_vert.geo_ev_intervention_demande
(
    idinter bigint NOT NULL DEFAULT nextval('m_espace_vert.geo_ev_intervention_idinter_seq'),
    objet_type varchar(3),
    inter_type varchar(254) DEFAULT '00000',
    src_demand varchar(2) DEFAULT '00',
    com_demand text,
    dat_souhai date,
    contr_adm boolean DEFAULT false,
    contr_com text,
    ress_affec integer, -- lien vers la table geo_ev_zone_equipe
    observ character varying(254),
    nb_jr_rapp integer,
    -- ajout d'un champ "iddemande" pour pouvoir faire une logique commune au niveau du trigger
    -- ce champ ne sera pas utilisé dans le trigger
    iddemande integer,
    -- ajout d'un champ "idequipe" pour la liaison avec un secteur d'équipe
    idequipe integer,
    -- récurrence
    recurrent boolean DEFAULT false,
    freq_value integer,
    freq_unite varchar(2) DEFAULT '00',
    dat_ref date,
    period_sta varchar(2) DEFAULT '00',
    period_end varchar(2) DEFAULT '00',
    --
    dat_sai timestamp without time zone DEFAULT now(),
    op_sai character varying(80),
    geom geometry(Polygon, 2154),
    CONSTRAINT geo_ev_intervention_demande_pkey PRIMARY KEY (idinter)    
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_intervention_demande IS 'Tables contenant les demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.objet_type IS 'Type d''objets';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.inter_type IS 'Type d''intervention';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.src_demand IS 'Source demande';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.com_demand IS 'Commentaire demande';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.dat_souhai IS 'Date d''intervention souhaitée';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.contr_adm IS 'Contraintes administratives';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.contr_com IS 'Commentaire sur contraintes adm.';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.ress_affec IS 'Équipe / Entreprise affectée';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.observ IS 'Observations';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.nb_jr_rapp IS 'Nb jours rappel';
-- récurrence
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.recurrent IS 'Demande d''intervention récurrente';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.freq_value IS 'Fréquence (valeur)';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.freq_unite IS 'Fréquence (unité)';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.dat_ref IS 'Date de référence';
--
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.dat_sai IS 'Date saisie';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention_demande.op_sai IS 'Auteur saisie';
--
COMMENT ON CONSTRAINT geo_ev_intervention_demande_pkey ON m_espace_vert.geo_ev_intervention_demande IS 'Clé primaire de la classe geo_ev_intervention_demande';



-- ################################################################# TABLE geo_ev_intervention ###############################################

-- DROP TABLE m_espace_vert.geo_ev_intervention;

CREATE TABLE m_espace_vert.geo_ev_intervention
(
    idinter bigint NOT NULL DEFAULT nextval('m_espace_vert.geo_ev_intervention_idinter_seq'),
    objet_type varchar(3),
    inter_type varchar(254) DEFAULT '00000',
    -- ajout d'un champ "idequipe" pour la liaison avec un secteur d'équipe
    idequipe integer,
    iddemande integer,
    inter_date date DEFAULT now(),
    ress_affec integer, -- lien vers la table geo_ev_zone_equipe
    statut varchar(2) DEFAULT '00',
    taches_eff text,
    observ character varying(254),
    notif_resp boolean DEFAULT true,
    -- récurrence
    nb_jr_rapp integer,
    recurrent boolean DEFAULT false,
    freq_value integer,
    freq_unite varchar(2) DEFAULT '00',
    dat_ref date,
    period_sta varchar(2) DEFAULT '00',
    period_end varchar(2) DEFAULT '00',
    --
    dat_sai timestamp without time zone DEFAULT now(),
    op_sai character varying(80),
    geom geometry(Polygon, 2154),
    CONSTRAINT geo_ev_intervention_pkey PRIMARY KEY (idinter)    
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.geo_ev_intervention IS 'Tables contenant les interventions';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.objet_type IS 'Type d''objets';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.inter_type IS 'Type d''intervention';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.iddemande IS 'Demande liée';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.inter_date IS 'Date d''intervention';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.ress_affec IS 'Équipe / Entreprise';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.statut IS 'Statut';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.taches_eff IS 'Liste des tâches effectuées';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.notif_resp IS 'Envoyer notification aux responsables EV ?';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.observ IS 'Observations';
-- récurrence
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.nb_jr_rapp IS 'Nb jours rappel';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.recurrent IS 'Intervention récurrente';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.freq_value IS 'Fréquence (valeur)';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.freq_unite IS 'Fréquence (unité)';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.dat_ref IS 'Date de référence';
--
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.dat_sai IS 'Date saisie';
COMMENT ON COLUMN m_espace_vert.geo_ev_intervention.op_sai IS 'Auteur saisie';
--
COMMENT ON CONSTRAINT geo_ev_intervention_pkey ON m_espace_vert.geo_ev_intervention IS 'Clé primaire de la classe geo_ev_intervention';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     LIAISON N-M                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- DROP TABLE m_espace_vert.lk_ev_intervention_objet;

CREATE TABLE m_espace_vert.lk_ev_intervention_objet
(
    idlk bigint NOT NULL DEFAULT nextval('m_espace_vert.lk_ev_intervention_objet_idlk_seq'::regclass),
    idinter bigint NOT NULL,
    idobjet bigint NOT NULL,
    CONSTRAINT lk_ev_intervention_objet_pkey PRIMARY KEY (idlk)  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.lk_ev_intervention_objet IS 'Table de relations N-M contenant la liaison entre les objets et les demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.lk_ev_intervention_objet.idlk IS 'Identifiant relation intervention<>objet';
COMMENT ON COLUMN m_espace_vert.lk_ev_intervention_objet.idinter IS 'Identifiant d''intervention';
COMMENT ON COLUMN m_espace_vert.lk_ev_intervention_objet.idobjet IS 'Identifiant d''objet';
COMMENT ON CONSTRAINT lk_ev_intervention_objet_pkey ON m_espace_vert.lk_ev_intervention_objet IS 'Clé primaire de la classe lk_ev_intervention_objet';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        MEDIA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Table: m_espace_vert.an_ev_media

-- DROP TABLE m_espace_vert.an_ev_media;

CREATE TABLE m_espace_vert.an_ev_media
(
    gid bigint NOT NULL DEFAULT nextval('m_espace_vert.an_ev_media_gid_seq'::regclass),
    idobjet bigint NOT NULL,
    media text,
    miniature bytea,
    n_fichier text,
    t_fichier text,
    op_sai character varying(100),
    date_sai timestamp without time zone,
    date_prise_vue timestamp without time zone,
    date_creation timestamp without time zone DEFAULT now(),
    CONSTRAINT an_ev_media_pkey PRIMARY KEY (gid)    
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_media IS 'Table gérant la liste des photos des objets Espace Vert (arbre notamment) avec le module média dans GEO (application Espace Vert V2)';
COMMENT ON COLUMN m_espace_vert.an_ev_media.gid IS 'Identifiant unique du média';
COMMENT ON COLUMN m_espace_vert.an_ev_media.idobjet IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_espace_vert.an_ev_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_espace_vert.an_ev_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_espace_vert.an_ev_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_espace_vert.an_ev_media.op_sai IS 'Libellé de l''opérateur ayant intégrer le document';
COMMENT ON COLUMN m_espace_vert.an_ev_media.date_sai IS 'Date d''intégration du document';



    
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        LOG                                                                   ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- Table: m_espace_vert.an_ev_log

-- DROP TABLE m_espace_vert.an_ev_log;

CREATE TABLE m_espace_vert.an_ev_log (
	idlog bigint NOT NULL DEFAULT nextval('m_espace_vert.an_ev_log_idlog_seq'::regclass),
	tablename character varying(80) NOT NULL,
	type_ope character varying(30) NOT NULL,
	dataold text,
	datanew text,
	date_maj timestamp DEFAULT now(),
  CONSTRAINT an_ev_log_pkey PRIMARY KEY (idlog)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_espace_vert.an_ev_log IS 'Table des opérations effectuées sur la base de données EV';
COMMENT ON COLUMN m_espace_vert.an_ev_log.idlog IS 'Identifiant de l''opération';
COMMENT ON COLUMN m_espace_vert.an_ev_log.tablename IS 'Nom de la table concernée par une opération';
COMMENT ON COLUMN m_espace_vert.an_ev_log.type_ope IS 'Type d''opération';
COMMENT ON COLUMN m_espace_vert.an_ev_log.dataold IS 'Valeurs anciennes';
COMMENT ON COLUMN m_espace_vert.an_ev_log.datanew IS 'Valeurs nouvelles';
COMMENT ON COLUMN m_espace_vert.an_ev_log.date_maj IS 'Horodatage de l''opération';




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                    CONTRAINTE                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- an_ev_objet
ALTER TABLE m_espace_vert.an_ev_objet
    ADD CONSTRAINT lt_ev_objet_typ1_fkey FOREIGN KEY (typ1)
        REFERENCES m_espace_vert.lt_ev_objet_typ1 (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_objet_typ2_fkey FOREIGN KEY (typ2)
        REFERENCES m_espace_vert.lt_ev_objet_typ2 (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_objet_typ3_fkey FOREIGN KEY (typ3)
        REFERENCES m_espace_vert.lt_ev_objet_typ3 (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,                
    ADD CONSTRAINT lt_ev_objet_etat_fkey FOREIGN KEY (etat)
        REFERENCES m_espace_vert.lt_ev_objet_etat (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_objet_doma_fkey FOREIGN KEY (doma)
        REFERENCES m_espace_vert.lt_ev_objet_doma (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_objet_qualdoma_fkey FOREIGN KEY (qualdoma)
        REFERENCES m_espace_vert.lt_ev_objet_qualdoma (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,      
    ADD CONSTRAINT geo_ev_zone_gestion_idgestion_fkey FOREIGN KEY (idgestion)
        REFERENCES m_espace_vert.geo_ev_zone_gestion(idgestion) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT geo_ev_zone_equipe_idequipe_fkey FOREIGN KEY (idequipe)
        REFERENCES m_espace_vert.geo_ev_zone_equipe(idequipe) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,         
    ADD CONSTRAINT geo_ev_zone_site_idsite_fkey FOREIGN KEY (idsite)
        REFERENCES m_espace_vert.geo_ev_zone_site(idsite) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,        
    ADD CONSTRAINT lt_src_geom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;


-- geo_ev_objet_pct
ALTER TABLE m_espace_vert.geo_ev_objet_pct
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
-- geo_ev_objet_line
ALTER TABLE m_espace_vert.geo_ev_objet_line
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
-- geo_ev_objet_polygon
ALTER TABLE m_espace_vert.geo_ev_objet_polygon
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
      
-- an_ev_vegetal
ALTER TABLE m_espace_vert.an_ev_vegetal
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_position_fkey FOREIGN KEY ("position")
        REFERENCES m_espace_vert.lt_ev_vegetal_position (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
        
-- an_ev_vegetal_arbre
ALTER TABLE m_espace_vert.an_ev_vegetal_arbre
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_hauteur_cl_fkey FOREIGN KEY (hauteur_cl)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_implant_fkey FOREIGN KEY (implant)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_implant (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_mode_conduite_fkey FOREIGN KEY (mode_cond)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_mode_conduite (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_date_plantation_saison_fkey FOREIGN KEY (date_pl_sa)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,                        
    ADD CONSTRAINT lt_ev_vegetal_arbre_periode_plantation_fkey FOREIGN KEY (periode_pl)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_periode_plantation (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_stade_dev_fkey FOREIGN KEY (stade_dev)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_stade_dev (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_sol_type_fkey FOREIGN KEY (sol_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_sol_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,  
    ADD CONSTRAINT lt_ev_vegetal_arbre_remarq_boolean_fkey FOREIGN KEY (remarq)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_proteg_boolean_fkey FOREIGN KEY (proteg)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,                
    ADD CONSTRAINT lt_ev_vegetal_arbre_contr_boolean_fkey FOREIGN KEY (contr)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_naiss_boolean_fkey FOREIGN KEY (naiss)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arbre_etatarbre_fkey FOREIGN KEY (etatarbre)
        REFERENCES m_espace_vert.lt_ev_vegetal_arbre_etatarbre (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
        

-- an_ev_vegetal_arbre_etat_sanitaire
ALTER TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_anomal_boolean_fkey FOREIGN KEY (anomal)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_surveil_boolean_fkey FOREIGN KEY (surveil)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;                 

-- an_ev_vegetal_arbuste_haie
ALTER TABLE m_espace_vert.an_ev_vegetal_arbuste_haie
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_haie_sai_type_fkey FOREIGN KEY (sai_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_haie_sai_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_haie_veget_type_fkey FOREIGN KEY (veget_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_haie_veget_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_haie_paillage_type_fkey FOREIGN KEY (paill_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_haie_paillage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,                 
    ADD CONSTRAINT lt_ev_vegetal_espace_type_fkey FOREIGN KEY (espac_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
                
-- an_ev_vegetal_arbuste_massif
ALTER TABLE m_espace_vert.an_ev_vegetal_arbuste_massif
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arrosage_type_fkey FOREIGN KEY (arros_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_espace_type_fkey FOREIGN KEY (espac_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_arros_auto_boolean_fkey FOREIGN KEY (arros_auto)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_inv_faunis_boolean_fkey FOREIGN KEY (inv_faunis)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
        
-- an_ev_vegetal_fleuri_massif
ALTER TABLE m_espace_vert.an_ev_vegetal_fleuri_massif
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arrosage_type_fkey FOREIGN KEY (arros_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_espace_type_fkey FOREIGN KEY (espac_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_arros_auto_boolean_fkey FOREIGN KEY (arros_auto)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_inv_faunis_boolean_fkey FOREIGN KEY (inv_faunis)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- an_ev_vegetal_herbe
ALTER TABLE m_espace_vert.an_ev_vegetal_herbe
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_arrosage_type_fkey FOREIGN KEY (arros_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_espace_type_fkey FOREIGN KEY (espac_type)
        REFERENCES m_espace_vert.lt_ev_vegetal_arrosage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_arros_auto_boolean_fkey FOREIGN KEY (arros_auto)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_inv_faunis_boolean_fkey FOREIGN KEY (inv_faunis)
        REFERENCES m_espace_vert.lt_ev_boolean (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;                             

-- an_ev_vegetal_ref_bota        
ALTER TABLE m_espace_vert.an_ev_vegetal_ref_bota
    ADD CONSTRAINT lt_ev_objet_typ2_fkey FOREIGN KEY (typ2)
        REFERENCES m_espace_vert.lt_ev_objet_typ2 (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_objet_typ3_fkey FOREIGN KEY (typ3)
        REFERENCES m_espace_vert.lt_ev_objet_typ3 (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_vegetal_niv_allerg_fkey FOREIGN KEY (niv_allerg)
        REFERENCES m_espace_vert.lt_ev_vegetal_niveau_allergisant (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;                                                 

-- geo_ev_zone_site 
ALTER TABLE m_espace_vert.geo_ev_zone_site
    ADD CONSTRAINT lt_ev_zone_site_type_fkey FOREIGN KEY (typ)
        REFERENCES m_espace_vert.lt_ev_zone_site_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- lt_ev_intervention_inter_type
ALTER TABLE m_espace_vert.lt_ev_intervention_inter_type
    ADD CONSTRAINT lt_ev_intervention_objet_type_fkey FOREIGN KEY (objet_type)
        REFERENCES m_espace_vert.lt_ev_intervention_objet_type(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- lk_ev_intervention_objet
ALTER TABLE m_espace_vert.lk_ev_intervention_objet
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    
-- vers inter ?

-- geo_ev_intervention_demande
ALTER TABLE m_espace_vert.geo_ev_intervention_demande
    ADD CONSTRAINT lt_ev_demande_intervention_objet_type_fkey FOREIGN KEY (objet_type)
        REFERENCES m_espace_vert.lt_ev_intervention_objet_type(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
/*  plus possible en multivarié
    ADD CONSTRAINT lt_ev_demande_intervention_inter_type_fkey FOREIGN KEY (inter_type)
        REFERENCES m_espace_vert.lt_ev_intervention_inter_type(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,   */
    ADD CONSTRAINT lt_ev_demande_intervention_src_demand_fkey FOREIGN KEY (src_demand)
        REFERENCES m_espace_vert.lt_ev_intervention_src_demand(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_demande_intervention_freq_unite_fkey FOREIGN KEY (freq_unite)
        REFERENCES m_espace_vert.lt_ev_intervention_freq_unite(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_demande_intervention_periode_sta_fkey FOREIGN KEY (period_sta)
        REFERENCES m_espace_vert.lt_ev_intervention_periode(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_demande_intervention_periode_end_fkey FOREIGN KEY (period_end)
        REFERENCES m_espace_vert.lt_ev_intervention_periode(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_demande_intervention_ress_affec_fkey FOREIGN KEY (ress_affec)
        REFERENCES m_espace_vert.geo_ev_zone_equipe(idequipe) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

-- geo_ev_intervention
ALTER TABLE m_espace_vert.geo_ev_intervention 
    ADD CONSTRAINT lt_ev_intervention_objet_type_fkey FOREIGN KEY (objet_type)
        REFERENCES m_espace_vert.lt_ev_intervention_objet_type(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
/*  plus possible en multivarié
     ADD CONSTRAINT lt_ev_intervention_inter_type_fkey FOREIGN KEY (inter_type)
        REFERENCES m_espace_vert.lt_ev_intervention_inter_type(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,   */
    ADD CONSTRAINT lt_ev_intervention_statut_fkey FOREIGN KEY (statut)
        REFERENCES m_espace_vert.lt_ev_intervention_statut(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_intervention_freq_unite_fkey FOREIGN KEY (freq_unite)
        REFERENCES m_espace_vert.lt_ev_intervention_freq_unite(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_intervention_periode_sta_fkey FOREIGN KEY (period_sta)
        REFERENCES m_espace_vert.lt_ev_intervention_periode(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_intervention_periode_end_fkey FOREIGN KEY (period_end)
        REFERENCES m_espace_vert.lt_ev_intervention_periode(code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION,
    ADD CONSTRAINT lt_ev_intervention_ress_affec_fkey FOREIGN KEY (ress_affec)
        REFERENCES m_espace_vert.geo_ev_zone_equipe(idequipe) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- an_ev_media
ALTER TABLE m_espace_vert.an_ev_media
    ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet)
        REFERENCES m_espace_vert.an_ev_objet (idobjet) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       INDEX                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- an_ev_objet
CREATE INDEX an_ev_objet_insee_idx ON m_espace_vert.an_ev_objet USING btree (insee);
CREATE INDEX an_ev_objet_typ1_idx ON m_espace_vert.an_ev_objet USING btree (typ1);
CREATE INDEX an_ev_objet_typ2_idx ON m_espace_vert.an_ev_objet USING btree (typ2);
CREATE INDEX an_ev_objet_typ3_idx ON m_espace_vert.an_ev_objet USING btree (typ3);
CREATE INDEX an_ev_objet_etat_idx ON m_espace_vert.an_ev_objet USING btree (etat);
CREATE INDEX an_ev_objet_doman_idx ON m_espace_vert.an_ev_objet USING btree (doma);
CREATE INDEX an_ev_objet_qualdoma_idx ON m_espace_vert.an_ev_objet USING btree (qualdoma);
-- idequipe
-- srg_geom


-- geo_ev_objet_line
CREATE INDEX geo_ev_objet_line_geom_idx ON m_espace_vert.geo_ev_objet_line USING gist (geom);
CREATE INDEX geo_ev_objet_line_idobjet_idx ON m_espace_vert.geo_ev_objet_line USING btree (idobjet);
-- geo_ev_objet_pct
CREATE INDEX geo_ev_objet_pct_geom_idx ON m_espace_vert.geo_ev_objet_pct USING gist (geom);
CREATE INDEX geo_ev_objet_pct_idobjet_idx ON m_espace_vert.geo_ev_objet_pct USING btree (idobjet);
-- geo_ev_objet_polygon
CREATE INDEX geo_ev_objet_polygon_geom_idx ON m_espace_vert.geo_ev_objet_polygon USING gist (geom);
CREATE INDEX geo_ev_objet_polygon_idobjet_idx ON m_espace_vert.geo_ev_objet_polygon USING btree (idobjet);

-- an_ev_vegetal
CREATE INDEX an_ev_vegetal_idobjet_idx ON m_espace_vert.an_ev_vegetal USING btree (idobjet);
CREATE INDEX an_ev_vegetal_position_idx ON m_espace_vert.an_ev_vegetal USING btree ("position");

-- an_ev_vegetal_arbre
CREATE INDEX an_ev_vegetal_arbre_idobjet_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (idobjet);
CREATE INDEX an_ev_vegetal_arbre_hauteur_cl_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (hauteur_cl);
CREATE INDEX an_ev_vegetal_arbre_implant_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (implant);
CREATE INDEX an_ev_vegetal_arbre_mode_cond_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (mode_cond);
CREATE INDEX an_ev_vegetal_arbre_date_pl_sa_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (date_pl_sa);
CREATE INDEX an_ev_vegetal_arbre_periode_pl_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (periode_pl);
CREATE INDEX an_ev_vegetal_arbre_stade_dev_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (stade_dev);
CREATE INDEX an_ev_vegetal_arbre_sol_type_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (sol_type);
CREATE INDEX an_ev_vegetal_arbre_amena_pied_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (amena_pied);
CREATE INDEX an_ev_vegetal_arbre_remarq_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (remarq);
CREATE INDEX an_ev_vegetal_arbre_proteg_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (proteg);
CREATE INDEX an_ev_vegetal_arbre_contr_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (contr);
CREATE INDEX an_ev_vegetal_arbre_naiss_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (naiss);
CREATE INDEX an_ev_vegetal_arbre_etatarbre_idx ON m_espace_vert.an_ev_vegetal_arbre USING btree (etatarbre);

-- an_ev_vegetal_arbre_etat_sanitaire
CREATE INDEX an_ev_vegetal_arbre_etat_sanitaire_idobjet_idx ON m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire USING btree (idobjet);
CREATE INDEX an_ev_vegetal_arbre_etat_sanitaire_anomal_typ_idx ON m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire USING btree (anomal_typ);
CREATE INDEX an_ev_vegetal_arbre_etat_sanitaire_anomal_idx ON m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire USING btree (anomal);
CREATE INDEX an_ev_vegetal_arbre_etat_sanitaire_surveil_idx ON m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire USING btree (surveil);

-- an_ev_vegetal_arbuste_haie
CREATE INDEX an_ev_vegetal_arbuste_haie_idobjet_idx ON m_espace_vert.an_ev_vegetal_arbuste_haie USING btree (idobjet);
CREATE INDEX an_ev_vegetal_arbuste_haie_sai_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_haie USING btree (sai_type);
CREATE INDEX an_ev_vegetal_arbuste_haie_veget_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_haie USING btree (veget_type);
CREATE INDEX an_ev_vegetal_arbuste_haie_paill_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_haie USING btree (paill_type);
CREATE INDEX an_ev_vegetal_arbuste_haie_espac_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_haie USING btree (espac_type);

-- an_ev_vegetal_arbuste_massif
CREATE INDEX an_ev_vegetal_arbuste_massif_idobjet_idx ON m_espace_vert.an_ev_vegetal_arbuste_massif USING btree (idobjet);
CREATE INDEX an_ev_vegetal_arbuste_massif_arros_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_massif USING btree (arros_type);
CREATE INDEX an_ev_vegetal_arbuste_massif_espac_type_idx ON m_espace_vert.an_ev_vegetal_arbuste_massif USING btree (espac_type);
CREATE INDEX an_ev_vegetal_arbuste_massif_arros_auto_idx ON m_espace_vert.an_ev_vegetal_arbuste_massif USING btree (arros_auto);
CREATE INDEX an_ev_vegetal_arbuste_massif_inv_faunis_idx ON m_espace_vert.an_ev_vegetal_arbuste_massif USING btree (inv_faunis);

-- an_ev_vegetal_fleuri_massif
CREATE INDEX an_ev_vegetal_fleuri_massif_idobjet_idx ON m_espace_vert.an_ev_vegetal_fleuri_massif USING btree (idobjet);
CREATE INDEX an_ev_vegetal_fleuri_massif_arros_type_idx ON m_espace_vert.an_ev_vegetal_fleuri_massif USING btree (arros_type);
CREATE INDEX an_ev_vegetal_fleuri_massif_espac_type_idx ON m_espace_vert.an_ev_vegetal_fleuri_massif USING btree (espac_type);
CREATE INDEX an_ev_vegetal_fleuri_massif_arros_auto_idx ON m_espace_vert.an_ev_vegetal_fleuri_massif USING btree (arros_auto);
CREATE INDEX an_ev_vegetal_fleuri_massif_inv_faunis_idx ON m_espace_vert.an_ev_vegetal_fleuri_massif USING btree (inv_faunis);

-- an_ev_vegetal_herbe 
CREATE INDEX an_ev_vegetal_herbe_idobjet_idx ON m_espace_vert.an_ev_vegetal_herbe USING btree (idobjet);
CREATE INDEX an_ev_vegetal_herbe_arros_type_idx ON m_espace_vert.an_ev_vegetal_herbe USING btree (arros_type);
CREATE INDEX an_ev_vegetal_herbe_espac_type_idx ON m_espace_vert.an_ev_vegetal_herbe USING btree (espac_type);
CREATE INDEX an_ev_vegetal_herbe_arros_auto_idx ON m_espace_vert.an_ev_vegetal_herbe USING btree (arros_auto);
CREATE INDEX an_ev_vegetal_herbe_inv_faunis_idx ON m_espace_vert.an_ev_vegetal_herbe USING btree (inv_faunis);

-- an_ev_vegetal_ref_bota
CREATE INDEX an_ev_vegetal_ref_bota_typ2_idx ON m_espace_vert.an_ev_vegetal_ref_bota USING btree (typ2);
CREATE INDEX an_ev_vegetal_ref_bota_typ3_idx ON m_espace_vert.an_ev_vegetal_ref_bota USING btree (typ3);
CREATE INDEX an_ev_vegetal_ref_bota_niv_allerg_idx ON m_espace_vert.an_ev_vegetal_ref_bota USING btree (niv_allerg);

-- geo_ev_zone_site
CREATE INDEX geo_ev_zone_site_geom_idx ON m_espace_vert.geo_ev_zone_site USING gist (geom);

-- geo_ev_intervention_demande
CREATE INDEX geo_ev_intervention_demande_geom_idx ON m_espace_vert.geo_ev_intervention_demande USING gist (geom);
-- geo_ev_intervention
CREATE INDEX geo_ev_intervention_geom_idx ON m_espace_vert.geo_ev_intervention USING gist (geom);

-- an_ev_media
-- utile si contrainte pkey définie ? CREATE INDEX an_ev_media_gid_idx ON m_espace_vert.an_ev_media USING btree (gid ASC NULLS LAST);
CREATE INDEX an_ev_media_idobjet_idx ON m_espace_vert.an_ev_media USING btree (idobjet ASC NULLS LAST);




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        VUE                                                                   ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### VUE geo_v_ev_vegetal_arbre ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position",     
-- an_ev_vegetal_arbre    
    a.famille,
    a.genre,
    a.espece,
    a.cultivar,
    a.nomlatin,
    a.nomcommun,
    a.niv_allerg,        
    a.hauteur_cl,
    a.circonf,
    a.diam_houpp,    
    a.implant,
    a.mode_cond,   
    a.date_pl_an,
    a.date_pl_sa,
    a.periode_pl,
    a.stade_dev,
    a.sol_type,
    a.amena_pied,       
    a.remarq,
    a.remarq_com,
    a.proteg,
    a.proteg_com,
    a.contr,
    a.contr_type,
    a.naiss,     
    a.naiss_com,           
    a.etatarbre  
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbre a ON o.idobjet = a.idobjet
     LEFT JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '111';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre IS 'Vue arbres';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre."position" IS 'Position des objets';
-- an_ev_vegetal_arbre
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idobjet IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.famille IS 'Nom de la famille de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.genre IS 'Nom du genre de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.espece IS 'Nom de l''espèce de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.cultivar IS 'Nom du cultivar de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.nomlatin IS 'Libellé scientifique complet du nom de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.nomcommun IS 'Libellé du nom commun/vernaculaire de l''arbre (en français)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.niv_allerg IS 'Niveau allergisant';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.hauteur_cl IS 'Classe de hauteur de l''arbre en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.circonf IS 'Circonférence du tronc en centimètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.diam_houpp IS 'Diamètre houppier en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.implant IS 'Type d''implantation de l''arbre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.mode_cond IS 'Mode de conduite, assimilé à « port de taille » ou forme taillée';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_pl_an IS 'Date de plantation (année)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_pl_sa IS 'Date de plantation (saison)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.periode_pl IS 'Période de plantation approx. (Décennie)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.stade_dev IS 'Stade de développement';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.sol_type IS 'Type de sol';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.amena_pied IS 'Aménagement pied de l''arbre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.remarq IS 'Arbre remarquable (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.remarq_com IS 'Commentaires arbre remarquable';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.proteg IS 'Arbre protégé (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.proteg_com IS 'Commentaires arbre protégé';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.contr IS 'Contrainte (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.contr_type IS 'Type(s) de contrainte(s)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.naiss IS 'Programme naissance (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.naiss_com IS 'Commentaire arbre du programme naissance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.etatarbre IS 'Etat de l''arbre';



-- #################################################################### VUE geo_v_ev_vegetal_arbre_alignement ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre_alignement

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_vegetal
    v."position"    
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '112';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement IS 'Vue arbres d''alignement';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement."position" IS 'Position des objets';


-- #################################################################### VUE geo_v_ev_vegetal_arbre_bois ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre_bois

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position"    
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '113';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois IS 'Vue zones boisées';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois."position" IS 'Position des objets';



-- #################################################################### VUE geo_v_ev_vegetal_arbuste ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position"     
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '121';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste IS 'Vue des arbustes';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste."position" IS 'Position des objets';


-- #################################################################### geo_v_ev_vegetal_arbuste_haie ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste_haie

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_objet_line_largeur
    l.larg_cm,    
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_arbuste_haie 
    h.sai_type,
    h.veget_type,
    h.hauteur,
    h.espac_type,
    h.surface,
    h.paill_type,
    h.biodiv
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     LEFT JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbuste_haie h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '122';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie IS 'Vue des haies arbustives';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.larg_cm IS 'Largeur des objets en cm';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie."position" IS 'Position des objets';
--
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.sai_type IS 'Type de saisie de l''objet linéaire haie';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.veget_type IS 'Type végétation';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.hauteur IS 'Hauteur';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.surface IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.paill_type IS 'Type de paillage';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.biodiv IS 'Biodiversité';


-- #################################################################### geo_v_ev_vegetal_arbuste_massif ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste_massif

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_arbuste_massif
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbuste_massif h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '123';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif IS 'Vue des massifs arbustifs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif."position" IS 'Position des objets';
-- an_ev_veget_arbuste_massif
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### VUE geo_v_ev_vegetal_fleuri ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_fleuri

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_fleuri;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_fleuri
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position"     
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '131';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_fleuri IS 'Vue des points fleuris';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri."position" IS 'Position des objets';


-- #################################################################### geo_v_ev_vegetal_fleuri_massif ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_fleuri_massif

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_fleuri_massif
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_fleuri_massif h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '132';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif IS 'Vue des massifs fleuris';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif."position" IS 'Position des objets';
-- an_ev_veget_fleuri_massif
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### geo_v_ev_vegetal_herbe ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_herbe

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_herbe;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_herbe
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_herbe
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_herbe h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '141';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_herbe IS 'Vue des espaces enherbés';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe."position" IS 'Position des objets';
-- an_ev_veget_herbe
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### geo_v_ev_mineral_circulation_voie ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_circulation_voie

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_objet_line_largeur
    l.larg_cm    
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet
  WHERE o.typ2 = '21';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie IS 'Vue des voies de circulation';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.larg_cm IS 'Largeur des objets en cm';


-- #################################################################### geo_v_ev_mineral_circulation_zone ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_circulation_zone

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '21';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone IS 'Vue des zones de circulation';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_mineral_cloture ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_cloture

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_cloture;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_cloture
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '22';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_cloture IS 'Vue des clotures';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_mineral_loisir_equipement ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_loisir_equipement

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '23';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_mineral_loisir_zone ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_loisir_zone

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '23';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone IS 'Vue des zones de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.geom IS 'Géométrie des objets espaces verts';

-- #################################################################### VUE geo_v_ev_hydro_eau_arrivee ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_arrivee

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '31';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_hydro_eau_point ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_point

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_point;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_point
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_point IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_hydro_eau_cours ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_cours

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_cours;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_cours
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,   
-- an_ev_objet_line_largeur
    l.larg_cm    
--     
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet     
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_cours IS 'Vue des références non classées de type linéaire';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.larg_cm IS 'Largeur des objets en cm';


-- #################################################################### geo_v_ev_hydro_eau_etendue ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_etendue

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue IS 'Vue des références non classées de type polygone';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_refnonclassee_point ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_point

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_point;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_point
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_point IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_refnonclassee_line ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_line

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_line
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_line IS 'Vue des références non classées de type linéaire';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_refnonclassee_polygon ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_polygon

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon IS 'Vue des références non classées de type polygone';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.geom IS 'Géométrie des objets espaces verts';


-- ## vue objets par type de geométrie


-- #################################################################### VUE geo_v_ev_objet_pct ###############################################

-- View: m_espace_vert.geo_v_ev_objet_pct

-- DROP VIEW m_espace_vert.geo_v_ev_objet_pct;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_pct
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_pct IS 'Vue des objets EV de type point';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.geom IS 'Géométrie des objets espaces verts';



-- #################################################################### VUE geo_v_ev_objet_line ###############################################

-- View: m_espace_vert.geo_v_ev_objet_line

-- DROP VIEW m_espace_vert.geo_v_ev_objet_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_line
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom  
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_line IS 'Vue des objets EV de type line';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_objet_polygon ###############################################

-- View: m_espace_vert.geo_v_ev_objet_polygon

-- DROP VIEW m_espace_vert.geo_v_ev_objet_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_polygon
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom   
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_polygon IS 'Vue des objets EV de type polygon';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.geom IS 'Géométrie des objets espaces verts';



-- #################################################################### VUE an_v_lt_ev_objet_typ123 ###############################################

-- View: m_espace_vert.an_v_lt_ev_objet_typ123

-- DROP VIEW m_espace_vert.an_v_lt_ev_objet_typ123;

CREATE OR REPLACE VIEW m_espace_vert.an_v_lt_ev_objet_typ123
 AS
 SELECT row_number() OVER () AS id,
    t1.code AS code_t1,
    t1.valeur AS valeur_t1,
    t2.code AS code_t2,
    t2.valeur AS valeur_t2,
    t3.code AS code_t3,
    t3.valeur AS valeur_t3
   FROM m_espace_vert.lt_ev_objet_typ1 t1
     LEFT JOIN m_espace_vert.lt_ev_objet_typ2 t2 ON t1.code::text = "left"(t2.code::text, 1)
     LEFT JOIN m_espace_vert.lt_ev_objet_typ3 t3 ON t2.code::text = "left"(t3.code::text, 2);






-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     FONCTION                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### FONCTION DATE RAPPEL ###############################################

-- à partir d'une date de référence, récupérer la prochaine date anniversaire
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_intervention_get_next_date_rappel(_date_ref date, _freq_value integer, _freq_unit text, _nb_jr_rapp integer, _period_start text, _period_end text)  RETURNS date LANGUAGE plpgsql AS $$
  DECLARE next_date date;
  -- valeur Postgresql utilisable dans un interval : jour -> days, Semaines -> weeks
  DECLARE _freq_unit_pg text;
  -- les mois sont codes à partir de 0 dans la donnée, depuis 1 dans PG
  DECLARE _month_start_pg integer := _period_start::integer + 1;
  DECLARE _month_end_pg integer := _period_end::integer + 1;
BEGIN
  -- transformer la valeur de l'unité en unité PG
  _freq_unit_pg := (
  CASE _freq_unit
    WHEN '01' THEN 'days'
    WHEN '02' THEN 'weeks'
    WHEN '03' THEN 'months'
    WHEN '04' THEN 'years'
  ELSE 
  'days' 
  END); 
  
  next_date := (
    with dates_anniv as (
      select _date_ref + incr * (_freq_value || ' ' || _freq_unit_pg)::interval - ('' || _nb_jr_rapp || ' days')::interval as date_anniv
      -- note: ici on prévoit les 10000 prochains anniversaire. Augmenter cette valeur a un impact sur la performance de la requête
      from pg_catalog.generate_series(0, 10000, 1) incr
    )
    select date_anniv 
      from dates_anniv 
      WHERE 
        -- à partir de maintenant (ne pas tenir compte des anniversaires passés)
        date_anniv >= now() 
        -- entre les mois indiqués
        AND EXTRACT(MONTH from date_anniv) BETWEEN _month_start_pg AND _month_end_pg
      limit 1);
  return next_date;
END;
$$
;


-- #################################################################### FONCTION GENERIQUE ###############################################

-- fonction pour gérer les attributs communs (méta + geo) à l'ensemble des objets de la base espaces verts (végétal, minéral, hydro et non reférencé)

--CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_process_generic_info(TG_OP text, TG_TABLE_NAME text, _geom geometry, _idobjet integer,
--_data_old text, _data_new text, _observ text, _position text, _op_sai text, _op_maj text, _typ2 text, _typ3 text) RETURNS void LANGUAGE plpgsql AS $$

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_process_generic_info(TG_OP text, TG_TABLE_NAME text, _geom geometry, _idobjet integer,
_data_old text, _data_new text, _observ text, _op_sai text, _op_maj text, _typ1 text, _typ2 text, _typ3 text) RETURNS void LANGUAGE plpgsql AS $$

  DECLARE _insee text;
  DECLARE _commune text;
  DECLARE _quartier text;
  DECLARE _idgestion integer;
  DECLARE _idsite integer;
  DECLARE _idequipe integer;

  DECLARE _geometry_type text := ST_GeometryType(_geom);
BEGIN
  -- traitements communs INSERT / UPDATE
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    -- récupération automatique INSEE / commune
    _insee := (SELECT insee FROM r_osm.geo_vm_osm_commune_arcba WHERE ST_Intersects(geom,_geom) LIMIT 1);
		_commune := (SELECT commune FROM r_osm.geo_vm_osm_commune_arcba WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- Lors de la saisie dun arbre, EV ou intervention, un message doit safficher lorsque la localisation ne se trouve pas dans zone « Commune » ou « Intercommunalité ».
    IF _insee IS NULL THEN
		  RAISE EXCEPTION 'Erreur : L''objet ne se situe pas dans une commune de l''ARC.<br><br>';
    END IF;
    -- récupération découpage adm (à remplacer par champs calculés ?)
    -- quartier
    _quartier := (SELECT nom FROM r_administratif.geo_adm_quartier WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- zone de gestion
    _idgestion := (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- site EV
    _idsite := (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- site EV
    _idequipe := (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(geom,_geom) LIMIT 1);
  END IF;

  IF (TG_OP = 'INSERT') THEN
    -- On insère les données meta, avec une date de mise à jour des données = NULL.
    INSERT INTO m_espace_vert.an_ev_objet
      (idobjet, 
      idgestion, idsite, idequipe, 
      insee, commune, 
      quartier, doma, qualdoma, 
      typ1, typ2, typ3, 
      op_sai, date_sai, 
      src_geom, src_date, 
      op_att, 
      date_maj_att, date_maj, 
      observ, etat)
      VALUES
      (_idobjet, 
      _idgestion, _idsite, _idequipe, 
      _insee, _commune, 
        _quartier, '00', '00', 
        _typ1, _typ2, _typ3, 
        _op_sai, now(), 
        '20', '2018', 
        _op_sai, 
        NULL, NULL, 
        _observ, '2');

    -- INSERTion de la géométrie
    if _geometry_type = 'ST_Point' THEN
      INSERT INTO m_espace_vert.geo_ev_objet_pct (idobjet, geom) VALUES (_idobjet, _geom);
    ELSIF _geometry_type = 'ST_LineString' THEN
      INSERT INTO m_espace_vert.geo_ev_objet_line (idobjet, geom) VALUES (_idobjet, _geom);
    ELSIF _geometry_type = 'ST_Polygon' THEN
      INSERT INTO m_espace_vert.geo_ev_objet_polygon (idobjet, geom) VALUES (_idobjet, _geom);
    ELSE
      RAISE EXCEPTION 'Type de géométrie inconnu %', _geometry_type ;
    END IF;

     --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename, type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);

  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ données meta
    UPDATE m_espace_vert.an_ev_objet SET 
      typ3 = _typ3,
      idgestion = _idgestion, 
      idsite = _idsite,
      idequipe = _idequipe,
      insee = _insee,
      commune = _commune,
      quartier = _quartier,
      date_maj = now(),
      date_maj_att = now(),
      observ = _observ,
      op_sai = coalesce(op_sai, _op_sai),
      op_maj = _op_maj
    WHERE idobjet = _idobjet;

    -- MAJ de la géométrie
    if _geometry_type = 'ST_Point' THEN
      UPDATE m_espace_vert.geo_ev_objet_pct SET geom = _geom WHERE idobjet = _idobjet;
    ELSIF _geometry_type = 'ST_LineString' THEN
      UPDATE m_espace_vert.geo_ev_objet_line SET geom = _geom WHERE idobjet = _idobjet;
    ELSIF _geometry_type = 'ST_Polygon' THEN
      UPDATE m_espace_vert.geo_ev_objet_polygon SET geom = _geom WHERE idobjet = _idobjet;
    ELSE
      RAISE EXCEPTION 'Type de géométrie inconnu %', _geometry_type ;
    END IF;

    --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename,  type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);
    
  ELSIF (TG_OP = 'DELETE') THEN
    -- passage à l'état supprimé
    UPDATE m_espace_vert.an_ev_objet --- En cas de suppression on change juste l'état de l'objet
    SET	etat = '3'
    WHERE idobjet = _idobjet;

    --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename,  type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);
  END IF;
END;
$$
;


-- #################################################################### FONCTION/TRIGGER arbre ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
    -- Lors de la saisie dun arbre, afficher un message davertissement dans la fiche si sa localisation se trouve à moins de 50cm dun autre arbre, afin déviter la saisie de doublons.
    IF (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre WHERE ST_DWithin(NEW.geom,geom, 0.5) AND etat <> '3' )  THEN
      RAISE EXCEPTION 'Erreur : Un arbre existe déjà à moins de 50cm de cette position.<br><br>';
    END IF;
  END IF;

  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '111');
  --  
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbre
    (idobjet, famille, genre, espece, cultivar, nomlatin, nomcommun, niv_allerg,
    hauteur_cl, circonf, diam_houpp, implant, mode_cond, date_pl_an, date_pl_sa, periode_pl, stade_dev, sol_type, amena_pied,
    remarq, remarq_com, proteg, proteg_com, contr, contr_type, naiss, naiss_com, etatarbre)
    VALUES
    (_idobjet, NEW.famille, NEW.genre, NEW.espece, NEW.cultivar, NEW.nomlatin, NEW.nomcommun, CASE WHEN NEW.niv_allerg IS NULL THEN '00' ELSE NEW.niv_allerg END,
-- proprio
    CASE WHEN NEW.hauteur_cl IS NULL THEN '00' ELSE NEW.hauteur_cl END,
    NEW.circonf,
    NEW.diam_houpp,    
-- implant est déduit uniquement dans le cas où l'utilisateur ne le renseigne pas ('00' OU NULL)
    CASE WHEN NEW.implant IN ('01','02','03') THEN NEW.implant WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_alignement b WHERE b.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),b.geom)) THEN '02' WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_bois c WHERE c.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),c.geom)) THEN '03' ELSE '00' END,
    CASE WHEN NEW.mode_cond IS NULL THEN '00' ELSE NEW.mode_cond END,   
-- historique
    NEW.date_pl_an, 
    CASE WHEN NEW.date_pl_sa IS NULL THEN '00' ELSE NEW.date_pl_sa END, 
    CASE WHEN NEW.periode_pl IS NULL THEN '00' ELSE NEW.periode_pl END, 
    CASE WHEN NEW.stade_dev IS NULL THEN '00' ELSE NEW.stade_dev END, 
-- divers
    CASE WHEN NEW.sol_type IS NULL THEN '00' ELSE NEW.sol_type END,
    CASE WHEN NEW.amena_pied IS NULL THEN '00' ELSE NEW.amena_pied END,
--
    CASE WHEN NEW.remarq IS NULL THEN '0' ELSE NEW.remarq END,
    CASE WHEN NEW.remarq ='t' THEN NEW.remarq_com ELSE NULL END,
    CASE WHEN NEW.proteg IS NULL THEN '0' ELSE NEW.proteg END,
    CASE WHEN NEW.proteg ='t' THEN NEW.proteg_com ELSE NULL END,
    CASE WHEN NEW.contr IS NULL THEN '0' ELSE NEW.contr END,
    CASE WHEN NEW.contr ='t' THEN NEW.contr_type ELSE NULL END,
    CASE WHEN NEW.naiss IS NULL THEN '0' ELSE NEW.naiss END,     
    CASE WHEN NEW.naiss ='t' THEN NEW.naiss_com ELSE NULL END,
    CASE WHEN NEW.etatarbre IS NULL THEN '00' ELSE NEW.etatarbre END);     
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;  
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbre SET
-- dico botanique    
    famille = NEW.famille,
    genre = NEW.genre,
    espece = NEW.espece,
    cultivar = NEW.cultivar,
    nomlatin = NEW.nomlatin,
    nomcommun = NEW.nomcommun,
    niv_allerg = CASE WHEN NEW.niv_allerg IS NULL THEN '00' ELSE NEW.niv_allerg END,        
-- proprio
    hauteur_cl = CASE WHEN NEW.hauteur_cl IS NULL THEN '00' ELSE NEW.hauteur_cl END,
    circonf = NEW.circonf,
    diam_houpp = NEW.diam_houpp,    
-- implant est déduit uniquement dans le cas où l'utilisateur ne le renseigne pas ('00' OU NULL)
    implant = CASE WHEN NEW.implant IN ('01','02','03') THEN NEW.implant WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_alignement b WHERE b.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),b.geom)) THEN '02' WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_bois c WHERE c.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),c.geom)) THEN '03' ELSE '00' END,
    mode_cond = CASE WHEN NEW.mode_cond IS NULL THEN '00' ELSE NEW.mode_cond END,   
-- historique
    date_pl_an = NEW.date_pl_an, 
    date_pl_sa = CASE WHEN NEW.date_pl_sa IS NULL THEN '00' ELSE NEW.date_pl_sa END, 
    periode_pl = CASE WHEN NEW.periode_pl IS NULL THEN '00' ELSE NEW.periode_pl END, 
    stade_dev = CASE WHEN NEW.stade_dev IS NULL THEN '00' ELSE NEW.stade_dev END, 
-- divers
    sol_type = CASE WHEN NEW.sol_type IS NULL THEN '00' ELSE NEW.sol_type END,
    amena_pied = CASE WHEN NEW.amena_pied IS NULL THEN '00' ELSE NEW.amena_pied END,
--
    remarq = CASE WHEN NEW.remarq IS NULL THEN '0' ELSE NEW.remarq END,
    remarq_com = CASE WHEN NEW.remarq ='t' THEN NEW.remarq_com ELSE NULL END,
    proteg = CASE WHEN NEW.proteg IS NULL THEN '0' ELSE NEW.proteg END,
    proteg_com = CASE WHEN NEW.proteg ='t' THEN NEW.proteg_com ELSE NULL END,
    contr = CASE WHEN NEW.contr IS NULL THEN '0' ELSE NEW.contr END,
    contr_type = CASE WHEN NEW.contr ='t' THEN NEW.contr_type ELSE NULL END,
    naiss = CASE WHEN NEW.naiss IS NULL THEN '0' ELSE NEW.naiss END,     
    naiss_com = CASE WHEN NEW.naiss ='t' THEN NEW.naiss_com ELSE NULL END,
    etatarbre = CASE WHEN NEW.etatarbre IS NULL THEN '00' ELSE NEW.etatarbre END      
    WHERE idobjet = NEW.idobjet;    
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;       
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
-- voir pour cas arbre supprimé (etatarbre) 
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre ON m_espace_vert.geo_v_ev_vegetal_arbre;
CREATE TRIGGER t_m_ev_vegetal_arbre INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre();


-- #################################################################### FONCTION/TRIGGER arbre_alignement ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_alignement() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '112');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux    
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre_alignement ON m_espace_vert.geo_v_ev_vegetal_arbre_alignement;
CREATE TRIGGER t_m_ev_vegetal_arbre_alignement INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre_alignement
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre_alignement();


-- #################################################################### FONCTION/TRIGGER ZONE BOISEE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_bois() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '113');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre_bois ON m_espace_vert.geo_v_ev_vegetal_arbre_bois;
CREATE TRIGGER t_m_ev_vegetal_arbre_bois INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre_bois
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre_bois();


-- #################################################################### FONCTION/TRIGGER arbuste ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '121');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
 
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux     
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbuste ON m_espace_vert.geo_v_ev_vegetal_arbuste;
CREATE TRIGGER t_m_ev_vegetal_arbuste INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste();


-- #################################################################### FONCTION/TRIGGER haie ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_haie() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '122');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbuste_haie
    (idobjet, 
    veget_type,
    hauteur, espac_type, paill_type, biodiv)
    VALUES
    (_idobjet, 
    NEW.veget_type,
    NEW.hauteur, NEW.espac_type, 
    NEW.paill_type, NEW.biodiv);
    -- INSERTion des attributs des EV végétaux      
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbuste_haie SET
    veget_type = NEW.veget_type,
    hauteur = NEW.hauteur, 
    espac_type = NEW.espac_type, 
    paill_type = NEW.paill_type, 
    biodiv = NEW.biodiv 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux      
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;    

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_haie ON m_espace_vert.geo_v_ev_vegetal_arbuste_haie;
CREATE TRIGGER t_m_ev_vegetal_haie INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste_haie
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste_haie();


-- #################################################################### FONCTION/TRIGGER arbuste_massif ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_massif() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '123');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbuste_massif
    (idobjet,
    espac_type, arros_type, 
    arros_auto, biodiv, inv_faunis)
    VALUES
    (_idobjet,
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;    
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbuste_massif SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;     

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbuste_massif ON m_espace_vert.geo_v_ev_vegetal_arbuste_massif;
CREATE TRIGGER t_m_ev_vegetal_arbuste_massif INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste_massif 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste_massif();


-- #################################################################### FONCTION/TRIGGER fleuri ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '131');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux   
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_fleuri ON m_espace_vert.geo_v_ev_vegetal_fleuri;
CREATE TRIGGER t_m_ev_vegetal_fleuri INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_fleuri 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_fleuri();


-- #################################################################### FONCTION/TRIGGER fleuri_massif ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri_massif() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '132');

  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_fleuri_massif
    (idobjet, 
    espac_type, arros_type, 
    arros_auto, biodiv, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_fleuri_massif SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_fleuri_massif ON m_espace_vert.geo_v_ev_vegetal_fleuri_massif;
CREATE TRIGGER t_m_ev_vegetal_fleuri_massif INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_fleuri_massif 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_fleuri_massif();


-- #################################################################### FONCTION/TRIGGER vegetal_herbe ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_herbe() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '14', '141');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_herbe
    (idobjet, 
    espac_type, arros_type, arros_auto, 
    biodiv, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_herbe SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

--DROP TRIGGER IF EXISTS t_m_ev_vegetal_herbe ON m_espace_vert.geo_v_ev_vegetal_herbe;
CREATE TRIGGER t_m_ev_vegetal_herbe INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_herbe 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_herbe();


-- #################################################################### FONCTION/TRIGGER circulation_voie ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_voie() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_objet_line_largeur
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_objet_line_largeur SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_circulation_voie ON m_espace_vert.geo_v_ev_mineral_circulation_voie;
CREATE TRIGGER t_m_ev_mineral_circulation_voie INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_circulation_voie 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_circulation_voie();


-- #################################################################### FONCTION/TRIGGER circulation_zone ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_zone() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_circulation_zone ON m_espace_vert.geo_v_ev_mineral_circulation_zone;
CREATE TRIGGER t_m_ev_mineral_circulation_zone INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_circulation_zone 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_circulation_zone();



-- #################################################################### FONCTION/TRIGGER cloture ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_cloture() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '22', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_cloture ON m_espace_vert.geo_v_ev_mineral_cloture;
CREATE TRIGGER t_m_ev_mineral_cloture INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_cloture 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_cloture();


-- #################################################################### FONCTION/TRIGGER loisir_equipement ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_equipement() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '231');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_loisir_equipement ON m_espace_vert.geo_v_ev_mineral_loisir_equipement;
CREATE TRIGGER t_m_ev_mineral_loisir_equipement INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_loisir_equipement 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_loisir_equipement();



-- #################################################################### FONCTION/TRIGGER loisir_zone ###############################################


CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_zone() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '232');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_loisir_zone ON m_espace_vert.geo_v_ev_mineral_loisir_zone;
CREATE TRIGGER t_m_ev_mineral_loisir_zone INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_loisir_zone 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_loisir_zone();


-- #################################################################### FONCTION/TRIGGER eau_arrivee ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro_eau_arrivee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '31', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

--DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_arrivee ON m_espace_vert.geo_v_ev_hydro_eau_arrivee;
CREATE TRIGGER t_m_ev_hydro_eau_arrivee INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_arrivee 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro_eau_arrivee();


-- #################################################################### FONCTION/TRIGGER hydro eau_point et eau_etendue ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table hydro_eau_point
-- DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_point ON m_espace_vert.geo_v_ev_hydro_eau_point;
CREATE TRIGGER t_m_ev_hydro_eau_point INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_point 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro();

-- trigger sur table hydro_eau_etendue
-- DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_etendue ON m_espace_vert.geo_v_ev_hydro_eau_etendue;
CREATE TRIGGER t_m_ev_hydro_eau_etendue INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_etendue 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro();


-- #################################################################### FONCTION/TRIGGER hydro eau_cours ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro_eau_cours() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_objet_line_largeur
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_objet_line_largeur SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table hydro_eau_cours
--DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_cours ON m_espace_vert.geo_v_ev_hydro_eau_cours;
CREATE TRIGGER t_m_ev_hydro_eau_cours INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_cours 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro_eau_cours();


-- #################################################################### FONCTION/TRIGGER REFNONCLASSEE PCT-LIN-POLYGON ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_refnonclassee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '9', '99', '999');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table refnonclassee_point
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_point ON m_espace_vert.geo_v_ev_refnonclassee_point;
CREATE TRIGGER t_m_ev_refnonclassee_point INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_point
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();

-- trigger sur table refnonclassee_line
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_line ON m_espace_vert.geo_v_ev_refnonclassee_line;
CREATE TRIGGER t_m_ev_refnonclassee_line INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_line
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();

-- trigger sur table refnonclassee_polygon
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_polygon ON m_espace_vert.geo_v_ev_refnonclassee_polygon;
CREATE TRIGGER t_m_ev_refnonclassee_polygon INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_polygon
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();



-- #################################################################### FONCTION/TRIGGER INTERVENTION + DDE INTER ###############################################

-- lors de la suppression d'une DI / Intervention, ne pas laisser les objets liés comme orphelins.
-- pas possible d'utilisée une FOREIGN KEY avec DELETE CASCADE car l'idinter peut être lié soit à une DI, soit à une intervention
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_intervention_purge_on_delete() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  DELETE FROM m_espace_vert.lk_ev_intervention_objet WHERE idinter = OLD.idinter;
  RETURN OLD;
END;
$$
;

-- demande d'intervention
-- assigner tous les objets du type choisi, à la DI
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_intervention_add_objets() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE 
  _geom_intersection geometry; -- géométrie à utiliser pour intersecter avec les éléments de patrimoine (soit tracée à la main, soit celle de l'équipe)
BEGIN
  -- si l'intervention saisie est liée à une demande d'intervention
  IF NEW.iddemande IS NOT NULL THEN
    -- on vérifie si une intervention n'existe pas déjà pour cette demande (car GEO ne permet pas de cacher le bouton)
    IF (SELECT count(1) > 0 FROM m_espace_vert.geo_ev_intervention WHERE iddemande = NEW.iddemande AND idinter <> NEW.idinter) THEN
      RAISE EXCEPTION 'Une intervention est déjà liée à cette demande d''intervention.<br><br>';
      return NEW;
    END IF;
    -- alors on va recopier tous les objets liés à la DI, au niveau de l'intervention
    INSERT INTO m_espace_vert.lk_ev_intervention_objet(idinter, idobjet)
      SELECT NEW.idinter, idobjet 
        FROM m_espace_vert.lk_ev_intervention_objet 
        WHERE idinter = NEW.iddemande;
    -- et recopier aussi la géométrie polygone issue de la DI
    -- on fait un UPDATE comme on est en AFTER INSERT, sinon on aurait pu faire NEW.geom := (SELECT ...)
    UPDATE m_espace_vert.geo_ev_intervention SET geom = (SELECT geom FROM m_espace_vert.geo_ev_intervention_demande WHERE idinter = NEW.iddemande) WHERE idinter = NEW.idinter;
    RETURN NEW;
  END IF;
  -- si géométrie dessinée
  IF NEW.geom IS NOT NULL THEN
    _geom_intersection := NEW.geom;
  END IF;
  -- si la demande provient de la fiche d'information d'un secteur d'équipe, alors on considère que la géométrie à utiliser est celle du secteur d'équipe
  IF NEW.idequipe IS NOT NULL THEN
    _geom_intersection := (SELECT geom FROM m_espace_vert.geo_ev_zone_equipe e WHERE e.idequipe = NEW.idequipe LIMIT 1);
  END IF;
  -- si pas de géométrie à intersecter, on ne fait rien
  IF _geom_intersection IS NULL THEN
    return NEW;
  END IF;
  -- si on a une géométrie mais pas de type d'objet, alors on refuse la saisie
  IF NEW.objet_type IS NULL OR NEW.objet_type = '000' THEN
    RAISE EXCEPTION 'Lors d''une saisie par polygone, veuillez choisir un type d''objet. Tous les objets de ce type présents dans cette zone seront liés automatiquement à la demande.<br><br>';
    return NEW;
  END IF;
  -- on ajoute dans la table de relation N-M tous les objets du type choisi
  INSERT INTO m_espace_vert.lk_ev_intervention_objet(idinter, idobjet)
    SELECT NEW.idinter, coalesce(l.idobjet, p.idobjet , s.idobjet)
    FROM m_espace_vert.an_ev_objet 
    -- pour pouvoir faire l'intersection spatiale, on fait des jointures avec les 3 tables dans lesquelles peuvent se trouver la géom (pct, ligne, polygon)
      LEFT JOIN m_espace_vert.geo_ev_objet_line l ON l.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, l.geom)
      LEFT JOIN m_espace_vert.geo_ev_objet_pct p ON p.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, p.geom)
      LEFT JOIN m_espace_vert.geo_ev_objet_polygon s ON s.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, s.geom)
          -- on ne prend que le type d'objets EV choisi par l'utilisateur
    where typ3 = NEW.objet_type
          -- pour retirer les lignes de an_ev_objet qui n'ont pas matché, on regarde les lignes en résultat qui ont un identifiant
          and (l.idobjet IS NOT NULL or p.idobjet IS NOT NULL or s.idobjet IS NOT NULL);
    -- on vérifie si des objets de ce type ont bien été ajoutés, sinon on refuse la saisie
    IF (SELECT count(1) = 0 FROM m_espace_vert.lk_ev_intervention_objet WHERE idinter = NEW.idinter) THEN
      RAISE EXCEPTION 'Aucun objet de ce type n''a été trouvé dans la zone tracée. Veuillez modifier la zone ou le type d''objets et essayer à nouveau.<br><br>';
    END IF;
  RETURN NEW;
END;
$$
;

-- demande d'intervention, trigger classique
-- on crée en AFTER INSERT pour pouvoir récupérer l'identifiant idinter généré
--DROP TRIGGER t_m_ev_intervention_demande ON m_espace_vert.geo_ev_intervention_demande;
CREATE TRIGGER t_m_ev_intervention_demande 
AFTER INSERT ON m_espace_vert.geo_ev_intervention_demande
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_intervention_add_objets();

-- purge des éléments liés à la DI lors du DELETE
-- DROP TRIGGER t_m_ev_intervention_demande_on_delete ON m_espace_vert.geo_ev_intervention_demande;
CREATE TRIGGER t_m_ev_intervention_demande_on_delete 
AFTER DELETE ON m_espace_vert.geo_ev_intervention_demande
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_intervention_purge_on_delete();

-- on crée en AFTER INSERT pour pouvoir récupérer l'identifiant idinter généré
-- DROP TRIGGER t_m_ev_intervention ON m_espace_vert.geo_ev_intervention;
CREATE TRIGGER t_m_ev_intervention 
AFTER INSERT ON m_espace_vert.geo_ev_intervention
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_intervention_add_objets();

-- purge des éléments liés à l'intervention lors du DELETE
-- DROP TRIGGER t_m_ev_intervention_on_delete ON m_espace_vert.geo_ev_intervention;
CREATE TRIGGER t_m_ev_intervention_on_delete 
AFTER DELETE ON m_espace_vert.geo_ev_intervention
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_intervention_purge_on_delete();


-- #################################################################### FONCTION/TRIGGER ZONE GESTION ###############################################

-- MAJ des objets EV liés quand modification découpage adm (zone_gestion, site cohérent)
-- pour chaque type de couche, on fait l'intersection
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_zone_gestion_set() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NEW.idgestion WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NEW.idgestion WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NEW.idgestion WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idgestion = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;


-- MAJ des objets EV liés quand modification découpage adm (zone_gestion)
-- DROP TRIGGER t_m_ev_zone_gestion_set ON m_espace_vert.geo_ev_zone_gestion;
CREATE TRIGGER t_m_ev_zone_gestion_set 
AFTER INSERT OR UPDATE of geom OR DELETE ON m_espace_vert.geo_ev_zone_gestion
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_zone_gestion_set();


-- #################################################################### FONCTION/TRIGGER ZONE SITE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_zone_site_set() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idsite = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;

-- MAJ des objets EV liés quand modification découpage adm (site cohérent)
-- DROP TRIGGER t_m_ev_zone_site_set ON m_espace_vert.geo_ev_zone_site;
CREATE TRIGGER t_m_ev_zone_site_set 
AFTER INSERT OR UPDATE of geom OR DELETE ON m_espace_vert.geo_ev_zone_site
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_zone_site_set();

-- #################################################################### FONCTION/TRIGGER ZONE EQUIPE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_zone_equipe_set() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NULL WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_objet_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;

-- MAJ des objets EV liés quand modification découpage adm (equipe ev)
-- DROP TRIGGER t_m_ev_zone_equipe_set ON m_espace_vert.geo_ev_zone_equipe;
CREATE TRIGGER t_m_ev_zone_equipe_set 
AFTER INSERT OR UPDATE of geom OR DELETE ON m_espace_vert.geo_ev_zone_equipe
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_zone_equipe_set();



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGER                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- MAJ des calculs de surface des objets de type polygone !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_objet_polygon_sup_m2 ON m_espace_vert.geo_ev_objet_polygon;
CREATE TRIGGER t_geo_ev_objet_polygon_sup_m2
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_objet_polygon
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

-- quid perimetre ??????

-- MAJ des calculs de longueur des objets de type line !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_objet_line_long_m ON m_espace_vert.geo_ev_objet_line;
CREATE TRIGGER t_geo_ev_objet_line_long_m
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_objet_line
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_longm_maj();

-- MAJ des calculs des coordonnées des objets de type point !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_objet_pct_xy_l93 ON m_espace_vert.geo_ev_objet_pct;
CREATE TRIGGER t_geo_ev_objet_pct_xy_l93
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_objet_pct
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_xy_l93();

-- MAJ des calculs de surface des zones sites !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_zone_site_sup_m2 ON m_espace_vert.geo_ev_zone_site;
CREATE TRIGGER t_geo_ev_zone_site_sup_m2
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_zone_site
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

-- MAJ des calculs de surface des zones equipe !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_zone_equipe_sup_m2 ON m_espace_vert.geo_ev_zone_equipe;
CREATE TRIGGER t_geo_ev_zone_equipe_sup_m2
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_zone_equipe
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

-- MAJ des calculs de surface des zones gestion !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
-- DROP TRIGGER t_geo_ev_zone_gestion_sup_m2 ON m_espace_vert.geo_ev_zone_gestion;
CREATE TRIGGER t_geo_ev_zone_gestion_sup_m2
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_zone_gestion
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_sup_m2_maj();



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                    EXPLOITATION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### VUE NBR ARBRE PAR QUARTIER  ###############################################

-- View: m_espace_vert.xapps_v_an_ev_chiffre_cle_tab

-- DROP VIEW m_espace_vert.xapps_an_v_ev_chiffre_cle_tab;

CREATE OR REPLACE VIEW m_espace_vert.xapps_an_v_ev_chiffre_cle_tab
 AS
 WITH req_arbre AS (
         SELECT 1 AS gid,
            count(*) AS nb_arbre
           FROM m_espace_vert.an_ev_objet o
          WHERE o.typ3 = '111'::text AND o.etat ='2'::text 
        ), req_lgarbre AS (
         SELECT 1 AS gid,
            sum(l.long_m) AS lg_arbre
           FROM m_espace_vert.an_ev_objet o,
            m_espace_vert.geo_ev_objet_line l
          WHERE o.typ3 = '112'::text AND o.etat ='2'::text AND o.idobjet = l.idobjet
        ), req_arbuste AS (
         SELECT 1 AS gid,
            count(*) AS nb_arbuste
           FROM m_espace_vert.an_ev_objet o
          WHERE o.typ3 = '121'::text AND o.etat ='2'::text 
        ), req_ptfleuri AS (
         SELECT 1 AS gid,
            count(*) AS nb_ptfleuri
           FROM m_espace_vert.an_ev_objet o
          WHERE o.typ3 = '131'::text AND o.etat ='2'::text 
        ), req_lghaie AS (
         SELECT 1 AS gid,
            sum(l.long_m) AS lg_haie
           FROM m_espace_vert.an_ev_objet o,
            m_espace_vert.geo_ev_objet_line l
          WHERE o.typ3 = '122'::text AND o.etat ='2'::text AND o.idobjet = l.idobjet
        ), req_surfenherbe AS (
         SELECT 1 AS gid,
            sum(s.sup_m2) AS surf_enherbe
           FROM m_espace_vert.an_ev_objet o,
            m_espace_vert.geo_ev_objet_polygon s
          WHERE o.typ3 = '141'::text AND o.etat ='2'::text AND o.idobjet = s.idobjet
        ), req_surfmassifarbustif AS (
         SELECT 1 AS gid,
            sum(s.sup_m2) AS surf_massifarbustif
           FROM m_espace_vert.an_ev_objet o,
            m_espace_vert.geo_ev_objet_polygon s
          WHERE o.typ3 = '123'::text AND o.etat ='2'::text AND o.idobjet = s.idobjet
        ), req_surfmassiffleuri AS (
         SELECT 1 AS gid,
            sum(s.sup_m2) AS surf_massiffleuri
           FROM m_espace_vert.an_ev_objet o,
            m_espace_vert.geo_ev_objet_polygon s
          WHERE o.typ3 = '132'::text AND o.etat ='2'::text AND o.idobjet = s.idobjet
        )
 SELECT row_number() OVER () AS gid,
    ar.nb_arbre,
    -- mise en forme séparateur millier
        CASE
            WHEN length(lar.lg_arbre::text) >= 1 AND length(lar.lg_arbre::text) <= 3 THEN lar.lg_arbre::text || ' m'::text
            WHEN length(lar.lg_arbre::text) = 4 THEN replace(to_char(lar.lg_arbre, 'FM9G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lar.lg_arbre::text) = 5 THEN replace(to_char(lar.lg_arbre, 'FM99G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lar.lg_arbre::text) = 6 THEN replace(to_char(lar.lg_arbre, 'FM999G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lar.lg_arbre::text) = 7 THEN replace(to_char(lar.lg_arbre, 'FM9G999G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lar.lg_arbre::text) = 8 THEN replace(to_char(lar.lg_arbre, 'FM99G999G999'::text), ','::text, ' '::text) || ' m'::text
            ELSE NULL::text
        END AS lg_arbre,
    arb.nb_arbuste,
    pf.nb_ptfleuri,
        CASE
            WHEN length(lh.lg_haie::text) >= 1 AND length(lh.lg_haie::text) <= 3 THEN lh.lg_haie::text || ' m'::text
            WHEN length(lh.lg_haie::text) = 4 THEN replace(to_char(lh.lg_haie, 'FM9G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lh.lg_haie::text) = 5 THEN replace(to_char(lh.lg_haie, 'FM99G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lh.lg_haie::text) = 6 THEN replace(to_char(lh.lg_haie, 'FM999G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lh.lg_haie::text) = 7 THEN replace(to_char(lh.lg_haie, 'FM9G999G999'::text), ','::text, ' '::text) || ' m'::text
            WHEN length(lh.lg_haie::text) = 8 THEN replace(to_char(lh.lg_haie, 'FM99G999G999'::text), ','::text, ' '::text) || ' m'::text
            ELSE NULL::text
        END AS lg_haie,
        CASE
            WHEN length(sh.surf_enherbe::text) >= 1 AND length(sh.surf_enherbe::text) <= 3 THEN sh.surf_enherbe::text || ' m²'::text
            WHEN length(sh.surf_enherbe::text) = 4 THEN replace(to_char(sh.surf_enherbe, 'FM9G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sh.surf_enherbe::text) = 5 THEN replace(to_char(sh.surf_enherbe, 'FM99G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sh.surf_enherbe::text) = 6 THEN replace(to_char(sh.surf_enherbe, 'FM999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sh.surf_enherbe::text) = 7 THEN replace(to_char(sh.surf_enherbe, 'FM9G999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sh.surf_enherbe::text) = 8 THEN replace(to_char(sh.surf_enherbe, 'FM99G999G999'::text), ','::text, ' '::text) || ' m²'::text
            ELSE NULL::text
        END AS surf_enherbe,
        CASE
            WHEN length(sma.surf_massifarbustif::text) >= 1 AND length(sma.surf_massifarbustif::text) <= 3 THEN sma.surf_massifarbustif::text || ' m²'::text
            WHEN length(sma.surf_massifarbustif::text) = 4 THEN replace(to_char(sma.surf_massifarbustif, 'FM9G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sma.surf_massifarbustif::text) = 5 THEN replace(to_char(sma.surf_massifarbustif, 'FM99G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sma.surf_massifarbustif::text) = 6 THEN replace(to_char(sma.surf_massifarbustif, 'FM999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sma.surf_massifarbustif::text) = 7 THEN replace(to_char(sma.surf_massifarbustif, 'FM9G999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(sma.surf_massifarbustif::text) = 8 THEN replace(to_char(sma.surf_massifarbustif, 'FM99G999G999'::text), ','::text, ' '::text) || ' m²'::text
            ELSE NULL::text
        END AS surf_massifarbustif,
        CASE
            WHEN length(smf.surf_massiffleuri::text) >= 1 AND length(smf.surf_massiffleuri::text) <= 3 THEN smf.surf_massiffleuri::text || ' m²'::text
            WHEN length(smf.surf_massiffleuri::text) = 4 THEN replace(to_char(smf.surf_massiffleuri, 'FM9G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(smf.surf_massiffleuri::text) = 5 THEN replace(to_char(smf.surf_massiffleuri, 'FM99G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(smf.surf_massiffleuri::text) = 6 THEN replace(to_char(smf.surf_massiffleuri, 'FM999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(smf.surf_massiffleuri::text) = 7 THEN replace(to_char(smf.surf_massiffleuri, 'FM9G999G999'::text), ','::text, ' '::text) || ' m²'::text
            WHEN length(smf.surf_massiffleuri::text) = 8 THEN replace(to_char(smf.surf_massiffleuri, 'FM99G999G999'::text), ','::text, ' '::text) || ' m²'::text
            ELSE NULL::text
        END AS surf_massiffleuri
   FROM req_arbre ar
     JOIN req_lgarbre lar ON ar.gid = lar.gid
     JOIN req_arbuste arb ON ar.gid = arb.gid
     JOIN req_ptfleuri pf ON ar.gid = pf.gid
     JOIN req_lghaie lh ON ar.gid = lh.gid
     JOIN req_surfenherbe sh ON ar.gid = sh.gid
     JOIN req_surfmassifarbustif sma ON ar.gid = sma.gid
     JOIN req_surfmassiffleuri smf ON ar.gid = smf.gid;

COMMENT ON VIEW m_espace_vert.xapps_an_v_ev_chiffre_cle_tab
    IS 'Vue alphanumérique présentant les chiffres clés des espaces verts sur la ville de Compiègne';

-- #################################################################### VUE NBR ARBRE D'ALIGNEMENT  ###############################################

-- View: m_espace_vert.xapps_an_v_ev_stat_arbre_alignement

-- DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_arbre_alignement;

CREATE OR REPLACE VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_alignement
 AS
 SELECT COUNT(*) AS nb
   FROM m_espace_vert.geo_v_ev_vegetal_arbre a
   WHERE a.typ3 = '111' AND a.etat ='2' AND a.implant ='02' ;

COMMENT ON VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_alignement IS 'Vue du nombre d''arbres d''alignement';


-- #################################################################### VUE NBR ARBRE PAR QUARTIER  ###############################################

-- View: m_espace_vert.xapps_an_v_ev_stat_arbre_quartier

-- DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_arbre_quartier;

CREATE OR REPLACE VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_quartier
 AS
 SELECT COUNT(*) AS nb,
    CASE WHEN a.quartier IS NULL THEN 'Hors quartier' ELSE a.quartier END AS quartier
   FROM m_espace_vert.geo_v_ev_vegetal_arbre a
   WHERE a.typ3 = '111' AND a.etat ='2' GROUP BY a.quartier;

COMMENT ON VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_quartier IS 'Vue du nombre d''arbres par quartiers';


-- #################################################################### VUE NBR DE LIEU FLEURI  ###############################################

-- View: m_espace_vert.xapps_an_v_ev_stat_fleuri

-- DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_fleuri;

CREATE OR REPLACE VIEW m_espace_vert.xapps_an_v_ev_stat_fleuri
 AS
 SELECT COUNT(*) AS nb
   FROM m_espace_vert.an_ev_objet a
   WHERE a.typ2 = '13' AND a.etat ='2';

COMMENT ON VIEW m_espace_vert.xapps_an_v_ev_stat_fleuri IS 'Vue du nombre de lieu (ponctuel, massif) de fleurissement';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       DROITS                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ## SCHEMA
ALTER SCHEMA m_espace_vert OWNER TO create_sig;
GRANT ALL ON SCHEMA m_espace_vert TO sig_create;
GRANT ALL ON SCHEMA m_espace_vert TO create_sig;
GRANT ALL ON SCHEMA m_espace_vert TO sig_create WITH GRANT OPTION;
GRANT ALL ON SCHEMA m_espace_vert TO sig_edit WITH GRANT OPTION;
GRANT ALL ON SCHEMA m_espace_vert TO sig_read WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO sig_create WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO sig_edit WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO sig_read WITH GRANT OPTION;


-- ## SEQUENCE

-- an_ev_objet_idobjet_seq
ALTER SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq
    OWNER TO create_sig;
ALTER SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq TO PUBLIC;

-- an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq
ALTER SEQUENCE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire_idetatsan_seq TO PUBLIC;

-- an_ev_vegetal_ref_bota_idref_bota_seq
ALTER SEQUENCE m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_vegetal_ref_bota_idref_bota_seq TO PUBLIC;

-- geo_ev_zone_gestion_idgestion_seq
ALTER SEQUENCE m_espace_vert.geo_ev_zone_gestion_idgestion_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_gestion_idgestion_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_gestion_idgestion_seq TO PUBLIC;

-- geo_ev_zone_site_idsite_seq
ALTER SEQUENCE m_espace_vert.geo_ev_zone_site_idsite_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_site_idsite_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_site_idsite_seq TO PUBLIC;

-- geo_ev_zone_equipe_idequipe_seq
ALTER SEQUENCE m_espace_vert.geo_ev_zone_equipe_idequipe_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_equipe_idequipe_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_zone_equipe_idequipe_seq TO PUBLIC;

-- geo_ev_intervention_idinter_seq
ALTER SEQUENCE m_espace_vert.geo_ev_intervention_idinter_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_intervention_idinter_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.geo_ev_intervention_idinter_seq TO PUBLIC;

-- lk_ev_intervention_objet_idlk_seq
ALTER SEQUENCE m_espace_vert.lk_ev_intervention_objet_idlk_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.lk_ev_intervention_objet_idlk_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.lk_ev_intervention_objet_idlk_seq TO PUBLIC;

-- an_ev_log_idlog_seq
ALTER SEQUENCE m_espace_vert.an_ev_log_idlog_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_log_idlog_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_log_idlog_seq TO PUBLIC;

-- an_ev_media_gid_seq
ALTER SEQUENCE m_espace_vert.an_ev_media_gid_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_media_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_media_gid_seq TO PUBLIC;


-- ## TABLE

-- an_ev_objet
ALTER TABLE m_espace_vert.an_ev_objet OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_objet TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_objet TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_objet TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_objet TO sig_edit;

-- geo_ev_objet_pct
ALTER TABLE m_espace_vert.geo_ev_objet_pct OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_pct TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_objet_pct TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_pct TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_objet_pct TO sig_edit;

-- geo_ev_objet_line
ALTER TABLE m_espace_vert.geo_ev_objet_line OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_line TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_objet_line TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_line TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_objet_line TO sig_edit;

-- geo_ev_objet_polygon
ALTER TABLE m_espace_vert.geo_ev_objet_polygon OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_polygon TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_objet_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_objet_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_objet_polygon TO sig_edit;

-- an_ev_objet_line_largeur
ALTER TABLE m_espace_vert.an_ev_objet_line_largeur OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_objet_line_largeur TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_objet_line_largeur TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_objet_line_largeur TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_objet_line_largeur TO sig_edit;

-- an_ev_vegetal
ALTER TABLE m_espace_vert.an_ev_vegetal OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal TO sig_edit;

-- an_ev_vegetal_arbre
ALTER TABLE m_espace_vert.an_ev_vegetal_arbre OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbre TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_arbre TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbre TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_arbre TO sig_edit;

-- an_ev_vegetal_arbre_etat_sanitaire
ALTER TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_arbre_etat_sanitaire TO sig_edit;

-- an_ev_vegetal_arbuste_haie
ALTER TABLE m_espace_vert.an_ev_vegetal_arbuste_haie OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbuste_haie TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_arbuste_haie TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbuste_haie TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_arbuste_haie TO sig_edit;

-- an_ev_vegetal_arbuste_massif
ALTER TABLE m_espace_vert.an_ev_vegetal_arbuste_massif OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbuste_massif TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_arbuste_massif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_arbuste_massif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_arbuste_massif TO sig_edit;

-- an_ev_vegetal_fleuri_massif
ALTER TABLE m_espace_vert.an_ev_vegetal_fleuri_massif OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_fleuri_massif TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_fleuri_massif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_fleuri_massif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_fleuri_massif TO sig_edit;

-- an_ev_vegetal_herbe
ALTER TABLE m_espace_vert.an_ev_vegetal_herbe OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_herbe TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_herbe TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_herbe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_herbe TO sig_edit;

-- an_ev_vegetal_ref_bota
ALTER TABLE m_espace_vert.an_ev_vegetal_ref_bota OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_ref_bota TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_vegetal_ref_bota TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_vegetal_ref_bota TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_vegetal_ref_bota TO sig_edit;

-- ## zonage

-- geo_ev_zone_site
ALTER TABLE m_espace_vert.geo_ev_zone_site OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_site TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_zone_site TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_site TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_zone_site TO sig_edit;

-- geo_ev_zone_gestion
ALTER TABLE m_espace_vert.geo_ev_zone_gestion OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_gestion TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_zone_gestion TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_gestion TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_zone_gestion TO sig_edit;

-- geo_ev_zone_equipe
ALTER TABLE m_espace_vert.geo_ev_zone_equipe OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_equipe TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_ev_zone_equipe TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_zone_equipe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_zone_equipe TO sig_edit;


-- ## intervention

-- geo_ev_intervention_demande
ALTER TABLE m_espace_vert.geo_ev_intervention_demande OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_intervention_demande TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_intervention_demande TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_ev_intervention_demande TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_intervention_demande TO sig_edit;

-- geo_ev_intervention
ALTER TABLE m_espace_vert.geo_ev_intervention OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_intervention TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_ev_intervention TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_ev_intervention TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_ev_intervention TO sig_edit;


-- ## DOMAINE

-- lt_ev_boolean
ALTER TABLE m_espace_vert.lt_ev_boolean OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_boolean TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_boolean TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_boolean TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_boolean TO sig_edit;

-- lt_ev_equipe_specialisation
ALTER TABLE m_espace_vert.lt_ev_equipe_specialisation OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_equipe_specialisation TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_equipe_specialisation TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_equipe_specialisation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_equipe_specialisation TO sig_edit;

-- lt_ev_intervention_freq_unite
ALTER TABLE m_espace_vert.lt_ev_intervention_freq_unite OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_freq_unite TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_freq_unite TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_freq_unite TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_freq_unite TO sig_edit;

-- lt_ev_intervention_periode
ALTER TABLE m_espace_vert.lt_ev_intervention_periode OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_periode TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_periode TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_periode TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_periode TO sig_edit;

-- lt_ev_intervention_src_demand
ALTER TABLE m_espace_vert.lt_ev_intervention_src_demand OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_src_demand TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_src_demand TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_src_demand TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_src_demand TO sig_edit;

-- lt_ev_intervention_statut
ALTER TABLE m_espace_vert.lt_ev_intervention_statut OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_statut TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_statut TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_statut TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_statut TO sig_edit;

-- lt_ev_intervention_inter_type
ALTER TABLE m_espace_vert.lt_ev_intervention_inter_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_inter_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_inter_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_inter_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_inter_type TO sig_edit;

-- lt_ev_intervention_objet_type
ALTER TABLE m_espace_vert.lt_ev_intervention_objet_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_objet_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_intervention_objet_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_intervention_objet_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_intervention_objet_type TO sig_edit;

-- lt_ev_objet_doma
ALTER TABLE m_espace_vert.lt_ev_objet_doma OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_doma TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_doma TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_doma TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_doma TO sig_edit;

-- lt_ev_objet_etat
ALTER TABLE m_espace_vert.lt_ev_objet_etat OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_etat TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_etat TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_etat TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_etat TO sig_edit;

-- lt_ev_objet_qualdoma
ALTER TABLE m_espace_vert.lt_ev_objet_qualdoma OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_qualdoma TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_qualdoma TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_qualdoma TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_qualdoma TO sig_edit;

-- lt_ev_objet_typ1
ALTER TABLE m_espace_vert.lt_ev_objet_typ1 OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ1 TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_typ1 TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ1 TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_typ1 TO sig_edit;

-- lt_ev_objet_typ2
ALTER TABLE m_espace_vert.lt_ev_objet_typ2 OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ2 TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_typ2 TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ2 TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_typ2 TO sig_edit;

-- lt_ev_objet_typ3
ALTER TABLE m_espace_vert.lt_ev_objet_typ3 OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ3 TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_objet_typ3 TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_objet_typ3 TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_objet_typ3 TO sig_edit;

-- lt_ev_vegetal_arrosage_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_arrosage_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arrosage_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arrosage_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arrosage_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arrosage_type TO sig_edit;

-- lt_ev_vegetal_espace_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_espace_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_espace_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_espace_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_espace_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_espace_type TO sig_edit;

-- lt_ev_vegetal_niveau_allergisant
ALTER TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_niveau_allergisant TO sig_edit;

-- lt_ev_vegetal_position
ALTER TABLE m_espace_vert.lt_ev_vegetal_position OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_position TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_position TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_position TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_position TO sig_edit;

-- lt_ev_vegetal_arbre_amenagement_pied
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied TO sig_edit;

-- lt_ev_vegetal_arbre_contr_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_contr_type TO sig_edit;

-- lt_ev_vegetal_arbre_date_plantation_saison
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_date_plantation_saison TO sig_edit;

-- lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etat_sanitaire_anomal_typ TO sig_edit;

-- lt_ev_vegetal_arbre_etatarbre
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_etatarbre TO sig_edit;

-- lt_ev_vegetal_arbre_hauteur_cl
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_hauteur_cl TO sig_edit;

-- lt_ev_vegetal_arbre_implant
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_implant OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_implant TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_implant TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_implant TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_implant TO sig_edit;

-- lt_ev_vegetal_arbre_mode_conduite
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_mode_conduite TO sig_edit;

-- lt_ev_vegetal_arbre_periode_plantation
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_periode_plantation TO sig_edit;

-- lt_ev_vegetal_arbre_stade_dev
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_stade_dev TO sig_edit;

-- lt_ev_vegetal_arbre_sol_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_arbre_sol_type TO sig_edit;

-- lt_ev_vegetal_haie_paillage_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_haie_paillage_type TO sig_edit;

-- lt_ev_vegetal_haie_sai_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_haie_sai_type TO sig_edit;

-- lt_ev_vegetal_haie_veget_type
ALTER TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_vegetal_haie_veget_type TO sig_edit;


-- lt_ev_zone_site_type
ALTER TABLE m_espace_vert.lt_ev_zone_site_type OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.lt_ev_zone_site_type TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.lt_ev_zone_site_type TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lt_ev_zone_site_type TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_zone_site_type TO sig_edit;

-- ##VUE

-- geo_v_ev_vegetal_arbre
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbre OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre TO sig_edit;

-- geo_v_ev_vegetal_arbre_alignement
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbre_alignement OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_alignement TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_alignement TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_alignement TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_alignement TO sig_edit;

-- geo_v_ev_vegetal_arbre_bois
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbre_bois OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_bois TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_bois TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_bois TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbre_bois TO sig_edit;

-- geo_v_ev_vegetal_arbuste
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbuste OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste TO sig_edit;

-- geo_v_ev_vegetal_arbuste_haie
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_haie OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_haie TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_haie TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_haie TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_haie TO sig_edit;

-- geo_v_ev_vegetal_arbuste_massif
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_massif OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_massif TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_massif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_massif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbuste_massif TO sig_edit;

-- geo_v_ev_vegetal_fleuri
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_fleuri OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri TO sig_edit;

-- geo_v_ev_vegetal_fleuri_massif
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_fleuri_massif OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri_massif TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri_massif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri_massif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_fleuri_massif TO sig_edit;

-- geo_v_ev_vegetal_herbe
ALTER TABLE m_espace_vert.geo_v_ev_vegetal_herbe OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_herbe TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_herbe TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_herbe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_herbe TO sig_edit;

-- geo_v_ev_mineral_circulation_voie
ALTER TABLE m_espace_vert.geo_v_ev_mineral_circulation_voie OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_voie TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_voie TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_voie TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_voie TO sig_edit;

-- geo_v_ev_mineral_circulation_zone
ALTER TABLE m_espace_vert.geo_v_ev_mineral_circulation_zone OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_zone TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_zone TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_zone TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_circulation_zone TO sig_edit;

-- geo_v_ev_mineral_cloture
ALTER TABLE m_espace_vert.geo_v_ev_mineral_cloture OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_edit;

-- geo_v_ev_mineral_loisir_equipement
ALTER TABLE m_espace_vert.geo_v_ev_mineral_loisir_equipement OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_equipement TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_equipement TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_equipement TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_equipement TO sig_edit;

-- geo_v_ev_mineral_loisir_zone
ALTER TABLE m_espace_vert.geo_v_ev_mineral_loisir_zone OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_zone TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_zone TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_zone TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_loisir_zone TO sig_edit;

-- geo_v_ev_hydro_eau_arrivee
ALTER TABLE m_espace_vert.geo_v_ev_hydro_eau_arrivee OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_arrivee TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydro_eau_arrivee TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_arrivee TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydro_eau_arrivee TO sig_edit;

-- geo_v_ev_hydro_eau_point
ALTER TABLE m_espace_vert.geo_v_ev_hydro_eau_point OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_point TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydro_eau_point TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_point TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydro_eau_point TO sig_edit;

-- geo_v_ev_hydro_eau_cours
ALTER TABLE m_espace_vert.geo_v_ev_hydro_eau_cours OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_cours TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydro_eau_cours TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_cours TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydro_eau_cours TO sig_edit;

-- geo_v_ev_hydro_eau_etendue
ALTER TABLE m_espace_vert.geo_v_ev_hydro_eau_etendue OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_etendue TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydro_eau_etendue TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydro_eau_etendue TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydro_eau_etendue TO sig_edit;

-- geo_v_ev_refnonclassee_point
ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_point OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_point TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_point TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_point TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_point TO sig_edit;

-- geo_v_ev_refnonclassee_line
ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_line OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_line TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_line TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_line TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_line TO sig_edit;

-- geo_v_ev_refnonclassee_polygon
ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_edit;

-- geo_v_ev_objet_pct
ALTER TABLE m_espace_vert.geo_v_ev_objet_pct OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_pct TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_objet_pct TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_pct TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_objet_pct TO sig_edit;

-- geo_v_ev_objet_line
ALTER TABLE m_espace_vert.geo_v_ev_objet_line OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_line TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_objet_line TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_line TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_objet_line TO sig_edit;

-- geo_v_ev_objet_polygon
ALTER TABLE m_espace_vert.geo_v_ev_objet_polygon OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_polygon TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_objet_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_objet_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_objet_polygon TO sig_edit;


-- an_v_lt_ev_objet_typ123 (les 3 types dans une meme vue)

ALTER TABLE m_espace_vert.an_v_lt_ev_objet_typ123 OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.an_v_lt_ev_objet_typ123 TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_v_lt_ev_objet_typ123 TO create_sig;
GRANT ALL ON TABLE m_espace_vert.an_v_lt_ev_objet_typ123 TO sig_create;
GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE m_espace_vert.an_v_lt_ev_objet_typ123 TO sig_edit;

-- ## RELATION

-- lk_ev_intervention_objet
ALTER TABLE m_espace_vert.lk_ev_intervention_objet OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.lk_ev_intervention_objet TO sig_read;
GRANT ALL ON TABLE m_espace_vert.lk_ev_intervention_objet TO sig_create;
GRANT ALL ON TABLE m_espace_vert.lk_ev_intervention_objet TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lk_ev_intervention_objet TO sig_edit;

-- ## MEDIA

-- an_ev_media
ALTER TABLE m_espace_vert.an_ev_media OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_media TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_media TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_media TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_media TO sig_edit;

-- ## STAT

-- xapps_an_v_ev_chiffre_cle_tab
ALTER TABLE m_espace_vert.xapps_an_v_ev_chiffre_cle_tab OWNER TO create_sig;

GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_chiffre_cle_tab TO sig_create;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_chiffre_cle_tab TO create_sig;
GRANT SELECT ON TABLE m_espace_vert.xapps_an_v_ev_chiffre_cle_tab TO sig_read;
GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE m_espace_vert.xapps_an_v_ev_chiffre_cle_tab TO sig_edit;

-- xapps_an_v_ev_stat_arbre_alignement
ALTER TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_alignement OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_alignement TO sig_read;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_alignement TO sig_create;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_alignement TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_alignement TO sig_edit;

-- xapps_an_v_ev_stat_fleuri
ALTER TABLE m_espace_vert.xapps_an_v_ev_stat_fleuri OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.xapps_an_v_ev_stat_fleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_fleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_fleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.xapps_an_v_ev_stat_fleuri TO sig_edit;

-- xapps_an_v_ev_stat_arbre_quartier
ALTER TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_read;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_create;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_edit;


-- ## FONCTION

ALTER FUNCTION m_espace_vert.ft_m_ev_hydro()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_hydro_eau_arrivee()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro_eau_arrivee() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro_eau_arrivee() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_hydro_eau_cours()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro_eau_cours() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_hydro_eau_cours() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_intervention_add_objets()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_add_objets() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_add_objets() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_intervention_purge_on_delete()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_purge_on_delete() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_purge_on_delete() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_voie()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_voie() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_voie() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_zone()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_zone() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_zone() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_mineral_cloture()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_cloture() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_cloture() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_equipement()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_equipement() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_equipement() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_zone()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_zone() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_zone() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_refnonclassee()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_refnonclassee() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_refnonclassee() TO PUBLIC;


ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_alignement()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_alignement() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_alignement() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_bois()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_bois() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_bois() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_haie()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_haie() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_haie() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_massif()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_massif() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_massif() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri_massif()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri_massif() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri_massif() TO PUBLIC;


ALTER FUNCTION m_espace_vert.ft_m_ev_vegetal_herbe()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_herbe() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_vegetal_herbe() TO PUBLIC;


ALTER FUNCTION m_espace_vert.ft_m_ev_zone_equipe_set()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_equipe_set() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_equipe_set() TO PUBLIC;


ALTER FUNCTION m_espace_vert.ft_m_ev_zone_gestion_set()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_gestion_set() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_gestion_set() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_zone_site_set()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_site_set() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_zone_site_set() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_intervention_get_next_date_rappel(date, integer, text, integer, text, text)
    OWNER TO create_sig;

GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_get_next_date_rappel(date, integer, text, integer, text, text) TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_intervention_get_next_date_rappel(date, integer, text, integer, text, text) TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_process_generic_info(text, text, geometry, integer, text, text, text, text, text, text, text, text)
    OWNER TO create_sig;

GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_process_generic_info(text, text, geometry, integer, text, text, text, text, text, text, text, text) TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_process_generic_info(text, text, geometry, integer, text, text, text, text, text, text, text, text) TO PUBLIC;


-- ## LOG



-- an_ev_log
ALTER TABLE m_espace_vert.an_ev_log OWNER to create_sig;

GRANT ALL ON TABLE m_espace_vert.an_ev_log TO sig_create;
GRANT SELECT ON TABLE m_espace_vert.an_ev_log TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_log TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_log TO sig_edit;

