-- ####################################################################### SCHEMA #####################################################################

-- Schema: m_espace_vert

-- DROP SCHEMA m_espace_vert;

begin;

/* CREATE SCHEMA m_espace_vert
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA m_espace_vert TO postgres;
         
COMMENT ON SCHEMA m_espace_vert
  IS 'Données métier issues du marché "Plan de gestion différenciée - zéro phyto _ Ville de Compiègne" et produites par la societe ECOLogiC';
*/  
  

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINES DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- ####################################################################### lt_ev_type  ################################################################

-- Table: m_espace_vert.lt_ev_type

DROP TABLE if exists m_espace_vert.lt_ev_type;

CREATE TABLE m_espace_vert.lt_ev_type
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,

  CONSTRAINT lt_ev_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.lt_ev_type
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.lt_ev_type TO postgres;

COMMENT ON TABLE m_espace_vert.lt_ev_type
IS 'Code permettant de décrire le type d''espace vert';
COMMENT ON COLUMN m_espace_vert.lt_ev_type.code IS 'Code de la liste énumérée relative au type d''espace vert';
COMMENT ON COLUMN m_espace_vert.lt_ev_type.valeur IS 'Valeur de la liste énumérée relative au type d''espace vert';

INSERT INTO m_espace_vert.lt_ev_type(
            code, valeur)
    VALUES
    ('00','non renseigné'),
    ('01','floral'),
    ('02','végétal'),
    ('03','minéral'),
    ('99','autre');


    
-- ####################################################################### lt_ev_sstype  ################################################################

-- Table: m_espace_vert.lt_ev_sstype

DROP TABLE if exists m_espace_vert.lt_ev_sstype;

CREATE TABLE m_espace_vert.lt_ev_sstype
(
  code character varying(5) NOT NULL,
  valeur character varying(80) NOT NULL,

  CONSTRAINT lt_ev_sstype_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.lt_ev_sstype
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.lt_ev_sstype TO postgres;

COMMENT ON TABLE m_espace_vert.lt_ev_sstype
IS 'Code permettant de décrire le sous-type d''espace vert';
COMMENT ON COLUMN m_espace_vert.lt_ev_sstype.code IS 'Code de la liste énumérée relative au sous-type d''espace vert';
COMMENT ON COLUMN m_espace_vert.lt_ev_sstype.valeur IS 'Valeur de la liste énumérée relative au sous-type d''espace vert';

INSERT INTO m_espace_vert.lt_ev_sstype(
            code, valeur)
    VALUES
    ('00-00','non renseigné'),
    ('01-00','non renseigné'),
    ('01-01','arbre'),
    ('01-02','arbuste'),
    ('01-03','bac, pot'),
    ('01-04','fleurissement'),
    ('01-05','massif'),
    ('01-99','autre'),
    ('02-00','non renseigné'),
    ('02-01','boisement'),
    ('02-02','haie'),
    ('02-03','HLM'),
    ('02-04','pelouse, herbe'),
    ('02-05','privé'),
    ('02-06','zone naturelle'),
    ('02-99','autre'),
    ('03-00','non renseigné'),
    ('03-01','bicouche gravier'),
    ('03-02','enrobé abimé'),
    ('03-03','enrobé, béton, pavé'),
    ('03-04','pavé autobloquant, dalle'),
    ('03-05','pavé autre'),
    ('03-06','stabilisé, calcaire, gravier, terre, schiste'),
    ('03-99','autre');
    
    
    
-- ####################################################################### lt_ev_entretien  ################################################################

-- Table: m_espace_vert.lt_ev_entretien

DROP TABLE if exists m_espace_vert.lt_ev_entretien;

CREATE TABLE m_espace_vert.lt_ev_entretien
(
  code character varying(5) NOT NULL,
  valeur character varying(80) NOT NULL,

  CONSTRAINT lt_ev_entretien_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.lt_ev_entretien
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.lt_ev_entretien TO postgres;

COMMENT ON TABLE m_espace_vert.lt_ev_entretien
IS 'Code permettant de décrire la pratique d''entretien des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_entretien.code IS 'Code de la liste énumérée relative à la pratique d''entretien des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_entretien.valeur IS 'Valeur de la liste énumérée relative à la pratique d''entretien des espaces verts';

INSERT INTO m_espace_vert.lt_ev_entretien(
            code, valeur)
    VALUES
    ('00-00','non renseigné'),
    ('01-00','non renseigné'),
    ('01-01','annuel'),
    ('01-02','arbustif'),
    ('01-03','couvre-sol'),
    ('01-04','herbe'),
    ('01-05','mixte'),
    ('01-06','paillage'),
    ('01-07','terre à nue'),
    ('01-08','vivace'),
    ('01-09','vivace, couvre-sol, paillage'),
    ('01-99','autre'),
    ('01-XX','aucun'),
    ('01-ZZ','non concerné'),
    ('02-00','non renseigné'),
    ('02-01','écopaturage'),
    ('02-02','entretien écologique'),
    ('02-03','fauche tardive'),
    ('02-04','tonte 2x/semaine'),
    ('02-05','tonte différenciée'),
    ('02-06','tonte régulière'),
    ('02-07','tonte très régulière'),
    ('02-99','autre'),
    ('02-XX','aucun'),
    ('02-ZZ','non concerné'),
    ('03-00','non renseigné'),
    ('03-01','chimique'),
    ('03-02','débroussaillage, tonte'),
    ('03-03','enherbement'),
    ('03-04','manuel'),
    ('03-05','mécanique'),
    ('03-06','nettoyeur haute pression'),
    ('03-07','thermique'),
    ('03-08','tolérance et gestion de la flore spontanée'),
    ('03-99','autre'),
    ('03-XX','aucun'),
    ('03-ZZ','non concerné');
    
    

-- ####################################################################### lt_ev_gestion  ################################################################

-- Table: m_espace_vert.lt_ev_gestion

DROP TABLE if exists m_espace_vert.lt_ev_gestion;

CREATE TABLE m_espace_vert.lt_ev_gestion
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,

  CONSTRAINT lt_ev_gestion_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.lt_ev_gestion
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.lt_ev_gestion TO postgres;

COMMENT ON TABLE m_espace_vert.lt_ev_gestion
IS 'Code permettant de décrire la maitrise d''oeuvre de l''entretien des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_gestion.code IS 'Code de la liste énumérée relative à la maitrise d''oeuvre de l''entretien des espaces verts';
COMMENT ON COLUMN m_espace_vert.lt_ev_gestion.valeur IS 'Valeur de la liste énumérée relative à la maitrise d''oeuvre de l''entretien des espaces verts';

INSERT INTO m_espace_vert.lt_ev_gestion(
            code, valeur)
    VALUES
    ('00','non renseigné')
    ('01','régie'),
    ('02','sous-traitance'),
    ('99','autre');  



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TABLES                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ####################################################################### an_ev_type #################################################################  
  
-- Table: m_espace_vert.an_ev_type

DROP TABLE if exists m_espace_vert.an_ev_type;

CREATE TABLE m_espace_vert.an_ev_type
(
  id bigint NOT NULL,
  type_ev character varying(2) NOT NULL,
  sstype_ev character varying(5) NOT NULL,
  insee character varying(5) NOT NULL,
  commune character varying(150) NOT NULL,
  op_sai character varying(80),
  date_sai timestamp without time zone,
  date_maj timestamp without time zone,
  src_geom character varying(2),
  observ character varying(254),
  
  CONSTRAINT an_ev_type_pkey PRIMARY KEY (id),
  CONSTRAINT lt_ev_type_fkey FOREIGN KEY (type_ev)
      REFERENCES m_espace_vert.lt_ev_type (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT lt_ev_sstype_fkey FOREIGN KEY (sstype_ev)
      REFERENCES m_espace_vert.lt_ev_sstype (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT lt_src_geom_fkey FOREIGN KEY (src_geom)
      REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION   
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.an_ev_type
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.an_ev_type TO postgres;

COMMENT ON TABLE m_espace_vert.an_ev_type
IS 'Table alphanumérique principale contenant les informations typologiques sur les objets';
COMMENT ON COLUMN m_espace_vert.an_ev_type.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.an_ev_type.type_ev IS 'Type d''espace vert';
COMMENT ON COLUMN m_espace_vert.an_ev_type.sstype_ev IS 'Sous-type d''espace vert';
COMMENT ON COLUMN m_espace_vert.an_ev_type.insee IS 'Code Insee de la commune';
COMMENT ON COLUMN m_espace_vert.an_ev_type.commune IS 'Nome de la commune';
COMMENT ON COLUMN m_espace_vert.an_ev_type.op_sai IS 'Opérateur de la dernière saisie en base de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_type.date_sai IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_type.date_maj IS 'Horodatage de la mise jour en base de l''objet';
COMMENT ON COLUMN m_espace_vert.an_ev_type.src_geom IS 'Référentiel de saisie';
COMMENT ON COLUMN m_espace_vert.an_ev_type.observ IS 'Observations';

-- Sequence: m_espace_vert.an_ev_type_id_seq

DROP SEQUENCE if exists m_espace_vert.an_ev_type_id_seq;
                    
CREATE SEQUENCE m_espace_vert.an_ev_type_id_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE m_espace_vert.an_ev_type_id_seq
  OWNER TO postgres;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_type_id_seq TO postgres;


                                                                                                                                       
-- ####################################################################### an_ev_entretien ##########################################################  
  
-- Table: m_espace_vert.an_ev_entretien

DROP TABLE if exists m_espace_vert.an_ev_entretien;

CREATE TABLE m_espace_vert.an_ev_entretien
(
  id bigint NOT NULL,
  prat_ini character varying(5),
  preco character varying(5),
  gestion character varying(2),
  
  CONSTRAINT an_ev_entretien_pkey PRIMARY KEY (id),
  CONSTRAINT lt_ev_entretien_prat_ini_fkey FOREIGN KEY (prat_ini)
      REFERENCES m_espace_vert.lt_ev_entretien (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT lt_ev_entretien_preco_fkey FOREIGN KEY (preco)
      REFERENCES m_espace_vert.lt_ev_entretien (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT lt_ev_gestion_fkey FOREIGN KEY (gestion)
      REFERENCES m_espace_vert.lt_ev_gestion (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION        
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.an_ev_entretien
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.an_ev_entretien TO postgres;

COMMENT ON TABLE m_espace_vert.an_ev_entretien
IS 'Table alphanumérique contenant les informations d''entretien et de gestion des espaces verts';
COMMENT ON COLUMN m_espace_vert.an_ev_entretien.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.an_ev_entretien.prat_ini IS 'Pratique d''entretien initial appliquée lors du diagnostic';
COMMENT ON COLUMN m_espace_vert.an_ev_entretien.preco IS 'Préconisation d''entretien conseillé à l''avenir';
COMMENT ON COLUMN m_espace_vert.an_ev_entretien.gestion IS 'Maitrise d''oeuvre de l''entretien';



-- ####################################################################### geo_ev_s #################################################################  
  
-- Table: m_espace_vert.geo_ev_s

DROP TABLE if exists m_espace_vert.geo_ev_s;

CREATE TABLE m_espace_vert.geo_ev_s
(
  id bigint NOT NULL,
  sup_m2 integer,
  geom geometry (MultiPolygon,2154),
  
  CONSTRAINT geo_ev_s_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.geo_ev_s
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.geo_ev_s TO postgres;

COMMENT ON TABLE m_espace_vert.geo_ev_s
IS 'Table géographique contenant les objets surfaciques espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_s.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_s.sup_m2 IS 'Superficie en m²';
COMMENT ON COLUMN m_espace_vert.geo_ev_s.geom IS 'Géométrie de l''objet';



-- ####################################################################### geo_ev_l #################################################################  
  
-- Table: m_espace_vert.geo_ev_l

DROP TABLE if exists m_espace_vert.geo_ev_l;

CREATE TABLE m_espace_vert.geo_ev_l
(
  id bigint NOT NULL,
  long_m integer,
  geom geometry (MultiLineString,2154),
  
  CONSTRAINT geo_ev_l_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.geo_ev_l
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.geo_ev_l TO postgres;

COMMENT ON TABLE m_espace_vert.geo_ev_l
IS 'Table géographique contenant les objets linéaires espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_l.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_l.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_ev_l.geom IS 'Géométrie de l''objet';



-- ####################################################################### geo_ev_p #################################################################  
  
-- Table: m_espace_vert.geo_ev_p

DROP TABLE if exists m_espace_vert.geo_ev_p;

CREATE TABLE m_espace_vert.geo_ev_p
(
  id bigint NOT NULL,
  geom geometry (Point,2154),
  
  CONSTRAINT geo_ev_p_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.geo_ev_p
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.geo_ev_p TO postgres;

COMMENT ON TABLE m_espace_vert.geo_ev_p
IS 'Table géographique contenant les objets ponctuels espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_p.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_p.geom IS 'Géométrie de l''objet';



-- ############################################################### geo_ev_espece_invasive ############################################################  
  
-- Table: m_espace_vert.geo_ev_espece_invasive

DROP TABLE if exists m_espace_vert.geo_ev_espece_invasive;

CREATE TABLE m_espace_vert.geo_ev_espece_invasive
(
  id bigint NOT NULL,
  nom_esp character varying(100),
  insee character varying(5) NOT NULL,
  commune character varying(150) NOT NULL,
  geom geometry (Point,2154),
  
  CONSTRAINT geo_ev_espece_invasive_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_espace_vert.geo_ev_espece_invasive
  OWNER TO postgres;
GRANT ALL ON TABLE m_espace_vert.geo_ev_espece_invasive TO postgres;

COMMENT ON TABLE m_espace_vert.geo_ev_espece_invasive
IS 'table géographique ponctuelle répertoriant les espèces invasives';
COMMENT ON COLUMN m_espace_vert.geo_ev_espece_invasive.id IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_ev_espece_invasive.nom_esp IS 'Nom de l''espèce végétale exotique envahissante'
COMMENT ON COLUMN m_espace_vert.an_ev_type.insee IS 'Code Insee de la commune';
COMMENT ON COLUMN m_espace_vert.an_ev_type.commune IS 'Nome de la commune';
COMMENT ON COLUMN m_espace_vert.geo_ev_espece_invasive.geom IS 'Géométrie de l''objet';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       INDEX                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Index: m_espace_vert.geo_ev_s_geom_idx

DROP INDEX if exists m_espace_vert.geo_ev_s_geom_idx;

CREATE INDEX geo_ev_s_geom_idx
  ON m_espace_vert.geo_ev_s
  USING gist
(geom);

-- Index: m_espace_vert.geo_ev_l_geom_idx

DROP INDEX if exists m_espace_vert.geo_ev_l_geom_idx;

CREATE INDEX geo_ev_l_geom_idx
  ON m_espace_vert.geo_ev_l
  USING gist
(geom);

-- Index: m_espace_vert.geo_ev_p_geom_idx

DROP INDEX if exists m_espace_vert.geo_ev_p_geom_idx;

CREATE INDEX geo_ev_p_geom_idx
  ON m_espace_vert.geo_ev_p
  USING gist
(geom);

-- Index: m_espace_vert.geo_ev_espece_invasive_geom_idx

DROP INDEX if exists m_espace_vert.geo_ev_espece_invasive_geom_idx;

CREATE INDEX geo_ev_espece_invasive_geom_idx
  ON m_espace_vert.geo_ev_espece_invasive
  USING gist
(geom);



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGERS                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Function: m_espace_vert.ft_an_ev_type_type_ev()

DROP FUNCTION if exists m_espace_vert.ft_an_ev_type_type_ev();

CREATE OR REPLACE FUNCTION m_espace_vert.ft_an_ev_type_type_ev()
  RETURNS trigger AS
$BODY$

BEGIN

NEW.type_ev := left(NEW.sstype_ev,2);

RETURN NEW;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_espace_vert.ft_an_ev_type_type_ev()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_an_ev_type_type_ev() TO public;
									   
COMMENT ON FUNCTION m_espace_vert.ft_an_ev_type_type_ev() IS 'Fonction trigger permettant de renseigner le type d''espace vert à partir du sous-type';

-- Trigger: t_t1_insert_update_sstype_ev on m_espace_vert.an_ev_type

DROP TRIGGER if exists t_t1_insert_update_sstype_ev ON m_espace_vert.an_ev_type;

CREATE TRIGGER t_t1_insert_update_sstype_ev
  BEFORE INSERT OR UPDATE
  ON m_espace_vert.an_ev_type
  FOR EACH ROW
EXECUTE PROCEDURE m_espace_vert.ft_an_ev_type_type_ev();



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                 VUES APPLICATIVES                                                            ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################
 
-- View: x_apps.xapps_geo_v_ev_floral_s

-- DROP VIEW x_apps.xapps_geo_v_ev_floral_s;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_floral_s AS 
 SELECT 
 z.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 z.sup_m2,
 t.observ,
 z.geom
   FROM m_espace_vert.geo_ev_s z    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = z.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = z.id
   
   WHERE  t.type_ev = '01';


ALTER TABLE x_apps.xapps_geo_v_ev_floral_s
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_floral_s TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_floral_s
IS 'Vue applicative sur les données surfaciques d''espace vert de type floral';

-- View: x_apps.xapps_geo_v_ev_floral_p

-- DROP VIEW x_apps.xapps_geo_v_ev_floral_p;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_floral_p AS 
 SELECT 
 x.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 t.observ,
 x.geom
   FROM m_espace_vert.geo_ev_p x    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = x.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = x.id
   
   WHERE  t.type_ev = '01';


ALTER TABLE x_apps.xapps_geo_v_ev_floral_p
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_floral_p TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_floral_p
IS 'Vue applicative sur les données ponctuelles d''espace vert de type floral';

-- View: x_apps.xapps_geo_v_ev_vegetal_s

-- DROP VIEW x_apps.xapps_geo_v_ev_vegetal_s;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_vegetal_s AS 
 SELECT 
 z.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 z.sup_m2,
 t.observ,
 z.geom
   FROM m_espace_vert.geo_ev_s z    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = z.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = z.id
   
   WHERE  t.type_ev = '02';


ALTER TABLE x_apps.xapps_geo_v_ev_vegetal_s
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_vegetal_s TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_vegetal_s
IS 'Vue applicative sur les données surfaciques d''espace vert de type végétal';

-- View: x_apps.xapps_geo_v_ev_vegetal_l

-- DROP VIEW x_apps.xapps_geo_v_ev_vegetal_l;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_vegetal_l AS 
 SELECT 
 y.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 y.long_m,
 t.observ,
 y.geom
   FROM m_espace_vert.geo_ev_l y    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = y.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = y.id
   
   WHERE  t.type_ev = '02';


ALTER TABLE x_apps.xapps_geo_v_ev_vegetal_l
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_vegetal_l TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_vegetal_l
IS 'Vue applicative sur les données linéaires d''espace vert de type végétal';

-- View: x_apps.xapps_geo_v_ev_mineral_s

-- DROP VIEW x_apps.xapps_geo_v_ev_mineral_s;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_mineral_s AS 
 SELECT 
 z.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 z.sup_m2,
 t.observ,
 z.geom
   FROM m_espace_vert.geo_ev_s z    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = z.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = z.id
   
   WHERE  t.type_ev = '03';


ALTER TABLE x_apps.xapps_geo_v_ev_mineral_s
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_mineral_s TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_mineral_s
IS 'Vue applicative sur les données surfaciques d''espace vert de type minéral';

-- View: x_apps.xapps_geo_v_ev_mineral_l

-- DROP VIEW x_apps.xapps_geo_v_ev_mineral_l;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_ev_mineral_l AS 
 SELECT 
 y.id,
 t.type_ev,
 t.sstype_ev,
 e.prat_ini,
 e.preco,
 e.gestion,
 t.insee,
 t.commune,
 t.op_sai,
 t.date_sai,
 t.date_maj,
 t.src_geom,
 y.long_m,
 t.observ,
 y.geom
   FROM m_espace_vert.geo_ev_l y    
   LEFT JOIN m_espace_vert.an_ev_type t ON t.id = y.id
   LEFT JOIN m_espace_vert.an_ev_entretien e ON e.id = y.id
   
   WHERE  t.type_ev = '03';


ALTER TABLE x_apps.xapps_geo_v_ev_mineral_l
  OWNER TO postgres;
GRANT ALL ON TABLE x_apps.xapps_geo_v_ev_mineral_l TO postgres;

COMMENT ON VIEW x_apps.xapps_geo_v_ev_mineral_l
IS 'Vue applicative sur les données linéaires d''espace vert de type minéral';


commit;
