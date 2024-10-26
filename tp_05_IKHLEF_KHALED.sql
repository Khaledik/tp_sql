-- Requêtes à réaliser :

-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT * FROM article ORDER BY designation ASC; 

-- b. Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * FROM article ORDER BY prix DESC; 

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM article WHERE designation LIKE "boulon%" ORDER BY prix ASC; 

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM article WHERE designation LIKE "%sachet%";

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * FROM article WHERE designation COLLATE utf8_general_ci  LIKE "%sachet%";

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT
	a.ID,
	a.REF,
	a.DESIGNATION,
	a.PRIX,
	f.NOM AS FOURNISSEUR 
FROM
	article AS a
	LEFT JOIN fournisseur AS f ON a.id_fou = f.id 
ORDER BY
	f.NOM ASC,
	prix DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT
	f.NOM,
	a.REF,
	a.DESIGNATION,
	a.PRIX
FROM
	fournisseur as f
	LEFT JOIN article as a ON  f.id = a.id_fou
	WHERE f.NOM = "Dubois & Fils"; 

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT
	f.NOM as FOURNISSEUR,
	SUM(a.prix) / COUNT(a.ref) as "MOYENNE DES PRIX" 
FROM
	article AS a
	LEFT JOIN fournisseur AS f ON a.id_fou = f.id
	WHERE f.nom = "Dubois & Fils"

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT
	f.NOM as FOURNISSEUR,
	SUM(a.prix) / COUNT(a.prix) as "MOYENNE DES PRIX" 
FROM
	article AS a
	LEFT JOIN fournisseur AS f ON a.id_fou = f.id
GROUP BY f.NOM

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT
	* 
FROM
	bon 
WHERE
	DATE_CMDE BETWEEN "2019-03-01" 
	AND "2019-04-05 12:00:00";

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT
	b.NUMERO AS "NUMERO DE BON",
	a.REF,
	a.DESIGNATION,
	c.QTE,
	a.PRIX,
	b.DATE_CMDE,
	b.DELAI 
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	LEFT JOIN bon AS b ON b.NUMERO = c.ID_BON
WHERE
	a.DESIGNATION LIKE "%boulon%";

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT
	b.NUMERO AS "NUMERO DE BON",
	f.NOM AS FOURNISSEUR,
	a.REF,
	a.DESIGNATION,
	c.QTE,
	a.PRIX,
	b.DATE_CMDE,
	b.DELAI 
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	LEFT JOIN bon AS b ON b.NUMERO = c.ID_BON
	LEFT JOIN fournisseur AS f ON b.ID_FOU 
WHERE
	a.DESIGNATION LIKE "%boulon%";

-- m. Calculez le prix total de chaque bon de commande
SELECT
	b.NUMERO AS "NUMERO DE BON",
	b.DATE_CMDE,
	b.DELAI,
	SUM(a.PRIX * c.QTE) as TOTAL 
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	RIGHT JOIN bon AS b ON b.NUMERO = c.ID_BON
	LEFT JOIN fournisseur AS f ON b.ID_FOU  
GROUP BY b.NUMERO;



-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT
	b.NUMERO AS "NUMERO DE BON",
	b.DATE_CMDE,
	b.DELAI,
	SUM(c.QTE) AS "NOMBRES ARTICLES" 
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	RIGHT JOIN bon AS b ON b.NUMERO = c.ID_BON
	LEFT JOIN fournisseur AS f ON b.ID_FOU  
GROUP BY b.NUMERO;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
SELECT
	b.NUMERO AS "NUMERO DE BON",
	b.DATE_CMDE,
	b.DELAI,
	SUM(c.QTE) AS "NOMBRES ARTICLES" 
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	LEFT JOIN bon AS b ON b.NUMERO = c.ID_BON
	LEFT JOIN fournisseur AS f ON b.ID_FOU
GROUP BY b.NUMERO
HAVING SUM(c.QTE) > 25;


-- p. Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT
	b.NUMERO,
	b.DATE_CMDE,
	b.DELAI,
	a.PRIX,
	c.QTE,
	SUM(a.PRIX * c.QTE) as TOTAL  
FROM
	compo AS c
	LEFT JOIN article AS a ON a.ID = c.ID_ART
	RIGHT JOIN bon AS b ON b.NUMERO = c.ID_BON
	LEFT JOIN fournisseur AS f ON f.ID = b.ID_FOU 
WHERE
	b.DATE_CMDE BETWEEN '2019-04-01' 
	AND '2019-04-30'


-- 	Requêtes plus difficiles (facultatives)

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto jointure i.e. de la table avec elle-même)
SELECT
	a1.ID,
	a1.REF,
	a1.DESIGNATION,
	a1.PRIX,
	a1.ID_FOU
FROM
	article AS a1
	JOIN article AS a2 ON a1.DESIGNATION = a2.DESIGNATION 
	AND a1.ID_FOU != a2.ID_FOU 
WHERE
	a1.ID != a2.ID

-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT
CASE
	MONTH
		( DATE_CMDE ) 
		WHEN 1 THEN
		'janvier' 
		WHEN 2 THEN
		'février' 
		WHEN 3 THEN
		'mars' 
		WHEN 4 THEN
		'avril' 
		WHEN 5 THEN
		'mai' 
		WHEN 6 THEN
		'juin' 
		WHEN 7 THEN
		'juillet' 
		WHEN 8 THEN
		'août' 
		WHEN 9 THEN
		'septembre' 
		WHEN 10 THEN
		'octobre' 
		WHEN 11 THEN
		'novembre' ELSE 'décembre' 
	END AS "MOIS",
	YEAR ( b.DATE_CMDE ) AS "ANNÉE",
	SUM( a.PRIX * c.QTE ) AS "DÉPENSES" 
FROM
	compo AS c
	LEFT JOIN article AS a ON c.ID_ART = a.ID
	LEFT JOIN bon AS b ON c.ID_BON = b.ID 
GROUP BY
	MONTH ( DATE_CMDE ),
	YEAR ( DATE_CMDE ) 
ORDER BY
	MONTH ( DATE_CMDE ),
	YEAR (
	DATE_CMDE)

-- c. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT
    b.NUMERO AS "NUMÉRO de BON",
    b.DATE_CMDE AS "DATE de COMMANDE"
FROM
    bon AS b
WHERE
    NOT EXISTS (
        SELECT *
        FROM compo AS c
        WHERE c.ID_BON = b.ID
    );

-- d. Calculez le prix moyen des bons de commande par fournisseur.
SELECT
	f.NOM,
	SUM( a.PRIX * c.QTE ) / COUNT( DISTINCT b.NUMERO ) AS "PRIX MOYEN BONS" 
FROM
	compo AS c
	LEFT JOIN article AS a ON c.ID_ART = a.ID
	RIGHT JOIN bon AS b ON c.ID_BON = b.ID
	LEFT JOIN fournisseur AS f ON b.ID_FOU = f.ID 
GROUP BY
	f.NOM