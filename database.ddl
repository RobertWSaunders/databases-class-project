/*
OTMS Database Definition
Group Number: 53
March 28th, 2018
*/

-- Create the database
CREATE DATABASE otmsdb;

-- Table for theatre complexes
CREATE TABLE theatre_complex (
	id INTEGER NOT NULL,
	name varchar(50) NOT NULL,
	phone_number varchar(30) NOT NULL,
	a_number INTEGER NOT NULL,
	a_street varchar(100) NOT NULL,
	a_city varchar(100) NOT NULL,
	a_postal_code varchar(7) NOT NULL,
	PRIMARY KEY (id)
);

-- Table for theatres
-- Belongs to a theatre complex
CREATE TABLE theatre (
	id INTEGER NOT NULL,
	theatre_num INTEGER NOT NULL,
	max_seats INTEGER NOT NULL,
	screen_size varchar(10) NOT NULL,
	theatre_complex_id INTEGER NOT NULL,
	PRIMARY KEY (id, theatre_num),
	FOREIGN KEY (theatre_complex_id) REFERENCES theatre_complex(id)
);

-- Table for a movie supplier
CREATE TABLE supplier (
	id INTEGER NOT NULL,
	name varchar(100) NOT NULL,
	a_number INTEGER NOT NULL,
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
	id INTEGER NOT NULL,
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
	id INTEGER NOT NULL,
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
	id INTEGER NOT NULL,
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
	account_num INTEGER NOT NULL,
	fname varchar(50) NOT NULL,
	lname varchar(50) NOT NULL,
	a_number INTEGER NOT NULL,
	a_street varchar(100) NOT NULL,
	a_city varchar(100) NOT NULL,
	a_postal_code varchar(7) NOT NULL,
	phone_number varchar(30) NOT NULL,
	email varchar(100) NOT NULL,
	password varchar(30) NOT NULL,
	cc_number varchar(30) NOT NULL,
	cc_expiry varchar(10) NOT NULL,
	isAdmin BOOLEAN NOT NULL,
	PRIMARY KEY(account_num)
);

-- Table for customer movie reservations
CREATE TABLE reservation (
	num_tickets INTEGER NOT NULL,
	showing_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	PRIMARY KEY (num_tickets),
	FOREIGN KEY (showing_id) REFERENCES showing(id),
	FOREIGN KEY (customer_id) REFERENCES customer(account_num)
);

-- Table for custom movie reviews
CREATE TABLE review (
	id INTEGER NOT NULL,
	rating INTEGER NOT NULL,
	description INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,
	PRIMARY KEY (id, rating, description),
	FOREIGN KEY (customer_id) REFERENCES customer(account_num),
	FOREIGN KEY (movie_id) REFERENCES movie(id)
);
