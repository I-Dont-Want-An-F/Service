 -- created by dylan mount

--select professors that teach a certain class
Select name from  users, userclass, class
where users.position = 'professor' 
and userclass.classID=class.ID 
and userclass.userID=users.ID
and class.shortName = 'cs 262';

--select certain classes a student is taking
Select shortName from  users, userclass, class
where users.position = 'student' 
and users.name = 'john'
and userclass.classID=class.ID 
and userclass.userID=users.ID
and role= 'taking';

--select certain classes a student has completed
Select shortName from  users, userclass, class
where users.position = 'student' 
and users.name = 'john'
and userclass.classID=class.ID 
and userclass.userID=users.ID
and role= 'completed';

--select all post for a certain class
select text from post, class
where post.classID=class.ID
and class.shortName='cs 112';

--select all comments for a certain class 
select text from post, class
where post.classID=class.ID
and class.shortName='cs 112'
and post.question = false;

--select all questions for a certain class
select text from post, class
where post.classID=class.ID
and class.shortName='cs 112'
and post.question = true;

--select the ratings for a certain class 
select stars, hw from rating, class
where class.shortName = 'cs 112'
and class.ID=rating.classID;