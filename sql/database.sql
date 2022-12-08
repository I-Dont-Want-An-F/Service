    --Database designed by Dylan 
-- 

DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS rating;
DROP TABLE IF EXISTS userclass;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS messagerooms;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS class;


-- Create the schema.
CREATE TABLE class (
	ID integer PRIMARY KEY,
	longName varchar(50),
    shortName varchar(10),
    subject varchar(20)
	);

CREATE TABLE users (
	ID integer PRIMARY KEY, 
    name varchar(50),
    username varchar(50) unique,
    emailAddress varchar(50) NOT NULL,
    position varchar(20)
	);

CREATE TABLE userclass (
	ID integer PRIMARY KEY, 
    userID integer references users(ID),
	classID integer references class(ID),
    role varchar(15)
	);

CREATE TABLE rating (
	ID integer PRIMARY KEY,
    classID integer references class(ID),
    userID integer references users(ID),
    stars integer, --out of 5 
    hw integer,  --easy medium hard
	dif integer, --out of 5 
	book varchar(50) --varies 
     --need to finialze what stats we want 
	);

CREATE TABLE post(
    ID integer PRIMARY KEY, 
    classID integer references class(ID),
    question boolean,
    userID integer references users(ID),
    postTime date,
    text text 
);

create table reply(
    ID integer PRIMARY KEY, 
    postID integer references post(ID),
    userID integer references users(ID),
    postTime date,
    text text
    );

create table messagerooms(
	ID integer PRIMARY KEY,
    userOne integer references users(ID),
	userTwo integer references users(ID)
    );

create table messages(
	ID  integer PRIMARY KEY ,
    roomID integer references messagerooms(ID),
	sender integer references users(ID),
    postTime date,
    text text
);

-- Allow users to select data from the tables.
GRANT SELECT ON class TO PUBLIC;
GRANT SELECT ON users TO PUBLIC;
GRANT select ON userclass to PUBLIC;
GRANT SELECT ON post to PUBLIC; 
GRANT SELECT ON rating to PUBLIC; 
GRANT SELECT ON messages to PUBLIC;
GRANT SELECT ON messagerooms to PUBLIC;
GRANT SELECT ON messages to PUBLIC;

-- Add sample records.

 --classes(ID, longname,shortName, subject)
insert into class values(1,'Intro to Data Structures', 'CS 112', 'computer science');
insert into class values(2,'Software Engineering', 'CS 262', 'computer science');
insert into class values(3,'Intro to Computer Architecture', 'ENGR 220','engineering');
insert into class values(4, 'Applied Computing', 'CS 104', 'computer science');
insert into class values(5, 'Intro to Computing', 'CS 108','computer science');
insert into class values(6, 'Calculus 1', 'MATH 171', 'math');
insert into class values(7, 'Calculus 2', 'MATH 172', 'math');
--no rating, proff, etc for these ones 
insert into class values(8,'Statics and Dynamics', 'ENGR 202','engineering');
insert into class values(9,'Intro to Ciruit Analysis and Electronics', 'ENGR 204','engineering');
insert into class values(10,'Intro to Conservation Laws & Fluid Mechanics', 'ENGR 209','engineering');
insert into class values(11,'Written Rhetoric', 'ENGL 101','english');
insert into class values(12,'Written Rhetoric 2', 'ENGL 102','english');
insert into class values(13,'Biblical Literature and Theology', 'REL 121','religion');




--users (ID, name, username, emailAddress, postion)
insert into users values(1,'john','abc12','abc12@calvin.edu', 'student');
insert into users values(2, 'Derek Schuurman','derek.schurrman', 'derek.schurrman@calvin.edu', 'professor');
insert into users values(3, 'Keith VanderLinden','keith.vanderlinden', 'keith.vanderlinden@calvin.edu', 'professor');
insert into users values(4, 'Chris Moseley','chris.moseley', 'chris.moseley@calvin.edu', 'professor');
insert into users values(5, 'Victor Norman','victor.norman', 'victor.norman@calvin.edu', 'professor');
insert into users values(6, 'Mark Michmerhuizen', 'mark.michmerhuizen', 'mark.michmerhuizen@calvin.edu', 'professor');
insert into users values(7, 'joe','def12', 'def12@calvin.edu', 'studnent');
insert into users values(8, 'joe', 'xyz15', 'xyz15@calvin.edu','student');
 
--userclass (ID, userID, classID, role)
insert into userclass values(1,1,1,'taking');
insert into userclass values(2,1,2,'completed');
insert into userclass values(3,3,2,'teaching');
insert into userclass values(4,4,6,'teaching');
insert into userclass values(5,5,1,'teaching');
insert into userclass values(6,6,3,'teaching');
insert into userclass values(7,7,2,'teaching');
insert into userclass values(8,3,5,'teaching'); --cs 108
insert into userclass values(13,2,5,'teaching'); --cs 108
insert into userclass values(9,2,4,'teaching');
insert into userclass values(10,1,3,'taking');
insert into userclass values(11,1,4,'taking');
insert into userclass values(12,1,5,'completed');

--stats (ID, classID, userID stars, hw, dif, book)
--cs 112
insert into rating values(1,1,1,4.5,5,2.9,'not required'); 
insert into rating values(2,1,7,4.8,20,3.2,'not required'); 
insert into rating values(3,1,8,2.1,1,4.3,'not required');
--cs 262
insert into rating values(4,2,1,4.5,5,2.9,'not required');  
insert into rating values(5,2,7,4.8,20,3.2,'not required'); 
insert into rating values(6,2,8,2.1,1,4.3,'not required');
--engr 220
insert into rating values(7,3,1,4.5,5,2.9,'not required');  
insert into rating values(8,3,7,4.8,20,3.2,'not required'); 
insert into rating values(9,3,8,2.1,1,4.3,'not required');
-- cs 104
insert into rating values(10,4,1,4.5,5,2.9,'not required');  
insert into rating values(11,4,7,4.8,20,3.2,'not required'); 
insert into rating values(12,4,8,2.1,1,4.3,'not required');
--cs 108 
insert into rating values(13,5,1,4.5,5,2.9,'not required');  
insert into rating values(14,5,7,4.8,20,3.2,'not required'); 
insert into rating values(15,5,8,2.1,1,4.3,'not required');
--math 271
insert into rating values(16,6,1,3.0,3,2.5,'not required'); 
insert into rating values(17,6,7,4.8,12,3.0,'not required'); 
insert into rating values(18,6,8,4.5,16,2.8,'not required');  


--post (ID,classID,question, userID,postTime)
insert into post values(1,1,true,1,(select now()), 'is the professor helpful'); --cs 112
insert into post values(2,1,false,1,(select now()), 'this class is boring');  --cs 112 
insert into post values(3,1,true,1,(select now()), 'Should I make lab 1 easier'); --cs 112
insert into post values(4,1, false,2,(select now()), 'there is no textbook'); --cs 112

insert into post values(5,2,false,1,(select now()),'I love learning JavaScript'); -- cs 262 
insert into post values(6,2,true,7,(select now()), 'Are you guys ready for the presentation?'); --cs  262

insert into post values(8,3,false,1,(select now()), 'this class is boring');  --engr 220 comment
insert into post values(7,3,true,7,(select now()), 'Should I make lab 1 easier'); --engr 220 question 

insert into post values(9,4, false,8,(select now()), 'This class is hard'); -- cs 104 comment 
insert into post values(10,4,false,7,(select now()),'When is this class offered'); --cs 104 question 

insert into post values(11,5,true,7,(select now()), 'Very helpful class'); --cs 108 comment 
insert into post values(12,5,false,8,(select now()), 'What coding language is used in this class');  --cs 108 question 

insert into post values(13,6,true,1,(select now()), 'Very easy if you took calc in high school'); --math 171 comment 
insert into post values(14,6, false,7,(select now()), 'What is the best way to study for the tests'); --math 171 question 
 


--reply (
-- ID postID user ID data text 
insert into reply values(1,1,2,(select now()),'yes'); --cs 112 
insert into reply values(15,1,2,(select now()),'second reply');
insert into reply values(2,2,2,(select now()),'I would disagree');
insert into reply values(16,2,2,(select now()),'second reply');
insert into reply values(3,3,2,(select now()),'please');
insert into reply values(17,3,2,(select now()),'second reply');
insert into reply values(4,4,2,(select now()),'Im glad I dont have to buy one');
insert into reply values(18,4,2,(select now()),'second reply');

insert into reply values(5,5,2,(select now()),'me too'); --cs 262 
insert into reply values(19,5,2,(select now()),'second reply');
insert into reply values(6,6,2,(select now()), 'Yes. My group practiced alot');
insert into reply values(20,6,2,(select now()),'second reply');

insert into reply values(7,7,2,(select now()),'Agreed');--engr 220
insert into reply values(21,7,2,(select now()),'second reply');
insert into reply values(8,8,2,(select now()),'Yes');
insert into reply values(22,8,2,(select now()),'second reply');

insert into reply values(9,9,2,(select now()),'Not if you have a study group'); --cs 104
insert into reply values(23,9,2,(select now()),'second reply');
insert into reply values(10,10,2,(select now()),'Try checking moodle');
insert into reply values(24,10,2,(select now()),'second reply');

insert into reply values(11,11,2,(select now()),'I still use the skills learned');--cs 108
insert into reply values(25,11,2,(select now()),'second reply');
insert into reply values(26,12,7,(select now()),'I really enjoyed coding in python');
insert into reply values(12,12,7,(select now()),'This class using python');

insert into reply values(13,13,2,(select now()),'I would disagree');--math 171
insert into reply values(27,13,2,(select now()),'second reply');
insert into reply values(14,14,2,(select now()),'review pratice problems');
insert into reply values(28,14,2,(select now()),'second reply');

--message room 
insert into messagerooms(ID, userOne, userTwo) values(1,1,7);
insert into messages(ID, roomID, sender, postTime, text) values(1, 1, 1, (select now()), 'hello');
insert into messages(ID, roomID, sender, postTime, text) values(2, 1, 7, (select now()), 'hi');

