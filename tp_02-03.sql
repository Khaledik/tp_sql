--  CREATION DE LA DB COMPTA
create database compta character set 'utf8' collate 'utf8mb4_general_ci';


--  UTILISATION DE LA DB COMPTA
use compta;


--  CREATION DES TABLES 

CREATE TABLE article (
    id int(10) primary key,
    ref varchar(13),
    designation varchar(255),
    prix decimal(7,2),
    id_fou int(10)
);

CREATE TABLE fournisseur (
    id int(10) primary key,
    nom varchar(50)
);

CREATE TABLE bon (
    id int(10) primary key,
    numero int(10),
    date_cmde timestamp,
    delai integer(10),
    id_fou int(10)
);

CREATE TABLE compo (
    id int(10) auto_increment primary key,
    qte int(10),
    id_art int(10),
    id_bon int(10)
);


-- • Créez la clé étrangère entre la colonne ID_FOU de la table ARTICLE et la colonne ID de la table FOURNISSEUR.
ALTER TABLE article ADD COLUMN id_fou INT(10);
ALTER TABLE article  add constraint fk_article_fourni foreign key (id_fou) references fournisseur(id);

-- • Créez la clé étrangère entre la colonne ID_FOU de la table BON et la colonne ID de la table FOURNISSEUR.
ALTER TABLE bon ADD COLUMN id_fou INT(10);
ALTER TABLE bon  add constraint fk_bon_fourni foreign key (id_fou) references fournisseur(id);

-- • Créez la clé étrangère entre la colonne ID_ART de la table COMPO et la colonne ID de la table ARTICLE.
ALTER TABLE compo ADD COLUMN id_art INT(10);
ALTER TABLE compo  add constraint fk_compo_article  foreign key (id_art) references article(id);

-- • Créez la clé étrangère entre la colonne ID_BON de la table COMPO et la colonne ID de la table BON.
ALTER TABLE compo ADD COLUMN id_bon INT(10);
ALTER TABLE compo  add constraint fk_compo_bon  foreign key (id_bon) references bon(id);


--  Insérer les 3 fournisseurs suivants
INSERT INTO  fournisseur (id,nom)  values (1,"Française d'Imports");
INSERT INTO  fournisseur (id,nom)  values (2,"FDM SA");
INSERT INTO  fournisseur (id,nom)  values (3,"Dubois & Fils");


-- Dans la table des articles, insérez les 10 articles suivants
INSERT INTO article (ref, designation, prix, id_fou)
VALUES
    ("A01", "Perceuse P1", 74.99, 1),
    ("F01", "Boulon laiton 4 x 40 mm (sachet de 10)", 2.25, 2),
    ("F02", "Boulon laiton 5 x 40 mm (sachet de 10)", 4.45, 2),
    ("D01", "Boulon laiton 5 x 40 mm (sachet de 10)", 4.40, 3),
    ("A02", "Meuleuse 125mm", 37.85, 1),
    ("D03", "Boulon acier zingué 4 x 40mm (sachet de 10)", 1.8, 3),
    ("A03", "Perceuse à colonne", 185.25, 1),
    ("D04", "Coffret mèches à bois", 12.25, 3),
    ("F03", "Coffret mèches plates", 6.25, 2),
    ("F04", "Fraises d’encastrement", 8.14, 2);


--  Insérez le bon de commande suivant passé auprès de Française d’Imports
INSERT INTO bon (id,numero,date_cmde, delai, id_fou) 
VALUES 
    (1, 001,NOW(),3, 1 );


INSERT INTO compo (qte, id_art, id_bon)
VALUES 
    (3,1,1),
    (4,5,1),
    (1,7,1);
