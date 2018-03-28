/*
OTMS Database Definition
Group Number: 53
March 28th, 2018
*/

-- Drop the database
DROP DATABASE otmsdb;

-- Create the database
CREATE DATABASE otmsdb;

-- Use the newly created database
USE otmsdb;

-- Table for theatre complexes
CREATE TABLE theatre_complex (
	id INTEGER NOT NULL AUTO_INCREMENT,
	name varchar(50) NOT NULL,
	phone_number varchar(30) NOT NULL,
	a_street varchar(100) NOT NULL,
	a_city varchar(100) NOT NULL,
	a_postal_code varchar(7) NOT NULL,
	PRIMARY KEY (id)
);

-- Table for theatres
-- Belongs to a theatre complex
CREATE TABLE theatre (
	id INTEGER NOT NULL AUTO_INCREMENT,
	theatre_num INTEGER NOT NULL,
	max_seats INTEGER NOT NULL,
	screen_size varchar(10) NOT NULL,
	theatre_complex_id INTEGER NOT NULL,
	PRIMARY KEY (id, theatre_num),
	FOREIGN KEY (theatre_complex_id) REFERENCES theatre_complex(id)
);

-- Table for a movie supplier
CREATE TABLE supplier (
	id INTEGER NOT NULL AUTO_INCREMENT,
	name varchar(100) NOT NULL,
	a_street varchar(100) NOT NULL,
	a_city varchar(100) NOT NULL,
	a_postal_code varchar(7) NOT NULL,
	contact_fname varchar(50) NOT NULL,
	contact_lname varchar(50) NOT NULL,
	phone_number varchar(30) NOT NULL,
	PRIMARY KEY (id)
);

-- Table for movies
-- Supplied from a supplier
CREATE TABLE movie (
	id INTEGER NOT NULL AUTO_INCREMENT,
	title varchar(50) NOT NULL,
	run_time TIME NOT NULL,
	rating varchar(3) NOT NULL,
	plot_synopsis varchar(300) NOT NULL,
	director varchar(50) NOT NULL,
	producer varchar(50) NOT NULL,
	supplier_id INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);

-- Table for a movies run
CREATE TABLE movie_run (
	id INTEGER NOT NULL AUTO_INCREMENT,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	movie_id INTEGER NOT NULL,
	theatre_complex_id INTEGER NOT NULL,
	PRIMARY KEY (id, start_date, end_date),
	FOREIGN KEY (movie_id) REFERENCES movie(id),
	FOREIGN KEY (theatre_complex_id) REFERENCES theatre_complex(id)
);

-- Table for actors
-- Belong to a movie
CREATE TABLE actor (
	name varchar(50) NOT NULL,
	movie_id INTEGER NOT NULL,
	PRIMARY KEY (name),
	FOREIGN KEY (movie_id) REFERENCES movie(id)
);

-- Table for movie showing
CREATE TABLE showing (
	id INTEGER NOT NULL AUTO_INCREMENT,
	seats_avail INTEGER NOT NULL,
	start_time TIME NOT NULL,
	start_date DATE NOT NULL,
	movie_id INTEGER NOT NULL,
	theatre_id INTEGER NOT NULL,
	PRIMARY KEY (id, seats_avail, start_time, start_date),
	FOREIGN KEY (movie_id) REFERENCES movie(id),
	FOREIGN KEY (theatre_id) REFERENCES theatre(id)
);

-- Table for customers
CREATE TABLE customer (
	account_num INTEGER NOT NULL AUTO_INCREMENT,
	fname varchar(50) NOT NULL,
	lname varchar(50) NOT NULL,
	a_street varchar(100) NOT NULL,
	a_city varchar(100) NOT NULL,
	a_postal_code varchar(7) NOT NULL,
	phone_number varchar(30) NOT NULL,
	email varchar(100) NOT NULL,
	password varchar(30) NOT NULL,
	cc_number varchar(30) NOT NULL,
	cc_expiry varchar(10) NOT NULL,
	cc_cvc varchar(3) NOT NULL,
	isAdmin BOOLEAN NOT NULL,
	PRIMARY KEY(account_num, email)
);

-- Table for customer movie reservations
CREATE TABLE reservation (
	reservation_id INTEGER NOT NULL AUTO_INCREMENT,
	num_tickets INTEGER NOT NULL,
	showing_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	PRIMARY KEY (reservation_id),
	FOREIGN KEY (showing_id) REFERENCES showing(id),
	FOREIGN KEY (customer_id) REFERENCES customer(account_num)
);

-- Table for custom movie reviews
CREATE TABLE review (
	id INTEGER NOT NULL AUTO_INCREMENT,
	rating INTEGER NOT NULL,
	description INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,
	PRIMARY KEY (id, rating, description),
	FOREIGN KEY (customer_id) REFERENCES customer(account_num),
	FOREIGN KEY (movie_id) REFERENCES movie(id)
);

-- Inserting some theatre complexes
INSERT INTO theatre_complex VALUES
(1, 'Silver City Toronto','123-456-789', 1200, 'Yonge St.', 'Toronto', 'A1B 2C3'),
(2, 'Bloor Street Cinemas','123-456-789', 8080, 'Bloor St.', 'Toronto', 'A1B 2C3'),
(3, 'Yorkdale Malls Cinema','123-456-789', 3000, 'Yorkdale St.', 'Toronto', 'A1B 2C3'),
(4, 'The Beaches Odeon','123-456-789', 1234, 'Beach St.', 'Toronto', 'A1B 2C3');

-- Inserting some theatres for the complexes
INSERT INTO theatre VALUES
(1, 1, 50, 'Large', 1),
(2, 2, 75, 'Large', 1),
(3, 3, 50, 'Small', 1),
(4, 4, 50, 'Medium', 1),
(5, 1, 25, 'Small', 2),
(6, 2, 50, 'Medium', 2),
(7, 3, 100, 'Large', 2),
(8, 4, 50, 'Medium', 2),
(9, 1, 75, 'Large', 3),
(10, 2, 50, 'Medium', 3),
(11, 3, 50, 'Medium', 3),
(12, 1, 200, 'Large', 4);

-- Inserting some movies

-- need to finish this
