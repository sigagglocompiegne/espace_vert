/*ESPACE VERT V2.2.0*/
/*Creation droits sur l'ensemble des objets */
/* init_db_ev.sql */
/*PostGIS*/
/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */


-- ICI SONT PRESENTES LES DROITS DE MANIERES GENERIQUES COMME ILS DOIVENT ETRE INTEGRES POUR CHAQUE CLASSE D'OBJETS. SI DES PARTICULARITES SONT
-- INTRODUITES ELLES SONT DETAILLEES CI-DESSOUS



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

ALTER FUNCTION m_espace_vert.ft_m_ev_objet_pct()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_pct() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_pct() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_objet_line()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_line() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_line() TO PUBLIC;

ALTER FUNCTION m_espace_vert.ft_m_ev_objet_polygon()
    OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_polygon() TO create_sig;
GRANT EXECUTE ON FUNCTION m_espace_vert.ft_m_ev_objet_polygon() TO PUBLIC;

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
