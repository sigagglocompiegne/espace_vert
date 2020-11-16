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

/*
-- Schema: m_espace_vert

-- DROP SCHEMA m_espace_vert;

CREATE SCHEMA m_espace_vert
  AUTHORIZATION sig_create;
  
COMMENT ON SCHEMA m_espace_vert
  IS 'Données métiers sur le thème des espaces verts';
  
*/

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                SEQUENCE                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

DROP SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq;

-- ################################################################# Séquence sur TABLE an_objet_ev ###############################################

-- SEQUENCE: m_espace_vert.an_ev_objet_idobjet_seq

-- DROP SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq;

CREATE SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq
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

DROP TABLE IF EXISTS  m_espace_vert.lt_ev_doma;
DROP TABLE IF EXISTS  m_espace_vert.lt_ev_typev1;
DROP TABLE IF EXISTS  m_espace_vert.lt_ev_typev2;
DROP TABLE IF EXISTS  m_espace_vert.lt_ev_typev3;
DROP TABLE IF EXISTS  m_espace_vert.lt_ev_typsite;
DROP TABLE IF EXISTS m_espace_vert.an_objet_ev;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_point;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_line;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_polygon;
DROP TABLE IF EXISTS m_espace_vert.geo_ev_site; 

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE DE VALEURS                                                            ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

    
-- Table: m_espace_vert.lt_ev_doma 

-- DROP TABLE m_espace_vert.lt_ev_doma ;

CREATE TABLE m_espace_vert.lt_ev_doma 
(
    code character varying(2) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_doma_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

COMMENT ON TABLE m_espace_vert.lt_ev_doma 
    IS 'Domaine de valeur de la domanialité';

COMMENT ON COLUMN m_espace_vert.lt_ev_doma .code
    IS 'code';

COMMENT ON COLUMN m_espace_vert.lt_ev_doma .valeur
    IS 'valeur';

INSERT INTO m_espace_vert.lt_ev_doma (
            code, valeur)
    VALUES
  ('00','Non renseignée'),
	('10','Publique'),
	('20','Privée (non déterminé)'),
	('21','Privée (communale)'),
	('22','Privée (autre organisme public)'),
	('23','Privée');  
  
-- Table: m_espace_vert.lt_ev_typev1

-- DROP TABLE m_espace_vert.lt_ev_typev1;

CREATE TABLE m_espace_vert.lt_ev_typev1
(
    code character varying(1) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typev1_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert.lt_ev_typev1
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 1';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev1.code
    IS 'code';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev1.valeur
    IS 'valeur';

INSERT INTO m_espace_vert.lt_ev_typev1(
            code, valeur)
    VALUES
    ('1','Végétal'),
    ('2','Minéral'),
    ('3','Hydrographie'),
    ('9','Référence non classée')	;
    
-- Table: m_espace_vert.lt_ev_typev2

-- DROP TABLE m_espace_vert.lt_ev_typev2;

CREATE TABLE m_espace_vert.lt_ev_typev2
(
    code character varying(3) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typev2_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert.lt_ev_typev2
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 2';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev2.code
    IS 'code';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev2.valeur
    IS 'valeur';

INSERT INTO m_espace_vert.lt_ev_typev2(
            code, valeur)
    VALUES
  ('101','Arbre'),
	('102','Espace enherbé'),
	('103','Espace planté'),
	('104','Ponctuel fleuri'),
  ('105','Haie, mur'),
	('106','Friche'),
	('201','Allée'),
	('202','Clôture'),
	('203','Zone de rencontre'),
	('204','Accès'),
  	('205','Equipement'),
	('301','Bassin'),
	('302','Points d''eau'),
	('303','Cours d''eau'),
	('999','Référence non classée');


-- Table: m_espace_vert.lt_ev_typev3

-- DROP TABLE m_espace_vert.lt_ev_typev3;

CREATE TABLE m_espace_vert.lt_ev_typev3
(
    code character varying(5) COLLATE pg_catalog."default" NOT NULL,
    valeur character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT lt_ev_typev3_pkey PRIMARY KEY (code)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;



COMMENT ON TABLE m_espace_vert.lt_ev_typev3
    IS 'Domaine de valeur de l''attribut code nomenclature de l''inventaire cartographique des espaces verts niveau 3';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev3.code
    IS 'code';

COMMENT ON COLUMN m_espace_vert.lt_ev_typev3.valeur
    IS 'valeur';
    
 INSERT INTO m_espace_vert.lt_ev_typev3(
            code, valeur)
    VALUES
   
   -- en attente retour service espace vert
   
   ;	   
  
  
-- Table: m_espace_vert.lt_ev_typsite

-- DROP TABLE m_espace_vert.lt_ev_typsite;

CREATE TABLE m_espace_vert.lt_ev_typsite
(
  code character varying(2) NOT NULL, -- code du type de site intégrant les objets des espaces verts
  valeur character varying(100), -- libellé du type de site intégrant les objets des espaces verts
  CONSTRAINT lt_ev_typsite_pkkey PRIMARY KEY (code) -- Clé primaire de la table lt_ev_typsite
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_espace_vert.lt_ev_typsite
    IS 'Liste de valeurs des codes du type de site intégrant les objets des espaces verts';

COMMENT ON COLUMN m_espace_vert.lt_ev_typsite.code
    IS 'code du type de site intégrant les objets des espaces verts';

COMMENT ON COLUMN m_espace_vert.lt_ev_typsite.valeur
    IS 'libellé du type de site intégrant les objets des espaces verts';
COMMENT ON CONSTRAINT lt_ev_typsite_pkkey ON m_espace_vert.lt_ev_typsite
    IS 'Clé primaire de la table lt_ev_typsite';

COMMENT ON TABLE m_espace_vert.lt_ev_typsite
  IS 'Liste de valeurs des codes du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_typsite.code IS 'code du type de site intégrant les objets des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_typsite.valeur IS 'libellé du type de site intégrant les objets des espaces verts';

COMMENT ON CONSTRAINT lt_ev_typsite_pkkey ON m_espace_vert.lt_ev_typsite IS 'Clé primaire de la table lt_ev_typsite';

INSERT INTO m_espace_vert.lt_ev_typsite(
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


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                TABLE                                                           		    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE an_objet_ev ###############################################

-- Table: m_espace_vert.an_objet_ev

-- DROP TABLE m_espace_vert.an_objet_ev;

CREATE TABLE m_espace_vert.an_objet_ev
(
  idobjet integer NOT NULL,
  idzone integer,
  idsite integer,
  idcontrat integer,
  insee character varying(5),
  commune character varying(80),
  quartier character varying(80),
  doma_d character varying(2),
  doma_r character varying(2),
  typev1 character varying(1),
  typev2 character varying(3),
  typev3 character varying(5),
  srcgeom_sai character varying(2),
  srcdate_sai integer,
  srcgeom_maj character varying(2),
  srcdate_maj integer,
  qualglocxy character varying(2), -- cf lister de valeurs dans PEI
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

ALTER TABLE m_espace_vert.an_objet_ev
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_objet_ev TO read_sig;

GRANT ALL ON TABLE m_espace_vert.an_objet_ev TO sig_create;

GRANT ALL ON TABLE m_espace_vert.an_objet_ev TO create_sig;

ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_typev1_fkey FOREIGN KEY (typev1)
    REFERENCES m_espace_vert.lt_ev_typev1 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typev1_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 1';
    
ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_typev2_fkey FOREIGN KEY (typev2)
    REFERENCES m_espace_vert.lt_ev_typev2 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typev2_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 2';

ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_typev3_fkey FOREIGN KEY (typev3)
    REFERENCES m_espace_vert.lt_ev_typev3 (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_typev3_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des espaces verts de niveau 3';
 
 ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_src_geomsai_fkey FOREIGN KEY (srcgeom_sai)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

     
COMMENT ON CONSTRAINT lt_src_geomsai_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de saisis'; 
    
 ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_src_geommaj_fkey FOREIGN KEY (srcgeom_maj)
    REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_src_geommaj_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature des référentiels géographiques de mise à jour';

-- Constraint: lt_ev_qualglocxy_kkey

-- ALTER TABLE m_espace_vert.an_objet_ev DROP CONSTRAINT lt_ev_qualglocxy_kkey;

ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_qualglocxy_fkey FOREIGN KEY (qualglocxy)
    REFERENCES m_espace_vert.lt_ev_qualglocxy (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_qualglocxy_kkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la nomenclature de la qualité de positionnement planimétrique';

-- Constraint: lt_ev_domad_fkey

-- ALTER TABLE m_espace_vert.an_objet_ev DROP CONSTRAINT lt_ev_domad_fkey;

ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_domad_fkey FOREIGN KEY (doma_d)
    REFERENCES m_espace_vert.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_doma_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la valeur de la domanialité déduite';

 -- Constraint: lt_ev_domar_fkey

-- ALTER TABLE m_espace_vert.an_objet_ev DROP CONSTRAINT lt_ev_domar_fkey;

	ALTER TABLE m_espace_vert.an_objet_ev
    ADD CONSTRAINT lt_ev_domar_fkey FOREIGN KEY (doma_r)
    REFERENCES m_espace_vert.lt_ev_doma (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT lt_ev_domar_fkey ON m_espace_vert.an_objet_ev
    IS 'Clé étrangère sur la valeur de la domanialité réelle';

-- ################################################################# TABLE geo_ev_point ###############################################

-- Table: m_espace_vert.geo_ev_point

-- DROP TABLE m_espace_vert.geo_ev_point;
  
CREATE TABLE m_espace_vert.geo_ev_point
(
  idobjet integer NOT NULL,
  x_l93 numeric(10,3),
  y_l93 numeric(10,3),
  geom geometry(point,2154),
  CONSTRAINT geo_ev_point_pkey PRIMARY KEY (idobjet)
                    )
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert.geo_ev_point
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_point TO read_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_point TO sig_create;

GRANT ALL ON TABLE m_espace_vert.geo_ev_point TO create_sig;

-- ################################################################# TABLE geo_ev_line ###############################################

-- Table: m_espace_vert.geo_ev_line

-- DROP TABLE m_espace_vert.geo_ev_line;
  
  CREATE TABLE m_espace_vert.geo_ev_line      -- prévoir 2 options avec ou sans ligne (indiquer dans surface périmètre et calcul auto de la longueur si haie ?))
(
  idobjet integer NOT NULL,
  long_m integer,
  larg_cm integer,
  geom geometry(linestring,2154),
  CONSTRAINT geo_ev_line_pkey PRIMARY KEY (idobjet)
  -- mettre clé étrangère sur lt_src_geom
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert.geo_ev_line
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_line TO read_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_line TO sig_create;

GRANT ALL ON TABLE m_espace_vert.geo_ev_line TO create_sig;

-- ################################################################# TABLE geo_ev_polygon ###############################################

-- Table: m_espace_vert.geo_ev_polygon

-- DROP TABLE m_espace_vert.geo_ev_polygon;
  CREATE TABLE m_espace_vert.geo_ev_polygon
(
  idobjet integer NOT NULL,
  sup_m2 integer,
  perimetre integer,
  long_m integer, -- à dédire du périmètre /2, uniquemelenbt si haie
  geom geometry(polygon,2154),
  CONSTRAINT geo_ev_polygon_pkey PRIMARY KEY (idobjet)
  -- mettre clé étrangère sur lt_src_geom
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert.geo_ev_polygon
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_polygon TO read_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_polygon TO sig_create;

GRANT ALL ON TABLE m_espace_vert.geo_ev_polygon TO create_sig;

-- ################################################################# TABLE geo_ev_site ###############################################

-- Table: m_espace_vert.geo_ev_site

-- DROP TABLE m_espace_vert.geo_ev_site; 

  CREATE TABLE m_espace_vert.geo_ev_site
(
  idsite integer NOT NULL,
  nom character varying(100),
  typ character varying(2), -- liste valeur lt_ev_typsite
  geom geometry(polygon,2154),
  CONSTRAINT geo_ev_site_pkey PRIMARY KEY (idsite)
  -- mettre clé étrangère sur lt_src_geom
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_espace_vert.geo_ev_site
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_ev_site TO read_sig;

GRANT ALL ON TABLE m_espace_vert.geo_ev_site TO sig_create;

GRANT ALL ON TABLE m_espace_vert.geo_ev_site TO create_sig;


-- Constraint: geo_ev_site_fkey

-- ALTER TABLE m_espace_vert.geo_ev_site DROP CONSTRAINT geo_ev_site_fkey;

ALTER TABLE m_espace_vert.geo_ev_site
    ADD CONSTRAINT geo_ev_site_typ_fkey FOREIGN KEY (typ)
    REFERENCES m_espace_vert.lt_ev_typsite (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

COMMENT ON CONSTRAINT geo_ev_site_typ_fkey ON m_espace_vert.geo_ev_site
    IS 'Clé étrangère sur le liste des valeurs d''un type de site';
    
    
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                LOG                                                           		             ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

(à traiter)

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX                                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

Sans objet
  
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                TRIGGERS                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

Sans objet (les triggers pour la gestion sont intégrés au niveau des vues de gestion)




