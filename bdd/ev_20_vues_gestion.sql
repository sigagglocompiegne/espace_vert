/* ESPACE VERT V1.0*/
/* Creation des vues de gestion */
/* ev_20_vues_gestion.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */
/* Participant : Florent Vanhoutte */

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- TRIGGERS

-- pas de fonction d'édition permise à ce stade de l'inventaire cartographique

--VUES

DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_arbreisole;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_haie;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe;

DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_mineral_voiecirculation;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_mineral_cloture;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_mineral_loisirsisole;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau;

DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_refnonclassee_pct;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_refnonclassee_lin;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_refnonclassee_polygon;

DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_line;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_pct;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_polygon;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_arbre;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      FONCTIONS                                                            ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- ############################################################ [name] #########################################     

-- pas de fonction d'édition permise à ce stade de l'inventaire cartographique
										   
                                        
-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DE GESTION                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- les vues ci-dessous sont pour le moment uniquement pour la visualisation des données en attentant de passer à une gestion métier par
-- le sezvice espace vert à l'issu de l'inventaire cartographique

-- View: m_espace_vert_v2.geo_v_ev_line

-- DROP VIEW m_espace_vert_v2.geo_v_ev_line;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_line
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    o.typ1,
    o.typ2,
    o.typ3,
    o.op_sai,
    o.date_sai,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.op_att,
    o.date_maj_att,
    o.date_maj,
    o.observ,
    l.long_m,
    h.typsai,
    c.larg_cm,
    v.position,
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geohaie h ON o.idobjet = h.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geoline c ON o.idobjet = c.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
	 JOIN m_espace_vert_v2.lt_ev_typsaihaie th ON th.code = h.typsai;

ALTER TABLE m_espace_vert_v2.geo_v_ev_line
    OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_line TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_line TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_line TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_line TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_pct

-- DROP VIEW m_espace_vert_v2.geo_v_ev_pct;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_pct
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    o.typ1,
    o.typ2,
    o.typ3,
    o.op_sai,
    o.date_sai,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.op_att,
    o.date_maj_att,
    o.date_maj,
    o.observ,
    v.position,
	  p.x_l93,
  	p.y_l93,
	  p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
      LEFT JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
   WHERE o.typ3 <> '111';

ALTER TABLE m_espace_vert_v2.geo_v_ev_pct
    OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_pct TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_pct TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_pct TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_pct TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_pct

-- DROP VIEW m_espace_vert_v2.geo_v_ev_polygon;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_polygon
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    o.typ1,
    o.typ2,
    o.typ3,
    o.op_sai,
    o.date_sai,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.op_att,
    o.date_maj_att,
    o.date_maj,
    o.observ,
    v.position,
	  p.sup_m2,
  	p.perimetre,
  	p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
        LEFT JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet;

ALTER TABLE m_espace_vert_v2.geo_v_ev_polygon
    OWNER TO create_sig;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_polygon TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_polygon TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_arbre

-- DROP VIEW m_espace_vert_v2.geo_v_ev_arbre;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_arbre
 AS
 SELECT o.idobjet,
    o.idzone,
    o.idsite,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    o.typ1,
    o.typ2,
    o.typ3,
    o.op_sai,
    o.date_sai,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.op_att,
    o.date_maj_att,
    o.date_maj,
    o.observ,
    a.nom,
    a.genre,
    a.espece,
    a.hauteur,
    a.circonf,
    a.forme,
    a.etat_gen,
    a.implant,
    a.remarq,
    a.malad_obs,
    a.malad_nom,
    a.danger,
    a.natur_sol,
    a.envnmt_obs,
    a.utilis_obs,
    a.cplt_fic_1,
    a.cplt_fic_2,
    a.gps_date,
    a.gnss_heigh,
    a.vert_prec,
    a.horz_prec,
    a.northing,
    a.easting,
    v.position,
    p.x_l93,
    p.y_l93,
    p.geom::geometry(point,2154) AS geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
	 JOIN m_espace_vert_v2.an_ev_arbre a ON o.idobjet = a.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
   WHERE o.typ3 = '111';			      

-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DU GABARIT                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- les vues listées ci-dessous sont les vues générant la structure des couches du gabarit

-- View: m_espace_vert_v2.geo_v_ev_vegetal_arbreisole

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbreisole;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbreisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '111'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbreisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbreisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbreisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbreisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbreisole TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '112'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbrealignement TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '113'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_zoneboisee TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '121'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_arbusteisole TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_vegetal_haie

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_haie;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_haie
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    h.typsai,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
     JOIN m_espace_vert_v2.an_ev_geoline gl ON o.idobjet = gl.idobjet
     JOIN m_espace_vert_v2.an_ev_geohaie h ON o.idobjet = h.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '122'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_haie
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_haie TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_haie TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_haie TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_haie TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '123'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massifarbustif TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '131'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_pointfleuri TO sig_edit;

-- View: m_espace_vert_v2.geo_ev_vegetal_massiffleuri

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '132'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_massiffleuri TO sig_edit;


-- View: m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe

-- DROP VIEW m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
     JOIN m_espace_vert_v2.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '141'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_vegetal_espaceenherbe TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_mineral_voiecirculation

-- DROP VIEW m_espace_vert_v2.geo_v_ev_mineral_voiecirculation;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_mineral_voiecirculation
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
     JOIN m_espace_vert_v2.an_ev_geoline gl ON o.idobjet = gl.idobjet
  WHERE o.typ2::text = '21'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_mineral_voiecirculation
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_mineral_voiecirculation TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_voiecirculation TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_voiecirculation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_mineral_voiecirculation TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation

-- DROP VIEW m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '21'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_mineral_zonedecirculation TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_mineral_cloture

-- DROP VIEW m_espace_vert_v2.geo_v_ev_mineral_cloture;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_mineral_cloture
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
  WHERE o.typ2::text = '22'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_mineral_cloture
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_mineral_cloture TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_cloture TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_cloture TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_mineral_cloture TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_mineral_loisirsisole

-- DROP VIEW m_espace_vert_v2.geo_v_ev_mineral_loisirsisole;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_mineral_loisirsisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '23'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_mineral_loisirsisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_mineral_loisirsisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_loisirsisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_loisirsisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_mineral_loisirsisole TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs

-- DROP VIEW m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '23'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_mineral_espacedeloisirs TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau

-- DROP VIEW m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '31'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_arriveedeau TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau

-- DROP VIEW m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_pointdeau TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau

-- DROP VIEW m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
     JOIN m_espace_vert_v2.an_ev_geoline gl ON o.idobjet = gl.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_coursdeau TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau

-- DROP VIEW m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_hydrographique_etenduedeau TO sig_edit;



-- View: m_espace_vert_v2.geo_v_ev_refnonclassee_pct

-- DROP VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_pct;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_pct
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    o.observ,
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_pct
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_pct TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_pct TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_pct TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_pct TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_refnonclassee_lin

-- DROP VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_lin;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_lin
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    o.observ,
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_lin
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_lin TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_lin TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_lin TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_lin TO sig_edit;

-- View: m_espace_vert_v2.geo_v_ev_refnonclassee_polygon

-- DROP VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_polygon;

CREATE OR REPLACE VIEW m_espace_vert_v2.geo_v_ev_refnonclassee_polygon
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    o.observ,
    p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_polygon
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_polygon TO sig_create;
GRANT ALL ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert_v2.geo_v_ev_refnonclassee_polygon TO sig_edit;
