DROP DATABASE IF EXISTS TicketBuyer;
CREATE DATABASE TicketBuyer;

USE TicketBuyer;

DROP TABLE IF EXISTS Utente;
CREATE TABLE Utente (
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    passwordUser VARCHAR(5000) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    numero CHAR(16) NOT NULL,
    ruolo ENUM('User', 'Admin') NOT NULL DEFAULT 'User'
);

DROP TABLE IF EXISTS Evento;
CREATE TABLE Evento (
    codiceEvento INT PRIMARY KEY auto_increment NOT NULL,
    nome VARCHAR(100) NOT NULL,
    orario TIME NOT NULL,
    luogo VARCHAR(100) NOT NULL,
    dataEvento DATE NOT NULL,
    tipo ENUM('Sport', 'Concerto', 'Fiera') NOT NULL,
    deleted BOOL NOT NULL DEFAULT false,
    image VARCHAR(255)
);

DROP TABLE IF EXISTS Biglietto;
CREATE TABLE Biglietto (
    codiceBiglietto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    codiceEvento INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    descrizione TEXT NOT NULL,
    prezzoUnitario DECIMAL(10,2) NOT NULL,
    deleted BOOL NOT NULL DEFAULT false,
    FOREIGN KEY (codiceEvento) REFERENCES Evento(codiceEvento) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Ordine;
CREATE TABLE Ordine (
    codiceOrdine INT PRIMARY KEY AUTO_INCREMENT,
    emailCliente VARCHAR(50),
    prezzoTotale DECIMAL(10,2),
    dataAcquisto DATE,
    stato ENUM('In lavorazione', 'Completato', 'Richiesto Rimborso'),
    FOREIGN KEY (emailCliente) REFERENCES Utente(email) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS DettaglioOrdine;
CREATE TABLE DettaglioOrdine (
    codiceOrdine INT,
    codiceBiglietto INT,
    quantita INT,
    PRIMARY KEY (codiceOrdine, codiceBiglietto),
    FOREIGN KEY (codiceOrdine) REFERENCES Ordine(codiceOrdine) ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (codiceBiglietto) REFERENCES Biglietto(codiceBiglietto) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Recensione;
CREATE TABLE Recensione (
    codiceRecensione INT PRIMARY KEY AUTO_INCREMENT,
    codiceEvento INT,
    emailCliente VARCHAR(50),
    votazione TINYINT UNSIGNED,
    testo TEXT,
    dataRecensione DATE,
    FOREIGN KEY (codiceEvento) REFERENCES Evento(codiceEvento) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (emailCliente) REFERENCES Utente(email) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Inserisci Utenti
INSERT INTO Utente (email, passwordUser, nome, cognome, indirizzo, telefono, numero, ruolo) VALUES
('user1@example.com', SHA2('password1', 256), 'John', 'Doe', '123 Main St', '1234567890', '1234567812345678', 'User'),
('user2@example.com', SHA2('password2', 256), 'Jane', 'Smith', '456 Oak St', '0987654321', '8765432187654321', 'Admin'),
('user3@example.com', SHA2('password3', 256), 'Alice', 'Brown', '789 Pine St', '1112223333', '1111222233334444', 'User'),
('user4@example.com', SHA2('password4', 256), 'Bob', 'Davis', '101 Maple St', '4445556666', '5555666677778888', 'User'),
('user5@example.com', SHA2('password5', 256), 'Charlie', 'Wilson', '202 Elm St', '7778889999', '9999000011112222', 'User'),
('user6@example.com', SHA2('password6', 256), 'Dave', 'Taylor', '303 Cedar St', '3334445555', '3333444455556666', 'User'),
('user7@example.com', SHA2('password7', 256), 'Eve', 'Anderson', '404 Birch St', '6667778888', '7777888899990000', 'User'),
('user8@example.com', SHA2('password8', 256), 'Frank', 'Thomas', '505 Ash St', '8889990000', '0000111122223333', 'User'),
('user9@example.com', SHA2('password9', 256), 'Grace', 'Moore', '606 Willow St', '5556667777', '4444555566667777', 'User'),
('user10@example.com', SHA2('password10', 256), 'Hank', 'Martin', '707 Spruce St', '9990001111', '8888999900001111', 'User');

-- Inserisci Eventi
INSERT INTO Evento (nome, orario, luogo, dataEvento, tipo, deleted, image) VALUES
('Concerto A', '18:00:00', 'Stadio A', '2024-07-10', 'Concerto', false, '1.jpeg'),
('Evento Sportivo B', '20:00:00', 'Arena B', '2024-08-15', 'Sport', false, '2.jpeg'),
('Fiera C', '10:00:00', 'Sala Espositiva C', '2024-09-20', 'Fiera', false, '3.jpeg'),
('Concerto D', '19:00:00', 'Stadio D', '2024-10-25', 'Concerto', false, '4.jpeg'),
('Evento Sportivo E', '21:00:00', 'Arena E', '2024-11-30', 'Sport', false, '5.jpeg'),
('Fiera F', '11:00:00', 'Sala Espositiva F', '2024-12-05', 'Fiera', false, '6.jpeg'),
('Concerto G', '17:00:00', 'Stadio G', '2024-12-15', 'Concerto', false, '7.jpeg'),
('Evento Sportivo H', '19:30:00', 'Arena H', '2024-12-20', 'Sport', false, '8.jpeg'),
('Fiera I', '09:00:00', 'Sala Espositiva I', '2024-12-25', 'Fiera', false, '9.jpeg'),
('Concerto J', '18:30:00', 'Stadio J', '2024-12-30', 'Concerto', false, '10.jpeg');

-- Inserisci Biglietti
INSERT INTO Biglietto (codiceEvento, tipo, descrizione, prezzoUnitario, deleted) VALUES
(1, 'Standard', 'Posto standard', 50.00, false),
(1, 'Premium', 'Posto premium', 100.00, false),
(2, 'Standard', 'Posto standard', 50.00, false),
(2, 'Premium', 'Posto premium', 100.00, false),
(3, 'Standard', 'Ingresso standard', 20.00, false),
(3, 'Premium', 'Ingresso premium', 40.00, false),
(4, 'Standard', 'Posto standard', 50.00, false),
(4, 'Premium', 'Posto premium', 100.00, false),
(5, 'Standard', 'Posto standard', 50.00, false),
(5, 'Premium', 'Posto premium', 100.00, false),
(6, 'Standard', 'Ingresso standard', 20.00, false),
(6, 'Premium', 'Ingresso premium', 40.00, false),
(7, 'Standard', 'Posto standard', 50.00, false),
(7, 'Premium', 'Posto premium', 100.00, false),
(8, 'Standard', 'Posto standard', 50.00, false),
(8, 'Premium', 'Posto premium', 100.00, false),
(9, 'Standard', 'Ingresso standard', 20.00, false),
(9, 'Premium', 'Ingresso premium', 40.00, false),
(10, 'Standard', 'Posto standard', 50.00, false),
(10, 'Premium', 'Posto premium', 100.00, false);

-- Inserisci Ordini
INSERT INTO Ordine (emailCliente, prezzoTotale, dataAcquisto, stato) VALUES
('user1@example.com', 150.00, '2024-06-01', 'Completato'),
('user2@example.com', 100.00, '2024-06-05', 'In lavorazione'),
('user3@example.com', 60.00, '2024-06-10', 'Completato'),
('user4@example.com', 40.00, '2024-06-15', 'Completato'),
('user5@example.com', 200.00, '2024-06-20', 'In lavorazione'),
('user6@example.com', 50.00, '2024-06-25', 'Completato'),
('user7@example.com', 80.00, '2024-06-30', 'Completato'),
('user8@example.com', 120.00, '2024-07-05', 'Completato'),
('user9@example.com', 70.00, '2024-07-10', 'In lavorazione'),
('user10@example.com', 90.00, '2024-07-15', 'Completato');

-- Inserisci Dettagli Ordini
INSERT INTO DettaglioOrdine (codiceOrdine, codiceBiglietto, quantita) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 3),
(4, 4, 2),
(5, 5, 4),
(6, 6, 1),
(7, 7, 2),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1);

-- Inserisci Recensioni
INSERT INTO Recensione (codiceEvento, emailCliente, votazione, testo, dataRecensione) VALUES
(1, 'user1@example.com', 5, 'Concerto fantastico!', '2024-07-11'),
(2, 'user2@example.com', 4, 'Evento sportivo divertente!', '2024-08-16'),
(3, 'user3@example.com', 3, 'Fiera nella media.', '2024-09-21'),
(4, 'user4@example.com', 5, 'Concerto indimenticabile!', '2024-10-26'),
(5, 'user5@example.com', 4, 'Ottimo evento sportivo!', '2024-12-01'),
(6, 'user6@example.com', 3, 'Fiera interessante.', '2024-12-06'),
(7, 'user7@example.com', 5, 'Concerto eccezionale!', '2024-12-16'),
(8, 'user8@example.com', 4, 'Partita emozionante!', '2024-12-21'),
(9, 'user9@example.com', 3, 'Fiera ben organizzata.', '2024-12-26'),
(10, 'user10@example.com', 5, 'Concerto magnifico!', '2024-12-31');
