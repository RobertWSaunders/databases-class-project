# databases-class-project

This is where our CMPE 332 (Database Management Systems) course project lives! This project is intended to give students an opportunity to participate in all phases of the development of a database application. The development of the application will require you to use ER modeling techniques, relational modeling techniques, SQL, and to access your database via a web application.

## Contents

- [Usage](#usage)
- [Project Requirements](#project-requirements)
	- [Data Requirements](#data-requirements)
	- [Functional Requirements](#functional-requirements)
- [Entity Relationship Diagram](#er-diagram)
- [Course Notes](#course-notes)
	- [Data Definition Language](#data-definition-language)
	- [Data Manipulation Language](#data-manipulation-language)
	- [Security](#security)
	- [Storage](#storage)
	- [File Organization](#file-organization)
	- [Indexing](#indexing)
- [Contributing](#contributing)
- [License](#license)

## Usage

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

Administrators:

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

## Course Notes

### Data Definition Language

both flavours of sql
transitioning er diagrams to a schema
strong entity sets just reduce to a schema with the same shit
weak entity sets reduce to a table with a primary key for the strong identifying entity set
many to many relationships is represented with attributes for the primary keys of the two participating entity sets in additon to the descriptive attributes
one to many relationships that are total just add the primary key of the one side
one to one relationships either side can have the primary key, have to watch out for null values in this, partial participation
schema for weak relationships are redundant because the weak entity set already contains the keys of the identifying set
multi valued attributes have a foreign key to their table and an attribute for the value

### Data Manipulation Language

case insensitive
select query lists attributes desired in the result of a query
insert distinct to remove duplicates from query result
* is all attributes
select clause can contain arithmetic expressions
where clause specifies conditions that the result must satisfy
where clauses can be combined using logical connectives and, or and not
from clause lists the relations involved in the query
can use the dot syntax if the columns are the same name
natural join matches tuples with same values for all common attributes and retains only one copy of each common column
as clause allows renaming of attributes and relations, the keyword can be ommitted
order by clause can be used to sort the display of tuples
you can also perform set operations, union for example
can also perform nested queries, using the in (not for difference) clause
aggregate functions are available on attributes (columns)
- avg
- min
- max
- sum
- count
- group by
- having
can have set comparisons
- some
- all
integrity contraints
- not NULL
- check(P), p is a predicate
referential integrity
- cascading actions in referential integrity
- set null
manipulating data
- delete from operation
- insertion (insert into)
- updates (update ...)
Views
- hide certain data from the view of certain users
- use "create view v as ..."
- its like a placeholder/stub
- improves reusability

### Security

- user authentication
- data encryption
- access control
- firewall policies
- intrusion detection

privacy is the ability for individuals to control the terms under which their personal information is aquired and used

threats
- loss of integrity
- loss of availability
- loss of confidentiality

DBA (admin)
- responsible for the overall security of the database system

access control models
- discretionary access control (dac)
	- owner just decides
- mandatory access control (mac)
	- determined by a central authrority to given set of policies
- role based access control (rbac)
	- instance of mac scheme, roles created for various job functions

grant statement used to author authorization
not on specific tuples
revoke is counterpart to grant
grant option for propagation of privileges
can use views to limit users tuple access
commonly used model for multilevel security is Bell-LaPadula, this classifies each subject and object into one of several security classes, simple security property, star property
create role and destroy role
role can be granted to users as well as other roles
privileges are associated with roles
protecting against sql injections
- prepared statements
- restricted access control

### Storage

physical storage
classification criteria for storage media
- speed
- cost
- reliability
	- volatile storage
	- non volatile storage

data is store on magnetic disk and read into main memory when requested, written back to the disk when contents are modified

time to access a disk block:
seek time + rotational delay + transfer time
key to lower I/O cost is to reduce seek time and rotational delay

optimizing disk access
- blocks (contiguous sequence of sectors from a single track)

file organization
- optimize block access time by organizing the pages to correspond to how data will be accessed (store related information together on the same or nearby cylinders)
- disk arm scheduling

database file is partitioned into fixed length blocks
tries to keep blocks in main memory, wants to minimize block transfers

buffer
portion of main memory available to store copies of disk blocks

buffer manager
subsystem responsible for allocating buffer space in main memory
programs call on the buffer manager when they need a block from disk
- if the block is already in the buffer, buffer manager returns the address of the block in main memory
- if the block is not in the buffer, the buffer manager
	- allocates space in the buffer for the block
		1. replacing (throwing out) some other block, if required
		2. replaced block is then written back to disk only if it was modified since the most recent time that it was written
	- reads the block from the disk to the buffer and returns the address of the block in main memory to requester

### File Organization

file of records
- each relation is typically stored as a file
- stored as a sequence of records (tuples) mapped onto disk blocks
- file organization is a method of arranging records in a file

represented within the file in two scenarios
- fixed length records
- variable length records

free lists are used to track deleted records

record types that allow variable lengths for one or more fields such as strings (varchar) result in records in records that are different lengths

slotted page header/structure

organizing records within a file
- stored in a heap (no ordering really)
- sequential ordering based on search key
	- uses overflow block with pointers to keep track
	- if there are a lot of overflow blocks that hurts performance
	- we reorganize the file from time to time to restore the sequential order

### Indexing

indices
- objective is to provide quick access to commonly access items
very similar to commonly accessed items
- often there are several indices that are created
- indices are stored as separate files, need to be updated whenever changes are made to a table, this adds overhead

basics
- search key
	- attribute or set of attributes used to loop up records in a file, may be different from primary key
- index file
	- consists of records (called index entries) of the form ([search-key, pointer to block])
	- two basic kinds of indices
		- ordered indices: search keys are stored in sorted order
		- hash indices: search keys are distributed uniformly across "buckets" using a "hash function".

ordered index
- index entries are stored sorted on the search key value
- associates the key with the records that contain it
- the clustering index (also called the primary index) is an index whose search key defines the order of the index file
- secondary index (non clustering index) is an index whose search key specifies an order different from the sequential order of the file
- a dense index has an index record for every search key in file
- a sparse index contains records for only some search key values
	- first key value in each page

sparse index files vs dense index files
- less space and less maintenance overhead for insertions and deletions
- generally slower than dense index for locating records

- secondary indices have to be dense and are unclustered
- sequential scan on a secondary index is very inefficient

how to create indexes:
create index <index-name> on <relation-name> (<attribute-list>)
drop index <index-name>
most dbms create an index on the primary key automatically
you get some perks from this, can check for duplicates

drawbacks
- performance of an index-sequential file organization degrades as the file size grows, often many overflow blocks
- file re-orgs are necessary to maintain performance, but frequent re-orgs are undesirable

B+ Tree Index
- B+ trees are most popular type of ordered index and are used extensively in DBMSs

advantages:
- balanced tree
- good performance for a variety of queries - point, scan and range

disadvantages:
- extra insertion and deletion overhead, space overhead


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b feature/my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin feature/my-new-feature`
5. Submit a pull request :D

## License

Copyright 2018 Robert Saunders

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
