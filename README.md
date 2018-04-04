# databases-class-project

This is where our CMPE 332 (Database Management Systems) course project lives! This project is intended to give students an opportunity to participate in all phases of the development of a database application. The development of the application will requires us to use ER modeling techniques, relational modeling techniques, SQL, and to access your database via a web application.

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

To use the project on your own machine:

1. Clone the project:

	`git clone [url]`

2. Run an Apache server (serves files) and a MySQL instance (our database).

3. Create and setup the database by running `db/init.sql` or by navigating to `/db/install.php` from within your browser (assuming Apache server is running).

4. Enjoy the movie!

## Project Requirements

The following is taken from our course website, it describes the scope and requirements of the project. You are required to develop a database that can be used to support the Online Movie Ticket Service (OMTS), which is an application for the advance purchase of movie tickets from any local theatre. Customers use the service to find out information about movies currently playing in their city and to order advance tickets for specific showings of the movies.  Your task is to provide the database and related functionality for this application.

### Data Requirements

Your database must, at a minimum, contain information about the following:

* The are multiple theatre complexes in the city. Each theatre complex contains some number of theatres and has a name, address and a phone number. Each theatre in a theatre complex has a theatre number, a maximum number of seats and a screen size (small, medium or large). You must have at least 3 theatre complexes represented in your project.

* Each current movie has a title, a running time, a rating (G, PG, AA, 14A, R, etc), a plot synopsis, a list of main actors, a director, a production company, the name of the supplier and the start and end dates for the movie's run at the theatre complex. The movie has one or more daily showings at the theatre complex specified by a start time. Each showing has the number of the theatre for the showing, the start time and the number of seats still available.

* A movie supplier has a company name, a company address, a phone number and the name of the contact person at the company. Movie information remains in the database even if the movie is no longer playing at any theatres.

* Each OMTS customer must register with the service. Once they have done so, they use the account number and password created to conduct transactions with the service. Each customer has a name, address, phone number, email address, account number, password, credit card number and credit card expiry date.

* Customers make reservations with the service (ie. they purchase movie tickets). Each reservation contains an account number, a showing, the number of tickets reserved. Assume that reservation records will be retained in the database for later analysis of customer movie viewing patterns.

* Customer reviews for movies.

### Functional Requirements

The OMTS application needs to support two categories of functions, one for members and one for administrators.

Members:

* Make an account including a login email and password
* Browse movies playing at the various theatre complexes
* Purchase some number of tickets for one or more movies showing at one or more theatres
* View their purchases
* Cancel a purchase
* Update their personal details
* Browse their past purchases
* Add a review for a movie

Administrators:

* List all the members
* Remove a member
* Add or update the information for a theatre complex/theatre
* Add movies to the database
* Update where/when movies are showing
* For a particular customer, show their rental history (including current tickets held)
* Find the movie that is the most popular (i.e. has sold the most tickets across all theatres)
* Find the theatre complex that is most popular (i.e. has sold the most tickets across all movies)

These requirements are a minimum. You may find that you need to add additional data and or functionality to make your application realistic, or to demonstrate that it works.

## Entity Relationship Diagram

Below you can see the entity relationship diagram we designed to fulfill the above requirements:

![OTMS ER Diagram](https://github.com/RobertWSaunders/databases-class-project/blob/master/src/assets/img/ERDiagram.png)

A couple of notes to help read that ER diagram:

- Directed line signifies one.
- Undirected line signifies many.
- Attributes with curly brackets are multivalued.
- Attributes spawning from relationships are descriptive attributes.
- Indented attributes are composite attributes.
- Top level attributes are simple attributes.
- Double line indicates total participation.
- Single line indicate partial participation.
- Identifying relationship is depicted using a double diamond.
- Underlined attributes in strong entity sets are the primary keys.
- Underlined attributes in weak entity sets are the discriminators (partial keys).
- Disjoint specialization is depicted via two lower level entities linked at the triangle.
- Overlapping specialization is depicted via unlinked entities linked at the triangle.
- The written "total" by specialization indicates total completeness (an entity must belong to lower level).

## Course Notes

The following is course notes from the various sections of the course we studied.

> NOTE: Please use at your own risk, they encapsulate everything that I personally needed to write down.

### Data Definition Language

Data definition language allows the specification of information about relations, including:

- The schema for each relation.
- The domain of each attribute.
- Integrity constraints.
- Other information such as:
	- The set of indices to be maintained for each relations.
	- Security and authorization information for each relation.
	- The physical storage structure of each relation on disk.

> NOTE: Data definition language is just a subset of SQL constructs, specifically the database and table creation constructs. The other subset of constructs is the data manipulation language discussed below.

#### Transitioning ER Diagrams to Schema

A common first task after creating an ER diagram is to convert it into DDL to actually create the database. To do that we have to follow some rules specifically pertaining to the cardinality constraints defined in the ER diagram. Follow the rules below:

- Strong entity sets reduce to a schema with all the same attributes.
- Weak entity sets have all of their attributes but also include the primary key of the strong identifying set.

- One to one relationships, the primary key of either entity in the relationship is included in one of the entities.
- One to many relationships, the primary key of the one side is added to the many side.
- Many to many relationships, the primary keys of both sides are added to a new table.

- Simple, composite and derived attributes are just added into entities as themselves.
- Multivalued attributes a new table is created for the attribute with a foreign key for the related entity.

Following those rules you are able to create a schema for an ER diagram.

### Data Manipulation Language

Data manipulation language is the other subset of constructs in SQL that allow you to manipulate data. It must noted that both DDL and DML are case insensitive when writing queries etc.

There are a few important DML clauses that I will touch on below:

- The *select* clause, this lists the desired attributes in the result of a query.

	`SELECT * FROM [tablename]`

 > NOTE: SQL allows duplicates in relations as well as in query results. To force the elimination of duplicates you can use the distinct keyword after select in your query.

- The *where* clause specifies the conditions that the result must satisfy.

	`SELECT * FROM [tablename] WHERE salary > 25000`

- The *from* clause lists the relations involved in the query.

	`SELECT * FROM employee`

- Natural join matches tuples with the same values for all common attributes and retains only one copy of each common column.

Additional operations include:

- Rename operation (as)
- Ordering operation (order by)
- Set operations (union)
- Nested queries
- Difference operation (not)
- Aggregate Functions
	- avg: average value
	- min: minimum value
	- max: maximum value
	- sum: sum of values
	- count: number of values
- Having clause (having)
- Set comparisons (some, all)

Integrity constraints guard against accidental damage to the database by ensuring that authorized changes to the database do not result in a loss of data consistency. A couple of these integrity constraints include:

- NOT NULL

	- Checks if a value is null or not and if it is the database will not allow it.


- CHECK(P)

	- Where P is a predicate, it checks to satisfy the given predicate.


- Referential Integrity

	- Ensures that a value that appears in one relation for a given set of attributes also appears for a certain set of attributes in another relation. Using referential integrity you can perform cascading actions such as `on delete`. `on update`, `set null`, `set default`.

There are lots of ways you can manipulate data as well, see some of those ways below:

- `delete from`
- `insert into`
- `update set`

In some cases it isn't desirable for all users to see the entire logical model (that is, all the actual relations store in the database). A *view* is a mechanism to hide certain data from the view of certain users. Any relation that is note of the conceptual model but is made visible to a user as a "virtual relation" is called a view. You can define a view using `create view [viewname] as [expression]`. A view is very much like a stub. We can use views in our queries as if they were tables. MySQL implementations allow updates only on simple views. The rules for updating a view are as follows:

- The *from* clause has only one database relation.
- The *select* clause contains only attribute names of the relation and does not have any expressions, aggregates or *distinct* specifications.
- Any attribute not list in the *select* clause can be set to null.
- The query does not have a *group by* pr *having* clause.

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
