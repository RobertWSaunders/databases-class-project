# databases-class-project

This is where our CMPE 332 (Database Management Systems) course project lives! This project is intended to give students an opportunity to participate in all phases of the development of a database application. The development of the application will require you to use ER modeling techniques, relational modeling techniques, SQL, and to access your database via a web application.

## Project Requirements

The following is taken from our course website, it describes the scope and requirements of the project. You are required to develop a database that can be used to support the Online Movie Ticket Service (OMTS), which is an application for the advance purchase of movie tickets from any local theatre. Customers use the service to find out information about movies currently playing in their city and to order advance tickets for specific showings of the movies.  Your task is to provide the database and related functionality for this application.

### Data Requirements

Your database must, at a minimum, contain information about the following:

* The are multiple theatre complexes in the city. Each theatre complex contains some number of theatres and has a name, address and a phone number. Each theatre in a theatre complex has a theatre number, a maximum number of seats and a screen size (small, medium or large).  You must have at least 3 theatre complexes represented in your project.

* Each current movie has a title, a running time, a rating (G, PG, AA, 14A, R, etc), a plot synopsis, a list of main actors, a director, a production company, the name of the supplier and the start and end dates for the movie's run at the theatre complex. The movie has one or more daily showings at the theatre complex specified by a start time. Each showing has the number of the theatre for the showing, the start time and the number of seats still available.

* A movie supplier has a company name, a company address, a phone number and the name of the contact person at the company.
Movie information remains in the database even if the movie is no longer playing at any theatres.

* Each OMTS customer must register with the service.  Once they have done so, they use the account number and password created to conduct transactions with the service. Each customer has a name, address, phone number, email address, account number, password, credit card number and credit card expiry date.

* Customers make reservations with the service (ie. they purchase movie tickets).   Each reservation contains an account number, a showing, the number of tickets reserved. Assume that reservation records will be retained in the database for later analysis of customer movie viewing patterns.

* Customer reviews for movies.

### Functional Requirements

The OMTS application needs to support two categories of functions - one for members and one for administrators.

Members:

* Make an account including a login id and password

* Browse movies playing at the various theatre complexes

* Purchase some number of tickets for one or more movies showing at one or more theatres

* View their purchases

* Cancel a purchase

* Update their personal details -- ie. modify their profile

* Browse their past rentals

* Add a review for a movie

Administrators

* List all the members

* Remove a member

* Add or update the information for a theatre complex/theatre

* Add movies to the database

* Update where/when movies are showing

* For a particular customer, show their rental history (including current tickets held)

* Find the movie that is the most popular (ie. has sold the * most tickets across all theatres)

* Find the theatre complex that is most popular (ie. has * sold the most tickets across all movies)

These requirements are a minimum.  You may find that you need to add additional data and or functionality to make your application realistic, or to demonstrate that it works.

## Entity Relationship Diagram

Below you can see the entity relationship diagram we designed to fulfill the above requirements:

Relationship sets
relationship participation constraints
descriptive attributes
multivalued attributes
derived attribute
simple and composite attributes
cardinality constraints
- one to one
- one to many
- many to one
- many to many

directed line is one
undirected line signifies many
participation constraints

weak entity sets, have discriminating attributes
specialization vs generalization
disjoint specialization (can only belong to one lower entity set)
overlapping specialization (can belong to more than one lower entity set)

completeness constraint (whether or not a higher level entity needs to belong to one of the lower level entity sets)
total and partial completeness

## Data Definition Language

both flavours of sql
transistioning er diagrams to a schema
strong entity sets just reduce to a schema with the same shit
weak entity sets reduce to a table with a primary key for the strong identifying entity set
many to many relationships is represented with attributes for the primary keys of the two participating entity sets in additon to the descriptive attributes
one to many relationships that are total just add the primary key of the one side
one to one relationships either side can have the primary key, have to watch out for null values in this, partial participation
schema for weak relationships are redundant because the weak entity set already contains the keys of the identifying set
multi valued attributes have a foreign key to their table and an attribute for the value

## Data Manipulation Language

## Naming Conventions


## Other Course Notes

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

Copyright 2018 Robert Saunders

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
