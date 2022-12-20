/* ESPACE VERT V1.0*/
/* Creation des vues de gestion */
/* init_db_ev.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Fabien Nicollet (Business Geografic) */

-- 20221207 : FV/ suppression ressources obsolètes (vue geo_v_ev_arbre, attributs an_ev_arbre (gnss_heigh, vert_prec, horz_prec, cplt_fic_1, cplt_fic_2, northing, easting, gps_date))
-- 20221208 : FV/ ajout attributs admin+mesures géographiques dans les vues applicatives (arbre, massifarbustif, zoneboisee, espaceenherbe, massiffleuri, arbrealignement, haie)
-- 20221212 : FV/ ajout fonction/trigger et attributs admin+mesures geographiques dans certaines vues applicatives (arbusteisole, pointfleuri)
-- 20221212 : FV/ intégration des attributs admin+mesure dans les vues des classes minérales, hydro, refnonclasse pct-lin-polygon
-- 20221213 : FV/ suppression du domaine de valeur lt_ev_type_vegetation (et dépendance) qui permettait de définir un type de végétation arbre, arbustif et fleuri, pour des objets de massif arbustifs ou massif fleuri
-- 20221213 : FV/ correctif et élargissement de domaines de valeur (lt_ev_arbre_mode_conduite, lt_ev_arbre_stade_dev, ...)
-- 20221213 : FV/ modif fonction générique en écartant l'attribut position qui relève uniquement des objets de type végétal (an_ev_geovegetal)
-- 20221213 : FV/ intégration dans les fonctions trigger des vues des objets végétaux (arbreisole, arbrealignement, pointfleuri, massiffleuri, espaceenherbe), de l'insert/update de l'attribut position
-- 20221214 : FV/ intégration dans les fonctions trigger des vues des objets végétaux (zone boisée, arbusteisole, haie, massifarbustif), de l'insert/update de l'attribut position
-- 20221214 : FV/ correctif de la fonction générique pour faire passer le typ1 en variable et supprimer le caractère fixe à la valeur 1 = objet végétal + corrections dans les fonctions pour les vues
-- 20221214 : FV/ correctif vue geo_v_ev_pct qui excluait les arbres isolés (typ3 = 111)
-- 20221214 : FV/ correction de la fonction générique pour faire passer le typ3 en variable lors d'une mise à jour de façon à permettre dans les cas qui le necessite, un changement de typ3 (ex : voie de circulation)
-- 20221214 : FV/ extension des fonctions et trigger sur les objets minéraux (voiecirculation, zonedecirculation, cloture, loisirisole)
-- 20221215 : FV/ extension des fonctions et trigger sur les objets minéraux (espacedeloisirs, arriveedeau, pointdeau, coursdeau, etenduedeau, refnonclassee_pct-lin-polygon)
-- 20221220 : FV/ suppression des attributs 'surface' et 'observatio' hérités des classes ev_objet et ev_'typegeom' dans les classes EV végétaux, les vues et fonctions trigger associées
-- 20221220 : FV/ suppression de l'attribut danger de la classe an_ev_arbre et du domaine de valeur lié (lt_ev_arbredanger) 
-- 20221220 : FV/ ajout d'une vue stat pour calcul du nbr d'arbre par quartier


/*
ToDo :
- vérifier la structure générale du script (ex : paragraphe d'ajout de champs, dc table sur table préexistante, vue de gabarit ???)
- corriger les domaines de valeur avec des 00 qui ne sont pas des "non renseigné" (reste à évaluer/faire : arbre_date_plantation_saison, arbre_periode_plantation, intervention_freq_unite, intervention_periode)
- vérifier fonction de découpe (ou comment se faire l'intersection si plusieurs zonage) des objets hors arbre (enherbé, arbustif, minéraux, hydro, non classés), depuis les découpages admin
- commentaires des attributs des vues
(A VERIFIER SI FAIT > - absence insert update du champ largeur larg_cm de la class geoline utilisée pour les haies et voies de circulation
- attribut position sans valeur par défaut (à corriger)
- attributs ev_objet avec plusieurs valeur par dégfaut à vérifier (src_geom ...)

*/


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           TABLES                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- table de log de l'historique à l'image de m_reseau_sec.an_ecl_log
DROP TABLE IF EXISTS m_espace_vert.an_ev_log;
CREATE TABLE m_espace_vert.an_ev_log (
	idlog serial primary key,
	tablename varchar(80) NOT NULL,
	type_ope text NOT NULL,
	dataold text,
	datanew text,
	date_maj timestamp default now()
);

ALTER TABLE m_espace_vert.an_ev_log OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_log TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_log TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_log TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_log TO sig_edit;


-- ajout de la table de liste "lt_ev_situation"
DROP TABLE IF EXISTS m_espace_vert.lt_ev_situation;
CREATE TABLE IF NOT EXISTS m_espace_vert.lt_ev_situation (
	code varchar(2) NOT NULL,
	valeur varchar(80) NOT NULL,
	CONSTRAINT lt_ev_situation_pkey PRIMARY KEY (code)
);
COMMENT ON TABLE m_espace_vert.lt_ev_situation IS 'Liste permettant de décrire les différents états des objets';
INSERT INTO m_espace_vert.lt_ev_situation (code, valeur) VALUES('10', 'Actif');
INSERT INTO m_espace_vert.lt_ev_situation (code, valeur) VALUES('12', 'Supprimé');



-- création des tables de liste pour Arbre : genres/espèces
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbregenre;
CREATE TABLE m_espace_vert.lt_ev_arbregenre (
	id serial primary key,
  famille text,
	genre text NOT NULL,
  espece text NOT NULL,
  cultivar text
);

COMMENT ON TABLE m_espace_vert.lt_ev_arbregenre IS 'Liste permettant de décrire les différents famille/genre/espèces d''arbres';
-- remplissage à partir des données existantes, car pas de référentiel en BDD
INSERT INTO m_espace_vert.lt_ev_arbregenre(genre, espece) 
SELECT distinct genre, espece FROM m_espace_vert.an_ev_arbre where genre <> '' order by 1, 2;

-- création des tables de liste pour Arbre : Mode de conduite
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_mode_conduite;
CREATE TABLE m_espace_vert.lt_ev_arbre_mode_conduite (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_mode_conduite IS 'Liste permettant de décrire le "Mode de conduite" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('01', 'Tête de chat');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('02', 'Mauvais suivi');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('03', 'Rideaux');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('04', 'Port libre');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('05', 'Semi libre');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('06', 'Accompagnement');
INSERT INTO m_espace_vert.lt_ev_arbre_mode_conduite(code, valeur) VALUES ('99', 'Autre');

-- création des tables de liste pour Arbre : Type de contrainte
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_type_contrainte;
CREATE TABLE m_espace_vert.lt_ev_arbre_type_contrainte (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_type_contrainte IS 'Liste permettant de décrire le "Type de contrainte" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_type_contrainte(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_type_contrainte(code, valeur) VALUES ('01', 'Cohabitation');
INSERT INTO m_espace_vert.lt_ev_arbre_type_contrainte(code, valeur) VALUES ('99', 'Autre');

-- création des tables de liste pour Arbre : Période de plantation
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_periode_plantation;
CREATE TABLE m_espace_vert.lt_ev_arbre_periode_plantation (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_periode_plantation IS 'Liste permettant de décrire la "Période de plantation" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('00', '1900');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('01', '1910');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('02', '1920');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('03', '1930');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('04', '1940');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('05', '1950');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('06', '1960');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('07', '1970');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('08', '1980');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('09', '1990');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('10', '2000');
INSERT INTO m_espace_vert.lt_ev_arbre_periode_plantation(code, valeur) VALUES ('11', '2010');

-- création des tables de liste pour Arbre : Date de plantation (saison)
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_date_plantation_saison;
CREATE TABLE m_espace_vert.lt_ev_arbre_date_plantation_saison (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_date_plantation_saison IS 'Liste permettant de décrire la "Date de plantation (saison)" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_date_plantation_saison(code, valeur) VALUES ('00', 'Automne');
INSERT INTO m_espace_vert.lt_ev_arbre_date_plantation_saison(code, valeur) VALUES ('01', 'Eté');
INSERT INTO m_espace_vert.lt_ev_arbre_date_plantation_saison(code, valeur) VALUES ('02', 'Hiver');
INSERT INTO m_espace_vert.lt_ev_arbre_date_plantation_saison(code, valeur) VALUES ('03', 'Printemps');

-- création des tables de liste pour Arbre : Stade de développement 
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_stade_dev;
CREATE TABLE m_espace_vert.lt_ev_arbre_stade_dev (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_stade_dev IS 'Liste permettant de décrire le "Stade de développement" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_stade_dev(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_stade_dev(code, valeur) VALUES ('01', 'Jeune');
INSERT INTO m_espace_vert.lt_ev_arbre_stade_dev(code, valeur) VALUES ('02', 'Adulte');
INSERT INTO m_espace_vert.lt_ev_arbre_stade_dev(code, valeur) VALUES ('03', 'Mature');

-- création des tables de liste pour Arbre : Type de sol
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_type_sol;
CREATE TABLE m_espace_vert.lt_ev_arbre_type_sol (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_type_sol IS 'Liste permettant de décrire le "Type de sol" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_type_sol(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_type_sol(code, valeur) VALUES ('01', 'Mauvais');
INSERT INTO m_espace_vert.lt_ev_arbre_type_sol(code, valeur) VALUES ('02', 'Moyen');
INSERT INTO m_espace_vert.lt_ev_arbre_type_sol(code, valeur) VALUES ('03', 'Bon');

-- création des tables de liste pour Arbre : Aménagement pied de l’arbre
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_amenagement_pied;
CREATE TABLE m_espace_vert.lt_ev_arbre_amenagement_pied (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_amenagement_pied IS 'Liste permettant de décrire le "Aménagement pied de l''arbre" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_amenagement_pied(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_amenagement_pied(code, valeur) VALUES ('01', 'Grille');
INSERT INTO m_espace_vert.lt_ev_arbre_amenagement_pied(code, valeur) VALUES ('02', 'Fleuri');
INSERT INTO m_espace_vert.lt_ev_arbre_amenagement_pied(code, valeur) VALUES ('99', 'Autre');

-- création des tables de liste pour Arbre : Niveau allergisant
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_niveau_allergisant;
CREATE TABLE m_espace_vert.lt_ev_arbre_niveau_allergisant (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_niveau_allergisant IS 'Liste permettant de décrire le "Niveau allergisant" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_niveau_allergisant(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_niveau_allergisant(code, valeur) VALUES ('01', 'Faible');
INSERT INTO m_espace_vert.lt_ev_arbre_niveau_allergisant(code, valeur) VALUES ('02', 'Moyen');
INSERT INTO m_espace_vert.lt_ev_arbre_niveau_allergisant(code, valeur) VALUES ('03', 'Elevé');

-- création des tables de liste pour Etat sanitaire : Type d'anomalie
DROP TABLE IF EXISTS m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type;
CREATE TABLE m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type IS 'Liste permettant de décrire le "Type d''anomalie" des arbres';
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('01', 'Descente de cime');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('02', 'Champignon');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('03', 'Ravageur');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('04', 'Pourriture');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('05', 'Défaut mécanique (écorce incluse)');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('06', 'Racine altérée');
INSERT INTO m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code, valeur) VALUES ('99', 'Autre');

-- table contenant la liste des états sanitaires (données jointes 0...N)
DROP TABLE IF EXISTS m_espace_vert.an_ev_arbre_etat_sanitaire;
CREATE TABLE m_espace_vert.an_ev_arbre_etat_sanitaire (
  id serial primary key,
  idobjet integer,
  date_const timestamp without time zone,
  ano_type varchar(2) default '00',
  a_surveill boolean default false
);
COMMENT ON TABLE m_espace_vert.an_ev_arbre_etat_sanitaire IS 'Table contenant la liste des états sanitaires des arbres';

ALTER TABLE m_espace_vert.an_ev_arbre_etat_sanitaire OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_arbre_etat_sanitaire TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_arbre_etat_sanitaire TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_arbre_etat_sanitaire TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_arbre_etat_sanitaire TO sig_edit;

-- création des tables de liste pour espaceenherbe : Type d’espace
DROP TABLE IF EXISTS m_espace_vert.lt_ev_type_espace;
CREATE TABLE m_espace_vert.lt_ev_type_espace (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_type_espace IS 'Liste permettant de décrire le "Type d''espace" des espaces en herbe';
INSERT INTO m_espace_vert.lt_ev_type_espace(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_type_espace(code, valeur) VALUES ('01', 'Ambiance fleuries/horticoles');
INSERT INTO m_espace_vert.lt_ev_type_espace(code, valeur) VALUES ('02', 'Ambiance végétale/ornementales');
INSERT INTO m_espace_vert.lt_ev_type_espace(code, valeur) VALUES ('03', 'Ambiance champêtre');
INSERT INTO m_espace_vert.lt_ev_type_espace(code, valeur) VALUES ('04', 'Ambiance de nature');

-- création des tables de liste pour espaceenherbe : Type d’arrosage automatique
DROP TABLE IF EXISTS m_espace_vert.lt_ev_type_arrosage;
CREATE TABLE m_espace_vert.lt_ev_type_arrosage (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_type_arrosage IS 'Liste permettant de décrire le "Type d''arrosage automatique" des espaces en herbe';
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('01', 'Arrosage à jet rotatif');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('02', 'Arrosage goutte à goutte ou localisé');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('03', 'Arrosage en surface - asperseur');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('04', 'Arrosage enterré');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('05', 'Tuyaux poreux');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('06', 'Arroseur oscillant');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('07', 'Arroseur canon');
INSERT INTO m_espace_vert.lt_ev_type_arrosage(code, valeur) VALUES ('08', 'Tuyaux à goutteurs intégrés');

-- table contenant les attributs complémentaires pour espaceenherbe
DROP TABLE IF EXISTS m_espace_vert.an_ev_espaceenherbe;
CREATE TABLE m_espace_vert.an_ev_espaceenherbe (
	idobjet     int8 PRIMARY KEY,
  type_espac  varchar(2) default '00',
  type_arros  varchar(2) default '00',
  arros_auto  boolean default false,
  biodiversi  text,
  inv_faunis  boolean default false
);
COMMENT ON TABLE m_espace_vert.an_ev_espaceenherbe IS 'Table contenant les attributs complémentaires pour les espaces en herbe';
COMMENT ON COLUMN m_espace_vert.an_ev_espaceenherbe.type_espac IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_espaceenherbe.arros_auto IS 'Arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_espaceenherbe.type_arros IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_espaceenherbe.biodiversi IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_espaceenherbe.inv_faunis IS 'Inventaire faunistique / floristique réalisé ?';

-- m_espace_vert.an_ev_arbre foreign keys
ALTER TABLE m_espace_vert.an_ev_espaceenherbe ADD CONSTRAINT lt_ev_type_espace_fkey FOREIGN KEY (type_espac) REFERENCES m_espace_vert.lt_ev_type_espace(code);
ALTER TABLE m_espace_vert.an_ev_espaceenherbe ADD CONSTRAINT lt_ev_type_arrosage_fkey FOREIGN KEY (type_arros) REFERENCES m_espace_vert.lt_ev_type_arrosage(code);

ALTER TABLE m_espace_vert.an_ev_espaceenherbe OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_espaceenherbe TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_espaceenherbe TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_espaceenherbe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_espaceenherbe TO sig_edit;


-- table contenant les attributs complémentaires pour massiffleuri
DROP TABLE IF EXISTS m_espace_vert.an_ev_massiffleuri;
CREATE TABLE m_espace_vert.an_ev_massiffleuri (
	idobjet     int8 PRIMARY KEY,
  type_espac  varchar(2) default '00',
  type_arros  varchar(2) default '00',
  arros_auto  boolean default false,
  biodiversi  text,
  inv_faunis  boolean default false
);
COMMENT ON TABLE m_espace_vert.an_ev_massiffleuri IS 'Table contenant les attributs complémentaires pour les massifs';
COMMENT ON COLUMN m_espace_vert.an_ev_massiffleuri.type_espac IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_massiffleuri.arros_auto IS 'Arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_massiffleuri.type_arros IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_massiffleuri.biodiversi IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_massiffleuri.inv_faunis IS 'Inventaire faunistique / floristique réalisé ?';

-- m_espace_vert.an_ev_arbre foreign keys
ALTER TABLE m_espace_vert.an_ev_massiffleuri ADD CONSTRAINT lt_ev_type_espace_fkey FOREIGN KEY (type_espac) REFERENCES m_espace_vert.lt_ev_type_espace(code);
ALTER TABLE m_espace_vert.an_ev_massiffleuri ADD CONSTRAINT lt_ev_type_arrosage_fkey FOREIGN KEY (type_arros) REFERENCES m_espace_vert.lt_ev_type_arrosage(code);

ALTER TABLE m_espace_vert.an_ev_massiffleuri OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_massiffleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_massiffleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_massiffleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_massiffleuri TO sig_edit;

-- table contenant les attributs complémentaires pour massifarbustif
DROP TABLE IF EXISTS m_espace_vert.an_ev_massifarbustif;
CREATE TABLE m_espace_vert.an_ev_massifarbustif (
	idobjet     int8 PRIMARY KEY,
  type_espac  varchar(2) default '00',
  type_arros  varchar(2) default '00',
  arros_auto  boolean default false,
  biodiversi  text,
  inv_faunis  boolean default false
);
COMMENT ON TABLE m_espace_vert.an_ev_massifarbustif IS 'Table contenant les attributs complémentaires pour les massifs arbustifs';
COMMENT ON COLUMN m_espace_vert.an_ev_massifarbustif.type_espac IS 'Type d''espace';
COMMENT ON COLUMN m_espace_vert.an_ev_massifarbustif.arros_auto IS 'Arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_massifarbustif.type_arros IS 'Type d''arrosage automatique';
COMMENT ON COLUMN m_espace_vert.an_ev_massifarbustif.biodiversi IS 'Biodiversité';
COMMENT ON COLUMN m_espace_vert.an_ev_massifarbustif.inv_faunis IS 'Inventaire faunistique / floristique réalisé ?';

ALTER TABLE m_espace_vert.an_ev_massifarbustif OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_massifarbustif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_massifarbustif TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_massifarbustif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_massifarbustif TO sig_edit;

-- création des tables de liste pour haies : Type végétation
DROP TABLE IF EXISTS m_espace_vert.lt_ev_type_vegetation_haie;
CREATE TABLE m_espace_vert.lt_ev_type_vegetation_haie (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_type_vegetation_haie IS 'Liste permettant de décrire le "Type végétation" des haies';
INSERT INTO m_espace_vert.lt_ev_type_vegetation_haie(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_type_vegetation_haie(code, valeur) VALUES ('01', 'Haie monospécifique');
INSERT INTO m_espace_vert.lt_ev_type_vegetation_haie(code, valeur) VALUES ('02', 'Haie mixte');

-- création des tables de liste pour haies : Type paillage
DROP TABLE IF EXISTS m_espace_vert.lt_ev_type_paillage_haie;
CREATE TABLE m_espace_vert.lt_ev_type_paillage_haie (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_type_paillage_haie IS 'Liste permettant de décrire le "Type paillage" des haies';
INSERT INTO m_espace_vert.lt_ev_type_paillage_haie(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_type_paillage_haie(code, valeur) VALUES ('01', 'Paillage organique');
INSERT INTO m_espace_vert.lt_ev_type_paillage_haie(code, valeur) VALUES ('02', 'Paillage minéral');

-- GESTION DES INTERVENTIONS
-- création des tables de liste pour interv : Type d'objet
-- cas exceptionnel, pour faciliter les traitements, on stocke comme code, le "typ3" de l'objet
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_type_objet;
CREATE TABLE m_espace_vert.lt_ev_intervention_type_objet (
  code varchar(3) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_type_objet IS 'Liste permettant de décrire le "Type d''objet" des interventions';
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('000', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('111', 'Arbres');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('113', 'Zones boisées');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('122', 'Haies');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('123', 'Massifs arbustifs');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('132', 'Massifs fleuris');
INSERT INTO m_espace_vert.lt_ev_intervention_type_objet(code, valeur) VALUES ('141', 'Engazonnements');



-- création des tables de liste pour interv : Type d'intervention (liée au type d'objet)
DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_type_inter;
CREATE TABLE m_espace_vert.lt_ev_intervention_type_inter (
  code varchar(2) NOT NULL PRIMARY KEY,
  type_objet varchar(3) NOT NULL,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_type_inter IS 'Liste permettant de décrire le type d''intervention';
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('00', '111', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('01', '111', 'Abattage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('02', '111', 'Tête de chat');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('03', '111', 'Cohabitation');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('04', '111', 'Sanitaire');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('05', '111', 'Sélection');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('06', '111', 'Démontage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('07', '111', 'Remontée de couronne');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('08', '111', 'Formation');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('10', '113', 'Abattage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('11', '113', 'Coupe');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('12', '113', 'Elagage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('20', '122', 'Abattage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('21', '122', 'Coupe');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('22', '122', 'Elagage');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('30', '141', 'Tonte');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('31', '141', 'Traitement');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('40', '132', 'Tonte');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('41', '132', 'Traitement');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('50', '123', 'Tonte');
INSERT INTO m_espace_vert.lt_ev_intervention_type_inter(code, type_objet, valeur) VALUES ('51', '123', 'Traitement');
-- constraint
ALTER TABLE m_espace_vert.lt_ev_intervention_type_inter ADD CONSTRAINT lt_ev_intervention_type_inter_type_objet_fkey FOREIGN KEY (type_objet) REFERENCES m_espace_vert.lt_ev_intervention_type_objet(code);


DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_src_demand;
CREATE TABLE m_espace_vert.lt_ev_intervention_src_demand (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_src_demand IS 'Liste permettant de décrire la source d''une demande d''intervention';
INSERT INTO m_espace_vert.lt_ev_intervention_src_demand(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_intervention_src_demand(code, valeur) VALUES ('01', 'Interne');
INSERT INTO m_espace_vert.lt_ev_intervention_src_demand(code, valeur) VALUES ('02', 'Riverain');

DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_freq_unite;
CREATE TABLE m_espace_vert.lt_ev_intervention_freq_unite (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_freq_unite IS 'Liste des unités pour la fréquence des DI';
INSERT INTO m_espace_vert.lt_ev_intervention_freq_unite(code, valeur) VALUES ('00', 'Jours');
INSERT INTO m_espace_vert.lt_ev_intervention_freq_unite(code, valeur) VALUES ('01', 'Semaines');
INSERT INTO m_espace_vert.lt_ev_intervention_freq_unite(code, valeur) VALUES ('02', 'Mois');
INSERT INTO m_espace_vert.lt_ev_intervention_freq_unite(code, valeur) VALUES ('03', 'Ans');

DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_statut;
CREATE TABLE m_espace_vert.lt_ev_intervention_statut (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_statut IS 'Liste des unités pour le statut des DI';
INSERT INTO m_espace_vert.lt_ev_intervention_statut(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_intervention_statut(code, valeur) VALUES ('01', 'Terminée');
INSERT INTO m_espace_vert.lt_ev_intervention_statut(code, valeur) VALUES ('02', 'Annulée');
INSERT INTO m_espace_vert.lt_ev_intervention_statut(code, valeur) VALUES ('03', 'Suspendue');

DROP TABLE IF EXISTS m_espace_vert.lt_ev_intervention_periode;
CREATE TABLE m_espace_vert.lt_ev_intervention_periode (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);
COMMENT ON TABLE m_espace_vert.lt_ev_intervention_periode IS 'Liste des mois de l''année';
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('00', 'Janvier');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('01', 'Février');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('02', 'Mars');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('03', 'Avril');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('04', 'Mai');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('05', 'Juin');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('06', 'Juillet');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('07', 'Août');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('08', 'Septembre');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('09', 'Octobre');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('10', 'Novembre');
INSERT INTO m_espace_vert.lt_ev_intervention_periode(code, valeur) VALUES ('11', 'Décembre');


-- table des demandes d'intervention
DROP TABLE IF EXISTS m_espace_vert.an_ev_demande_intervention;
CREATE TABLE m_espace_vert.an_ev_demande_intervention (
  id_inter integer PRIMARY KEY default nextval('m_espace_vert.an_ev_objet_idobjet_seq'),
  type_objet varchar(3),
  type_inter varchar(2) default '00',
  src_demand varchar(2) default '00',
  com_demand text,
  dat_souhai date,
  contr_adm  boolean default false,
  contr_admc text,
  ress_affec integer, -- lien vers la table geo_ev_equipe
  commentair text,
  nb_jr_rapp integer,
  -- ajout d'un champ "id_demande" pour pouvoir faire une logique commune au niveau du trigger
  -- ce champ ne sera pas utilisé dans le trigger
  id_demande integer,
  -- ajout d'un champ "id_equipe" pour la liaison avec un secteur d'équipe
  id_equipe integer,
  -- récurrence
  recurrent boolean default false,
  freq_value integer,
  freq_unite varchar(2) default '00',
  dat_ref    date,
  period_sta varchar(2) default '00',
  period_end varchar(2) default '00',
  --
  dat_sai    timestamp without time zone default now(),
  op_sai     text,
  geom       geometry(Polygon, 2154)
);
COMMENT ON TABLE m_espace_vert.an_ev_demande_intervention IS 'Tables contenant les demandes d''intervention';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.type_objet IS 'Type d''objets';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.type_inter IS 'Type d''intervention';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.src_demand IS 'Source demande';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.com_demand IS 'Commentaire demande';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.dat_souhai IS 'Date d''intervention souhaitée';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.contr_adm IS 'Contraintes administratives';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.contr_admc IS 'Commentaire sur contraintes adm.';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.ress_affec IS 'Équipe / Entreprise affectée';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.commentair IS 'Commentaire';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.nb_jr_rapp IS 'Nb jours rappel';
-- récurrence
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.recurrent IS 'Demande d''intervention récurrente';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.freq_value IS 'Fréquence (valeur)';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.freq_unite IS 'Fréquence (unité)';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.dat_ref IS 'Date de référence';
--
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.dat_sai IS 'Date saisie';
COMMENT ON COLUMN m_espace_vert.an_ev_demande_intervention.op_sai IS 'Auteur saisie';

ALTER TABLE m_espace_vert.an_ev_demande_intervention OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_demande_intervention TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_demande_intervention TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_demande_intervention TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_demande_intervention TO sig_edit;

-- index
CREATE INDEX IF NOT EXISTS an_ev_demande_intervention_geom_idx ON m_espace_vert.an_ev_demande_intervention USING gist (geom);
-- constraint
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_type_objet_fkey FOREIGN KEY (type_objet) REFERENCES m_espace_vert.lt_ev_intervention_type_objet(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_type_inter_fkey FOREIGN KEY (type_inter) REFERENCES m_espace_vert.lt_ev_intervention_type_inter(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_src_demand_fkey FOREIGN KEY (src_demand) REFERENCES m_espace_vert.lt_ev_intervention_src_demand(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_freq_unite_fkey FOREIGN KEY (freq_unite) REFERENCES m_espace_vert.lt_ev_intervention_freq_unite(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_periode_sta_fkey FOREIGN KEY (period_sta) REFERENCES m_espace_vert.lt_ev_intervention_periode(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_periode_end_fkey FOREIGN KEY (period_end) REFERENCES m_espace_vert.lt_ev_intervention_periode(code);
ALTER TABLE m_espace_vert.an_ev_demande_intervention ADD CONSTRAINT lt_ev_demande_intervention_ress_affec_fkey FOREIGN KEY (ress_affec) REFERENCES m_espace_vert.geo_ev_equipe(idequipe);

-- table de jointure N-M entre demandes d'intervention et objets
DROP TABLE IF EXISTS m_espace_vert.an_ev_intervention_objets;
CREATE TABLE m_espace_vert.an_ev_intervention_objets (
  id serial primary key,
  id_inter integer NOT NULL,
  idobjet integer NOT NULL
);
COMMENT ON TABLE m_espace_vert.an_ev_intervention_objets IS 'Tables de jointure N-M contenant la liaison entre les objets et les demandes d''intervention';
ALTER TABLE m_espace_vert.an_ev_intervention_objets OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_intervention_objets TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_intervention_objets TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_intervention_objets TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_intervention_objets TO sig_edit;
-- constraint
ALTER TABLE m_espace_vert.an_ev_intervention_objets ADD CONSTRAINT an_ev_objet_fkey FOREIGN KEY (idobjet) REFERENCES m_espace_vert.an_ev_objet(idobjet);

-- table des interventions
DROP TABLE IF EXISTS m_espace_vert.an_ev_intervention;
CREATE TABLE m_espace_vert.an_ev_intervention (
  id_inter integer PRIMARY KEY default nextval('m_espace_vert.an_ev_objet_idobjet_seq'),
  type_objet varchar(3),
  type_inter varchar(2) default '00',
  -- ajout d'un champ "id_equipe" pour la liaison avec un secteur d'équipe
  id_equipe integer,
  id_demande integer,
  dat_interv date default now(),
  ress_affec integer, -- lien vers la table geo_ev_equipe
  statut     varchar(2) default '00',
  taches_eff text,
  commentair text,
  notif_resp boolean default true,
  -- récurrence
  nb_jr_rapp integer,
  recurrent boolean default false,
  freq_value integer,
  freq_unite varchar(2) default '00',
  dat_ref    date,
  period_sta varchar(2) default '00',
  period_end varchar(2) default '00',
  --
  dat_sai    timestamp without time zone default now(),
  op_sai     text,
  geom       geometry(Polygon, 2154)
);
COMMENT ON TABLE m_espace_vert.an_ev_intervention IS 'Tables contenant les interventions';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.type_objet IS 'Type d''objets';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.type_inter IS 'Type d''intervention';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.id_demande IS 'Demande liée';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.dat_interv IS 'Date d''intervention';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.ress_affec IS 'Équipe / Entreprise';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.statut IS 'Statut';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.taches_eff IS 'Liste des tâches effectuées';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.notif_resp IS 'Envoyer notification aux responsables EV ?';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.commentair IS 'Commentaire';
-- récurrence
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.nb_jr_rapp IS 'Nb jours rappel';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.recurrent IS 'Intervention récurrente';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.freq_value IS 'Fréquence (valeur)';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.freq_unite IS 'Fréquence (unité)';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.dat_ref IS 'Date de référence';
--
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.dat_sai IS 'Date saisie';
COMMENT ON COLUMN m_espace_vert.an_ev_intervention.op_sai IS 'Auteur saisie';

ALTER TABLE m_espace_vert.an_ev_intervention OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.an_ev_intervention TO sig_read;
GRANT ALL ON TABLE m_espace_vert.an_ev_intervention TO sig_create;
GRANT ALL ON TABLE m_espace_vert.an_ev_intervention TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.an_ev_intervention TO sig_edit;

-- index
CREATE INDEX IF NOT EXISTS an_ev_intervention_geom_idx ON m_espace_vert.an_ev_intervention USING gist (geom);

-- constraint
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_type_objet_fkey FOREIGN KEY (type_objet) REFERENCES m_espace_vert.lt_ev_intervention_type_objet(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_type_inter_fkey FOREIGN KEY (type_inter) REFERENCES m_espace_vert.lt_ev_intervention_type_inter(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_statut_fkey FOREIGN KEY (statut) REFERENCES m_espace_vert.lt_ev_intervention_statut(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_freq_unite_fkey FOREIGN KEY (freq_unite) REFERENCES m_espace_vert.lt_ev_intervention_freq_unite(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_periode_sta_fkey FOREIGN KEY (period_sta) REFERENCES m_espace_vert.lt_ev_intervention_periode(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_periode_end_fkey FOREIGN KEY (period_end) REFERENCES m_espace_vert.lt_ev_intervention_periode(code);
ALTER TABLE m_espace_vert.an_ev_intervention ADD CONSTRAINT lt_ev_intervention_ress_affec_fkey FOREIGN KEY (ress_affec) REFERENCES m_espace_vert.geo_ev_equipe(idequipe);

-- Liste des spécialisations entreprise
DROP TABLE IF EXISTS m_espace_vert.lt_ev_equipe_specialisation;
CREATE TABLE m_espace_vert.lt_ev_equipe_specialisation (
  code varchar(2) NOT NULL PRIMARY KEY,
	valeur varchar(80) NULL
);

COMMENT ON TABLE m_espace_vert.lt_ev_equipe_specialisation IS 'Tables contenant la liste des spécialisations des entreprises';
INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(code, valeur) VALUES ('00', 'Non renseigné');
INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(code, valeur) VALUES ('01', 'Taille en rideau');
INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(code, valeur) VALUES ('02', 'Tonte');
INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(code, valeur) VALUES ('03', 'Désherbage');
INSERT INTO m_espace_vert.lt_ev_equipe_specialisation(code, valeur) VALUES ('04', 'Taille');

-- création de la couche des équipes (secteurs)
DROP TABLE IF EXISTS m_espace_vert.geo_ev_equipe;
CREATE TABLE m_espace_vert.geo_ev_equipe (
  idequipe serial PRIMARY KEY,
  nom text,
  interne boolean default true,
  nom_resp text,
  tel_resp text,
  email text,
  specialisa varchar(2) default '00',
  geom public.geometry(MultiPolygon, 2154) NULL
);
COMMENT ON TABLE m_espace_vert.geo_ev_equipe IS 'Tables contenant la liste des équipes EV';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.nom IS 'Nom de l''équipe ou de l''entreprise';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.interne IS 'Interne ou entreprise';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.nom_resp IS 'Nom du responsable';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.tel_resp IS 'Téléphone du responsable';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.email IS 'Adresse email du responsable';
COMMENT ON COLUMN m_espace_vert.geo_ev_equipe.specialisa IS 'Spécialisations, pour les entreprises ';

CREATE INDEX IF NOT EXISTS geo_ev_equipe_geom_idx ON m_espace_vert.geo_ev_equipe USING gist (geom);

ALTER TABLE m_espace_vert.geo_ev_equipe ADD CONSTRAINT lt_ev_equipe_specialisa_fkey FOREIGN KEY (specialisa) REFERENCES m_espace_vert.lt_ev_equipe_specialisation(code);

-- remplissage initial de la table à partir des zones
INSERT INTO m_espace_vert.geo_ev_equipe (geom) SELECT geom from m_espace_vert.geo_ev_zone_gestion;
UPDATE m_espace_vert.geo_ev_equipe SET nom = 'Equipe ' || idequipe;
UPDATE m_espace_vert.geo_ev_equipe SET nom_resp = 'Resp Equipe ' || idequipe;
UPDATE m_espace_vert.geo_ev_equipe SET email = 'resp_equipe' || idequipe || '@agglo-compiegne.fr';



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           FIELDS                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- ajout du champ "situation" (permet de détecter les suppressions) sur la table d'objet de base "an_ev_objet"
-- fait à l'image de m_reseau_sec.geo_ecl_noeud, le champ "situation" contient "12" si suppression, "10" si actif
-- liaison avec une table jointe à 3 états
ALTER TABLE m_espace_vert.an_ev_objet ADD situation varchar(2) NOT NULL DEFAULT '10'::character varying;
COMMENT ON COLUMN m_espace_vert.an_ev_objet.situation IS 'Situation générale : Actif / supprimé';
-- ajout d'une contrainte de clé étrangère
ALTER TABLE m_espace_vert.an_ev_objet ADD CONSTRAINT an_ev_objet_lt_ev_situation_fkey FOREIGN KEY (situation) REFERENCES m_espace_vert.lt_ev_situation(code);

-- ajout d'un champ contenant le matricule de l'opérateur qui fait une modification
ALTER TABLE m_espace_vert.an_ev_objet ADD op_maj varchar(80);

-- ajout des champs de saisie au niveau des arbres
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS cultivar text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.cultivar IS 'Cultivar';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS mode_cond text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.mode_cond IS 'Mode de conduite. Assimilé à « port de taille » ou forme taillée. Ex : tête de chat, mauvais suivi ';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS contrainte boolean default false;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.contrainte IS 'Contrainte ?';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS contr_type text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.contr_type IS 'Cohabitation, ... ?';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS date_pl_an integer;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.date_pl_an IS 'Date de plantation (année)';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS date_pl_sa text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.date_pl_an IS 'Date de plantation (saison)';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS periode_pl text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.periode_pl IS 'Période de plantation approx. (Décennie)';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS stade_dev varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.stade_dev IS 'Stade de développement';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS protege varchar(3) default 'Non';
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.protege IS 'Arbre protégé';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS protege_co text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.protege_co IS 'Commentaire arbre protégé';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS remarq_com text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.remarq_com IS 'Commentaire arbre remarquable';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS diam_houpp text;
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.diam_houpp IS 'Diamètre houppier';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS type_sol varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.type_sol IS 'Type de sol';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS amena_pied varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.amena_pied IS 'Aménagement pied de l''arbre';
ALTER TABLE m_espace_vert.an_ev_arbre ADD COLUMN IF NOT EXISTS niveau_all varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_arbre.niveau_all IS 'Niveau allergisant';

-- vm_espace_vert.an_ev_media
-- manque un champ pour laisser l'utilisateur saisir la date de la prise de vue
ALTER TABLE m_espace_vert.an_ev_media ADD COLUMN date_prise_vue timestamp without time zone;
ALTER TABLE m_espace_vert.an_ev_media ADD COLUMN date_creation timestamp without time zone default now();


-- champs manquants sur la table "an_ev_geohaie"
ALTER TABLE m_espace_vert.an_ev_geohaie ADD COLUMN IF NOT EXISTS type_veget varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_geohaie.type_veget IS 'Type végétation';
ALTER TABLE m_espace_vert.an_ev_geohaie ADD COLUMN IF NOT EXISTS hauteur numeric;
COMMENT ON COLUMN m_espace_vert.an_ev_geohaie.hauteur IS 'Hauteur';;
ALTER TABLE m_espace_vert.an_ev_geohaie ADD COLUMN IF NOT EXISTS type_espace varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_geohaie.type_espace IS 'Type d''espace';
ALTER TABLE m_espace_vert.an_ev_geohaie ADD COLUMN IF NOT EXISTS type_paill varchar(2);
COMMENT ON COLUMN m_espace_vert.an_ev_geohaie.type_paill IS 'Type de paillage';
ALTER TABLE m_espace_vert.an_ev_geohaie ADD COLUMN IF NOT EXISTS biodiversi text;
COMMENT ON COLUMN m_espace_vert.an_ev_geohaie.biodiversi IS 'Biodiversité';

-- champ identifiant KO sur les zones de gestion
alter TABLE m_espace_vert.geo_ev_zone_gestion drop column idzone;
alter TABLE m_espace_vert.geo_ev_zone_gestion add column idzone serial;

-- champ identifiant KO sur les sites cohérents
alter TABLE m_espace_vert.geo_ev_site drop column idsite;
alter TABLE m_espace_vert.geo_ev_site add column idsite serial;

-- ajout champ identifiant secteur d'équipe sur metaclasse
alter TABLE m_espace_vert.an_ev_objet add column idequipe int4;
ALTER TABLE m_espace_vert.an_ev_objet ADD CONSTRAINT an_ev_objet_lt_ev_idequipe_fkey FOREIGN KEY (idequipe) REFERENCES m_espace_vert.geo_ev_equipe(idequipe);

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           CONSTRAINT                                                    ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- ajout des contraintes de clé étrangère pour les champs liés à une liste
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_type_contrainte_fkey FOREIGN KEY (contr_type) REFERENCES m_espace_vert.lt_ev_arbre_type_contrainte(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_periode_plantation_fkey FOREIGN KEY (periode_pl) REFERENCES m_espace_vert.lt_ev_arbre_periode_plantation(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_stade_dev_fkey FOREIGN KEY (stade_dev) REFERENCES m_espace_vert.lt_ev_arbre_stade_dev(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_type_sol_fkey FOREIGN KEY (type_sol) REFERENCES m_espace_vert.lt_ev_arbre_type_sol(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_amenagement_pied_fkey FOREIGN KEY (amena_pied) REFERENCES m_espace_vert.lt_ev_arbre_amenagement_pied(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre ADD CONSTRAINT lt_ev_arbre_niveau_allergisant_fkey FOREIGN KEY (niveau_all) REFERENCES m_espace_vert.lt_ev_arbre_niveau_allergisant(code) NOT VALID;


ALTER TABLE m_espace_vert.an_ev_arbre_etat_sanitaire ADD CONSTRAINT lt_ev_arbre_etat_sanitaire_ano_type_fkey FOREIGN KEY (ano_type) REFERENCES m_espace_vert.lt_ev_arbre_etat_sanitaire_ano_type(code) NOT VALID;
ALTER TABLE m_espace_vert.an_ev_arbre_etat_sanitaire ADD CONSTRAINT lt_ev_arbre_etat_sanitaire_idobjet_fkey FOREIGN KEY (idobjet) REFERENCES m_espace_vert.an_ev_objet(idobjet) ON DELETE CASCADE;

-- m_espace_vert.an_ev_arbre foreign keys
ALTER TABLE m_espace_vert.an_ev_massifarbustif ADD CONSTRAINT lt_ev_type_espace_fkey FOREIGN KEY (type_espac) REFERENCES m_espace_vert.lt_ev_type_espace(code);
ALTER TABLE m_espace_vert.an_ev_massifarbustif ADD CONSTRAINT lt_ev_type_arrosage_fkey FOREIGN KEY (type_arros) REFERENCES m_espace_vert.lt_ev_type_arrosage(code);

-- an_ev_geohaie
ALTER TABLE m_espace_vert.an_ev_geohaie ADD CONSTRAINT lt_ev_type_espace_fkey FOREIGN KEY (type_espac) REFERENCES m_espace_vert.lt_ev_type_espace(code);
ALTER TABLE m_espace_vert.an_ev_geohaie ADD CONSTRAINT lt_ev_type_paillage_haie_fkey FOREIGN KEY (type_paill) REFERENCES m_espace_vert.lt_ev_type_paillage_haie(code);
ALTER TABLE m_espace_vert.an_ev_geohaie ADD CONSTRAINT lt_ev_type_vegetation_haie_fkey FOREIGN KEY (type_veget) REFERENCES m_espace_vert.lt_ev_type_vegetation_haie(code);



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           INDEX                                                         ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- an_ev_media
CREATE INDEX IF NOT EXISTS an_ev_media_gid_idx ON m_espace_vert.an_ev_media USING btree (gid);
-- an_ev_objet
CREATE INDEX IF NOT EXISTS an_ev_objet_insee_idx ON m_espace_vert.an_ev_objet USING btree (insee);
CREATE INDEX IF NOT EXISTS an_ev_objet_typ1_idx ON m_espace_vert.an_ev_objet USING btree (typ1);
CREATE INDEX IF NOT EXISTS an_ev_objet_typ2_idx ON m_espace_vert.an_ev_objet USING btree (typ2);
CREATE INDEX IF NOT EXISTS an_ev_objet_typ3_idx ON m_espace_vert.an_ev_objet USING btree (typ3);
-- an_ev_geohaie
CREATE INDEX IF NOT EXISTS an_ev_geohaie_typsai_idx ON m_espace_vert.an_ev_geohaie USING btree (typsai);
-- geo_ev_line
CREATE INDEX IF NOT EXISTS geo_ev_line_geom_idx ON m_espace_vert.geo_ev_line USING gist (geom);
-- geo_ev_pct
CREATE INDEX IF NOT EXISTS geo_ev_pct_geom_idx ON m_espace_vert.geo_ev_pct USING gist (geom);
-- geo_ev_polygon
CREATE INDEX IF NOT EXISTS geo_ev_polygon_geom_idx ON m_espace_vert.geo_ev_polygon USING gist (geom);
-- geo_ev_secteur_inv
CREATE INDEX IF NOT EXISTS geo_ev_secteur_inv_geom_idx ON m_espace_vert.geo_ev_secteur_inv USING gist (geom);
-- geo_ev_secteur_presta
CREATE INDEX IF NOT EXISTS geo_ev_secteur_presta_geom_idx ON m_espace_vert.geo_ev_secteur_presta USING gist (geom);
-- geo_ev_site
CREATE INDEX IF NOT EXISTS geo_ev_site_geom_idx ON m_espace_vert.geo_ev_site USING gist (geom);
-- geo_ev_zone_gestion
CREATE INDEX IF NOT EXISTS geo_ev_zone_gestion_geom_idx ON m_espace_vert.geo_ev_zone_gestion USING gist (geom);
-- geo_ev_zone_inv
CREATE INDEX IF NOT EXISTS geo_ev_zone_inv_geom_idx ON m_espace_vert.geo_ev_zone_inv USING gist (geom);

										   
                                        
-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DE GESTION                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- View: m_espace_vert.geo_v_ev_line

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_line;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_line
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
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line l ON o.idobjet = l.idobjet
	 LEFT JOIN m_espace_vert.an_ev_geohaie h ON o.idobjet = h.idobjet
	 LEFT JOIN m_espace_vert.an_ev_geoline c ON o.idobjet = c.idobjet
	 LEFT JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
	 JOIN m_espace_vert.lt_ev_typsaihaie th ON th.code = h.typsai;

ALTER TABLE m_espace_vert.geo_v_ev_line
    OWNER TO create_sig;

COMMENT ON VIEW m_espace_vert.geo_v_ev_line
    IS 'Vue de gestion des objets "espace vert" de type linéaire';

-- View: m_espace_vert.geo_v_ev_pct

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_pct;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_pct
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
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct p ON o.idobjet = p.idobjet
      LEFT JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet;

ALTER TABLE m_espace_vert.geo_v_ev_pct
    OWNER TO create_sig;
    
COMMENT ON VIEW m_espace_vert.geo_v_ev_pct
    IS 'Vue de gestion des objets "espace vert" de type ponctuel';

-- View: m_espace_vert.geo_v_ev_polygon

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_polygon
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
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon p ON o.idobjet = p.idobjet
        LEFT JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet;

ALTER TABLE m_espace_vert.geo_v_ev_polygon
    OWNER TO create_sig;

COMMENT ON VIEW m_espace_vert.geo_v_ev_polygon
    IS 'Vue de gestion des objets "espace vert" de type surfacique';


   
-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DU GABARIT                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- les vues listées ci-dessous sont les vues générant la structure des couches du gabarit, à migrer plus tard dans les vues applicatives (x_apps).


-- #################################################################### VUE ARBRE ISOLE ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbreisole

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbreisole;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbreisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,
    -- champs métiers de l'arbre, à saisir
    a.genre,
    a.espece,
    a.hauteur,
    a.circonf,
    a.remarq,
    a.cultivar,
    a.mode_cond,
    a.contrainte,
    a.contr_type,
    a.date_pl_an,
    a.date_pl_sa,
    a.periode_pl,
    a.stade_dev,
    a.protege,
    a.protege_co,
    a.remarq_com,
    a.diam_houpp,
    a.type_sol,
    a.amena_pied,
    a.niveau_all,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    p.x_l93,
    p.y_l93,
    p.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct p ON o.idobjet = p.idobjet
     JOIN m_espace_vert.an_ev_arbre a ON o.idobjet = a.idobjet
     LEFT JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '111'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbreisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbreisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbreisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbreisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbreisole TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbreisole IS 'Vue arbres isolés';


-- #################################################################### VUE ARBRE ALIGNEMENT ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbrealignement

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbrealignement;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbrealignement
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.long_m,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '112'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbrealignement
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbrealignement TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbrealignement TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbrealignement TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbrealignement TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbrealignement IS 'Vue arbres d''alignement';


-- #################################################################### VUE ZONE BOISEE ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_zoneboisee

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_zoneboisee;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_zoneboisee
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '113'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_zoneboisee
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_zoneboisee TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_zoneboisee TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_zoneboisee TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_zoneboisee TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_zoneboisee IS 'Vue zones boisées';


-- #################################################################### VUE ARBUSTE ISOLE ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_arbusteisole

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_arbusteisole;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_arbusteisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,        
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '121'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_arbusteisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_arbusteisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbusteisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_arbusteisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_arbusteisole TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_arbusteisole IS 'Vue arbustes isolés';


-- #################################################################### VUE HAIE ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_haie

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_haie;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_haie
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    h.typsai,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
      -- attributs complémentaires
    h.type_veget,
    h.hauteur,
    h.type_espace,
    h.type_paill,
    h.biodiversi,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,  
    o.op_maj, 
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    --
    g.long_m, 
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
     LEFT JOIN m_espace_vert.an_ev_geoline gl ON o.idobjet = gl.idobjet
     JOIN m_espace_vert.an_ev_geohaie h ON o.idobjet = h.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '122'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_haie
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_haie TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_haie TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_haie TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_haie TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_haie IS 'Vue haies';


-- #################################################################### VUE MASSIF ARBUSTIF ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_massifarbustif

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_massifarbustif;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_massifarbustif
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date, 
    -- attributs complémentaires
    a.type_espac,
    a.type_arros,
    a.arros_auto,
    a.biodiversi,
    a.inv_faunis,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,    
    o.op_maj, 
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    --
    g.sup_m2, 
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_massifarbustif a ON o.idobjet = a.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '123'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_massifarbustif
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_massifarbustif TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_massifarbustif TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_massifarbustif TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_massifarbustif TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_massifarbustif IS 'Vue massifs arbustifs';


-- #################################################################### VUE POINT FLEURI ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_pointfleuri

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_pointfleuri;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_pointfleuri
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,  
    o.op_maj, 
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,    
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '131'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_pointfleuri
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_pointfleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_pointfleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_pointfleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_pointfleuri TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_pointfleuri IS 'Vue points fleuris';


-- #################################################################### VUE MASSIF FLEURI ###############################################

-- View: m_espace_vert.geo_ev_vegetal_massiffleuri

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_massiffleuri;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_massiffleuri
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date, 
    -- attributs complémentaires
    a.type_espac,
    a.type_arros,
    a.arros_auto,
    a.biodiversi,
    a.inv_faunis,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,  
    o.op_maj, 
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_massiffleuri a ON o.idobjet = a.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '132'::text;

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_massiffleuri
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_massiffleuri TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_massiffleuri TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_massiffleuri TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_massiffleuri TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_massiffleuri IS 'Vue massifs fleuris';


-- #################################################################### VUE ESPACE ENBERBE  ###############################################

-- View: m_espace_vert.geo_v_ev_vegetal_espaceenherbe

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_vegetal_espaceenherbe;
CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_vegetal_espaceenherbe
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    v."position",
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date, 
    -- attributs complémentaires
    a.type_espac,
    a.type_arros,
    a.arros_auto,
    a.biodiversi,
    a.inv_faunis,
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj, 
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,   
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_espaceenherbe a ON o.idobjet = a.idobjet
     JOIN m_espace_vert.an_ev_geovegetal v ON o.idobjet = v.idobjet
  WHERE o.typ3::text = '141'::text;
  

ALTER TABLE m_espace_vert.geo_v_ev_vegetal_espaceenherbe
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_vegetal_espaceenherbe TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_espaceenherbe TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_vegetal_espaceenherbe TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_vegetal_espaceenherbe TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_vegetal_espaceenherbe IS 'Vue engazonnements';


-- #################################################################### VUE VOIE CIRCULATION  ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_voiecirculation

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_voiecirculation;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_voiecirculation
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.long_m,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geoline gl ON o.idobjet = gl.idobjet
  WHERE o.typ2::text = '21'::text;

ALTER TABLE m_espace_vert.geo_v_ev_mineral_voiecirculation
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_voiecirculation TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_voiecirculation TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_voiecirculation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_voiecirculation TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_voiecirculation IS 'Vue voies de circulation';


-- #################################################################### VUE ZONE CIRCULATION  ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_zonedecirculation

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_zonedecirculation;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_zonedecirculation
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '21'::text;

ALTER TABLE m_espace_vert.geo_v_ev_mineral_zonedecirculation
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_zonedecirculation TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_zonedecirculation TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_zonedecirculation TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_zonedecirculation TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_zonedecirculation IS 'Vue zones de circulation';


-- #################################################################### VUE CLOTURE  ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_cloture

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_cloture;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_cloture
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.long_m,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '22'::text;

ALTER TABLE m_espace_vert.geo_v_ev_mineral_cloture
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_cloture TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_cloture IS 'Vue clôtures';


-- #################################################################### VUE EQUIPEMENT DE LOISIR ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_loisirsisole

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_loisirsisole;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_loisirsisole
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '23'::text;

ALTER TABLE m_espace_vert.geo_v_ev_mineral_loisirsisole
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_loisirsisole TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisirsisole TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_loisirsisole TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_loisirsisole TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_loisirsisole IS 'Vue loisirs isolés';


-- #################################################################### VUE ZONE DE LOISIRS  ###############################################

-- View: m_espace_vert.geo_v_ev_mineral_espacedeloisirs

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_mineral_espacedeloisirs;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_mineral_espacedeloisirs
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '23'::text;

ALTER TABLE m_espace_vert.geo_v_ev_mineral_espacedeloisirs
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_mineral_espacedeloisirs TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_espacedeloisirs TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_mineral_espacedeloisirs TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_mineral_espacedeloisirs TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_mineral_espacedeloisirs IS 'Vue espaces de loisirs';


-- #################################################################### VUE ARRIVEE D'EAU  ###############################################

-- View: m_espace_vert.geo_v_ev_hydrographique_arriveedeau

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydrographique_arriveedeau;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydrographique_arriveedeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '31'::text;

ALTER TABLE m_espace_vert.geo_v_ev_hydrographique_arriveedeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydrographique_arriveedeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_arriveedeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_arriveedeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydrographique_arriveedeau TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydrographique_arriveedeau IS 'Vue arrivées d''eau';


-- #################################################################### VUE POINT D'EAU  ###############################################

-- View: m_espace_vert.geo_v_ev_hydrographique_pointdeau

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydrographique_pointdeau;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydrographique_pointdeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert.geo_v_ev_hydrographique_pointdeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydrographique_pointdeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_pointdeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_pointdeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydrographique_pointdeau TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydrographique_pointdeau IS 'Vue points d''eau';


-- #################################################################### VUE COURS D'EAU  ###############################################

-- View: m_espace_vert.geo_v_ev_hydrographique_coursdeau

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydrographique_coursdeau;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydrographique_coursdeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    gl.larg_cm,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.long_m,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
     JOIN m_espace_vert.an_ev_geoline gl ON o.idobjet = gl.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert.geo_v_ev_hydrographique_coursdeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydrographique_coursdeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_coursdeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_coursdeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydrographique_coursdeau TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydrographique_coursdeau IS 'Vue cours d''eau';


-- #################################################################### VUE ETENDUE EAU  ###############################################

-- View: m_espace_vert.geo_v_ev_hydrographique_etenduedeau

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_hydrographique_etenduedeau;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_hydrographique_etenduedeau
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ2::text = '32'::text;

ALTER TABLE m_espace_vert.geo_v_ev_hydrographique_etenduedeau
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_hydrographique_etenduedeau TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_etenduedeau TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_hydrographique_etenduedeau TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_hydrographique_etenduedeau TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_hydrographique_etenduedeau IS 'Vue étendue d''eau';


-- #################################################################### VUE REF NON CLASSEE PONCTUEL  ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_pct

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_pct;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_pct
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.x_l93,
    g.y_l93,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_pct g ON o.idobjet = g.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_pct
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_pct TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_pct TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_pct TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_pct TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_pct IS 'Vue ponctuels non classés';


-- #################################################################### VUE REF NON CLASSEE LINEAIRE  ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_lin

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_lin;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_lin
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.long_m,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_line g ON o.idobjet = g.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_lin
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_lin TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_lin TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_lin TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_lin TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_lin IS 'Vue linéaires non classés';


-- #################################################################### VUE REF NON CLASSEE SURFACE  ###############################################

-- View: m_espace_vert.geo_v_ev_refnonclassee_polygon

DROP VIEW IF EXISTS m_espace_vert.geo_v_ev_refnonclassee_polygon;

CREATE OR REPLACE VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon
 AS
 SELECT o.idobjet,
    o.typ1,
    o.typ2,
    o.typ3,
    o.situation,
    o.srcgeom_sai as src_geom,
    o.srcdate_sai as src_date,    
    -- autre champs de saisie
    o.date_sai,
    o.op_sai,
    o.observ,
    o.op_maj,
    o.date_maj,
    -- autres champs découpage adm
    o.idzone,
    o.idsite,
    o.idequipe,
    o.idcontrat,
    o.insee,
    o.commune,
    o.quartier,
    o.doma,
    o.qualdoma,
    -- geom
    g.sup_m2,
    g.geom
   FROM m_espace_vert.an_ev_objet o
     JOIN m_espace_vert.geo_ev_polygon g ON o.idobjet = g.idobjet
  WHERE o.typ1::text = '9'::text;

ALTER TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_read;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_create;
GRANT ALL ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.geo_v_ev_refnonclassee_polygon TO sig_edit;

COMMENT ON VIEW m_espace_vert.geo_v_ev_refnonclassee_polygon IS 'Vue polygones non classés';



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      FONCTIONS TRIGGER                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################



-- #################################################################### FONCTION DATE RAPPEL ###############################################

-- à partir d'une date de référence, récupérer la prochaine date anniversaire
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_get_next_date_rappel(_date_ref date, _freq_value integer, _freq_unit text, _nb_jr_rapp integer, _period_start text, _period_end text)  RETURNS date LANGUAGE plpgsql AS $$
  DECLARE next_date date;
  -- valeur Postgresql utilisable dans un interval : jour -> days, Semaines -> weeks
  DECLARE _freq_unit_pg text;
  -- les mois sont codes à partir de 0 dans la donnée, depuis 1 dans PG
  DECLARE _month_start_pg integer := _period_start::integer + 1;
  DECLARE _month_end_pg integer := _period_end::integer + 1;
BEGIN
  -- transformer la valeur de l'unité en unité PG
  _freq_unit_pg := (
  CASE _freq_unit
    WHEN '00' THEN 'days'
    WHEN '01' THEN 'weeks'
    WHEN '02' THEN 'months'
    WHEN '03' THEN 'years'
  ELSE 
  'days' 
  END); 
  
  next_date := (
    with dates_anniv as (
      select _date_ref + incr * (_freq_value || ' ' || _freq_unit_pg)::interval - ('' || _nb_jr_rapp || ' days')::interval as date_anniv
      -- note: ici on prévoit les 10000 prochains anniversaire. Augmenter cette valeur a un impact sur la performance de la requête
      from pg_catalog.generate_series(0, 10000, 1) incr
    )
    select date_anniv 
      from dates_anniv 
      where 
        -- à partir de maintenant (ne pas tenir compte des anniversaires passés)
        date_anniv >= now() 
        -- entre les mois indiqués
        AND EXTRACT(MONTH from date_anniv) BETWEEN _month_start_pg AND _month_end_pg
      limit 1);
  return next_date;
END;
$$
;


-- #################################################################### FONCTION GENERIQUE ###############################################

-- fonction pour gérer les attributs communs (méta + geo) à l'ensemble des objets de la base espaces verts (végétal, minéral, hydro et non reférencé)

--CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP text, TG_TABLE_NAME text, _geom geometry, _idobjet integer,
--_data_old text, _data_new text, _observ text, _position text, _op_sai text, _op_maj text, _typ2 text, _typ3 text) RETURNS void LANGUAGE plpgsql AS $$
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP text, TG_TABLE_NAME text, _geom geometry, _idobjet integer,
_data_old text, _data_new text, _observ text, _op_sai text, _op_maj text, _typ1 text, _typ2 text, _typ3 text) RETURNS void LANGUAGE plpgsql AS $$

  DECLARE _insee text;
  DECLARE _commune text;
  DECLARE _quartier text;
  DECLARE _idzone integer;
  DECLARE _idsite integer;
  DECLARE _idequipe integer;

  DECLARE _geometry_type text := ST_GeometryType(_geom);
BEGIN
  -- traitements communs INSERT / UPDATE
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    -- récupération automatique INSEE / commune
    _insee := (SELECT insee FROM r_osm.geo_vm_osm_commune_arcba WHERE ST_Intersects(geom,_geom) LIMIT 1);
		_commune := (SELECT commune FROM r_osm.geo_vm_osm_commune_arcba WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- Lors de la saisie d’un arbre, EV ou intervention, un message doit s’afficher lorsque la localisation ne se trouve pas dans zone « Commune » ou « Intercommunalité ».
    IF _insee IS NULL THEN
		  RAISE EXCEPTION 'Erreur : L''objet ne se situe pas dans une commune de l''ARC.<br><br>';
    END IF;
    -- récupération découpage adm (à remplacer par champs calculés ?)
    -- quartier
    _quartier := (SELECT nom FROM r_administratif.geo_adm_quartier WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- zone de gestion
    _idzone := (SELECT idzone FROM m_espace_vert.geo_ev_zone_gestion WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- site EV
    _idsite := (SELECT idsite FROM m_espace_vert.geo_ev_site WHERE ST_Intersects(geom,_geom) LIMIT 1);
    -- site EV
    _idequipe := (SELECT idequipe FROM m_espace_vert.geo_ev_equipe WHERE ST_Intersects(geom,_geom) LIMIT 1);
  END IF;

  IF (TG_OP = 'INSERT') THEN
    -- On insère les données meta, avec une date de mise à jour des données = NULL.
    INSERT INTO m_espace_vert.an_ev_objet
      (idobjet, 
      idzone, idsite, idequipe, 
      insee, commune, 
      quartier, doma, qualdoma, 
      typ1, typ2, typ3, 
      op_sai, date_sai, 
      srcgeom_sai, srcdate_sai, 
      op_att, 
      date_maj_att, date_maj, 
      observ, situation)
      VALUES
      (_idobjet, 
      _idzone, _idsite, _idequipe, 
      _insee, _commune, 
        _quartier, '00', '00', 
        _typ1, _typ2, _typ3, 
        _op_sai, now(), 
        '20', '2018', 
        _op_sai, 
        null, null, 
        _observ, '10'::character varying);

    -- insertion de la géométrie
    if _geometry_type = 'ST_Point' THEN
      INSERT INTO m_espace_vert.geo_ev_pct (idobjet, geom) VALUES (_idobjet, _geom);
    ELSIF _geometry_type = 'ST_LineString' THEN
      INSERT INTO m_espace_vert.geo_ev_line (idobjet, geom) VALUES (_idobjet, _geom);
    ELSIF _geometry_type = 'ST_Polygon' THEN
      INSERT INTO m_espace_vert.geo_ev_polygon (idobjet, geom) VALUES (_idobjet, _geom);
    ELSE
      RAISE EXCEPTION 'Type de géométrie inconnu %', _geometry_type ;
    END IF;

     --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename, type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);

  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ données meta
    UPDATE m_espace_vert.an_ev_objet SET 
      typ3 = _typ3,
      idzone = _idzone, 
      idsite = _idsite,
      idequipe = _idequipe,
      insee = _insee,
      commune = _commune,
      quartier = _quartier,
      date_maj = now(),
      date_maj_att = now(),
      observ = _observ,
      op_sai = coalesce(op_sai, _op_sai),
      op_maj = _op_maj
    WHERE idobjet = _idobjet;

    -- MAJ de la géométrie
    if _geometry_type = 'ST_Point' THEN
      UPDATE m_espace_vert.geo_ev_pct SET geom = _geom WHERE idobjet = _idobjet;
    ELSIF _geometry_type = 'ST_LineString' THEN
      UPDATE m_espace_vert.geo_ev_line SET geom = _geom WHERE idobjet = _idobjet;
    ELSIF _geometry_type = 'ST_Polygon' THEN
      UPDATE m_espace_vert.geo_ev_polygon SET geom = _geom WHERE idobjet = _idobjet;
    ELSE
      RAISE EXCEPTION 'Type de géométrie inconnu %', _geometry_type ;
    END IF;

    --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename,  type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);
    
  ELSIF (TG_OP = 'DELETE') THEN
    -- passage à l'état supprimé
    UPDATE m_espace_vert.an_ev_objet --- En cas de suppression on change juste la situation de l'objet
    SET	situation = '12'
    WHERE idobjet = _idobjet;

    --- log
    INSERT INTO m_espace_vert.an_ev_log (tablename,  type_ope, dataold, datanew) VALUES (TG_TABLE_NAME, TG_OP, _data_old, _data_new);
  END IF;
END;
$$
;

-- #################################################################### FONCTION/TRIGGER ARBRE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_arbre_isole() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
    -- Lors de la saisie d’un arbre, afficher un message d’avertissement dans la fiche si sa localisation se trouve à moins de 50cm d’un autre arbre, afin d’éviter la saisie de doublons.
    IF (SELECT count(1) > 0 FROM m_espace_vert.geo_v_ev_vegetal_arbreisole WHERE ST_DWithin(NEW.geom,geom, 0.5) AND situation <> '12' )  THEN
      RAISE EXCEPTION 'Erreur : Un arbre existe déjà à moins de 50cm de cette position.<br><br>';
    END IF;
  END IF;

  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '111');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_arbre
    (idobjet, nom, 
    genre, espece, 
    hauteur, circonf, 
    --forme, 
    --etat_gen, 
    --implant, 
    --natur_sol,  
    cultivar, mode_cond, contrainte, contr_type,
    date_pl_an, date_pl_sa, periode_pl, stade_dev, 
    protege, protege_co, remarq, remarq_com, diam_houpp, type_sol, amena_pied, niveau_all)
    VALUES
    (_idobjet, null, 
    NEW.genre, NEW.espece, 
    NEW.hauteur, NEW.circonf, 
    --NEW.forme, 
    --NEW.etat_gen, 
    --NEW.implant, 
    --NEW.natur_sol,
    NEW.cultivar, NEW.mode_cond, NEW.contrainte, NEW.contr_type, 
    NEW.date_pl_an, NEW.date_pl_sa, NEW.periode_pl, NEW.stade_dev, 
    NEW.protege, NEW.protege_co, NEW.remarq, NEW.remarq_com, NEW.diam_houpp, NEW.type_sol, NEW.amena_pied, NEW.niveau_all);
    -- insertion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;  
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_arbre SET
    genre = NEW.genre, 
    espece = NEW.espece, 
    hauteur = NEW.hauteur, 
    circonf = NEW.circonf, 
    --forme = NEW.forme, 
    --etat_gen = NEW.etat_gen, 
    --implant = NEW.implant, 
    --natur_sol = NEW.natur_sol, 
    cultivar = NEW.cultivar, 
    mode_cond = NEW.mode_cond, 
    contrainte = NEW.contrainte, 
    contr_type = NEW.contr_type, 
    date_pl_an = NEW.date_pl_an, 
    date_pl_sa = NEW.date_pl_sa, 
    periode_pl = NEW.periode_pl, 
    stade_dev = NEW.stade_dev, 
    protege = NEW.protege, 
    protege_co = NEW.protege_co, 
    remarq = NEW.remarq, 
    remarq_com = NEW.remarq_com, 
    diam_houpp = NEW.diam_houpp, 
    type_sol = NEW.type_sol, 
    amena_pied = NEW.amena_pied, 
    niveau_all = NEW.niveau_all
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;       
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_arbre_isole on m_espace_vert.geo_v_ev_vegetal_arbreisole;
CREATE TRIGGER t_t1_arbre_isole INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbreisole 
for each row execute procedure m_espace_vert.ft_m_espace_vert_arbre_isole();


-- #################################################################### FONCTION/TRIGGER ALIGNEMENT D'ARBRE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_arbrealignement() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '112');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux    
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_arbrealignement on m_espace_vert.geo_v_ev_vegetal_arbrealignement;
CREATE TRIGGER t_t1_arbrealignement INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbrealignement
for each row execute procedure m_espace_vert.ft_m_espace_vert_arbrealignement();


-- #################################################################### FONCTION/TRIGGER ZONE BOISEE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_zoneboisee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '11', '113');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_zoneboisee on m_espace_vert.geo_v_ev_vegetal_zoneboisee;
CREATE TRIGGER t_t1_zoneboisee INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_zoneboisee
for each row execute procedure m_espace_vert.ft_m_espace_vert_zoneboisee();


-- #################################################################### FONCTION/TRIGGER ARBUSTE ISOLE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_arbusteisole() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '121');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;
 
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux     
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_arbusteisole on m_espace_vert.geo_v_ev_vegetal_arbusteisole;
CREATE TRIGGER t_t1_arbusteisole INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_arbusteisole 
for each row execute procedure m_espace_vert.ft_m_espace_vert_arbusteisole();


-- #################################################################### FONCTION/TRIGGER HAIE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_haie() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '122');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_geohaie
    (idobjet, 
    type_veget,
    hauteur, type_espace, type_paill, biodiversi)
    VALUES
    (_idobjet, 
    NEW.type_veget,
    NEW.hauteur, NEW.type_espace, 
    NEW.type_paill, NEW.biodiversi);
    -- insertion des attributs des EV végétaux      
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_geohaie SET
    type_veget = NEW.type_veget,
    hauteur = NEW.hauteur, 
    type_espace = NEW.type_espace, 
    type_paill = NEW.type_paill, 
    biodiversi = NEW.biodiversi 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux      
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;    

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_haie on m_espace_vert.geo_v_ev_vegetal_haie;
CREATE TRIGGER t_t1_haie INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_haie
for each row execute procedure m_espace_vert.ft_m_espace_vert_haie();


-- #################################################################### FONCTION/TRIGGER MASSIF ARBUSTIF ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_massifarbustif() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '12', '123');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_massifarbustif
    (idobjet,
    type_espac, type_arros, 
    arros_auto, biodiversi, inv_faunis)
    VALUES
    (_idobjet,
    NEW.type_espac, NEW.type_arros, 
    NEW.arros_auto, NEW.biodiversi, 
    NEW.inv_faunis);
    -- insertion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;    
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_massifarbustif SET
    type_espac = NEW.type_espac, 
    type_arros = NEW.type_arros, 
    arros_auto = NEW.arros_auto, 
    biodiversi = NEW.biodiversi, 
    inv_faunis = NEW.inv_faunis 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;     

  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_massifarbustif on m_espace_vert.geo_v_ev_vegetal_massifarbustif;
CREATE TRIGGER t_t1_massifarbustif INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_massifarbustif 
for each row execute procedure m_espace_vert.ft_m_espace_vert_massifarbustif();


-- #################################################################### FONCTION/TRIGGER FLEURI ISOLE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_pointfleuri() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '131');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des EV végétaux   
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);  
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_pointfleuri on m_espace_vert.geo_v_ev_vegetal_pointfleuri;
CREATE TRIGGER t_t1_pointfleuri INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_pointfleuri 
for each row execute procedure m_espace_vert.ft_m_espace_vert_pointfleuri();


-- #################################################################### FONCTION/TRIGGER MASSIF FLEURI ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_massiffleuri() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '13', '132');

  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_massiffleuri
    (idobjet, 
    type_espac, type_arros, 
    arros_auto, biodiversi, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.type_espac, NEW.type_arros, 
    NEW.arros_auto, NEW.biodiversi, 
    NEW.inv_faunis);
    -- insertion des attributs des EV végétaux  
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_massiffleuri SET
    type_espac = NEW.type_espac, 
    type_arros = NEW.type_arros, 
    arros_auto = NEW.arros_auto, 
    biodiversi = NEW.biodiversi, 
    inv_faunis = NEW.inv_faunis 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_massiffleuri on m_espace_vert.geo_v_ev_vegetal_massiffleuri;
CREATE TRIGGER t_t1_massiffleuri INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_massiffleuri 
for each row execute procedure m_espace_vert.ft_m_espace_vert_massiffleuri();


-- #################################################################### FONCTION/TRIGGER ESPACE ENHERBE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_espaceenherbe() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '1', '14', '141');
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs spécifiques
    INSERT INTO m_espace_vert.an_ev_espaceenherbe
    (idobjet, 
    type_espac, type_arros, arros_auto, 
    biodiversi, inv_faunis)
    VALUES
    (_idobjet, 
    NEW.type_espac, NEW.type_arros, 
    NEW.arros_auto, NEW.biodiversi, 
    NEW.inv_faunis);
    -- insertion des attributs des EV végétaux    
    INSERT INTO m_espace_vert.an_ev_geovegetal
    (idobjet, 
    position)
    VALUES
    (_idobjet, 
    NEW.position);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs spécifiques
    UPDATE m_espace_vert.an_ev_espaceenherbe SET
    type_espac = NEW.type_espac, 
    type_arros = NEW.type_arros, 
    arros_auto = NEW.arros_auto, 
    biodiversi = NEW.biodiversi, 
    inv_faunis = NEW.inv_faunis 
    WHERE idobjet = NEW.idobjet;
    -- MAJ des attributs des EV végétaux  
    UPDATE m_espace_vert.an_ev_geovegetal SET
    position = NEW.position 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_espaceenherbe on m_espace_vert.geo_v_ev_vegetal_espaceenherbe;
CREATE TRIGGER t_t1_espaceenherbe INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_vegetal_espaceenherbe 
for each row execute procedure m_espace_vert.ft_m_espace_vert_espaceenherbe();



-- #################################################################### FONCTION/TRIGGER VOIE CIRCULATION ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_voiecirculation() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_geoline
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_geoline SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

DROP TRIGGER IF EXISTS t_t1_voiecirculation on m_espace_vert.geo_v_ev_mineral_voiecirculation;
CREATE TRIGGER t_t1_voiecirculation INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_voiecirculation 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_voiecirculation();


-- #################################################################### FONCTION/TRIGGER ZONE DE CIRCULATION ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_zonedecirculation() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '21', _record_used.typ3);
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

DROP TRIGGER IF EXISTS t_t1_zonedecirculation on m_espace_vert.geo_v_ev_mineral_zonedecirculation;
CREATE TRIGGER t_t1_zonedecirculation INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_zonedecirculation 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_zonedecirculation();


-- #################################################################### FONCTION/TRIGGER CLOTURE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_cloture() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '22', _record_used.typ3);
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

DROP TRIGGER IF EXISTS t_t1_cloture on m_espace_vert.geo_v_ev_mineral_cloture;
CREATE TRIGGER t_t1_cloture INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_cloture 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_cloture();

-- #################################################################### FONCTION/TRIGGER LOISIR ISOLE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_loisirsisole() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '231');
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

DROP TRIGGER IF EXISTS t_t1_loisirsisole on m_espace_vert.geo_v_ev_mineral_loisirsisole;
CREATE TRIGGER t_t1_loisirsisole INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_loisirsisole 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_loisirsisole();


-- #################################################################### FONCTION/TRIGGER ESPACE DE LOISIRS ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_espacedeloisirs() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '2', '23', '232');
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

DROP TRIGGER IF EXISTS t_t1_espacedeloisirs on m_espace_vert.geo_v_ev_mineral_espacedeloisirs;
CREATE TRIGGER t_t1_espacedeloisirs INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_mineral_espacedeloisirs 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_espacedeloisirs();


-- #################################################################### FONCTION/TRIGGER ARRIVEE D'EAU ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_arriveedeau() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '31', _record_used.typ3);
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

DROP TRIGGER IF EXISTS t_t1_arriveedeau on m_espace_vert.geo_v_ev_hydrographique_arriveedeau;
CREATE TRIGGER t_t1_arriveedeau INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydrographique_arriveedeau 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_arriveedeau();


-- #################################################################### FONCTION/TRIGGER HYDROGRAPHIQUE PCT ETENDUE ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_hydrographique() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
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

-- trigger sur table hydrographique_pointdeau
DROP TRIGGER IF EXISTS t_t1_pointdeau on m_espace_vert.geo_v_ev_hydrographique_pointdeau;
CREATE TRIGGER t_t1_pointdeau INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydrographique_pointdeau 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_hydrographique();

-- trigger sur table hydrographique_etenduedeau
DROP TRIGGER IF EXISTS t_t1_etenduedeau on m_espace_vert.geo_v_ev_hydrographique_etenduedeau;
CREATE TRIGGER t_t1_etenduedeau INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydrographique_etenduedeau 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_hydrographique();


-- #################################################################### FONCTION/TRIGGER HYDROGRAPHIQUE COURS D'EAU ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_coursdeau() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '3', '32', _record_used.typ3);
  -- 
  IF (TG_OP = 'INSERT') THEN
    -- insertion des attributs des objets geoline    
    INSERT INTO m_espace_vert.an_ev_geoline
    (idobjet, 
    larg_cm)
    VALUES
    (_idobjet, 
    NEW.larg_cm);
    RETURN NEW;
    
  ELSIF (TG_OP = 'UPDATE') THEN
    -- MAJ des attributs des objets geoline   
    UPDATE m_espace_vert.an_ev_geoline SET
    larg_cm = NEW.larg_cm 
    WHERE idobjet = NEW.idobjet;
    RETURN NEW;
    
  ELSIF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  END IF;
END;
$$
;

-- trigger sur table hydrographique_coursdeau
DROP TRIGGER IF EXISTS t_t1_coursdeau on m_espace_vert.geo_v_ev_hydrographique_coursdeau;
CREATE TRIGGER t_t1_coursdeau INSTEAD OF
INSERT OR UPDATE OR DELETE 
ON m_espace_vert.geo_v_ev_hydrographique_coursdeau 
FOR EACH ROW EXECUTE PROCEDURE m_espace_vert.ft_m_espace_vert_coursdeau();


-- #################################################################### FONCTION/TRIGGER REFNONCLASSEE PCT-LIN-POLYGON ###############################################

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_refnonclassee() RETURNS trigger LANGUAGE plpgsql AS $$
  
  DECLARE _idobjet integer;
  DECLARE _dataold text;
  DECLARE _datanew text;
  DECLARE _record_used record;

BEGIN 
  IF TG_OP = 'INSERT' THEN
   -- générer un nouvel identifiant à partir de la séquence globale des objets EV
    _idobjet := nextval('m_espace_vert.an_ev_objet_idobjet_seq');
    _record_used := NEW;
    _dataold := null;
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
    _datanew := null;
  END IF;
  PERFORM m_espace_vert.ft_m_espace_vert_process_generic_info(TG_OP, TG_TABLE_NAME, _record_used.geom, _idobjet, _dataold, _datanew, _record_used.observ, _record_used.op_sai, _record_used.op_maj, '9', '99', '999');
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

-- trigger sur table refnonclassee_pct
DROP TRIGGER IF EXISTS t_t1_refnonclassee_pct on m_espace_vert.geo_v_ev_refnonclassee_pct;
CREATE TRIGGER t_t1_refnonclassee_pct INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_pct
for each row execute procedure m_espace_vert.ft_m_espace_vert_refnonclassee();

-- trigger sur table refnonclassee_lin
DROP TRIGGER IF EXISTS t_t1_refnonclassee_lin on m_espace_vert.geo_v_ev_refnonclassee_lin;
CREATE TRIGGER t_t1_refnonclassee_lin INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_lin
for each row execute procedure m_espace_vert.ft_m_espace_vert_refnonclassee();

-- trigger sur table refnonclassee_polygon
DROP TRIGGER IF EXISTS t_t1_refnonclassee_polygon on m_espace_vert.geo_v_ev_refnonclassee_polygon;
CREATE TRIGGER t_t1_refnonclassee_polygon INSTEAD OF
INSERT OR UPDATE OR DELETE 
on m_espace_vert.geo_v_ev_refnonclassee_polygon
for each row execute procedure m_espace_vert.ft_m_espace_vert_refnonclassee();



-- #################################################################### INTERVENTION ###############################################

-- lors de la suppression d'une DI / Intervention, ne pas laisser les objets liés comme orphelins.
-- pas possible d'utilisée une FOREIGN KEY avec DELETE CASCADE car l'id_inter peut être lié soit à une DI, soit à une intervention
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_intervention_purge_on_delete() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  DELETE FROM m_espace_vert.an_ev_intervention_objets WHERE id_inter = OLD.id_inter;
  RETURN OLD;
END;
$$
;

-- demande d'intervention
-- assigner tous les objets du type choisi, à la DI
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_intervention_add_objets() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE 
  _geom_intersection geometry; -- géométrie à utiliser pour intersecter avec les éléments de patrimoine (soit tracée à la main, soit celle de l'équipe)
BEGIN
  -- si l'intervention saisie est liée à une demande d'intervention
  IF NEW.id_demande IS NOT NULL THEN
    -- on vérifie si une intervention n'existe pas déjà pour cette demande (car GEO ne permet pas de cacher le bouton)
    IF (SELECT count(1) > 0 FROM m_espace_vert.an_ev_intervention WHERE id_demande = NEW.id_demande AND id_inter <> NEW.id_inter) THEN
      RAISE EXCEPTION 'Une intervention est déjà liée à cette demande d''intervention.<br><br>';
      return NEW;
    END IF;
    -- alors on va recopier tous les objets liés à la DI, au niveau de l'intervention
    INSERT INTO m_espace_vert.an_ev_intervention_objets(id_inter, idobjet)
      SELECT NEW.id_inter, idobjet 
        FROM m_espace_vert.an_ev_intervention_objets 
        WHERE id_inter = NEW.id_demande;
    -- et recopier aussi la géométrie polygone issue de la DI
    -- on fait un UPDATE comme on est en AFTER INSERT, sinon on aurait pu faire NEW.geom := (SELECT ...)
    UPDATE m_espace_vert.an_ev_intervention SET geom = (SELECT geom FROM m_espace_vert.an_ev_demande_intervention WHERE id_inter = NEW.id_demande) WHERE id_inter = NEW.id_inter;
    RETURN NEW;
  END IF;
  -- si géométrie dessinée
  IF NEW.geom is NOT null THEN
    _geom_intersection := NEW.geom;
  END IF;
  -- si la demande provient de la fiche d'information d'un secteur d'équipe, alors on considère que la géométrie à utiliser est celle du secteur d'équipe
  IF NEW.id_equipe is NOT null THEN
    _geom_intersection := (SELECT geom from m_espace_vert.geo_ev_equipe WHERE idequipe = NEW.id_equipe LIMIT 1);
  END IF;
  -- si pas de géométrie à intersecter, on ne fait rien
  IF _geom_intersection is null THEN
    return NEW;
  END IF;
  -- si on a une géométrie mais pas de type d'objet, alors on refuse la saisie
  IF NEW.type_objet is null OR NEW.type_objet = '00' THEN
    RAISE EXCEPTION 'Lors d''une saisie par polygone, veuillez choisir un type d''objet. Tous les objets de ce type présents dans cette zone seront liés automatiquement à la demande.<br><br>';
    return NEW;
  END IF;
  -- on ajoute dans la table de relation N-M tous les objets du type choisi
  INSERT INTO m_espace_vert.an_ev_intervention_objets(id_inter, idobjet)
    select NEW.id_inter, coalesce(line.idobjet, pct.idobjet , polygon.idobjet)
    from m_espace_vert.an_ev_objet 
    -- pour pouvoir faire l'intersection spatiale, on fait des jointures avec les 3 tables dans lesquelles peuvent se trouver la géom (pct, ligne, polygon)
      left join m_espace_vert.geo_ev_line line on line.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, line.geom)
      left join m_espace_vert.geo_ev_pct pct on pct.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, pct.geom)
      left join m_espace_vert.geo_ev_polygon polygon on polygon.idobjet = an_ev_objet.idobjet AND ST_Intersects(_geom_intersection, polygon.geom)
          -- on ne prend que le type d'objets EV choisi par l'utilisateur
    where typ3 = NEW.type_objet 
          -- pour retirer les lignes de an_ev_objet qui n'ont pas matché, on regarde les lignes en résultat qui ont un identifiant
          and (line.idobjet is not null or pct.idobjet is not null or polygon.idobjet is not null);
    -- on vérifie si des objets de ce type ont bien été ajoutés, sinon on refuse la saisie
    IF (SELECT count(1) = 0 FROM m_espace_vert.an_ev_intervention_objets WHERE id_inter = NEW.id_inter) THEN
      RAISE EXCEPTION 'Aucun objet de ce type n''a été trouvé dans la zone tracée. Veuillez modifier la zone ou le type d''objets et essayer à nouveau.<br><br>';
    END IF;
  RETURN NEW;
END;
$$
;

-- MAJ des objets EV liés quand modification découpage adm (zone_gestion, site cohérent)
-- pour chaque type de couche, on fait l'intersection
CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_set_zone_gestion() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idzone = NEW.idzone WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idzone = NEW.idzone WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idzone = NEW.idzone WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idzone = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idzone = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idzone = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_set_site() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = NEW.idsite WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idsite = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idsite = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;

CREATE OR REPLACE FUNCTION m_espace_vert.ft_m_espace_vert_set_equipe() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,NEW.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = NEW.idequipe WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,NEW.geom));
  ELSE
    UPDATE m_espace_vert.an_ev_objet SET idequipe = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_polygon WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_line WHERE ST_Intersects(geom,OLD.geom));
    UPDATE m_espace_vert.an_ev_objet SET idequipe = null WHERE idobjet IN (SELECT idobjet FROM m_espace_vert.geo_ev_pct WHERE ST_Intersects(geom,OLD.geom));
    RETURN OLD;
  END IF;
 RETURN NEW;
END;
$$
;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      TRIGGERS                                                             ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


-- demande d'intervention, trigger classique
-- on crée en AFTER INSERT pour pouvoir récupérer l'identifiant id_inter généré
DROP TRIGGER IF EXISTS t_t1_demande_intervention on m_espace_vert.an_ev_demande_intervention;
CREATE TRIGGER t_t1_demande_intervention 
AFTER insert on m_espace_vert.an_ev_demande_intervention
for each row execute procedure m_espace_vert.ft_m_espace_vert_intervention_add_objets();

-- purge des éléments liés à la DI lors du DELETE
DROP TRIGGER IF EXISTS t_t1_demande_intervention_on_delete on m_espace_vert.an_ev_demande_intervention;
CREATE TRIGGER t_t1_demande_intervention_on_delete 
AFTER DELETE on m_espace_vert.an_ev_demande_intervention
for each row execute procedure m_espace_vert.ft_m_espace_vert_intervention_purge_on_delete();

-- on crée en AFTER INSERT pour pouvoir récupérer l'identifiant id_inter généré
DROP TRIGGER IF EXISTS t_t1_intervention on m_espace_vert.an_ev_intervention;
CREATE TRIGGER t_t1_intervention 
AFTER insert on m_espace_vert.an_ev_intervention
for each row execute procedure m_espace_vert.ft_m_espace_vert_intervention_add_objets();

-- purge des éléments liés à l'intervention lors du DELETE
DROP TRIGGER IF EXISTS t_t1_intervention_on_delete on m_espace_vert.an_ev_intervention;
CREATE TRIGGER t_t1_intervention_on_delete 
AFTER DELETE on m_espace_vert.an_ev_intervention
for each row execute procedure m_espace_vert.ft_m_espace_vert_intervention_purge_on_delete();

-- MAJ des objets EV liés quand modification découpage adm (zone_gestion)
DROP TRIGGER IF EXISTS t_t1_set_zone_gestion on m_espace_vert.geo_ev_zone_gestion;
CREATE TRIGGER t_t1_set_zone_gestion 
AFTER INSERT OR UPDATE of geom OR DELETE on m_espace_vert.geo_ev_zone_gestion
for each row execute procedure m_espace_vert.ft_m_espace_vert_set_zone_gestion();

-- MAJ des objets EV liés quand modification découpage adm (site cohérent)
DROP TRIGGER IF EXISTS t_t1_set_site on m_espace_vert.geo_ev_site;
CREATE TRIGGER t_t1_set_site 
AFTER INSERT OR UPDATE of geom OR DELETE on m_espace_vert.geo_ev_site
for each row execute procedure m_espace_vert.ft_m_espace_vert_set_site();

-- MAJ des objets EV liés quand modification découpage adm (equipe ev)
DROP TRIGGER IF EXISTS t_t1_set_equipe on m_espace_vert.geo_ev_equipe;
CREATE TRIGGER t_t1_set_equipe 
AFTER INSERT OR UPDATE of geom OR DELETE on m_espace_vert.geo_ev_equipe
for each row execute procedure m_espace_vert.ft_m_espace_vert_set_equipe();

-- MAJ des calculs de surface des objets de type polygone !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
DROP TRIGGER IF EXISTS t_t1_ev_polygon_surf;
CREATE TRIGGER t_t1_ev_polygon_surf
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_polygon
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

-- MAJ des calculs de longueur des objets de type line !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
DROP TRIGGER IF EXISTS t_t1_ev_line_long;
CREATE TRIGGER t_t1_ev_line_long
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_line
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_longm_maj();

-- MAJ des calculs des coordonnées des objets de type point !!!!!! renvoit vers fonction trigger générique du schéma public !!!!;
DROP TRIGGER IF EXISTS t_t1_geo_ev_pct_xy_l93;
CREATE TRIGGER t_t1_geo_ev_pct_xy_l93
BEFORE INSERT OR UPDATE OF geom ON m_espace_vert.geo_ev_pct
FOR EACH ROW EXECUTE PROCEDURE public.ft_r_xy_l93();




-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUE EXPLOIT                                                          ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- #################################################################### VUE NBR ARBRE PAR QUARTIER  ###############################################

-- View: m_espace_vert.xapps_an_v_ev_stat_arbre_quartier

DROP VIEW IF EXISTS m_espace_vert.xapps_an_v_ev_stat_arbre_quartier;

CREATE OR REPLACE VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_quartier
 AS
 SELECT COUNT(*) AS nb,
    CASE WHEN a.quartier IS NULL THEN 'Hors quartier' ELSE a.quartier END AS quartier
   FROM m_espace_vert.geo_v_ev_pct a
   WHERE a.typ3 = '111' GROUP BY a.quartier;

ALTER TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier
    OWNER TO sig_create;

GRANT SELECT ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_read;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_create;
GRANT ALL ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO create_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_espace_vert.xapps_an_v_ev_stat_arbre_quartier TO sig_edit;

COMMENT ON VIEW m_espace_vert.xapps_an_v_ev_stat_arbre_quartier IS 'Vue du nombre d''arbres par quartiers';







-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      PURGE                                                                ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- purger les enregistrements de test
DELETE FROM m_espace_vert.an_ev_arbre where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_espaceenherbe where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_arbre_etat_sanitaire where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_geohaie where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_geovegetal where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_massifarbustif where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_massiffleuri where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_media where idobjet >= 53321;
DELETE FROM m_espace_vert.an_ev_objet where idobjet >= 53321;
DELETE FROM m_espace_vert.geo_ev_line where idobjet >= 53321;
DELETE FROM m_espace_vert.geo_ev_pct where idobjet >= 53321;
DELETE FROM m_espace_vert.geo_ev_polygon where idobjet >= 53321;

-- ré-assignation des champs automatiques (découpage admin) via les fonctions trigger
UPDATE m_espace_vert.geo_v_ev_vegetal_arbreisole SET geom = geom;
UPDATE m_espace_vert.geo_v_ev_vegetal_espaceenherbe SET geom = geom;
UPDATE m_espace_vert.geo_v_ev_vegetal_massiffleuri SET geom = geom;
UPDATE m_espace_vert.geo_v_ev_vegetal_massifarbustif SET geom = geom;
UPDATE m_espace_vert.geo_v_ev_vegetal_haie SET geom = geom;
