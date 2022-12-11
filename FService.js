      
// Set up the database connection.
const pgp = require('pg-promise')();
const db = pgp({
    host: process.env.DB_SERVER,
    port: process.env.DB_PORT,
    database: process.env.DB_USER,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

// Configure the server and its routes.
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());


router.get("/", readHelloMessage);
router.get("/prof/:id", readProf); //selects prof that teach a certain class 
router.get("/classtake/:id", classTake); // selects the classes a student is taking
router.get("/classtook/:id",classTook); //selects the classes a student has taken


router.get("/post/:id", posts); //selects all the posts for a given class
router.post("/createposts", createposts);



router.get("/questions/:id", questions); //selects all the questions for a given class
router.get("/rating/:id", rating);// retuns a rating for a class 
router.get("/classes", classes); //returns all classes 

router.get("/subject/:id", subject); //returns all classes sorted by subject  id is subject 
router.get("/shortname/:id", shortname); //returns all classes sorted by shortname id is shortname 


router.get("/comments/:id", comments);//selects all the comments for a given class
router.post("/createcomments", createcomments); // creates a question created by a user
router.put("/updatecomments", updatecomments); // update a question created by a user

router.get("/reply/:id", reply); //returns the reply to a comment
router.post("/createreply", createreply); // creates a question created by a user
router.put("/updatereply", updatereply); // update a question created by a user

router.get("/messagerooms/:id", messageRooms);
router.get("/messages/:id", messages);
router.post("/sendmessage", sendmessage);

app.use(router);
app.use(errorHandler);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.

function errorHandler(err, req, res) {
    if (app.get('env') === "development") {
        console.log(err);
    }
    res.sendStatus(err.status || 500);
}

function returnDataOr404(res, data) {
    if (data == null) {
        res.sendStatus(404);
    } else {
        res.send(data);
    }
}

function readHelloMessage(req, res) {
    res.send('This is teams F database');
}

//selects proff that teach a certain class 
function readProf(req, res, next) {
    db.many("Select name from  users, userclass, class where users.position = 'professor' and userclass.classID=class.ID  and userclass.userID=users.ID and class.shortName =${id}", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

//selects the classes a user is taking 
function classTake(req, res, next) {
    db.many("Select shortName, class.ID, longname, subject  from  users, userclass, class WHERE users.position = 'student' AND users.username = ${id} and userclass.classID=class.ID and userclass.userID=users.ID and role= 'taking'", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

 //selects the classes a user has completed
function classTook(req, res, next) {
    db.many(" Select shortName, class.ID, longname, subject from  users, userclass, class where users.position = 'student' and users.username = ${id} and userclass.classID=class.ID  and userclass.userID=users.ID and role= 'completed'", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

 //selects all posts for a certain class 
 function posts(req, res, next) {
    db.many("select text,post.ID, users.username from post, class, users where post.classID=class.ID and class.shortName =${id} and post.userID=users.ID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function createposts(req, res, next) {
    db.many("insert into post(ID, classID, question, userID, postTime, text) values(${body.ID}, (${body.classID}), false , (select users.id from users where username = 'abc12'),  (select now()), ${body.text});", req)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

//selects all comments for a certain class 
function comments(req, res, next) {
    db.many("select text,post.ID,users.username from post, class,users where post.classID=class.ID and class.shortName =${id} and post.question = false and post.userID=users.ID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function createcomments(req, res, next) {
    db.many("insert into text,post.ID,users.username from post, class,users where post.classID=class.ID and class.shortName =${id} and post.question = false and post.userID=users.ID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function updatecomments(req, res, next) {
    db.many("UPDATE text,post.ID,users.username from post, class,users where post.classID=class.ID and class.shortName =${id} and post.question = false and post.userID=users.ID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}


//selects all the questions for a certian class
function questions(req, res, next) {
    db.many("select text,post.ID, users.username from post, users, class where post.classID=class.ID and class.shortName =${id} and post.question = true and post.userID=users.ID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}


//selects the rating for a certain class
function rating(req, res, next) {
    db.many("select stars, hw, dif, book from rating, class where class.shortName =${id} and class.ID=rating.classID", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

//selects all the classes 
function classes(req, res, next) {
    db.many("select * from class", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

//selects the reply 
function reply(req, res, next) {
    db.many("select text,reply.ID, users.username  from reply,users where reply.userID=users.ID and reply.postID= ${id}", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}



function createreply(req, res, next) {
    db.many("insert into reply(ID, postID, userID, postTime, text) values(${body.ID},  (select post.id from post where classID = 1  AND text = 'is the professor helpful'),  (select users.id from users where username = 'abc12'), (select now()), ${body.text});", req)
    
    .then(data => {
        res.sendStatus(200);
    })
    .catch(err => {
        next(err);
    })
}


function updatereply(req, res, next) {
    db.many("UPDATE * from reply where reply.postID= ${id}", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

//returns all classes by subject 
function subject(req, res, next) {
    db.many("Select * from class where subject=${id}", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

//returns all classes by shortname
function shortname(req, res, next) {
    db.many("Select * from class where shortName=${id}", req.params)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}




function messageRooms(req, res, next){
    db.many("select id, (select username from users where id = userOne) AS userOne, (select username from users where id = userTwo) AS userTwo from messagerooms where (userOne = (select users.id from users where username = ${id}) OR userTwo = (select users.id from users where username = ${id}) );", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}


function messages(req, res, next){
    db.many("select id, (select username from users where id = sender), posttime, text from messages where roomID = ${id}", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function sendmessage(req, res, next){
    db.many("insert into messages(ID, roomID, sender, posttime, text) values(${body.ID}, ${body.roomID}, (select users.id from users where username = ${body.sender}), (select now()), ${body.text});", req)
    .then(data => {
        res.sendStatus(200);
    })
    .catch(err => {
       next(err);
    })
}

// function createuserid(req, res, next){
//     db.many("insert into user(ID, username, sender, posttime, text) values(${body.ID}, ${body.roomID}, (select users.id from users where username = ${body.sender}), (select now()), ${body.text});", req)
//     .then(data => {
//         res.sendStatus(200);
//     })
//     .catch(err => {
//        next(err);
//     })
// }
