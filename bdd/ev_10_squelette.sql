/*ESPACE VERT V2.2.0*/
/*Creation de la structure*/
/* init_db_ev.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

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




-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_pct ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_pct() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),    
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_pct SET
    x_l93 = ST_X(new.geom),
    y_l93 = ST_Y(new.geom),
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_pct ON m_espace_vert.geo_v_ev_objet_pct;
CREATE TRIGGER t_m_ev_objet_pct INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_pct 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_pct();     
     
     
 
-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_line ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_line() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),   
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_line SET
    long_m = ST_Length(new.geom)::integer,
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_line ON m_espace_vert.geo_v_ev_objet_line;
CREATE TRIGGER t_m_ev_objet_line INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_line 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_line();         


-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_polygon ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_polygon() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),  
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_polygon SET
    sup_m2 = round(cast(st_area(new.geom) as numeric),0),
    perimetre = NEW.perimetre,
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_polygon ON m_espace_vert.geo_v_ev_objet_polygon;
CREATE TRIGGER t_m_ev_objet_polygon INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_polygon 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_polygon();  



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


