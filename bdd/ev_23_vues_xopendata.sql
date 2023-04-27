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



COMMENT ON VIEW x_opendata.xopendata_an_v_ev_vegetal_arbre IS 'Table géographique des secteurs de gestion espace vert de l''ARC';

COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.id IS 'identifiant unique de l''objet arbre pour le jeu de données.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.longitude IS 'La longitude de la localisation de l''arbre dans le système de coordonnées WGS84.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.latitude IS 'La latitude de la localisation de l''arbre dans le système de coordonnées WGS84.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.date_releve IS 'Date à laquelle les données ont été relevées pour cet arbre.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.famille IS 'Le taxon auquel appartient l''arbre en latin (cinquième niveau de la classification classique).';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.genre IS 'La subdivision de la famille auquel appartient l''arbre en latin (sixième niveau de la classification classique).';	
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.espece IS 'La subdivision du genre auquel appartient l''arbre en latin (septième niveau de la classification classique).';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.cultivar_variete IS 'La subdivision de l''espèce auquel appartient l''arbre en latin.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.nom_vernaculaire IS 'Le nom commun français correspondant au ([genre][espèce][cultivar]).';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.code_insee IS 'Le code INSEE de la commune dans laquelle l''arbre se trouve.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.date_plantation IS 'La date de plantation de l''arbre';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.stade_developpement IS 'La maturité de l''arbre en fonction de sa date de plantation.';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.hauteur IS 'La hauteur de l''arbre exprimée en cm';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.circonference IS 'La circonférence de l''arbre mesurée à hauteur d''homme, exprimée en cm';	
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.diametre_couronne IS 'Le diamètre du houpier de l''arbre';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.description_pied_arbre IS 'Aménagement présent sur le sol autour du pied de l''arbre';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.remarquable IS 'Classification de l''arbre à remarquable selon son âge, sa circonférence et sa hauteur';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.protege IS 'Si l''arbre fait l''objet d''une classification et d''une protection';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.contrainte_aerienne IS 'Indique la présence de contraintes physiques au-dessus du sol';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.allergie IS 'Indique le potentiel allergisant de l''arbre';
COMMENT ON COLUMN x_opendata.xopendata_an_v_ev_vegetal_arbre.remarque IS 'Tout autre remarque nécessaire à la gestion de l''arbre';
