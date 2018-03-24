// constructs
// integrity constraint
// domain types
// char(n)
// varchar(n)
// int
// smallint
// decimal(p,d)
// real, double precision
// float(n)

-- relational schema
-- Creating the theatre complex
CREATE TABLE theatre_complex (
	ID INTEGER NOT NULL,
	name varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	a_number INTEGER NOT NULL,
	a_street varchar(255) NOT NULL,
	a_city varchar(255) NOT NULL, 	PRIMARY KEY(f_name, l_name, movie_title),
	a_postal_code varchar(255) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE theatre (
	theatre_num INTEGER NOT NULL,
	max_seats INTEGER NOT NULL,
	theatre_complex_ID INTEGER NOT NULL,
	screen_size varchar(255) NOT NULL,
	FOREIGN KEY (theatre_complex_ID) REFERENCES theatre_complex(ID),
	PRIMARY KEY (theatre_num)
);

CREATE TABLE movie (
	ID INTEGER NOT NULL,
	title varchar(255) NOT NULL,
	rating varchar(255) NOT NULL,
	run_time INTEGER NOT NULL,
	plot_synopsis varchar(255) NOT NULL,
	director varchar(255) NOT NULL,
	producer varchar(255) NOT NULL,
	supplier varchar(255) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE actor (
	f_name varchar(255) NOT NULL,
	l_name varchar(255) NOT NULL,
	movie_title varchar(255) NOT NULL,
	FOREIGN KEY(movie_title) REFERENCES Movie(title),
	PRIMARY KEY(f_name, l_name)
);

CREATE TABLE showing (
	theatre_num INTEGER NOT NULL,
	start_time varchar(255) NOT NULL,
	seats_avail INTEGER NOT NULL,
	FOREIGN KEY(theatre_num) REFERENCES theatre (theatre_num),
	PRIMARY KEY(seats_avail, start_time)
);

CREATE TABLE review (
	ID INTEGER NOT NULL,
	rating INTEGER NOT NULL,
	description varchar(255),
	PRIMARY KEY(ID)
);

CREATE TABLE customer (
	account_num INTEGER NOT NULL,
	f_name varchar(255) NOT NULL,
	l_name varchar(255) NOT NULL,
	a_number INTEGER NOT NULL,
	a_street varchar(255) NOT NULL,
	a_city varchar(255) NOT NULL,
	a_postal_code varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	cc_number INTEGER NOT NULL,
	cc_expiry varchar(255) NOT NULL,
	PRIMARY KEY(account_num)
);

-- GENERATE SEED DATA
insert into instructor values ();
drop table
delete from student
alter table
