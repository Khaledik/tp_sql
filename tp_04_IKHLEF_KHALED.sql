--  CREATION DE LA DB COMPTA
create database if not exists compta2 character set 'utf8' collate 'utf8_general_ci';


--  UTILISATION DE LA DB COMPTA2
use compta2;


-- Requêtes à réaliser :

-- a. Listez toutes les données concernant les articles
SELECT * FROM article;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT ref, designation FROM article WHERE prix > 2;

-- c. En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * FROM article WHERE prix >= 2 AND prix <= 6.25;

-- d. En utilisant l’opérateur BETWEEN, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * FROM article WHERE prix BETWEEN 2 AND 6.25;

-- e. Listez tous les articles dont le prix n’est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports.
SELECT * 
FROM article 
WHERE id_fou = (
    SELECT id 
    FROM fournisseur 
    WHERE nom = "Française d'Imports"
) NOT BETWEEN 2 AND 6.25;

-- f. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la Française d’imports ou Dubois et Fils
SELECT * 
FROM article 
WHERE id_fou = (
    SELECT id 
    FROM fournisseur 
    WHERE nom = "Française d'Imports" 
)
OR
id_fou = (
    SELECT id 
    FROM fournisseur 
    WHERE nom = "Dubois & Fils" 
);

-- g. En utilisant l’opérateur IN, réalisez la même requête que précédemment
SELECT * 
FROM article 
WHERE id_fou IN (
    SELECT id 
    FROM fournisseur 
    WHERE nom IN ("Française d'Imports", "Dubois & Fils")
);

-- h. En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne sont ni Française d’Imports, ni Dubois et Fils.
SELECT * 
FROM article 
WHERE id_fou IN (
    SELECT id 
    FROM fournisseur 
    WHERE nom NOT IN ("Française d'Imports", "Dubois & Fils")
);

-- i. Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019.
SELECT * FROM bon WHERE date_cmde BETWEEN '2019-02-01' AND '2019-04-30';