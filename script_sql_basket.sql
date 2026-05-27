create database Basket ;

use Basket ; 

DROP TABLE IF EXISTS statistiques_journalieres;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS creneaux;
DROP TABLE IF EXISTS terrains;
DROP TABLE IF EXISTS utilisateurs;


CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE terrains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_terrain VARCHAR(50) NOT NULL,
    statut VARCHAR(20) NOT NULL
);

CREATE TABLE creneaux (
    id INT AUTO_INCREMENT PRIMARY KEY,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    tarif DECIMAL(5,2) NOT NULL
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    terrain_id INT NOT NULL,
    creneau_id INT NOT NULL,
    date_reservation DATE NOT NULL,
    statut_paiement VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,
    FOREIGN KEY (terrain_id) REFERENCES terrains(id) ON DELETE CASCADE,
    FOREIGN KEY (creneau_id) REFERENCES creneaux(id) ON DELETE CASCADE,
    CONSTRAINT unique_terrain_creneau_date UNIQUE (terrain_id, creneau_id, date_reservation)
);

CREATE TABLE statistiques_journalieres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_analyse DATE NOT NULL,
    terrain_id INT NOT NULL,
    taux_occupation DECIMAL(5,2) NOT NULL,
    chiffre_affaires_genere DECIMAL(7,2) NOT NULL,
    
    FOREIGN KEY (terrain_id) REFERENCES terrains(id) ON DELETE CASCADE
);


INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe, role) VALUES
('Basket', 'Aaron', 'aaron@example.com', '$2b$12$eImiTXxFp1234567890abcdef123456789', 'client'),
('Dunkeur', 'Regis', 'regis@example.com', '$2b$12$eImiTXxFp1234567890abcdef123456789', 'client'),
('Pivot', 'Jesse', 'jesse@example.com', '$2b$12$eImiTXxFp1234567890abcdef123456789', 'client'),
('Meneur', 'Liebe', 'liebe@example.com', '$2b$12$eImiTXxFp1234567890abcdef123456789', 'client'),
('Coach', 'Biglaf', 'biglaf@example.com', '$2b$12$eImiTXxFp1234567890abcdef123456789', 'gerant');

INSERT INTO terrains (nom_terrain, statut) VALUES
('Terrain Noir (Intérieur)', 'actif'),
('Terrain Rouge (Intérieur)', 'actif'),
('Terrain Extérieur (3x3)', 'maintenance');

INSERT INTO creneaux (heure_debut, heure_fin, tarif) VALUES
('10:00:00', '11:00:00', 20.00),
('14:00:00', '15:00:00', 25.00),
('18:00:00', '19:00:00', 35.00),
('19:00:00', '20:00:00', 35.00);

INSERT INTO reservations (utilisateur_id, terrain_id, creneau_id, date_reservation, statut_paiement) VALUES
(1, 1, 3, '2026-06-01', 'paye'),
(2, 1, 4, '2026-06-01', 'paye'),
(3, 2, 3, '2026-06-01', 'en_attente'),
(4, 2, 1, '2026-06-02', 'paye');

INSERT INTO statistiques_journalieres (date_analyse, terrain_id, taux_occupation, chiffre_affaires_genere) VALUES
('2026-05-25', 1, 75.00, 105.00),
('2026-05-25', 2, 50.00, 60.00);
