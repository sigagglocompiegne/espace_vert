/*ESPACE VERT V2.2.0*/
/* Creation des vues pour l'opendata */
/* ev_23_vues_xopendata.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet, Florent Vanhoutte, Caroline Sarg, Fabien Nicollet (Business Geografic) */


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES OPENDATA                                                        ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


DROP VIEW IF EXISTS x_opendata.xopendata_an_v_ev_vegetal_arbre;
CREATE OR REPLACE VIEW x_opendata.xopendata_an_v_ev_vegetal_arbre
 AS

SELECT 
	o.idobjet AS id,
    st_x(st_transform(p.geom, 4326))::numeric(8,7) AS longitude,
    st_y(st_transform(p.geom, 4326))::numeric(9,7) AS latitude,
	to_char(o.date_sai,'yyyy-mm-dd')::date AS date_releve,
	a.famille,
	a.genre,
	a.espece,
	a.cultivar AS cultivar_variete,
	a.nomcommun AS nom_vernaculaire,
	m.insee AS code_insee,
	--adresse.codepostal AS code_postal
	--?? AS adresse 
	--?? AS matricule --> nous n'avons pas cette info
	a.date_pl_an AS date_plantation, -- le standard attend une date mais il n'y a que l'année dans notre base. J'ai mis l'année en integer. 
	c.valeur AS stade_developpement,
	null::integer AS hauteur,
	--?? AS diametre --> Le diamètre de l'arbre mesurée à hauteur d'homme --> nous n'avons pas cette info
	a.circonf AS circonference, 
	a.diam_houpp AS diametre_couronne,
	-- AS type_sol --> nous n'avons pas cette info
	g.valeur AS description_pied_arbre,
	--?? AS type_enracinement --> nous n'avons pas cette info	
	--?? AS port_arbre --> nous n'avons pas cette info
	CASE 
		WHEN a.remarq= 'f' then 'Non'  
		WHEN a.remarq = 't' then 'Oui'
	ELSE ''
	END	AS remarquable,
	
		CASE 
		WHEN a.proteg= 'f' then 'Non'  
		WHEN a.proteg = 't' then 'Oui'
	ELSE ''
	END	AS protege,
	
	--?? AS contrainte_sol --> nous n'avons pas cette info
	k.valeur AS contrainte_aerienne,
	--?? AS eclairage --> nous n'avons pas cette info
	--?? AS arrosage --> nous n'avons pas cette info
	null::integer AS allergie, -- pas les memes ordres de grandeur : opendata va de 0 à 5 / BDD-SIG-ARC va de non-renseigné à élevé (00 à 03)
	m.observ AS remarque
	
	
FROM
	m_espace_vert.an_ev_objet o
		JOIN m_espace_vert.geo_ev_objet_pct p ON o.idobjet = p.idobjet
		JOIN m_espace_vert.an_ev_vegetal_arbre a ON o.idobjet = a.idobjet
		JOIN m_espace_vert.lt_ev_vegetal_arbre_stade_dev c ON a.stade_dev = c.code
		JOIN m_espace_vert.lt_ev_vegetal_arbre_amenagement_pied g on a.amena_pied = g.code
		JOIN m_espace_vert.lt_ev_vegetal_arbre_contr_type k on a.amena_pied = k.code
		JOIN m_espace_vert.geo_v_ev_vegetal_arbre m on a.idobjet = m.idobjet
		JOIN m_espace_vert.an_ev_objet t ON o.idobjet = t.idobjet
		--JOIN r_adresse.geo_v_adresse adresse ON o.insee = adresse.insee
		
WHERE
	o.typ3::text = '111'::text;

ALTER TABLE x_opendata.xopendata_an_v_ev_vegetal_arbre
OWNER TO sig_create;

COMMENT ON VIEW x_opendata.xopendata_an_v_ev_vegetal_arbre
IS 'Vue opendata de la données ''Arbres urbains''';


GRANT ALL ON TABLE x_opendata.xopendata_an_v_ev_vegetal_arbre TO sig_read WITH GRANT OPTION;
GRANT ALL ON TABLE x_opendata.xopendata_an_v_ev_vegetal_arbre TO sig_create WITH GRANT OPTION;
GRANT ALL ON TABLE x_opendata.xopendata_an_v_ev_vegetal_arbre TO sig_edit WITH GRANT OPTION;
GRANT ALL ON TABLE x_opendata.xopendata_an_v_ev_vegetal_arbre TO create_sig;
