-- Requêtes à réaliser :

-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d’avril 2019
DELETE 
FROM
	compo 
WHERE
	ID_BON IN (
	SELECT
		ID 
	FROM
		bon 
WHERE
	MONTH (bon.DATE_CMDE) = 4 AND YEAR(bon.DATE_CMDE) = 2019)


-- b. Supprimer dans la table bon tous les bons de commande d’avril 2019.
DELETE 
FROM
	bon 
WHERE
	ID IN (
	SELECT
		ID 
	FROM
		bon 
	WHERE
		MONTH ( bon.DATE_CMDE ) = 4 
	AND YEAR ( bon.DATE_CMDE ) = 2019 
	)