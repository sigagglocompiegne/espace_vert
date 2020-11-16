/*ESPACE VERT V1.0*/
/*Creation des droits sur l'ensemble des objets */
/* ev_99_grant.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        GRANT                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- #################################################################### SCHEMA  ####################################################################

GRANT ALL ON SCHEMA m_espace_vert TO create_sig;

GRANT USAGE ON SCHEMA m_espace_vert TO edit_sig;

GRANT USAGE ON SCHEMA m_espace_vert TO read_sig;

GRANT ALL ON SCHEMA m_espace_vert TO sig_create;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT SELECT ON TABLES TO read_sig;

ALTER DEFAULT PRIVILEGES IN SCHEMA m_espace_vert
GRANT ALL ON TABLES TO create_sig;

-- #################################################################### SEQUENCE  ####################################################################

ALTER SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq
    OWNER TO sig_create;

GRANT ALL ON SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq TO PUBLIC;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq TO create_sig;
GRANT ALL ON SEQUENCE m_espace_vert.an_ev_objet_idobjet_seq TO sig_create;

-- #################################################################### TABLE  ####################################################################

ALTER TABLE m_espace_vert.lt_ev_doma 
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.lt_ev_doma  TO read_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_doma  TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_doma  TO edit_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_doma  TO create_sig;

ALTER TABLE m_espace_vert.lt_ev_typev1
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.lt_ev_typev1 TO read_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev1 TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_typev1 TO edit_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev1 TO create_sig;

ALTER TABLE m_espace_vert.lt_ev_typev2
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.lt_ev_typev2 TO read_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev2 TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_typev2 TO edit_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev2 TO create_sig;

ALTER TABLE m_espace_vert.lt_ev_typev3
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.lt_ev_typev3 TO read_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev3 TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.lt_ev_typev3 TO edit_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typev3 TO create_sig;


ALTER TABLE m_espace_vert.lt_ev_typsite
    OWNER to sig_create;

GRANT SELECT ON TABLE m_espace_vert.lt_ev_typsite TO read_sig;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typsite TO sig_create;
GRANT ALL ON TABLE m_espace_vert.lt_ev_typsite TO create_sig;
