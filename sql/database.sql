    --Database designed by Dylan 
-- 

DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS rating;
DROP TABLE IF EXISTS userclass;
DROP TABLE IF EXISTS messagerooms;
DROP TABLE IF EXISTS messages;
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
    username varchar(50),
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
    stars integer, --out of 5 
    hw varchar(10),  --easy medium hard
	dif integer, --out of 5 
	book varchar(50) --varies 
     --need to finialze what stats we want 
	);

CREATE TABLE post(
    ID integer PRIMARY KEY, 
    classID integer references class(ID),
    question boolean,
    userID integer references users(ID),
    date integer,
    text varchar(1000)
);

create table reply(
    ID integer PRIMARY KEY, 
    postID integer references post(ID),
    userID integer references users(ID),
    date integer,
    text varchar(1000)
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
    date integer,
    text varchar(250)
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

 --classes
insert into class values(1,'Intro to data Structures', 'CS 112', 'CS');
insert into class values(2,'Software Engineering', 'CS 262', 'CS');
insert into class values(3,'Intro to Computer Architecture', 'ENGR 220','ENGR');
insert into class values(4, 'Applied Computing', 'CS 104', 'CS');
insert into class values(5, 'Intro to Computing', 'CS 108','CS');
insert into class values(6, 'Calculus 1', 'MATH 171', 'MATH');


--users
insert into users values(1,'john','abc12','abc12@calvin.edu', 'student');
insert into users values(2, 'Derek Schuurman','derek.schurrman', 'derek.schurrman@calvin.edu', 'professor');
insert into users values(3, 'Keith VanderLinden','keith.vanderlinden', 'keith.vanderlinden@calvin.edu', 'professor');
insert into users values(4, 'Chris Moseley','chris.moseley', 'chris.moseley@calvin.edu', 'professor');
insert into users values(5, 'Victor Norman','victor.norman', 'victor.norman@calvin.edu', 'professor');
insert into users values(6, 'Mark Michmerhuizen', 'mark.michmerhuizen', 'mark.michmerhuizen@calvin.edu', 'professor');
insert into users values(7, 'joe','def12', 'def12@calvin.edu', 'studnent');

--userclass 
insert into userclass values(1,1,1,'taking');
insert into userclass values(2,2,2,'completed');
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

--stats 
insert into rating values(1,1,4.5,'weeky',2.9,'not required but recommended'); --cs 112
insert into rating values(2,2,4.8,'weekly',3.2,'not required'); --cs 262
insert into rating values(3,3,2.1,'never',4.3,'none'); --engr 220
insert into rating values(4,4,3.0,'daily',2.5,'none'); -- cs 104
insert into rating values(5,5,4.8,'weekly',3.0,'Online resource'); --cs 108 
insert into rating values(6,6,4.5,'weekly',2.8,'not required'); --math 271


--post 
insert into post values(1,1,true,1,11202022, 'is the professor helpful'); --cs 112
insert into post values(2,1,false,1,11202022, 'this class is boring');  --cs 112 
insert into post values(3,1,true,1,11202022, 'Should I make lab 1 easier'); --cs 112
insert into post values(4,1, false,2,11202022, 'there is no textbook'); --cs 112

insert into post values(5,2,false,1,11072022,'I love learning JavaScript'); -- cs 262 
insert into post values(6,2,true,7,11072022, 'Are you guys ready for the presentation?'); --cs  262

insert into post values(7,3,false,1,11072022, 'this class is boring');  --engr 220 comment
insert into post values(8,3,true,7,11072022, 'Should I make lab 1 easier'); --engr 220 question 

insert into post values(9,4, false,1,11072022, 'This class is hard'); -- cs 104 comment 
insert into post values(10,4,false,7,11072022,'When is this class offered'); --cs 104 question 

insert into post values(11,5,true,1,11072022, 'Very helpful class'); --cs 108 comment 
insert into post values(12,5,false,7,11072022, 'I deleted my Thonny! How can I fix this');  --cs 108 question 

insert into post values(13,6,true,1,11072022, 'Very easy if you took calc in high school'); --math 171 comment 
insert into post values(14,6, false,7,11072022, 'What is the best way to study for the tests'); --math 171 question 
 


--reply
-- ID postID user ID data text 
insert into reply values(1,1,2,10252022,'yes'); --cs 112 
insert into reply values(15,1,2,102520022,'second reply');
insert into reply values(2,2,2,102520022,'I would disagree');
insert into reply values(16,2,2,102520022,'second reply');
insert into reply values(3,3,2,102520022,'please');
insert into reply values(17,3,2,102520022,'second reply');
insert into reply values(4,4,2,102520022,'Im glad I dont have to buy one');
insert into reply values(18,4,2,102520022,'second reply');

insert into reply values(5,5,2,102520022,'me too'); --cs 262 
insert into reply values(19,5,2,102520022,'second reply');
insert into reply values(6,6,2,102520022, 'Yes. My group practiced alot');
insert into reply values(20,6,2,102520022,'second reply');

insert into reply values(7,7,2,102520022,'Agreed');--engr 220
insert into reply values(21,7,2,102520022,'second reply');
insert into reply values(8,8,2,102520022,'Yes');
insert into reply values(22,8,2,102520022,'second reply');

insert into reply values(9,9,2,102520022,'Not if you have a study group'); --cs 104
insert into reply values(23,9,2,102520022,'second reply');
insert into reply values(10,10,2,102520022,'Try checking moodle');
insert into reply values(24,10,2,102520022,'second reply');

insert into reply values(11,11,2,102520022,'I still use the skills learned');--cs 108
insert into reply values(25,11,2,102520022,'second reply');
insert into reply values(12,12,2,102520022,'fall and spring');
insert into reply values(26,12,2,102520022,'second reply');

insert into reply values(13,13,2,102520022,'I would disagree');--math 171
insert into reply values(27,13,2,102520022,'second reply');
insert into reply values(14,14,2,102520022,'review pratice problems');
insert into reply values(28,14,2,102520022,'second reply');

insert into messagerooms(ID, userOne, userTwo) values(1,1,7);
insert into messages(roomID, sender, date, text) values( 1, 1, 12, 'hello');
insert into messages(roomID, sender, date, text) values( 1, 7, 13, 'hi');
