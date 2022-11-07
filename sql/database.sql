  --Database designed by Dylan 
-- 

DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS rating;
DROP TABLE IF EXISTS userclass;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS class;

-- Create the schema.
CREATE TABLE class (
	ID integer PRIMARY KEY,
	longName varchar(50),
    	shortName varchar(10),
    	subject varchar(50)
	);

CREATE TABLE users (
	ID integer PRIMARY KEY, 
   	name varchar(50),
   	emailAddress varchar(50) NOT NULL,
    	position varchar(20),
	sessiontoken varchar(16)
	);

CREATE TABLE userclass (
	ID integer PRIMARY KEY, 
    	userID integer references users(ID),
	classID integer references class(ID)
	);

CREATE TABLE  rating (
	ID integer PRIMARY KEY,
     	classID integer references class(ID),
    	stars integer, 
    	hw varchar(10)
     --need to finialze what stats we want 
	);

CREATE TABLE post(
    	ID integer PRIMARY KEY, 
    	classID integer references class(ID),
    	question boolean,
    	userID integer references users(ID),
    	date integer,
    	text varchar(200)
);

create table reply(
  	ID integer PRIMARY KEY, 
  	postID integer references post(ID),
    	userID integer references users(ID),
  	text varchar(200)
    );



-- Allow users to select data from the tables.
GRANT SELECT ON class TO PUBLIC;
GRANT SELECT ON users TO PUBLIC;
GRANT select ON userclass to PUBLIC;
GRANT SELECT ON post to PUBLIC; 
GRANT SELECT ON rating to PUBLIC; 


-- Add sample records.

 --classes
insert into class values (1,'intro to data structures', 'cs 112', 'cs');
insert into class values(2,'web devolomnet', 'cs 262', 'cs');
insert into class values(3,'computer engineering', 'engr 220','cs');

--users
insert into users values(1,'john','abc12@calvin.edu', 'student');
insert into users values(2, 'josh', 'def34@calvin.edu', 'professor');

--userclass 
insert into userclass values(1,1,1);
insert into userclass values(2,1,2);
insert into userclass values(3,2,2);

--stats 
insert into rating values(1,1,3.2,'weekly');

--post 
insert into post values(1,1,true,1,11202022, 'is the professor helpful');
insert into post values(2,1,false,1,11202022, 'this class is boring');
insert into post values(3,1,true,1,11202022, 'Should I make lab 1 easier');
insert into post values(4,1, false,2,11202022, 'there is no textbook');
insert into post values(5,2,false,1,10252022,'I really like working on the app');


--reply
insert into reply values(1,1,2,'yes');
