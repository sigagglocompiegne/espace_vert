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

-- DROP SCHEMA m_espace_vert_v2;

CREATE SCHEMA m_espace_vert_v2
  AUTHORIZATION create_sig;
  
COMMENT ON SCHEMA m_espace_vert_v2
  IS 'Données métiers sur le thème des espaces verts';

GRANT ALL ON SCHEMA m_espace_vert TO create_sig;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO sig_create;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT SELECT ON TABLES TO sig_read;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO create_sig;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
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
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_type;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_sstype;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_typsite;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_gestion;
DROP TABLE IF EXISTS  m_espace_vert_v2.lt_ev_entretien;
DROP TABLE IF EXISTS m_espace_vert_v2.an_objet_ev;
DROP TABLE IF EXISTS m_espace_vert_v2.an_ev_arbre;
DROP TABLE IF EXISTS m_espace_vert_v2.geo_ev_point;
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
    IS 'code';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_doma .valeur
    IS 'valeur';

INSERT INTO m_espace_vert_v2.lt_ev_doma (
            code, valeur)
    VALUES
    ('00','Non renseignée'),
	('10','Publique'),
	('20','Privée (non déterminé)'),
	('21','Privée (communale)'),
	('22','Privée (autre organisme public, HLM, ...)'),
	('23','Privée');  

-- ################################################################# lt_ev_type ###############################################

-- Table: m_espace_vert_v2.lt_ev_type

-- DROP TABLE m_espace_vert_v2.lt_ev_type;

CREATE TABLE m_espace_vert_v2.lt_ev_type
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_type_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_type
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 1';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_type.code
    IS 'code';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_type.valeur
    IS 'valeur';

INSERT INTO m_espace_vert_v2.lt_ev_type(
            code, valeur)
    VALUES
	('00','Non renseigné'),
    ('01','Floral'),
    ('02','Végétal'),
    ('03','Minéral'),
	('04','Hydrographie'),
    ('99','Référence non classée');

-- ################################################################# lt_ev_sstype ###############################################

-- Table: m_espace_vert_v2.lt_ev_sstype

-- DROP TABLE m_espace_vert_v2.lt_ev_sstype;

CREATE TABLE m_espace_vert_v2.lt_ev_sstype
(
    code character varying(5) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_sstype_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_sstype
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 2';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_sstype.code
    IS 'code';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_sstype.valeur
    IS 'valeur';

INSERT INTO m_espace_vert_v2.lt_ev_sstype(
            code, valeur)
    VALUES
('00-00','Non renseigné'),
('01-00','Non renseigné'),
('01-01','Arbre'),
('01-02','Arbuste'),
('01-03','Contenant artificiel (bac, pot, suspension, jardinière ...)'),
('01-04','Fleurissement'), -- devrait être supprimé ici ?
('01-05','Massif'),
('01-99','Autre'),
('02-00','Non renseigné'),
('02-01','Zone boisée'),
('02-02','Haie'),
('02-04','Pelouse, herbe'),
('02-05','Privé'),
('02-06','Zone naturelle'),
('02-99','Autre'),
('03-00','Non renseigné'),
('03-01','Bicouche gravier'),
('03-02','Enrobé abimé'),
('03-03','Enrobé, béton, pavé'),
('03-04','Pavé autobloquant, dalle'),
('03-05','Pavé autre'),
('03-06','Stabilisé, calcaire, gravier, terre, schiste'),
('03-99','Autre'),
('04-00','Non renseigné'),
('04-01','Fontaine'),
('04-02','Bassin'),
('04-99','Autre'),
('99-00','Non renseigné'),
('99-99','Autre');
	   
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

-- ################################################################# lt_ev_gestion ###############################################

-- Table: m_espace_vert_v2.lt_ev_gestion

-- DROP TABLE m_espace_vert_v2.lt_ev_gestion;

CREATE TABLE m_espace_vert_v2.lt_ev_gestion
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT lt_ev_gestion_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_gestion
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.lt_ev_gestion
    IS 'Code permettant de décrire la maitrise d''oeuvre de l''entretien des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_gestion.code
    IS 'Code de la liste énumérée relative à la maitrise d''oeuvre de l''entretien des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_gestion.valeur
    IS 'Valeur de la liste énumérée relative à la maitrise d''oeuvre de l''entretien des espaces verts';

COMMENT ON CONSTRAINT lt_ev_gestion_pkey ON m_espace_vert_v2.lt_ev_gestion IS 'Clé primaire de la table lt_ev_gestion';

INSERT INTO m_espace_vert_v2.lt_ev_gestion(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('01','Régie'),
  ('02','Sous-traitance'),
  ('99','Autre');

-- ################################################################# lt_ev_entretien ###############################################

-- Table: m_espace_vert_v2.lt_ev_entretien

-- DROP TABLE m_espace_vert_v2.lt_ev_entretien;

CREATE TABLE m_espace_vert_v2.lt_ev_entretien
(
    code character varying(5) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT lt_ev_entretien_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.lt_ev_entretien
    OWNER to create_sig;

COMMENT ON TABLE m_espace_vert_v2.lt_ev_entretien
    IS 'Code permettant de décrire la pratique d''entretien des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_entretien.code
    IS 'Code de la liste énumérée relative à la pratique d''entretien des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.lt_ev_entretien.valeur
    IS 'Valeur de la liste énumérée relative à la pratique d''entretien des espaces verts';
	
COMMENT ON CONSTRAINT lt_ev_entretien_pkey ON m_espace_vert_v2.lt_ev_entretien IS 'Clé primaire de la table lt_ev_entretien';

INSERT INTO m_espace_vert_v2.lt_ev_entretien(
            code, valeur)
    VALUES
('00-00','Non renseigné'),
('01-00','Non renseigné'),
('01-01','Annuel'),
('01-02','Arbustif'),
('01-03','Couvre-sol'),
('01-04','Herbe'),
('01-05','Mixte'),
('01-06','Paillage'),
('01-07','Terre à nue'),
('01-08','Vivace'),
('01-09','Vivace, couvre-sol, paillage'),
('01-99','Autre'),
('01-XX','Aucun'),
('01-ZZ','Non concerné'),
('02-00','Non renseigné'),
('02-01','Ecopaturage'),
('02-02','Entretien écologique'),
('02-03','Fauche tardive'),
('02-04','Tonte 2x/semaine'),
('02-05','Tonte différenciée'),
('02-06','Tonte régulière'),
('02-07','Tonte très régulière'),
('02-99','Autre'),
('02-XX','Aucun'),
('02-ZZ','Non concerné'),
('03-00','Non renseigné'),
('03-01','Chimique'),
('03-02','Débroussaillage, tonte'),
('03-03','Enherbement'),
('03-04','Manuel'),
('03-05','Mécanique'),
('03-06','Nettoyeur haute pression'),
('03-07','Thermique'),
('03-08','Tolérance et gestion de la flore spontanée'),
('03-99','autre'),
('03-XX','Aucun'),
('03-ZZ','Non concerné');
  
  
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                TABLE                                                           		    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE an_objet_ev ###############################################

-- Table: m_espace_vert_v2.an_objet_ev

-- DROP TABLE m_espace_vert_v2.an_objet_ev;

CREATE TABLE m_espace_vert_v2.an_objet_ev
(
  idobjet bigint NOT NULL,
  idzone integer,
  idsite integer,
  idcontrat integer,
  insee character varying(5),
  commune character varying(80),
  quartier character varying(80),
  doma_d character varying(2),
  doma_r character varying(2),
  typ character varying(2),
  sstyp character varying(5),
  srcgeom_sai character varying(2),
  srcdate_sai integer,
  srcgeom_maj character varying(2),
  srcdate_maj integer,
  op_sai character varying(50),
  op_maj character varying(50),
  dat_sai timestamp without time zone,
  dat_maj timestamp without time zone,
  observ character varying(255),
  CONSTRAINT an_objet_ev_pkey PRIMARY KEY (idobjet)
  -- mettre clé étrangère sur lt_src_geom
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_objet_ev
    OWNER to sig_create;


ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_ev_type_fkey FOREIGN KEY (typ)
    REFERENCES m_espace_vert_v2.lt_ev_type (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_type_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 1';
    
ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_ev_sstyp_fkey FOREIGN KEY (sstyp)
    REFERENCES m_espace_vert_v2.lt_ev_sstype (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_sstyp_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 2';

 
 ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_src_geomsai_fkey FOREIGN KEY (srcgeom_sai)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

     
COMMENT ON CONSTRAINT lt_src_geomsai_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de saisis'; 
    
 ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_src_geommaj_fkey FOREIGN KEY (srcgeom_maj)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_src_geommaj_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de mise à jour';


-- Constraint: lt_ev_domad_fkey

-- ALTER TABLE m_espace_vert_v2.an_objet_ev DROP CONSTRAINT lt_ev_doma_fkey;

ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_ev_domad_fkey FOREIGN KEY (doma_d)
    REFERENCES m_espace_vert_v2.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_domad_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la valeur de la domanialité déduite';

 -- Constraint: lt_ev_domar_fkey

-- ALTER TABLE m_espace_vert_v2.an_objet_ev DROP CONSTRAINT lt_ev_doma_fkey;

	ALTER TABLE m_espace_vert_v2.an_objet_ev
    ADD CONSTRAINT lt_ev_domar_fkey FOREIGN KEY (doma_r)
    REFERENCES m_espace_vert_v2.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_domar_fkey ON m_espace_vert_v2.an_objet_ev
    IS 'Clé étrangère sur la valeur de la domanialité réelle';

-- ################################################################# TABLE geo_ev_point ###############################################

-- Table: m_espace_vert_v2.geo_ev_point

-- DROP TABLE m_espace_vert_v2.geo_ev_point;
  
CREATE TABLE m_espace_vert_v2.geo_ev_point
(
  idobjet bigint NOT NULL,
  x_l93 numeric(10,3),
  y_l93 numeric(10,3),
  geom geometry(point,2154),
  CONSTRAINT geo_ev_point_pkey PRIMARY KEY (idobjet)
                    )
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_point
    OWNER to sig_create;



-- ################################################################# TABLE geo_ev_line ###############################################

-- Table: m_espace_vert_v2.geo_ev_line

-- DROP TABLE m_espace_vert_v2.geo_ev_line;
  
  CREATE TABLE m_espace_vert_v2.geo_ev_line      
(
  idobjet bigint NOT NULL,
  long_m integer,
  larg_cm integer,
  geom geometry(linestring,2154),
  CONSTRAINT geo_ev_line_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_line
    OWNER to sig_create;



-- ################################################################# TABLE geo_ev_polygon ###############################################

-- Table: m_espace_vert_v2.geo_ev_polygon

-- DROP TABLE m_espace_vert_v2.geo_ev_polygon;
  CREATE TABLE m_espace_vert_v2.geo_ev_polygon
(
  idobjet bigint NOT NULL,
  sup_m2 integer,
  perimetre integer,
  geom geometry(polygon,2154),
  CONSTRAINT geo_ev_polygon_pkey PRIMARY KEY (idobjet)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_polygon
    OWNER to sig_create;



-- ################################################################# TABLE geo_ev_site ###############################################

-- Table: m_espace_vert_v2.geo_ev_site

-- DROP TABLE m_espace_vert_v2.geo_ev_site; 

  CREATE TABLE m_espace_vert_v2.geo_ev_site
(
  idsite integer NOT NULL,
  nom character varying(100),
  typ character varying(2), -- liste valeur lt_ev_typsite
  geom geometry(polygon,2154),
  CONSTRAINT geo_ev_site_pkey PRIMARY KEY (idsite)
  
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.geo_ev_site
    OWNER to sig_create;


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
    genre character(20) COLLATE pg_catalog."default",
    espece character(20) COLLATE pg_catalog."default",
    hauteur character(20) COLLATE pg_catalog."default",
    circonf double precision,
    forme character(20) COLLATE pg_catalog."default",
    etat_gen character(30) COLLATE pg_catalog."default",
    implant character(20) COLLATE pg_catalog."default",
    remarq character(3) COLLATE pg_catalog."default",
    malad_obs character(3) COLLATE pg_catalog."default",
    malad_nom character(80) COLLATE pg_catalog."default",
    danger character(20) COLLATE pg_catalog."default",
    natur_sol character(20) COLLATE pg_catalog."default",
    envnmt_obs character(230) COLLATE pg_catalog."default",
    utilis_obs character(230) COLLATE pg_catalog."default",
    cplt_fic_1 character(230) COLLATE pg_catalog."default",
    cplt_fic_2 character(230) COLLATE pg_catalog."default",
    gps_date date,
    gnss_heigh double precision,
    vert_prec double precision,
    horz_prec double precision,
    northing double precision,
    easting double precision,
    geom geometry(MultiPoint,2154),
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
 
-- ################################################################ TABLE an_ev_entretien #####################################
 
 -- Table: m_espace_vert_v2.an_ev_entretien

-- DROP TABLE m_espace_vert_v2.an_ev_entretien;

CREATE TABLE m_espace_vert_v2.an_ev_entretien
(
    idobjet bigint NOT NULL,
    prat_ini character varying(5) COLLATE pg_catalog."default",
    preco character varying(5) COLLATE pg_catalog."default",
    gestion character varying(2) COLLATE pg_catalog."default",
    CONSTRAINT an_ev_entretien_pkey PRIMARY KEY (idobjet),
    CONSTRAINT lt_ev_entretien_prat_ini_fkey FOREIGN KEY (prat_ini)
        REFERENCES m_espace_vert_v2.lt_ev_entretien (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT lt_ev_entretien_preco_fkey FOREIGN KEY (preco)
        REFERENCES m_espace_vert_v2.lt_ev_entretien (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT lt_ev_gestion_fkey FOREIGN KEY (gestion)
        REFERENCES m_espace_vert_v2.lt_ev_gestion (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert_v2.an_ev_entretien
    OWNER to create_sig;


COMMENT ON TABLE m_espace_vert_v2.an_ev_entretien
    IS 'Table alphanumérique contenant les informations d''entretien et de gestion des espaces verts';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_entretien.idobjet
    IS 'Identifiant unique de l''objet espace vert';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_entretien.prat_ini
    IS 'Pratique d''entretien initial appliquée lors du diagnostic';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_entretien.preco
    IS 'Préconisation d''entretien conseillé à l''avenir';

COMMENT ON COLUMN m_espace_vert_v2.an_ev_entretien.gestion
    IS 'Maitrise d''oeuvre de l''entretien';

    
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                LOG                                                      		                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- (à traiter)

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX                                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Sans objet
  





