/*ESPACE VERT V2.2.0*/
/* Creation des vues applicatives */
/* ev_21_vues_xapps.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */


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
