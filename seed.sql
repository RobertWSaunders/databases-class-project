/*
OTMS Database Seed Data
Group Number: 53
March 28th, 2018
*/

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
INSERT INTO movie VALUES
(1, 'The Avengers', )

-- need to finish this
