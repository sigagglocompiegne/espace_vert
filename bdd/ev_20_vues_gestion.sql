/*ESPACE VERT V2.2.0*/
/* Creation des vues de gestion */
/* ev_20_vues_gestion.sql */
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


-- #################################################################### FONCTION/TRIGGER arbre ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
    -- Lors de la saisie d'un arbre, afficher un message d'avertissement dans la fiche si sa localisation se trouve à moins de 50cm d'un autre arbre, afin d'éviter la saisie de doublons.
    IF (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre WHERE ST_DWithin(NEW.geom,geom, 0.5) AND etat <> '3' )  THEN
      RAISE EXCEPTION 'Erreur : Un arbre existe déjà à moins de 50cm de cette position.<br><br>';
    END IF;
  END IF;

  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '111');
  --  
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbre
    (idobjet, famille, genre, espece, cultivar, nomlatin, nomcommun, niv_allerg,
    hauteur_cl, circonf, diam_houpp, implant, mode_cond, date_pl_an, date_pl_sa, periode_pl, stade_dev, sol_type, amena_pied,
    remarq, remarq_com, proteg, proteg_com, contr, contr_type, naiss, naiss_com, etatarbre)
    VALUES
    (_idobjet, NEW.famille, NEW.genre, NEW.espece, NEW.cultivar, NEW.nomlatin, NEW.nomcommun, CASE WHEN NEW.niv_allerg IS NULL THEN '00' ELSE NEW.niv_allerg END,
-- proprio
    CASE WHEN NEW.hauteur_cl IS NULL THEN '00' ELSE NEW.hauteur_cl END,
    NEW.circonf,
    NEW.diam_houpp,    
-- implant est déduit uniquement dans le cas où l'utilisateur ne le renseigne pas ('00' OU NULL)
    CASE WHEN NEW.implant IN ('01','02','03') THEN NEW.implant WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_alignement b WHERE b.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),b.geom)) THEN '02' WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_bois c WHERE c.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),c.geom)) THEN '03' ELSE '00' END,
    CASE WHEN NEW.mode_cond IS NULL THEN '00' ELSE NEW.mode_cond END,   
-- historique
    NEW.date_pl_an, 
    CASE WHEN NEW.date_pl_sa IS NULL THEN '00' ELSE NEW.date_pl_sa END, 
    CASE WHEN NEW.periode_pl IS NULL THEN '00' ELSE NEW.periode_pl END, 
    CASE WHEN NEW.stade_dev IS NULL THEN '00' ELSE NEW.stade_dev END, 
-- divers
    CASE WHEN NEW.sol_type IS NULL THEN '00' ELSE NEW.sol_type END,
    CASE WHEN NEW.amena_pied IS NULL THEN '00' ELSE NEW.amena_pied END,
--
    CASE WHEN NEW.remarq IS NULL THEN '0' ELSE NEW.remarq END,
    CASE WHEN NEW.remarq ='t' THEN NEW.remarq_com ELSE NULL END,
    CASE WHEN NEW.proteg IS NULL THEN '0' ELSE NEW.proteg END,
    CASE WHEN NEW.proteg ='t' THEN NEW.proteg_com ELSE NULL END,
    CASE WHEN NEW.contr IS NULL THEN '0' ELSE NEW.contr END,
    CASE WHEN NEW.contr ='t' THEN NEW.contr_type ELSE NULL END,
    CASE WHEN NEW.naiss IS NULL THEN '0' ELSE NEW.naiss END,     
    CASE WHEN NEW.naiss ='t' THEN NEW.naiss_com ELSE NULL END,
    CASE WHEN NEW.etatarbre IS NULL THEN '00' ELSE NEW.etatarbre END);     
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;  
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbre SET
-- dico botanique    
    famille = NEW.famille,
    genre = NEW.genre,
    espece = NEW.espece,
    cultivar = NEW.cultivar,
    nomlatin = NEW.nomlatin,
    nomcommun = NEW.nomcommun,
    niv_allerg = CASE WHEN NEW.niv_allerg IS NULL THEN '00' ELSE NEW.niv_allerg END,        
-- proprio
    hauteur_cl = CASE WHEN NEW.hauteur_cl IS NULL THEN '00' ELSE NEW.hauteur_cl END,
    circonf = NEW.circonf,
    diam_houpp = NEW.diam_houpp,    
-- implant est déduit uniquement dans le cas où l'utilisateur ne le renseigne pas ('00' OU NULL)
    implant = CASE WHEN NEW.implant IN ('01','02','03') THEN NEW.implant WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_alignement b WHERE b.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),b.geom)) THEN '02' WHEN (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbre_bois c WHERE c.etat = '2' AND ST_Intersects(St_buffer(NEW.geom,0.1),c.geom)) THEN '03' ELSE '00' END,
    mode_cond = CASE WHEN NEW.mode_cond IS NULL THEN '00' ELSE NEW.mode_cond END,   
-- historique
    date_pl_an = NEW.date_pl_an, 
    date_pl_sa = CASE WHEN NEW.date_pl_sa IS NULL THEN '00' ELSE NEW.date_pl_sa END, 
    periode_pl = CASE WHEN NEW.periode_pl IS NULL THEN '00' ELSE NEW.periode_pl END, 
    stade_dev = CASE WHEN NEW.stade_dev IS NULL THEN '00' ELSE NEW.stade_dev END, 
-- divers
    sol_type = CASE WHEN NEW.sol_type IS NULL THEN '00' ELSE NEW.sol_type END,
    amena_pied = CASE WHEN NEW.amena_pied IS NULL THEN '00' ELSE NEW.amena_pied END,
--
    remarq = CASE WHEN NEW.remarq IS NULL THEN '0' ELSE NEW.remarq END,
    remarq_com = CASE WHEN NEW.remarq ='t' THEN NEW.remarq_com ELSE NULL END,
    proteg = CASE WHEN NEW.proteg IS NULL THEN '0' ELSE NEW.proteg END,
    proteg_com = CASE WHEN NEW.proteg ='t' THEN NEW.proteg_com ELSE NULL END,
    contr = CASE WHEN NEW.contr IS NULL THEN '0' ELSE NEW.contr END,
    contr_type = CASE WHEN NEW.contr ='t' THEN NEW.contr_type ELSE NULL END,
    naiss = CASE WHEN NEW.naiss IS NULL THEN '0' ELSE NEW.naiss END,     
    naiss_com = CASE WHEN NEW.naiss ='t' THEN NEW.naiss_com ELSE NULL END,
    etatarbre = CASE WHEN NEW.etatarbre IS NULL THEN '00' ELSE NEW.etatarbre END      
    WHERE idobjet = NEW.idobjet;    
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;       
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
-- voir pour cas arbre supprimé (etatarbre) 
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre ON m_espace_vert.geo_v_ev_vegetal_arbre;
CREATE TRIGGER t_m_ev_vegetal_arbre INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre();



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


-- #################################################################### FONCTION/TRIGGER arbre_alignement ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_alignement() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '112');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux    
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre_alignement ON m_espace_vert.geo_v_ev_vegetal_arbre_alignement;
CREATE TRIGGER t_m_ev_vegetal_arbre_alignement INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre_alignement
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre_alignement();


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


-- #################################################################### FONCTION/TRIGGER ZONE BOISEE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbre_bois() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '113');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbre_bois ON m_espace_vert.geo_v_ev_vegetal_arbre_bois;
CREATE TRIGGER t_m_ev_vegetal_arbre_bois INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbre_bois
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbre_bois();


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


-- #################################################################### FONCTION/TRIGGER arbuste ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '121');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
 
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux     
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbuste ON m_espace_vert.geo_v_ev_vegetal_arbuste;
CREATE TRIGGER t_m_ev_vegetal_arbuste INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste();


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



-- #################################################################### FONCTION/TRIGGER haie ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_haie() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '122');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbuste_haie
    (idobjet, 
    veget_type,
    hauteur, espac_type, paill_type, biodiv)
    VALUES
    (_idobjet, 
    NEW.veget_type,
    NEW.hauteur, NEW.espac_type, 
    NEW.paill_type, NEW.biodiv);
    -- INSERTion des attributs des EV végétaux      
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbuste_haie SET
    veget_type = NEW.veget_type,
    hauteur = NEW.hauteur, 
    espac_type = NEW.espac_type, 
    paill_type = NEW.paill_type, 
    biodiv = NEW.biodiv 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux      
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;    

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_haie ON m_espace_vert.geo_v_ev_vegetal_arbuste_haie;
CREATE TRIGGER t_m_ev_vegetal_haie INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste_haie
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste_haie();


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


-- #################################################################### FONCTION/TRIGGER arbuste_massif ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_arbuste_massif() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '123');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_arbuste_massif
    (idobjet,
    espac_type, arros_type, 
    arros_auto, biodiv, inv_faunis)
    VALUES
    (_idobjet,
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;    
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_arbuste_massif SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;     

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_arbuste_massif ON m_espace_vert.geo_v_ev_vegetal_arbuste_massif;
CREATE TRIGGER t_m_ev_vegetal_arbuste_massif INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbuste_massif 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_arbuste_massif();


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



-- #################################################################### FONCTION/TRIGGER fleuri ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '131');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des EV végétaux   
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_fleuri ON m_espace_vert.geo_v_ev_vegetal_fleuri;
CREATE TRIGGER t_m_ev_vegetal_fleuri INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_fleuri 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_fleuri();



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


-- #################################################################### FONCTION/TRIGGER fleuri_massif ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_fleuri_massif() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '132');

  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_fleuri_massif
    (idobjet, 
    espac_type, arros_type, 
    arros_auto, biodiv, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_fleuri_massif SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_vegetal_fleuri_massif ON m_espace_vert.geo_v_ev_vegetal_fleuri_massif;
CREATE TRIGGER t_m_ev_vegetal_fleuri_massif INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_fleuri_massif 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_fleuri_massif();



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


-- #################################################################### FONCTION/TRIGGER vegetal_herbe ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_vegetal_herbe() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '14', '141');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_vegetal_herbe
    (idobjet, 
    espac_type, arros_type, arros_auto, 
    biodiv, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.espac_type, NEW.arros_type, 
    CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, NEW.biodiv, 
    CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END);
    -- INSERTion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_vegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_vegetal_herbe SET
    espac_type = NEW.espac_type, 
    arros_type = NEW.arros_type, 
    arros_auto = CASE WHEN NEW.arros_auto IS NULL THEN '0' ELSE NEW.arros_auto END, 
    biodiv = NEW.biodiv, 
    inv_faunis = CASE WHEN NEW.inv_faunis IS NULL THEN '0' ELSE NEW.inv_faunis END 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_vegetal SET
    position = CASE WHEN NEW.position IS NULL THEN '10' ELSE NEW.position END 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

--DROP TRIGGER IF EXISTS t_m_ev_vegetal_herbe ON m_espace_vert.geo_v_ev_vegetal_herbe;
CREATE TRIGGER t_m_ev_vegetal_herbe INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_herbe 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_vegetal_herbe();


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


-- #################################################################### FONCTION/TRIGGER circulation_voie ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_voie() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_objet_line_largeur
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_objet_line_largeur SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_circulation_voie ON m_espace_vert.geo_v_ev_mineral_circulation_voie;
CREATE TRIGGER t_m_ev_mineral_circulation_voie INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_circulation_voie 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_circulation_voie();



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


-- #################################################################### FONCTION/TRIGGER circulation_zone ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_circulation_zone() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_circulation_zone ON m_espace_vert.geo_v_ev_mineral_circulation_zone;
CREATE TRIGGER t_m_ev_mineral_circulation_zone INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_circulation_zone 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_circulation_zone();



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



-- #################################################################### FONCTION/TRIGGER cloture ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_cloture() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '22', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_cloture ON m_espace_vert.geo_v_ev_mineral_cloture;
CREATE TRIGGER t_m_ev_mineral_cloture INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_cloture 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_cloture();


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




-- #################################################################### FONCTION/TRIGGER loisir_equipement ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_equipement() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '231');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_loisir_equipement ON m_espace_vert.geo_v_ev_mineral_loisir_equipement;
CREATE TRIGGER t_m_ev_mineral_loisir_equipement INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_loisir_equipement 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_loisir_equipement();


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


-- #################################################################### FONCTION/TRIGGER loisir_zone ###############################################


CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_mineral_loisir_zone() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '232');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- DROP TRIGGER IF EXISTS t_m_ev_mineral_loisir_zone ON m_espace_vert.geo_v_ev_mineral_loisir_zone;
CREATE TRIGGER t_m_ev_mineral_loisir_zone INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_loisir_zone 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_mineral_loisir_zone();


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


-- #################################################################### FONCTION/TRIGGER eau_arrivee ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro_eau_arrivee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '31', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

--DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_arrivee ON m_espace_vert.geo_v_ev_hydro_eau_arrivee;
CREATE TRIGGER t_m_ev_hydro_eau_arrivee INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_arrivee 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro_eau_arrivee();


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


-- #################################################################### FONCTION/TRIGGER hydro eau_point et eau_etendue ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table hydro_eau_point
-- DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_point ON m_espace_vert.geo_v_ev_hydro_eau_point;
CREATE TRIGGER t_m_ev_hydro_eau_point INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_point 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro();

-- trigger sur table hydro_eau_etendue
-- DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_etendue ON m_espace_vert.geo_v_ev_hydro_eau_etendue;
CREATE TRIGGER t_m_ev_hydro_eau_etendue INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_etendue 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro();


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


-- #################################################################### FONCTION/TRIGGER hydro eau_cours ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_hydro_eau_cours() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- INSERTion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_objet_line_largeur
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_objet_line_largeur SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table hydro_eau_cours
--DROP TRIGGER IF EXISTS t_m_ev_hydro_eau_cours ON m_espace_vert.geo_v_ev_hydro_eau_cours;
CREATE TRIGGER t_m_ev_hydro_eau_cours INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydro_eau_cours 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_hydro_eau_cours();


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


-- #################################################################### FONCTION/TRIGGER REFNONCLASSEE PCT-LIN-POLYGON ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_refnonclassee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := NULL;
    _datanew := ROW(NEW.*)::text;
  ELSIF TG_OP = 'UPDATE' THEN
    _idobjet := NEW.idobjet;
    _record_used := NEW;
    _dataold := ROW(OLD.*)::text;
    _datanew := ROW(NEW.*)::text;
  ELSE
    _idobjet := OLD.idobjet;
    _record_used := OLD;
    _dataold := ROW(OLD.*)::text;
    _datanew := NULL;
  END IF;
  PERFORM m_espace_vert.ft_m_ev_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '9', '99', '999');
  -- 
  IF (TG_OP = 'INSERT') THEN
    RETURN NEW;
  ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table refnonclassee_point
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_point ON m_espace_vert.geo_v_ev_refnonclassee_point;
CREATE TRIGGER t_m_ev_refnonclassee_point INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_point
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();

-- trigger sur table refnonclassee_line
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_line ON m_espace_vert.geo_v_ev_refnonclassee_line;
CREATE TRIGGER t_m_ev_refnonclassee_line INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_line
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();

-- trigger sur table refnonclassee_polygon
-- DROP TRIGGER IF EXISTS t_m_ev_refnonclassee_polygon ON m_espace_vert.geo_v_ev_refnonclassee_polygon;
CREATE TRIGGER t_m_ev_refnonclassee_polygon INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_polygon
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_refnonclassee();


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


-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_pct ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_pct() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),    
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_pct SET
    x_l93 = ST_X(new.geom),
    y_l93 = ST_Y(new.geom),
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_pct ON m_espace_vert.geo_v_ev_objet_pct;
CREATE TRIGGER t_m_ev_objet_pct INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_pct 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_pct();     
     
 

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


-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_line ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_line() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),   
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_line SET
    long_m = ST_Length(new.geom)::integer,
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_line ON m_espace_vert.geo_v_ev_objet_line;
CREATE TRIGGER t_m_ev_objet_line INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_line 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_line();         



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


-- #################################################################### FONCTION/TRIGGER geo_v_ev_objet_polygon ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_ev_objet_polygon() RETURNS trigger LANGUAGE plpgsql AS $$
  
BEGIN
   
-- MAJ des attributs objets
    UPDATE m_espace_vert.an_ev_objet SET
    idobjet = OLD.idobjet,
    idgestion = (SELECT idgestion FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idsite = (SELECT idsite FROM m_espace_vert.geo_ev_zone_site WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),
    idequipe = (SELECT idequipe FROM m_espace_vert.geo_ev_zone_equipe WHERE ST_Intersects(NEW.geom,geom) LIMIT 1),  
    idcontrat = NEW.idcontrat,
    insee = (SELECT insee FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    commune = (SELECT commune FROM r_osm.geo_osm_commune WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    quartier = (SELECT nom FROM r_administratif.geo_adm_quartier WHERE st_intersects(NEW.geom,geom) LIMIT 1),
    typ1 = NEW.typ1,
    typ2 = NEW.typ2,
    typ3 = NEW.typ3,
    etat = NEW.etat,  
    doma = NEW.doma,
    qualdoma = NEW.qualdoma,
    op_sai = NEW.op_sai,  
    date_sai = NEW.date_sai,
    src_geom = NEW.src_geom,
    src_date = NEW.src_date,    
    op_att = NEW.op_att,
    date_maj_att = NEW.date_maj_att,	    
    op_maj = NEW.op_maj,  
    date_maj = NEW.date_sai,
    observ = NEW.observ  
    WHERE idobjet = NEW.idobjet;      
-- MAJ des attributs geom  
    UPDATE m_espace_vert.geo_ev_objet_polygon SET
    sup_m2 = round(cast(st_area(new.geom) as numeric),0),
    perimetre = NEW.perimetre,
    geom = NEW.geom 
    WHERE idobjet = NEW.idobjet; 
          
    RETURN NEW;

END;
$$
;
     
-- DROP TRIGGER IF EXISTS t_m_ev_objet_polygon ON m_espace_vert.geo_v_ev_objet_polygon;
CREATE TRIGGER t_m_ev_objet_polygon INSTEAD OF
UPDATE
ON m_espace_vert.geo_v_ev_objet_polygon 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_ev_objet_polygon();  


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


