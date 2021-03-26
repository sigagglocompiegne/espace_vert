/* ESPACE VERT V1.0*/
/* Creation du squelette de la structure des données */
/* ev_10_squelette.sql */
/* PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                SCHEMA                                                                        ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- Schema: m_espace_vert_v2

DROP SCHEMA IF EXISTS m_espace_vert_v2 CASCADE;

CREATE SCHEMA m_espace_vert_v2
  AUTHORIZATION create_sig;
  
COMMENT ON SCHEMA m_espace_vert_v2
  IS 'Données métiers sur le thème des espaces verts';

GRANT ALL ON SCHEMA m_espace_vert_v2 TO create_sig;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert_v2
GRANT ALL ON TABLES TO sig_create;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert_v2
GRANT SELECT ON TABLES TO sig_read;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert_v2
GRANT ALL ON TABLES TO create_sig;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert_v2
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO sig_edit;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                SEQUENCE                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

DROP SEQUENCE IF EXISTS m_espace_vert_v2.an_ev_objet_idobjet_seq;

-- ################################################################# Séquence sur TABLE an_objet_ev ###############################################

-- SEQUENCE: m_espace_vert_v2.an_ev_objet_idobjet_seq

-- DROP SEQUENCE m_espace_vert_v2.an_ev_objet_idobjet_seq;

CREATE SEQUENCE m_espace_vert_v2.an_ev_objet_idobjet_seq
    INCREMENT 1
    START 0
    MINVALUE 0
    MAXVALUE 9223372036854775807
    CACHE 1;



    
 -- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                REINITIALISATION DU MODELE                                                    ###
-- ###                                                                                                                                              ###
-- #################################################################################################################################################### 

DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_doma;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typ1;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typ2;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typ3;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typsite;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_arbrehauteur;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_arbreforme;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_arbreimplant;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_arbredanger;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_arbresol;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typsaihaie;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_position;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_niventretien;
DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_objet;
DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_arbre;

DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_geohaie;
DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_geoline;
DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_geovegetal;

DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_pct;
DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_line;
DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_polygon;
DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_site; 
DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_zone_gestion; 

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE DE VALEURS                                                            ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# lt_ev_doma ###############################################
    
-- Table: m_espace_vert_v2.lt_ev_doma 

-- DROP TABLE m_espace_vert_v2.lt_ev_doma ;

CREATE TABLE m_espace_vert_v2.lt_ev_doma 
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_doma_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

COMMENT ON TABLE m_espace_vert_v2.lt_ev_doma 
    IS 'Domaine de valeur de la domanialité';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_doma .code
    IS 'code du type de domanialité';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_doma .valeur
    IS 'valeur du type de domanialité';

INSERT INTO m_espace_vert_v2.lt_ev_doma (
            code, valeur)
    VALUES
    ('00','Non renseignée'),
	('10','Publique'),
	('20','Privée (non déterminé)'),
	('21','Privée (communale)'),
	('22','Privée (autre organisme public, HLM, ...)'),
	('23','Privée');  

-- ################################################################# lt_ev_typ1 ###############################################

-- Table: m_espace_vert_v2.lt_ev_typ1

-- DROP TABLE m_espace_vert_v2.lt_ev_typ1;

CREATE TABLE m_espace_vert_v2.lt_ev_typ1
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typ1_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_typ1
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 1';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ1.code
    IS 'Code du type principal des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ1.valeur
    IS 'Valeur du type principal des objets espaces verts';

INSERT INTO m_espace_vert_v2.lt_ev_typ1(
            code, valeur)
    VALUES
    ('10','Floral'),
    ('20','Végétal'),
    ('30','Minéral'),
    ('40','Hydrographie'),
    ('99','Référence non classée');

COMMENT ON CONSTRAINT lt_ev_typ1_pkey ON m_espace_vert_v2.lt_ev_typ1 IS 'Clé primaire de la table lt_ev_typ1';

-- ################################################################# lt_ev_typ2 ###############################################

-- Table: m_espace_vert_v2.lt_ev_typ2

-- DROP TABLE m_espace_vert_v2.lt_ev_typ2;

CREATE TABLE m_espace_vert_v2.lt_ev_typ2
(
    code character varying(5) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typ2_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_typ2
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 2';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ2.code
    IS 'Code du sous-type de niveau 2 principal des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ2.valeur
    IS 'Valeur du sous-type de niveau 2 principal des objets espaces verts';

INSERT INTO m_espace_vert_v2.lt_ev_typ2(
            code, valeur)
    VALUES
('101','Arbre'),
('102','Arbuste'),
('103','Fleuri'),
('104','Enherbé'),
('201','Circulation'),
('202','Clôture'),
('203','Stationnement'),
('204','Equipement'),
('301','Point d''eau'),
('302','Cours d''eau'),
('303','Etendue d''eau'),
('990','Référence non classée');

COMMENT ON CONSTRAINT lt_ev_typ2_pkey ON m_espace_vert_v2.lt_ev_typ2 IS 'Clé primaire de la table lt_ev_typ2';

-- ################################################################# lt_ev_typ3 ###############################################

-- Table: m_espace_vert_v2.lt_ev_typ3

-- DROP TABLE m_espace_vert_v2.lt_ev_typ3;

CREATE TABLE m_espace_vert_v2.lt_ev_typ3
(
    code character varying(5) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typ3_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_typ3
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 3';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ3.code
    IS 'Code du sous-type de niveau 3 principal des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typ3.valeur
    IS 'Valeur du sous-type de niveau 3 principal des objets espaces verts';

INSERT INTO m_espace_vert_v2.lt_ev_typ3(
            code, valeur)
    VALUES
('10111','Arbre isolé'),
('10112','Arbre en alignement'),
('10113','Zone boisée'),
('10119','Autre'),
('10211','Arbuste isolé'),
('10212','Haie arbustive'),
('10213','Massif arbustif'),
('10219','Autre'),
('10311','Point fleuri'),
('10312','Massif fleuri'),
('10319','Autre'),
('10411','Pelouse, gazon'),
('10419','Autre'),
('20111','Allée'),
('20112','Piste cyclable'),
('20119','Autre'),
('20211','Mur'),
('20212','Grillage'),
('20213','Palissage'),
('20219','Autre'),
('20311','Parking matérialisé'),
('20312','Espace de stationnement libre'),
('20319','Autre'),
('20411','Aire de jeux'),
('20419','Autre'),
('30111','Fontaine'),
('30112','Point d''accès à l''eau'),
('30119','Autre'),
('30211','Rivière'),
('30213','Ru'),
('30219','Autre'),
('30311','Bassin'),
('30312','Marre'),
('30313','Etang'),
('30319','Autre'),
('99000','Référence non classée');

COMMENT ON CONSTRAINT lt_ev_typ3_pkey ON m_espace_vert_v2.lt_ev_typ3 IS 'Clé primaire de la table lt_ev_typ3';

-- ################################################################# lt_ev_typsite ###############################################
  
-- Table: m_espace_vert_v2.lt_ev_typsite

-- DROP TABLE m_espace_vert_v2.lt_ev_typsite;

CREATE TABLE m_espace_vert_v2.lt_ev_typsite
(
  code character varying(2) NOT NULL, -- code du type de site intégrant les objets des espaces verts
  valeur character varying(100), -- libellé du type de site intégrant les objets des espaces verts
  CONSTRAINT lt_ev_typsite_pkkey PRIMARY KEY (code) -- Clé primaire de la table lt_ev_typsite
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_typsite
    IS 'Liste de valeurs des codes du type de site intégrant les objets des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsite.code
    IS 'code du type de site intégrant les objets des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsite.valeur
    IS 'libellé du type de site intégrant les objets des espaces verts';
COMMENT ON CONSTRAINT lt_ev_typsite_pkkey ON m_espace_vert_v2.lt_ev_typsite
    IS 'Clé primaire de la table lt_ev_typsite';

COMMENT ON TABLE m_espace_vert_v2.lt_ev_typsite
  IS 'Liste de valeurs des codes du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsite.code IS 'code du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsite.valeur IS 'libellé du type de site intégrant les objets des espaces verts';

COMMENT ON CONSTRAINT lt_ev_typsite_pkkey ON m_espace_vert_v2.lt_ev_typsite IS 'Clé primaire de la table lt_ev_typsite';

INSERT INTO m_espace_vert_v2.lt_ev_typsite(
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
  ('11','Espace naturel aménagé'),
  ('12','Arbre l''alignement');


  
-- ################################################################# lt_ev_arbrehauteur ###############################################

-- Table: m_espace_vert_v2.lt_ev_arbrehauteur

-- DROP TABLE m_espace_vert_v2.lt_ev_arbrehauteur;

CREATE TABLE m_espace_vert_v2.lt_ev_arbrehauteur
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_arbrehauteur_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_arbrehauteur
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_arbrehauteur
    IS 'Liste permettant de décrire la classe de hauteur des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbrehauteur.code
    IS 'Code de la classe de hauteur des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbrehauteur.valeur
    IS 'Valeur de la classe de hauteur des objets ponctuels arbre';

COMMENT ON CONSTRAINT lt_ev_arbrehauteur_pkey ON m_espace_vert_v2.lt_ev_arbrehauteur IS 'Clé primaire de la table lt_ev_arbrehauteur';

INSERT INTO m_espace_vert_v2.lt_ev_arbrehauteur(
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

-- ################################################################# lt_ev_arbreforme ###############################################

-- Table: m_espace_vert_v2.lt_ev_arbreforme

-- DROP TABLE m_espace_vert_v2.lt_ev_arbreforme;

CREATE TABLE m_espace_vert_v2.lt_ev_arbreforme
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_arbreforme_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_arbreforme
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_arbreforme
    IS 'Liste permettant de décrire la classe de forme des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbreforme.code
    IS 'Code de la classe de forme des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbreforme.valeur
    IS 'Valeur de la classe de forme des objets ponctuels arbre';

COMMENT ON CONSTRAINT lt_ev_arbreforme_pkey ON m_espace_vert_v2.lt_ev_arbreforme IS 'Clé primaire de la table lt_ev_arbreforme';

INSERT INTO m_espace_vert_v2.lt_ev_arbreforme(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Rideau'),
  ('02','Taille de contrainte'),
  ('03','Taille douce'),
  ('04','Libre'),
  ('05','Tête de chat');
  
  -- ################################################################# lt_ev_arbreimplant ###############################################

-- Table: m_espace_vert_v2.lt_ev_arbreimplant

-- DROP TABLE m_espace_vert_v2.lt_ev_arbreimplant;

CREATE TABLE m_espace_vert_v2.lt_ev_arbreimplant
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_arbreimplant_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_arbreimplant
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_arbreimplant
    IS 'Liste permettant de décrire la classe d''implantation des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbreimplant.code
    IS 'Code de la classe d''implantation des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbreimplant.valeur
    IS 'Valeur de la classe d''implantation des objets ponctuels arbre';

COMMENT ON CONSTRAINT lt_ev_arbreimplant_pkey ON m_espace_vert_v2.lt_ev_arbreimplant IS 'Clé primaire de la table lt_ev_arbreimplant';

INSERT INTO m_espace_vert_v2.lt_ev_arbreimplant(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Alignement'),
  ('02','Groupe/Bosquet'),
  ('03','Solitaire');
  
  -- ################################################################# lt_ev_arbredanger ###############################################

-- Table: m_espace_vert_v2.lt_ev_arbredanger

-- DROP TABLE m_espace_vert_v2.lt_ev_arbredanger;

CREATE TABLE m_espace_vert_v2.lt_ev_arbredanger
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_arbredanger_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_arbredanger
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_arbredanger
    IS 'Liste permettant de décrire la classe de dangerosité des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbredanger.code
    IS 'Code de la classe de dangerosité des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbredanger.valeur
    IS 'Valeur de la classe de dangerosité des objets ponctuels arbre';

COMMENT ON CONSTRAINT lt_ev_arbredanger_pkey ON m_espace_vert_v2.lt_ev_arbredanger IS 'Clé primaire de la table lt_ev_arbredanger';

INSERT INTO m_espace_vert_v2.lt_ev_arbredanger(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Aucun'),
  ('02','Dangereux'),
  ('03','Moyenne dangereux'),
  ('04','Faiblement dangereux');
  
 -- ################################################################# lt_ev_arbresol ###############################################

-- Table: m_espace_vert_v2.lt_ev_arbresol

-- DROP TABLE m_espace_vert_v2.lt_ev_arbresol;

CREATE TABLE m_espace_vert_v2.lt_ev_arbresol
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_arbresol_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_arbresol
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_arbresol
    IS 'Liste permettant de décrire la classe de nature de sol des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbresol.code
    IS 'Code de la classe de nature de sol des objets ponctuels arbre';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_arbresol.valeur
    IS 'Valeur de la classe de nature de sol des objets ponctuels arbre';

COMMENT ON CONSTRAINT lt_ev_arbresol_pkey ON m_espace_vert_v2.lt_ev_arbresol IS 'Clé primaire de la table lt_ev_arbresol';

INSERT INTO m_espace_vert_v2.lt_ev_arbresol(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Gazon'),
  ('02','Minéral'),
  ('03','Paillage'),
  ('04','Synthétique'),
  ('05','Terre'),
  ('06','Végétalisé'),
  ('99','Autre');
  
-- ################################################################# lt_ev_typsaihaie ###############################################

-- Table: m_espace_vert_v2.lt_ev_typsaihaie

-- DROP TABLE m_espace_vert_v2.lt_ev_typsaihaie;

CREATE TABLE m_espace_vert_v2.lt_ev_typsaihaie
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typsaihaie_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_typsaihaie
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_typsaihaie
    IS 'Liste permettant de décrire le type de saisie de la sous-classe de précision des objets espace vert de type haie';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsaihaie.code
    IS 'Code de la classe du type de saisie de la sous-classe de précision des objets espace vert de type haie';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_typsaihaie.valeur
    IS 'Valeur de la classe du type de saisie de la sous-classe de précision des objets espace vert de type haie';

COMMENT ON CONSTRAINT lt_ev_typsaihaie_pkey ON m_espace_vert_v2.lt_ev_typsaihaie IS 'Clé primaire de la table lt_ev_typsaihaie';

INSERT INTO m_espace_vert_v2.lt_ev_typsaihaie(
            code, valeur)
    VALUES
  ('10','Largeur à appliquer au centre du linéaire'),
  ('20','Largeur à appliquer dans le sens de saisie'),
  ('30','Largeur à appliquer dans le sens inverse de saisie');
  
  
-- ################################################################# lt_ev_niventretien ###############################################

-- Table: m_espace_vert_v2.lt_ev_niventretien

-- DROP TABLE m_espace_vert_v2.lt_ev_niventretien;

CREATE TABLE m_espace_vert_v2.lt_ev_niventretien
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_niventretien_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_niventretien
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_niventretien
    IS 'Liste des valeurs décrivant le niveau d''entretien des objets "espace vert" de type végétal';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_niventretien.code
    IS 'Code de la classe décrivant le niveau d''entretien des objets "espace vert" de type végétal';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_niventretien.valeur
    IS 'Valeur de la classe décrivant le niveau d''entretien des objets "espace vert" de type végétal';

COMMENT ON CONSTRAINT lt_ev_niventretien_pkey ON m_espace_vert_v2.lt_ev_niventretien IS 'Clé primaire de la table lt_ev_niventretien';

INSERT INTO m_espace_vert_v2.lt_ev_niventretien(
            code, valeur)
    VALUES
('10','Espace entretenu, jardiné'),
('20','Espace rustique'),
('30','Espace naturel');

 -- ################################################################# lt_ev_position ###############################################

-- Table: m_espace_vert_v2.lt_ev_position

-- DROP TABLE m_espace_vert_v2.lt_ev_position;

CREATE TABLE m_espace_vert_v2.lt_ev_position
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_position_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_position
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_position
    IS 'Liste des valeurs décrivant la position des objets "espace vert" de type végétal';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_position.code
    IS 'Code de la classe décrivant la position des objets "espace vert" de type végétal';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_position.valeur
    IS 'Valeur de la classe décrivant la position des objets "espace vert" de type végétal';

COMMENT ON CONSTRAINT lt_ev_position_pkey ON m_espace_vert_v2.lt_ev_position IS 'Clé primaire de la table lt_ev_position';

INSERT INTO m_espace_vert_v2.lt_ev_position(
            code, valeur)
    VALUES
('10','Sol'),
('20','Hors-sol (non précisé)'),
('21','Pot'),
('22','Bac'),
('23','Jardinière'),
('24','Suspension'),
('29','Autre');
  
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                TABLE                                                           		    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE an_ev_objet ###############################################

-- Table: m_espace_vert_v2.an_ev_objet

-- DROP TABLE m_espace_vert_v2.an_ev_objet;

CREATE TABLE m_espace_vert_v2.an_ev_objet
(
  idobjet bigint NOT NULL,
  idzone integer,
  idsite integer,
  idcontrat character varying(2),
  insee character varying(5),
  commune character varying(80),
  quartier character varying(80),
  doma_d character varying(2),
  doma_r character varying(2),
  typ1 character varying(2),
  typ2 character varying(3),
  typ3 character varying(5),
  srcgeom_sai character varying(2),
  srcdate_sai integer,
  srcgeom_maj character varying(2),
  srcdate_maj integer,
  op_sai character varying(50),
  op_maj character varying(50),
  date_sai timestamp without time zone,
  date_maj timestamp without time zone,
  observ character varying(255),
  CONSTRAINT an_ev_objet_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_objet
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.an_ev_objet
    IS 'Classe des métadonnées des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.idobjet
    IS 'Identifiant unique de l''objet espace vert';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.idzone
    IS 'identifiant de la zone de gestion';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.idsite
    IS 'Identifiant du site cohérent';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.idcontrat
    IS 'Identifiant du contrat';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.insee
    IS 'Code insee de la commune d''appartenance';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.commune
    IS 'Libellé de la commune d''appartenance';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.quartier
    IS 'Libellé du quartier';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.doma_d
    IS 'Domanialité déduite';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.doma_r
    IS 'Domanialité réelle';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.typ1
    IS 'Type d''espace vert de niveau 1';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.typ2
    IS 'Sous-Type d''espace vert de niveau 2';


COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.typ3
    IS 'Sous-Type d''espace vert de niveau 3';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.srcgeom_sai
    IS 'Source du référentiel géographique ayant servi à l''inventaire cartographique initial';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.srcdate_sai
    IS 'Année du référentiel géographique ayant servi à l''inventaire cartographique initial';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.srcgeom_maj
    IS 'Source du référentiel géographique ayant servi pour la mise à jour de l''inventaire cartographique initial';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.srcdate_maj
    IS 'Année du référentiel géographique ayant servi à la mise à jour de l''inventaire cartographique initial';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.op_sai
    IS 'Opérateur de saisie';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.op_maj
    IS 'Opérateur de mise à jour';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.date_sai
    IS 'Date de saisie';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.date_maj
    IS 'Date de mise à jour';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_objet.observ
    IS 'Observations diverses';


ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_ev_typ1_fkey FOREIGN KEY (typ1)
    REFERENCES m_espace_vert_v2.lt_ev_typ1 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typ1_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 1';
    
ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_ev_typ2_fkey FOREIGN KEY (typ2)
    REFERENCES m_espace_vert_v2.lt_ev_typ2 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typ2_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 2';

ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_ev_typ3_fkey FOREIGN KEY (typ3)
    REFERENCES m_espace_vert_v2.lt_ev_typ3 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typ2_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 2';
 
 ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_src_geomsai_fkey FOREIGN KEY (srcgeom_sai)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

     
COMMENT ON CONSTRAINT lt_src_geomsai_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de saisis'; 
    
 ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_src_geommaj_fkey FOREIGN KEY (srcgeom_maj)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_src_geommaj_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de mise à jour';


-- Constraint: lt_ev_domad_fkey

-- ALTER TABLE m_espace_vert_v2.an_objet_ev DROP CONSTRAINT lt_ev_doma_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_ev_domad_fkey FOREIGN KEY (doma_d)
    REFERENCES m_espace_vert_v2.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_domad_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la valeur de la domanialité déduite';

 -- Constraint: lt_ev_domar_fkey

-- ALTER TABLE m_espace_vert_v2.an_objet_ev DROP CONSTRAINT lt_ev_doma_fkey;

	ALTER TABLE m_espace_vert_v2.an_ev_objet
    ADD CONSTRAINT lt_ev_domar_fkey FOREIGN KEY (doma_r)
    REFERENCES m_espace_vert_v2.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_domar_fkey ON m_espace_vert_v2.an_ev_objet
    IS 'Clé étrangère sur la valeur de la domanialité réelle';

-- ################################################################# TABLE an_ev_geohaie ###############################################

-- Table: m_espace_vert_v2.an_ev_geohaie

-- DROP TABLE m_espace_vert_v2.an_ev_geohaie;

CREATE TABLE m_espace_vert_v2.an_ev_geohaie
(
  idobjet bigint NOT NULL,
  typsai character varying(2),
  CONSTRAINT an_ev_geohaie_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_geohaie
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.an_ev_geohaie
    IS 'Classe de précision des objets de l''inventaire des objets haies';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geohaie.idobjet
    IS 'Identifiant unique de l''objet haie';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geohaie.typsai
    IS 'Type de saisie de l''objet linéaire haie';

-- Constraint: lt_ev_typsaihaie_fkey

-- ALTER TABLE m_espace_vert_v2.lt_ev_typsaihaie DROP CONSTRAINT lt_ev_typsaihaie_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geohaie
    ADD CONSTRAINT lt_ev_typsaihaie_fkey FOREIGN KEY (typsai)
    REFERENCES m_espace_vert_v2.lt_ev_typsaihaie (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typsaihaie_fkey ON m_espace_vert_v2.an_ev_geohaie
    IS 'Clé étrangère sur la valeur du type de saisie de la haie';

-- ################################################################# TABLE an_ev_geoline ###############################################

-- Table: m_espace_vert_v2.an_ev_geoline

-- DROP TABLE m_espace_vert_v2.an_ev_geoline;

CREATE TABLE m_espace_vert_v2.an_ev_geoline
(
  idobjet bigint NOT NULL,
  larg_cm integer,
  CONSTRAINT an_ev_geoline_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_geoline
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.an_ev_geoline
    IS 'Classe de précision des objets de l''inventaire de type linéaire nécessitant des précisions de largeur';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geoline.idobjet
    IS 'Identifiant unique de les objets concernés';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geoline.larg_cm
    IS 'Largeur des objets';
    
-- ################################################################# TABLE an_ev_geovegetal ###############################################

-- Table: m_espace_vert_v2.an_ev_geovegetal

-- DROP TABLE m_espace_vert_v2.an_ev_geovegetal;

CREATE TABLE m_espace_vert_v2.an_ev_geovegetal
(
  idobjet bigint NOT NULL,
  position character varying(2),
  niventretien character varying(2),
  CONSTRAINT an_ev_geovegetal_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.an_ev_geovegetal
    IS 'Classe de précision générique des objets "espace vert" de type "végétal"';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geovegetal.idobjet
    IS 'Identifiant unique de les objets concernés';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geovegetal.position
    IS 'Position des objets';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_geovegetal.niventretien
    IS 'Niveau d''entretien des objets';
    
-- Constraint: lt_ev_niventretien_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geovegetal DROP CONSTRAINT lt_ev_niventretien_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    ADD CONSTRAINT lt_ev_niventretien_fkey FOREIGN KEY (niventretien)
    REFERENCES m_espace_vert_v2.lt_ev_niventretien (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_niventretien_fkey ON m_espace_vert_v2.an_ev_geovegetal
    IS 'Clé étrangère sur la valeur du niveau d''entretien des espaces verts';
    
    -- Constraint: lt_ev_niventretien_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geovegetal DROP CONSTRAINT lt_ev_position_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    ADD CONSTRAINT lt_ev_position_fkey FOREIGN KEY (position)
    REFERENCES m_espace_vert_v2.lt_ev_position (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_position_fkey ON m_espace_vert_v2.an_ev_geovegetal
    IS 'Clé étrangère sur la valeur de position des espaces verts';


-- ################################################################# TABLE geo_ev_pct ###############################################

-- Table: m_espace_vert_v2.geo_ev_pct

-- DROP TABLE m_espace_vert_v2.geo_ev_pct;
  
CREATE TABLE m_espace_vert_v2.geo_ev_pct
(
  idobjet bigint NOT NULL,
  x_l93 numeric(10,3),
  y_l93 numeric(10,3),
  geom geometry(point,2154),
  CONSTRAINT geo_ev_pct_pkey PRIMARY KEY (idobjet)
                    )
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_pct
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.geo_ev_pct
    IS 'Table géographique de la classe des objets points des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_pct.idobjet
    IS 'Identifiant des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_pct.x_l93
    IS 'Coordonnées X en lambert 93';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_pct.y_l93
    IS 'Coordonnées Y en Lambert 93';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_pct.geom
    IS 'Géométrie des objets espaces verts ponctuel';

    
-- Constraint: an_ev_objet_pct_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_objet DROP CONSTRAINT an_ev_objet_pct_fkey;

ALTER TABLE m_espace_vert_v2.geo_ev_pct
    ADD CONSTRAINT geo_ev_pct_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.an_ev_objet (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT geo_ev_pct_fkey ON m_espace_vert_v2.geo_ev_pct
    IS 'Clé étrangère sur la classe des objets ponctuels des espaces verts';
    

-- ################################################################# TABLE geo_ev_line ###############################################

-- Table: m_espace_vert_v2.geo_ev_line

-- DROP TABLE m_espace_vert_v2.geo_ev_line;
  
  CREATE TABLE m_espace_vert_v2.geo_ev_line      
(
  idobjet bigint NOT NULL,
  long_m integer,
  geom geometry(multilinestring,2154),
  CONSTRAINT geo_ev_line_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_line
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.geo_ev_line
    IS 'Table géographique de la classe des objets linéaires des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_line.idobjet
    IS 'Identifiant des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_line.long_m
    IS 'Longueur en mètres';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_line.geom
    IS 'Géométrie des objets espace vert linéaire';

-- Constraint: an_ev_objet_line_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_objet DROP CONSTRAINT an_ev_objet_line_fkey;

ALTER TABLE m_espace_vert_v2.geo_ev_line
    ADD CONSTRAINT geo_ev_line_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.an_ev_objet (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT geo_ev_line_fkey ON m_espace_vert_v2.geo_ev_line
    IS 'Clé étrangère sur la classe des objets linéaires des espaces verts';


	
-- ################################################################# TABLE geo_ev_polygon ###############################################

-- Table: m_espace_vert_v2.geo_ev_polygon

-- DROP TABLE m_espace_vert_v2.geo_ev_polygon;
  CREATE TABLE m_espace_vert_v2.geo_ev_polygon
(
  idobjet bigint NOT NULL,
  sup_m2 integer,
  perimetre integer,
  geom geometry(multipolygon,2154),
  CONSTRAINT geo_ev_polygon_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_polygon
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.geo_ev_polygon
    IS 'Table géographique de la classe des objets polygones des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_polygon.idobjet
    IS 'Identifiant des objets espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_polygon.sup_m2
    IS 'Surface en m²';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_polygon.perimetre
    IS 'Périmètre des objets surfaciques en mètre';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_polygon.geom
    IS 'Géométrie des objets espace vert surfacique';

-- Constraint: an_ev_objet_polygon_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_objet DROP CONSTRAINT an_ev_objet_polygon_fkey;

ALTER TABLE m_espace_vert_v2.geo_ev_polygon
    ADD CONSTRAINT geo_ev_polygon_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.an_ev_objet (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT geo_ev_polygon_fkey ON m_espace_vert_v2.geo_ev_polygon
    IS 'Clé étrangère sur la classe des objets polygon des espaces verts';
    
    
-- ################################################################# TABLE geo_ev_site ###############################################

-- Table: m_espace_vert_v2.geo_ev_site

-- DROP TABLE m_espace_vert_v2.geo_ev_site; 

  CREATE TABLE m_espace_vert_v2.geo_ev_site
(
  idsite integer NOT NULL,
  nom character varying(100),
  typ character varying(2), -- liste valeur lt_ev_typsite
  geom geometry(multipolygon,2154),
  CONSTRAINT geo_ev_site_pkey PRIMARY KEY (idsite)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_site
    OWNER to sig_create;

COMMENT ON TABLE m_espace_vert_v2.geo_ev_site
    IS 'Table géographique de la classe des objets des sites cohérents';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_site.idsite
    IS 'Identifiant des sites cohérent';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_site.nom
    IS 'Libellé du site cohérent';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_site.typ
    IS 'Type de site cohérent';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_site.geom
    IS 'Géométrie des objets site cohérent surfacique';
    
-- Constraint: geo_ev_site_fkey

-- ALTER TABLE m_espace_vert_v2.geo_ev_site DROP CONSTRAINT geo_ev_site_fkey;

ALTER TABLE m_espace_vert_v2.geo_ev_site
    ADD CONSTRAINT geo_ev_site_typ_fkey FOREIGN KEY (typ)
    REFERENCES m_espace_vert_v2.lt_ev_typsite (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT geo_ev_site_typ_fkey ON m_espace_vert_v2.geo_ev_site
    IS 'Clé étrangère sur le liste des valeurs d''un type de site';

-- ################################################################# TABLE geo_ev_zone_gestion ###############################################
 
 -- Table: m_espace_vert_v2.geo_ev_zone_gestion

-- DROP TABLE m_espace_vert_v2.geo_ev_zone_gestion;

CREATE TABLE m_espace_vert_v2.geo_ev_zone_gestion
(
    idzone integer NOT NULL,
    nom_zone character varying(50) COLLATE pg_catalog."default",
    sup_m2 integer,
    geom geometry(MultiPolygon,2154),
    CONSTRAINT geo_ev_zone_gestion_pkey PRIMARY KEY (idzone)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_zone_gestion
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.geo_ev_zone_gestion
    IS 'Table contenant la géométrie des zones de gestion des espaces verts de la ville de Compiègne dont la source est issue d''un fichier de dessin Autocad fourni par le service EV.';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_zone_gestion.idzone
    IS 'identifiant unique de la zone';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_zone_gestion.nom_zone
    IS 'nom de la zone de gestion';

COMMENT ON COLUMN m_espace_vert_v2.geo_ev_zone_gestion.sup_m2
    IS 'superficie en m²';

 
-- ################################################################ TABLE an_ev_arbre #####################################

-- Table: m_espace_vert_v2.an_ev_arbre

-- DROP TABLE m_espace_vert_v2.an_ev_arbre;

CREATE TABLE m_espace_vert_v2.an_ev_arbre
(
    idobjet bigint NOT NULL,
    nom character varying(50) COLLATE pg_catalog."default",
    genre character varying(20) COLLATE pg_catalog."default",
    espece character varying(20) COLLATE pg_catalog."default",
    hauteur character varying(2) COLLATE pg_catalog."default",
    circonf double precision,
    forme character varying(2) COLLATE pg_catalog."default",
    etat_gen character varying(30) COLLATE pg_catalog."default",
    implant character varying(2) COLLATE pg_catalog."default",
    remarq character varying(3) COLLATE pg_catalog."default",
    malad_obs character varying(3) COLLATE pg_catalog."default",
    malad_nom character varying(80) COLLATE pg_catalog."default",
    danger character varying(2) COLLATE pg_catalog."default",
    natur_sol character varying(2) COLLATE pg_catalog."default",
    envnmt_obs character varying(254) COLLATE pg_catalog."default",
    utilis_obs character varying(254) COLLATE pg_catalog."default",
    cplt_fic_1 character varying(254) COLLATE pg_catalog."default",
    cplt_fic_2 character varying(254) COLLATE pg_catalog."default",
    gps_date date,
    gnss_heigh double precision,
    vert_prec double precision,
    horz_prec double precision,
    northing double precision,
    easting double precision,
    CONSTRAINT geo_ev_arbres_pkey_idobjet PRIMARY KEY (idobjet)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_arbre
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.an_ev_arbre
    IS 'Donnée issue du levé terrain réalisé à l''aide du GPS par les apprentis du service Espaces verts de la Ville de Compiègne et complété par l''inventaire cartographique en 2021';

ALTER TABLE m_espace_vert_v2.an_ev_arbre
    ADD CONSTRAINT lt_ev_arbrehauteur_fkey FOREIGN KEY (hauteur)
    REFERENCES m_espace_vert_v2.lt_ev_arbrehauteur (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
	ALTER TABLE m_espace_vert_v2.an_ev_arbre
    ADD CONSTRAINT lt_ev_arbreforme_fkey FOREIGN KEY (forme)
    REFERENCES m_espace_vert_v2.lt_ev_arbreforme (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
		ALTER TABLE m_espace_vert_v2.an_ev_arbre
    ADD CONSTRAINT lt_ev_arbreimplant_fkey FOREIGN KEY (implant)
    REFERENCES m_espace_vert_v2.lt_ev_arbreimplant (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
			ALTER TABLE m_espace_vert_v2.an_ev_arbre
    ADD CONSTRAINT lt_ev_arbredanger_fkey FOREIGN KEY (danger)
    REFERENCES m_espace_vert_v2.lt_ev_arbredanger (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
				ALTER TABLE m_espace_vert_v2.an_ev_arbre
    ADD CONSTRAINT lt_ev_arbresol_fkey FOREIGN KEY (natur_sol)
    REFERENCES m_espace_vert_v2.lt_ev_arbresol (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                CLE ETRANGERE DEPENDANTE                                        		    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Constraint: an_ev_geohaie_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geohaie DROP CONSTRAINT an_ev_geohaie_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geohaie
    ADD CONSTRAINT an_ev_geohaie_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.geo_ev_line (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT an_ev_geohaie_fkey ON m_espace_vert_v2.an_ev_geohaie
    IS 'Clé étrangère sur la classe des objets linéaires des espaces verts';
    
-- Constraint: an_ev_geoline_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geoline DROP CONSTRAINT an_ev_geoline_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geoline
    ADD CONSTRAINT an_ev_geoline_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.geo_ev_line (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT an_ev_geoline_fkey ON m_espace_vert_v2.an_ev_geoline
    IS 'Clé étrangère sur la classe des objets linéaires des espaces verts';

-- Constraint: an_ev_geovegetal_pct_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geovegetal DROP CONSTRAINT an_ev_geovegetal_pct_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    ADD CONSTRAINT an_ev_geovegetal_pct_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.geo_ev_pct (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT an_ev_geovegetal_pct_fkey ON m_espace_vert_v2.an_ev_geovegetal
    IS 'Clé étrangère sur la classe des objets ponctuels des espaces verts';
    
    -- Constraint: an_ev_geovegetal_lin_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geovegetal DROP CONSTRAINT an_ev_geovegetal_lin_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    ADD CONSTRAINT an_ev_geovegetal_lin_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.geo_ev_line (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT an_ev_geovegetal_lin_fkey ON m_espace_vert_v2.an_ev_geovegetal
    IS 'Clé étrangère sur la classe des objets linéaire des espaces verts';

    -- Constraint: an_ev_geovegetal_polygon_fkey

-- ALTER TABLE m_espace_vert_v2.an_ev_geovegetal DROP CONSTRAINT an_ev_geovegetal_polygon_fkey;

ALTER TABLE m_espace_vert_v2.an_ev_geovegetal
    ADD CONSTRAINT an_ev_geovegetal_polygon_fkey FOREIGN KEY (idobjet)
    REFERENCES m_espace_vert_v2.geo_ev_line (idobjet) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT an_ev_geovegetal_polygon_fkey ON m_espace_vert_v2.an_ev_geovegetal
    IS 'Clé étrangère sur la classe des objets polygones des espaces verts';

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX                                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Sans objet
  





