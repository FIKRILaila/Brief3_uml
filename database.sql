DROP TABLE IF EXISTS affecter;
DROP TABLE IF EXISTS livrable;
DROP TABLE IF EXISTS phase;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS projet;
DROP TABLE IF EXISTS organisme;
DROP TABLE IF EXISTS employe;
DROP TABLE IF EXISTS profil;

CREATE TABLE profil(
	id SERIAL PRIMARY KEY,
	libelle VARCHAR(50) UNIQUE
);

CREATE TABLE employe(
	matricule VARCHAR(20) PRIMARY KEY,
	nom  VARCHAR(50),
	prenom VARCHAR(50),
	telephone VARCHAR(20),
	email VARCHAR(30) UNIQUE,
 	login VARCHAR(20),
 	password VARCHAR(20),
	profil_id INTEGER REFERENCES profil(id) ON DELETE CASCADE 
);

CREATE TABLE organisme(
	code VARCHAR(20) PRIMARY KEY,
	nom VARCHAR(50),
 	adresse VARCHAR(50),
 	telephone VARCHAR(20),
 	nomContact VARCHAR(30),
 	emailContact VARCHAR(30),
 	adresseWeb VARCHAR(40)
);
DROP TYPE Etat;
CREATE TYPE Etat AS ENUM ('Nouveau','en_cours','cloture');

CREATE TABLE projet(
	code VARCHAR(20) PRIMARY KEY,
 	nom VARCHAR(30),
 	description text,
 	date_debut date,
	date_fin date,
	montant INTEGER,
	etat Etat,
 	organisme_code VARCHAR(20) REFERENCES organisme(code) ON DELETE CASCADE,
 	chef_matricule VARCHAR(20) REFERENCES employe(matricule) ON DELETE CASCADE 
);

CREATE TABLE documents(
	id SERIAL PRIMARY KEY,
	path VARCHAR(255),
	code_projet VARCHAR(20) REFERENCES projet(code) ON DELETE CASCADE 
);

CREATE TABLE phase(
	code VARCHAR(20) PRIMARY KEY,
 	libelle VARCHAR(20),
 	description TEXT,
 	date_debut DATE,
 	date_fin DATE,
 	montant INTEGER,
 	terminee BOOLEAN,
 	facturee BOOLEAN,
 	paye BOOLEAN,
 	code_projet VARCHAR(20) REFERENCES projet(code) ON DELETE CASCADE 
);

CREATE TABLE livrable(
	code VARCHAR(20) PRIMARY KEY,
 	libelle VARCHAR(50),
 	description TEXT,
	chemin VARCHAR(20),
	code_phase VARCHAR(20) REFERENCES phase(code) ON DELETE CASCADE 
);

CREATE TABLE affecter(
	id SERIAL PRIMARY KEY,
	date DATE,
	emp_matricule VARCHAR(20) REFERENCES employe(matricule) ON DELETE CASCADE ,
	chef_matricule VARCHAR(20) REFERENCES employe(matricule) ON DELETE CASCADE ,
 	code_phase VARCHAR(20) REFERENCES phase(code) ON DELETE CASCADE 
);




