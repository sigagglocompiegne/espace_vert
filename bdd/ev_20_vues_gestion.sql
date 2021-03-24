/* ESPACE VERT V1.0*/
/* Creation des vues de gestion */
/* ev_20_vues_gestion.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- TRIGGERS

-- pas de fonction d'édition permise à ce stade de l'inventaire cartographique

--VUES

DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_line;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_pct;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_polygon;
DROP VIEW IF EXISTS m_espace_vert_v2.geo_v_ev_arbre;

-- FONCTIONS

-- pas de fonction d'édition permise à ce stade de l'inventaire cartographique

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
    o.doma_d,
    o.doma_r,
    o.typ,
    o.sstyp,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.op_sai,
    o.op_maj,
    o.date_sai,
    o.date_maj,
    o.observ,
	l.long_m,
	CASE 
		WHEN h.larg_cm IS NULL AND c.larg_cm IS NULL THEN 'Non concerné'
		ELSE 
			CASE
				WHEN h.larg_cm IS NULL AND c.larg_cm IS NOT NULL THEN c.larg_cm::text
				WHEN c.larg_cm IS NULL AND h.larg_cm IS NOT NULL THEN h.larg_cm::text
			END
		END	as larg_cm,
	CASE WHEN h.typsai IS NULL THEN 'Non concerné' ELSE th.valeur END as typsai,
    l.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_line l ON o.idobjet = l.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geohaie h ON o.idobjet = h.idobjet
	 LEFT JOIN m_espace_vert_v2.an_ev_geocircudouce c ON o.idobjet = c.idobjet
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
    o.doma_d,
    o.doma_r,
    o.typ,
    o.sstyp,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.op_sai,
    o.op_maj,
    o.date_sai,
    o.date_maj,
    o.observ,
	p.x_l93,
	p.y_l93,
	p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
   WHERE o.sstyp <> '01-01';

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
    o.doma_d,
    o.doma_r,
    o.typ,
    o.sstyp,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.op_sai,
    o.op_maj,
    o.date_sai,
    o.date_maj,
    o.observ,
	p.sup_m2,
	p.perimetre,
	p.geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_polygon p ON o.idobjet = p.idobjet;

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
    o.doma_d,
    o.doma_r,
    o.typ,
    o.sstyp,
    o.srcgeom_sai,
    o.srcdate_sai,
    o.srcgeom_maj,
    o.srcdate_maj,
    o.op_sai,
    o.op_maj,
    o.date_sai,
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
    p.x_l93,
    p.y_l93,
    p.geom::geometry(point,2154) AS geom
   FROM m_espace_vert_v2.an_ev_objet o
     JOIN m_espace_vert_v2.geo_ev_pct p ON o.idobjet = p.idobjet
	 JOIN m_espace_vert_v2.an_ev_arbre a ON o.idobjet = a.idobjet
   WHERE o.sstyp = '01-01';			      






