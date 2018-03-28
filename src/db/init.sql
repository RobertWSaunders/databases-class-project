/*
OTMS Database Definition
Group Number: 53
March 28th, 2018
*/

-- Drop the database
DROP DATABASE omtsdb;

-- Create the database
CREATE DATABASE omtsdb;

-- Use the newly created database
USE omtsdb;

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
	rating varchar(10) NOT NULL,
	plot_synopsis varchar(300) NOT NULL,
	director varchar(50) NOT NULL,
	producer varchar(50) NOT NULL,
	supplier_id INTEGER NOT NULL,
	image varchar(100),
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
	isAdmin BOOLEAN DEFAULT false,
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
(1, 'Silver City Toronto','123-456-789', '1200 Yonge St.', 'Toronto', 'A1B 2C3'),
(2, 'Bloor Street Cinemas','123-456-789', '800 Bloor St.', 'Toronto', 'A1B 2C3'),
(3, 'Yorkdale Malls Cinema','123-456-789', '12 Yorkdale St.', 'Toronto', 'A1B 2C3'),
(4, 'The Beaches Odeon','123-456-789', '14 Beach St.', 'Toronto', 'A1B 2C3'),
(5, 'Cineplex Cinema Yonge-Bloor', '123-456-789', '10 Dundas St. E', 'Toronto', 'A1B 2C3');

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
(12, 1, 200, 'Large', 4),
(13, 1, 75, 'Large', 5),
(14, 2, 25, 'Small', 5),
(15, 3, 150, 'Large', 5),
(16, 4, 50, 'Medium', 5);

-- Inserting some suppliers
INSERT INTO supplier VALUES
(1, 'Warner Bros.', 'Bay St.', 'Toronto', 'A1B 2C3', 'John', 'Smith', '123-456-789'),
(2, 'Entertainment One', 'Yonge St.', 'Toronto', 'A1B 2C3', 'Jane', 'Doe', '123-456-789'),
(3, 'Teletoon', 'Queen St.', 'Toronto', 'A1B 2C3', 'Ryan', 'Cooper', '123-456-789');

-- Inserting some movies
INSERT INTO movie VALUES
(1, 'The Prestige', 21039, 'R', 'After a trick goes wrong, two magicians have the feud of the century.', 'Christopher Nolan', 'Emma Thomas', 1, 'assets/img/prestige.jpg'),
(2, 'Black Panther', 21453, 'PG', 'The Black Panther must fight for his country against a long lost enemy.', 'Ryan Coogler', 'Kevin Feige', 2, 'assets/img/panther.jpg'),
(3, 'Pitch Perfect 3', 13314, 'R', 'The gang gets back together for one final singing tour.', 'Trish Sie', 'Elizabeth Banks', 1, 'assets/img/perfect.jpg'),
(4, 'Pacific Rim Uprising', 15147, 'PG', 'The humans must once again use their giant robots to fight off enemy Precursors.', 'Steven S. DeKnight', 'John Boyega', 3, 'assets/img/uprising.jpg'),
(5, 'IT', 21557, 'R', 'Pennywise makes a horrifying return to the big screen in one of the best horror movies of the year.', 'Andy Muschietti', 'Roy Lee', 1, 'assets/img/it.jpg'),
(6, 'Peter Rabbit', 13511, 'PG13', 'Peter and his furry friends go on a fun adventure through the neighbourhood.', 'Will Gluck', 'Zareh Nalbandian', 3, 'assets/img/rabbit.jpg'),
(7, 'Tomb Raider', 15819, 'PG13', 'Watch Laura Crofts return to the big screen in this thrilling adventure.', 'Roar Uthaug', 'Graham King', 3, 'assets/img/tomb.jpg'),
(8, 'Shape of Water', 20309, 'R', 'An unsuspecting love story between a mute human and humanoid amphibian.', 'Guillermo del Toro', 'J. Miles. Dale', 2, 'assets/img/water.jpg');

-- Inserting some movie runs
INSERT INTO movie_run VALUES
(1, 2018-02-16, 2018-04-18, 2, 1),
(2, 2018-03-15, 2018-05-27, 4, 2),
(3, 2017-12-21, 2018-04-07, 3, 4),
(4, 2018-01-12, 2018-04-01, 1, 3),
(5, 2018-02-16, 2018-04-18, 2, 2),
(6, 2018-03-15, 2018-05-27, 4, 1);

-- Inserting some actors
INSERT INTO actor VALUES
('John Boyega', 4),
('Hugh Jackman', 1),
('Christian Bale', 1),
('Chadwich Bosman', 2),
('Anna Kendrick', 3),
('Andy Serkis', 2),
('Jaeden Lieberher', 5),
('Rose Byrne', 6),
('Alicia Vikander', 7),
('Sally Hawkins', 8);

-- Inserting some showings
INSERT INTO showing VALUES
(1, 10, 20000, 2018-05-02, 1, 5),
(2, 33, 80000, 2018-04-01, 2, 11),
(3, 19, 120000, 2018-05-12, 3, 1),
(4, 9, 33000, 2018-04-29, 4, 3),
(5, 4, 24500, 2018-04-13, 2, 5),
(6, 41, 51500, 2018-05-22, 3, 8),
(7, 108, 40000, 2018-04-27, 4, 12),
(8, 20, 73000, 2018-05-02, 5, 10),
(9, 2, 110000, 2018-03-29, 8, 2),
(10, 31, 53000, 2018-06-02, 6, 4),
(11, 17, 21500, 2018-05-02, 5, 6),
(12, 49, 123000, 2018-04-02, 7, 9),
(13, 15, 80000, 2018-04-29, 8, 5);

-- Inserting some customers
INSERT INTO customer VALUES
(1, 'John', 'Dale', 'Avenue Rd.', 'Toronto', 'A1B 2C3', '123-456-789', 'jdale@rogers.com', 'moviefan', '5483-3912-4921-0819', '08/20','456', false),
(2, 'Jane', 'Steel', 'Yonge St.', 'Toronto', 'A1B 2C3', '123-456-789', 'jsteel@gmail.com', 'movieguy', '7356-1475-8416-1783', '04/19', '127', true),
(3, 'Emma', 'Johnson', 'Duffrin Ave.', 'Toronto', 'A1B 2C3', '123-456-789', 'ejohnson@yahoo.ca', 'ilikemovies', '7823-9463-1689-1635', '11/21', '724', false),
(4, 'Matthew', 'Brown', 'Avenue Rd.', 'Toronto', 'A1B 2C3', '123-456-789', 'mbrown@rogers.com', 'fanofmovies', '5425-1948-4612-5223', '10/18', '522', false),
(5, 'Becky', 'Davis', 'King St. W.', 'Toronto', 'A1B 2C3', '123-456-789', 'bdavis@gmail.com', 'password', '8934-2436-3547-8456', '07/19', '736', false),
(6, 'Jared', 'Miller', 'Lawrence Ave.', 'Toronto', 'A1B 2C3', '123-456-789', 'jmiller@rogers.com', 'dogsname', '2034-7456-8375-1648', '09/19', '536', true),
(7, 'Robert', 'Saunders', '19 Whithall Rd.', 'Toronto', 'A1B 2C3', '123-456-789', 'robert@admin.com', '12345', '123456789', '1234', '123', true),
(8, 'Robert', 'Saunders', '19 Whithall Rd.', 'Toronto', 'A1B 2C3', '123-456-789', 'robert@notadmin.com', '12345', '123456789', '1234', '123', false);

-- Inserting some reservations
INSERT INTO reservation VALUES
(1, 3, 7, 1),
(2, 1, 1, 4),
(3, 4, 4, 3),
(4, 1, 5, 4),
(5, 2, 2, 5),
(6, 10, 7, 3),
(7, 1, 6, 1),
(8, 3, 3, 3),
(9, 2, 1, 5);

-- Inserting some movie reviews
INSERT INTO review VALUES
(1, 91, 'Very cool, great acting, insane twist ending.', 1, 1),
(2, 87, 'Awesome effects with a very powerful message.', 1, 2),
(3, 42, 'Very dissapointing compared to the first 2, was expecting more.', 3, 3),
(4, 65, 'Great action scenes, a good, mind numbing movie.', 4, 4),
(5, 22, 'Not a huge fan, was forced to go watch with my family.', 4, 3),
(6, 86, 'Really interesting, I love movies from this time period.', 3, 1),
(7, 30, 'Seemed pretty pointless with no real plot, just giants fighting.', 5, 4),
(8, 92, 'Incredible movie with an amazing cast, very excited for the sequel.', 3, 2),
(9, 89, 'Awesome film, best action in a movie in a long time.', 4, 2),
(10, 40, 'Great singing but lacking compared to the first two, some of my favourite movies ever.', 5, 3),
(11, 50, 'Not as good as the first but still alright, decent acting.', 1, 4),
(12, 70, 'Was okay, I didnt really understand the ending though.', 5, 1);
