/*ESPACE VERT V2.2.0*/
/* Creation des vues de gestion */
/* init_db_ev.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ##VUE
-- vegetal
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre_alignement;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbre_bois;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste_haie;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbuste_massif;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_fleuri;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_fleuri_massif;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_herbe;
-- mineral
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_circulation_voie;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_circulation_zone;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_cloture;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_loisir_equipement;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_loisir_zone;
-- hydro
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_arrivee;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_point;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_cours;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydro_eau_etendue;
-- nonref
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_point;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_line;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_polygon;
-- type geom
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_pct;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_line;
DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_objet_polygon;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        VUE                                                                   ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### VUE geo_v_ev_vegetal_arbre ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position",     
-- an_ev_vegetal_arbre    
    a.famille,
    a.genre,
    a.espece,
    a.cultivar,
    a.nomlatin,
    a.nomcommun,
    a.niv_allerg,        
    a.hauteur_cl,
    a.circonf,
    a.diam_houpp,    
    a.implant,
    a.mode_cond,   
    a.date_pl_an,
    a.date_pl_sa,
    a.periode_pl,
    a.stade_dev,
    a.sol_type,
    a.amena_pied,       
    a.remarq,
    a.remarq_com,
    a.proteg,
    a.proteg_com,
    a.contr,
    a.contr_type,
    a.naiss,     
    a.naiss_com,           
    a.etatarbre  
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbre a ON o.idobjet = a.idobjet
     LEFT JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '111';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre IS 'Vue arbres';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre."position" IS 'Position des objets';
-- an_ev_vegetal_arbre
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.idobjet IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.famille IS 'Nom de la famille de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.genre IS 'Nom du genre de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.espece IS 'Nom de l''espèce de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.cultivar IS 'Nom du cultivar de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.nomlatin IS 'Libellé scientifique complet du nom de l''arbre (en latin)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.nomcommun IS 'Libellé du nom commun/vernaculaire de l''arbre (en français)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.niv_allerg IS 'Niveau allergisant';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.hauteur_cl IS 'Classe de hauteur de l''arbre en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.circonf IS 'Circonférence du tronc en centimètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.diam_houpp IS 'Diamètre houppier en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.implant IS 'Type d''implantation de l''arbre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.mode_cond IS 'Mode de conduite, assimilé à « port de taille » ou forme taillée';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_pl_an IS 'Date de plantation (année)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.date_pl_sa IS 'Date de plantation (saison)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.periode_pl IS 'Période de plantation approx. (Décennie)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.stade_dev IS 'Stade de développement';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.sol_type IS 'Type de sol';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.amena_pied IS 'Aménagement pied de l''arbre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.remarq IS 'Arbre remarquable (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.remarq_com IS 'Commentaires arbre remarquable';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.proteg IS 'Arbre protégé (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.proteg_com IS 'Commentaires arbre protégé';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.contr IS 'Contrainte (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.contr_type IS 'Type(s) de contrainte(s)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.naiss IS 'Programme naissance (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.naiss_com IS 'Commentaire arbre du programme naissance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre.etatarbre IS 'Etat de l''arbre';



-- #################################################################### VUE geo_v_ev_vegetal_arbre_alignement ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre_alignement

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_vegetal
    v."position"    
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '112';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre_alignement IS 'Vue arbres d''alignement';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_alignement."position" IS 'Position des objets';


-- #################################################################### VUE geo_v_ev_vegetal_arbre_bois ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbre_bois

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position"    
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '113';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbre_bois IS 'Vue zones boisées';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbre_bois."position" IS 'Position des objets';



-- #################################################################### VUE geo_v_ev_vegetal_arbuste ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position"     
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '121';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste IS 'Vue des arbustes';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste."position" IS 'Position des objets';


-- #################################################################### geo_v_ev_vegetal_arbuste_haie ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste_haie

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_objet_line_largeur
    l.larg_cm,    
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_arbuste_haie 
    h.sai_type,
    h.veget_type,
    h.hauteur,
    h.espac_type,
    h.surface,
    h.paill_type,
    h.biodiv
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     LEFT JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbuste_haie h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '122';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_haie IS 'Vue des haies arbustives';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.larg_cm IS 'Largeur des objets en cm';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie."position" IS 'Position des objets';
--
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.sai_type IS 'Type de saisie de l''objet linéaire haie';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.veget_type IS 'Type végétation';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.hauteur IS 'Hauteur';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.surface IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.paill_type IS 'Type de paillage';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_haie.biodiv IS 'Biodiversité';


-- #################################################################### geo_v_ev_vegetal_arbuste_massif ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbuste_massif

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_arbuste_massif
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_arbuste_massif h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '123';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbuste_massif IS 'Vue des massifs arbustifs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif."position" IS 'Position des objets';
-- an_ev_veget_arbuste_massif
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_arbuste_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### VUE geo_v_ev_vegetal_fleuri ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_fleuri

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_fleuri;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_fleuri
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom,
-- an_ev_vegetal
    v."position"     
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3 = '131';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_fleuri IS 'Vue des points fleuris';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri.geom IS 'Géométrie des objets espaces verts';
-- an_ev_vegetal
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri."position" IS 'Position des objets';


-- #################################################################### geo_v_ev_vegetal_fleuri_massif ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_fleuri_massif

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_fleuri_massif
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_fleuri_massif h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '132';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_fleuri_massif IS 'Vue des massifs fleuris';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif."position" IS 'Position des objets';
-- an_ev_veget_fleuri_massif
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_fleuri_massif.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### geo_v_ev_vegetal_herbe ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_herbe

-- DROP VIEW m_espace_vert.geo_v_ev_vegetal_herbe;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_herbe
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom,
-- an_ev_vegetal
    v."position",
-- an_ev_vegetal_herbe
    h.espac_type,
    h.arros_auto,
    h.arros_type,
    h.biodiv,
    h.inv_faunis   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_vegetal v ON o.idobjet = v.idobjet
     JOIN m_espace_vert.an_ev_vegetal_herbe h ON o.idobjet = h.idobjet
  WHERE o.typ3 = '141';

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_herbe IS 'Vue des espaces enherbés';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.geom IS 'Géométrie des objets espaces verts';
-- an_ev_veget
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe."position" IS 'Position des objets';
-- an_ev_veget_herbe
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.espac_type IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.arros_auto IS 'Arrosage automatique (O/N)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.arros_type IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.biodiv IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_vegetal_herbe.inv_faunis IS 'Inventaire faunistique / floristique réalisé (O/N)';


-- #################################################################### geo_v_ev_mineral_circulation_voie ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_circulation_voie

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,
-- an_ev_objet_line_largeur
    l.larg_cm    
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet
  WHERE o.typ2 = '21';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_circulation_voie IS 'Vue des voies de circulation';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_voie.larg_cm IS 'Largeur des objets en cm';


-- #################################################################### geo_v_ev_mineral_circulation_zone ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_circulation_zone

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '21';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_circulation_zone IS 'Vue des zones de circulation';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_circulation_zone.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_mineral_cloture ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_cloture

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_cloture;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_cloture
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '22';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_cloture IS 'Vue des clotures';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_cloture.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_mineral_loisir_equipement ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_loisir_equipement

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '23';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_loisir_equipement IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_equipement.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_mineral_loisir_zone ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_loisir_zone

-- DROP VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '23';

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_loisir_zone IS 'Vue des zones de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_mineral_loisir_zone.geom IS 'Géométrie des objets espaces verts';

-- #################################################################### VUE geo_v_ev_hydro_eau_arrivee ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_arrivee

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '31';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_arrivee IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_arrivee.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_hydro_eau_point ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_point

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_point;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_point
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_point IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_point.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_hydro_eau_cours ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_cours

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_cours;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_cours
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom,   
-- an_ev_objet_line_largeur
    l.larg_cm    
--     
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_objet_line_largeur l ON o.idobjet = l.idobjet     
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_cours IS 'Vue des références non classées de type linéaire';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.geom IS 'Géométrie des objets espaces verts';
-- an_line_largeur
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_cours.larg_cm IS 'Largeur des objets en cm';


-- #################################################################### geo_v_ev_hydro_eau_etendue ###############################################

-- View: m_espace_vert.geo_v_ev_hydro_eau_etendue

-- DROP VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2 = '32';

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydro_eau_etendue IS 'Vue des références non classées de type polygone';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_hydro_eau_etendue.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_refnonclassee_point ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_point

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_point;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_point
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom   
--
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_point IS 'Vue des équipements de loisirs';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_point.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_refnonclassee_line ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_line

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_line
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom   
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_line IS 'Vue des références non classées de type linéaire';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_line.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### geo_v_ev_refnonclassee_polygon ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_polygon

-- DROP VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom
--       
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ1 = '9';

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon IS 'Vue des références non classées de type polygone';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_refnonclassee_polygon.geom IS 'Géométrie des objets espaces verts';


-- ## vue objets par type de geométrie


-- #################################################################### VUE geo_v_ev_objet_pct ###############################################

-- View: m_espace_vert.geo_v_ev_objet_pct

-- DROP VIEW m_espace_vert.geo_v_ev_objet_pct;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_pct
 AS
 SELECT 
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_pct
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_pct g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_pct IS 'Vue des objets EV de type point';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.observ IS 'Observations diverses';
-- geo_ev_objet_pct
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_pct.geom IS 'Géométrie des objets espaces verts';



-- #################################################################### VUE geo_v_ev_objet_line ###############################################

-- View: m_espace_vert.geo_v_ev_objet_line

-- DROP VIEW m_espace_vert.geo_v_ev_objet_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_line
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_line
    g.long_m,
    g.geom  
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_line g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_line IS 'Vue des objets EV de type line';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.observ IS 'Observations diverses';
-- geo_ev_objet_line
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.long_m IS 'Longueur en mètres';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_line.geom IS 'Géométrie des objets espaces verts';


-- #################################################################### VUE geo_v_ev_objet_polygon ###############################################

-- View: m_espace_vert.geo_v_ev_objet_polygon

-- DROP VIEW m_espace_vert.geo_v_ev_objet_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_objet_polygon
 AS
 SELECT
-- an_ev_objet
    o.idobjet,
    o.idgestion,
    o.idsite,
    o.idequipe,  
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.typ1,
    o.typ2,
    o.typ3,
    o.etat,  
    o.doma,
    o.qualdoma,
    o.op_sai,  
    o.date_sai,
    o.src_geom,
    o.src_date,    
    o.op_att,
    o.date_maj_att,	    
    o.op_maj,  
    o.date_maj,
    o.observ,
-- geo_ev_objet_polygon
    g.sup_m2,
    g.perimetre,
    g.geom   
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_objet_polygon g ON o.idobjet = g.idobjet;

COMMENT ON VIEW m_espace_vert.geo_v_ev_objet_polygon IS 'Vue des objets EV de type polygon';
-- an_ev_objet
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idobjet IS 'Identifiant unique de l''objet espace vert';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idgestion IS 'identifiant de la zone de gestion';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idsite IS 'Identifiant du site cohérent';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idequipe IS 'Identifiant de la zone d''équipe';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.idcontrat IS 'Identifiant du contrat';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.insee IS 'Code insee de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.commune IS 'Libellé de la commune d''appartenance';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.quartier IS 'Libellé du quartier';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ1 IS 'Type d''espace vert de niveau 1';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ2 IS 'Sous-Type d''espace vert de niveau 2';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.typ3 IS 'Sous-Type d''espace vert de niveau 3';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.etat IS 'Etat de l''objet dans la base de données (projet, existant, supprimé)';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.doma IS 'Domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.qualdoma IS 'Qualité de l''information liée à la domanialité';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_sai IS 'Opérateur de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_sai IS 'Date de saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.src_geom IS 'Référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.src_date IS 'Date du référentiel géographique utilisé pour la saisie de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_att IS 'Opérateur de saisie des attributs métiers de l''objet initial';   
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_maj_att IS 'Année de mise à jour des attributs métiers de l''objet initial';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.op_maj IS 'Opérateur de la dernière mise à jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.date_maj IS 'Date de la dernière mise jour de l''objet';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.observ IS 'Observations diverses';
-- geo_ev_objet_polygon
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.sup_m2 IS 'Surface en mètre carré';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.perimetre IS 'Périmètre des objets surfaciques en mètre';
COMMENT ON COLUMN m_espace_vert.geo_v_ev_objet_polygon.geom IS 'Géométrie des objets espaces verts';



-- #################################################################### VUE an_v_lt_ev_objet_typ123 ###############################################

-- View: m_espace_vert.an_v_lt_ev_objet_typ123

DROP VIEW IF EXISTS m_espace_vert.an_v_lt_ev_objet_typ123;

CREATE OR REPLACE VIEW m_espace_vert.an_v_lt_ev_objet_typ123
 AS
 SELECT row_number() OVER () AS id,
    t1.code AS code_t1,
    t1.valeur AS valeur_t1,
    t2.code AS code_t2,
    t2.valeur AS valeur_t2,
    t3.code AS code_t3,
    t3.valeur AS valeur_t3
   FROM m_espace_vert.lt_ev_objet_typ1 t1
     LEFT JOIN m_espace_vert.lt_ev_objet_typ2 t2 ON t1.code::text = "left"(t2.code::text, 1)
     LEFT JOIN m_espace_vert.lt_ev_objet_typ3 t3 ON t2.code::text = "left"(t3.code::text, 2);


