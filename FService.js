 
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
router.get("/classtaken/:id", classTook);



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
function classTook(req, res, next) {
    db.many("Select shortName from  users, userclass, class WHERE users.position = 'student' AND users.name = ${id} and userclass.classID=class.ID and userclass.userID=users.ID and role= 'taking'", req.params)
    .then(data => {
        res.send(data);
    })
    .catch(err => {
        next(err);
    })
}

 