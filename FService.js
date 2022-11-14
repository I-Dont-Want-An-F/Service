   
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
router.get("/comments/:id", comments);//selects all the comments for a given class
router.get("/questions/:id", questions); //selects all the questions for a given class
router.get("/rating/:id", rating);// retuns a rating for a class 
router.get("/classes", classes); //returns all classes 
router.get("/reply/:id", reply); //returns the reply to a comment

router.post("/questions", createcomments); // creates a question created by a user
router.put("/questions/:id", updatecomments); // update a question created by a user

router.post("/reply", createreply); // creates a question created by a user
router.put("/reply/:id", updatereply); // update a question created by a user

router.get("/messagerooms/:id", messageRooms);
router.get("/messages/:id", messages);
router.post("/sendmessage/:content", sendmessage);

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
    db.many("Select shortName from  users, userclass, class WHERE users.position = 'student' AND users.username = ${id} and userclass.classID=class.ID and userclass.userID=users.ID and role= 'taking'", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

 //selects the classes a user has completed
function classTook(req, res, next) {
    db.many(" Select shortName from  users, userclass, class where users.position = 'student' and users.username = ${id} and userclass.classID=class.ID  and userclass.userID=users.ID and role= 'completed'", req.params)
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
    db.many("select * from reply where reply.postID= ${id}", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function createreply(req, res, next) {
    db.many("INSERT into * from reply where reply.postID= ${id}", req.params)
    .then(data => {
        res.send(data);
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


function messageRooms(req, res, next){
    db.many("select id, userOne, userTwo from messagerooms where (userOne = (select users.id from users where username = `${1}`) OR userTwo = (select users.id from users where username = `${1}`) );", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}


function messages(req, res, next){
    db.many("select * from messages where roomID = ${id}", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

function sendmessage(req, res, next){
    db.many("insert into messages(ID, roomID, sender, date, text) values(${body.ID}, ${body.roomID}, (select users.id from users where username = `${body.sender}`), (select now()), `${body.text}`);", req)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}
