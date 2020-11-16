/* ESPACE VERT V1.0*/
/* Creation des vues de gestion */
/* ev_20_vues_gestion.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */

-- View: m_espace_vert.geo_v_ev_line

-- DROP VIEW m_espace_vert.geo_v_ev_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_line
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma_d,
    o.doma_r,
    o.typev1,
    o.typev2,
    o.typev3,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.qualglocxy,
    o.op_sai,
    o.op_maj,
    o.dat_sai,
    o.dat_maj,
    o.observ,
    l.long_m,
    l.larg_cm,
    l.geom
   FROM m_espace_vert.an_objet_ev o
     JOIN m_espace_vert.geo_ev_line l ON o.idobjet = l.idobjet;


-- FUNCTION: m_espace_vert.ft_m_insert_update_ev_line()

-- DROP FUNCTION m_espace_vert.ft_m_insert_update_ev_line();

CREATE FUNCTION m_espace_vert.ft_m_insert_update_ev_line()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

DECLARE v_idobjet integer;

BEGIN

	 	 
IF (TG_OP = 'INSERT') THEN 

v_idobjet := (select (nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass)));

INSERT INTO
	m_espace_vert.an_objet_ev 
SELECT
	v_idobjet, -- idobjet
	null, -- idzone
	null, --(SELECT s.idsite FROM m_espace_vert.geo_ev_site s WHERE st_intersects(s.geom,new.geom) = true), -- idsite
	null, -- idcontrat
	'', --	(select into new.insee string_agg(insee, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- insee
	'', -- (select into new.commune string_agg(commune, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- commune
	'', --(select into new.quartier string_agg(nom, ', ') from r_administratif.geo_adm_quartier where st_intersects(new.geom,geom)), -- quartier
	'00', -- doma_d
	'00', -- doma_r
	new.typev1,
	new.typev2,
	new.typev3,
	new.srcgeom_sai,
	new.srcdate_sai,
	'00', -- srcgeom_maj
	null, -- srcdate_maj
	new.qualglocxy,
	new.op_sai,
	'', -- op_maj
	new.dat_sai,
	null, -- dat_maj
	new.observ;
	
INSERT INTO 
	m_espace_vert.geo_ev_line
SELECT
	v_idobjet, -- idobjet
	new.long_m, 
	new.larg_cm,
	new.geom;

END IF;

IF (TG_OP = 'UPDATE') THEN 

UPDATE m_espace_vert.an_objet_ev SET
    typev1 = new.typev1,
    typev2 = new.typev2,
    typev3 = new.typev3,
    srcgeom_sai = new.srcgeom_sai,
    srcdate_sai = new.srcdate_sai,
    qualglocxy = new.qualglocxy,
    op_sai = new.op_sai,
    dat_sai = new.dat_sai,
    observ = new.observ
WHERE idobjet = new.idobjet;

UPDATE m_espace_vert.geo_ev_line SET
    long_m = new.long_m,
	larg_cm = new.larg_cm,
	geom = new.geom
WHERE idobjet = new.idobjet;

END IF;

IF (TG_OP = 'DELETE') THEN 

DELETE FROM m_espace_vert.an_objet_ev WHERE idobjet = old.idobjet;
DELETE FROM m_espace_vert.geo_ev_line WHERE idobjet = old.idobjet;

END IF;

return new ;

END;

$BODY$;


COMMENT ON FUNCTION m_espace_vert.ft_m_insert_update_ev_line()
    IS 'Fonction gérant l''insertion et la mise à jour des objets linéaires de l''inventaire cartographique des espaces verts';


CREATE TRIGGER t_t1_insert_update_delete_ev_line
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON m_espace_vert.geo_v_ev_line
    FOR EACH ROW
    EXECUTE PROCEDURE m_espace_vert.ft_m_insert_update_ev_line();

-- View: m_espace_vert.geo_v_ev_point

-- DROP VIEW m_espace_vert.geo_v_ev_point;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_point
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma_d,
    o.doma_r,
    o.typev1,
    o.typev2,
    o.typev3,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.qualglocxy,
    o.op_sai,
    o.op_maj,
    o.dat_sai,
    o.dat_maj,
    o.observ,
    p.x_l93,
    p.y_l93,
    p.geom
   FROM m_espace_vert.an_objet_ev o
     JOIN m_espace_vert.geo_ev_point p ON o.idobjet = p.idobjet;

			      -- FUNCTION: m_espace_vert.ft_m_insert_update_ev_point()

-- DROP FUNCTION m_espace_vert.ft_m_insert_update_ev_point();

CREATE FUNCTION m_espace_vert.ft_m_insert_update_ev_point()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

DECLARE v_idobjet integer;

BEGIN

	 	 
IF (TG_OP = 'INSERT') THEN 

v_idobjet := (select (nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass)));

INSERT INTO
	m_espace_vert.an_objet_ev 
SELECT
	v_idobjet, -- idobjet
	null, -- idzone
	null, --(SELECT s.idsite FROM m_espace_vert.geo_ev_site s WHERE st_intersects(s.geom,new.geom) = true), -- idsite
	null, -- idcontrat
	'', --	(select into new.insee string_agg(insee, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- insee
	'', -- (select into new.commune string_agg(commune, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- commune
	'', --(select into new.quartier string_agg(nom, ', ') from r_administratif.geo_adm_quartier where st_intersects(new.geom,geom)), -- quartier
	'00', -- doma_d
	'00', -- doma_r
	new.typev1,
	new.typev2,
	new.typev3,
	new.srcgeom_sai,
	new.srcdate_sai,
	'00', -- srcgeom_maj
	null, -- srcdate_maj
	new.qualglocxy,
	new.op_sai,
	'', -- op_maj
	new.dat_sai,
	null, -- dat_maj
	new.observ;
	
INSERT INTO 
	m_espace_vert.geo_ev_point
SELECT
	v_idobjet, -- idobjet
	st_x(new.geom), -- l_x93
	st_y(new.geom), -- l_y93
	new.geom;

END IF;

IF (TG_OP = 'UPDATE') THEN 

UPDATE m_espace_vert.an_objet_ev SET
    typev1 = new.typev1,
    typev2 = new.typev2,
    typev3 = new.typev3,
    srcgeom_sai = new.srcgeom_sai,
    srcdate_sai = new.srcdate_sai,
    qualglocxy = new.qualglocxy,
    op_sai = new.op_sai,
    dat_sai = new.dat_sai,
    observ = new.observ
WHERE idobjet = new.idobjet;

UPDATE m_espace_vert.geo_ev_point SET
    x_l93 = st_x(new.geom),
	y_l93 = st_y(new.geom),
	geom = new.geom
WHERE idobjet = new.idobjet;

END IF;

return new ;

END;

$BODY$;



COMMENT ON FUNCTION m_espace_vert.ft_m_insert_update_ev_point()
    IS 'Fonction gérant l''insertion et la mise à jour des objets ponctuels de l''inventaire cartographique des espaces verts';


CREATE TRIGGER t_t1_insert_update_ev_point
    INSTEAD OF INSERT OR UPDATE 
    ON m_espace_vert.geo_v_ev_point
    FOR EACH ROW
    EXECUTE PROCEDURE m_espace_vert.ft_m_insert_update_ev_point();

-- View: m_espace_vert.geo_v_ev_polygon

-- DROP VIEW m_espace_vert.geo_v_ev_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_polygon
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma_d,
    o.doma_r,
    o.typev1,
    o.typev2,
    o.typev3,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.qualglocxy,
    o.op_sai,
    o.op_maj,
    o.dat_sai,
    o.dat_maj,
    o.observ,
    p.sup_m2,
    p.perimetre,
    p.long_m,
    p.geom
   FROM m_espace_vert.an_objet_ev o
     JOIN m_espace_vert.geo_ev_polygon p ON o.idobjet = p.idobjet;

-- FUNCTION: m_espace_vert.ft_m_insert_update_ev_polygon()

-- DROP FUNCTION m_espace_vert.ft_m_insert_update_ev_polygon();

CREATE FUNCTION m_espace_vert.ft_m_insert_update_ev_polygon()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

DECLARE v_idobjet integer;

BEGIN

	 	 
IF (TG_OP = 'INSERT') THEN 

v_idobjet := (select (nextval('m_espace_vert.an_ev_objet_idobjet_seq'::regclass)));

INSERT INTO
	m_espace_vert.an_objet_ev 
SELECT
	v_idobjet, -- idobjet
	null, -- idzone
	null, --(SELECT s.idsite FROM m_espace_vert.geo_ev_site s WHERE st_intersects(s.geom,new.geom) = true), -- idsite
	null, -- idcontrat
	'', --	(select into new.insee string_agg(insee, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- insee
	'', -- (select into new.commune string_agg(commune, ', ') from r_osm.geo_osm_commune where st_intersects(new.geom,geom)), -- commune
	'', --(select into new.quartier string_agg(nom, ', ') from r_administratif.geo_adm_quartier where st_intersects(new.geom,geom)), -- quartier
	'00', -- doma_d
	'00', -- doma_r
	new.typev1,
	new.typev2,
	new.typev3,
	new.srcgeom_sai,
	new.srcdate_sai,
	'00', -- srcgeom_maj
	null, -- srcdate_maj
	new.qualglocxy,
	new.op_sai,
	'', -- op_maj
	new.dat_sai,
	null, -- dat_maj
	new.observ;
	
INSERT INTO 
	m_espace_vert.geo_ev_polygon
SELECT
	v_idobjet, -- idobjet
	new.sup_m2, 
	new.perimetre,
	null, -- long_m
	new.geom;

END IF;

IF (TG_OP = 'UPDATE') THEN 

UPDATE m_espace_vert.an_objet_ev SET
    typev1 = new.typev1,
    typev2 = new.typev2,
    typev3 = new.typev3,
    srcgeom_sai = new.srcgeom_sai,
    srcdate_sai = new.srcdate_sai,
    qualglocxy = new.qualglocxy,
    op_sai = new.op_sai,
    dat_sai = new.dat_sai,
    observ = new.observ
WHERE idobjet = new.idobjet;

UPDATE m_espace_vert.geo_ev_polygon SET
    sup_m2 = new.sup_m2,
	perimetre = new.perimetre,
	geom = new.geom
WHERE idobjet = new.idobjet;

END IF;

IF (TG_OP = 'DELETE') THEN 

DELETE FROM m_espace_vert.an_objet_ev WHERE idobjet = old.idobjet;
DELETE FROM m_espace_vert.geo_ev_polygon WHERE idobjet = old.idobjet;

END IF;

return new ;

END;

$BODY$;


COMMENT ON FUNCTION m_espace_vert.ft_m_insert_update_ev_polygon()
    IS 'Fonction gérant l''insertion et la mise à jour des objets polygones de l''inventaire cartographique des espaces verts';


CREATE TRIGGER t_t1_insert_update_delete_ev_polygon
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON m_espace_vert.geo_v_ev_polygon
    FOR EACH ROW
    EXECUTE PROCEDURE m_espace_vert.ft_m_insert_update_ev_polygon();


