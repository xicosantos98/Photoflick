const port = 3000;
const mysql = require("mysql");
const express = require("express");
const app = express();
const http = require("http").Server(app);
const io = require("socket.io")(http);
var cors = require("cors");
const path = require("path");
var crypto = require("crypto-js");

var publicDir = require("path").join(__dirname, "/public");
app.use(express.static(publicDir));

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "photoflick"
});

/*var con = mysql.createConnection({
    host: "db4free.net",
    user: "xico26",
    password: "xico0508",
    database: "photoflick"
});*/

con.connect(err => {
  if (err) {
    throw err;
  }
  console.log("Connected to database");
});

global.con = con;
global.http = http;

app.use(express.json());
app.use(cors());
app.use(express.static("public"));

app.use(
  "/public/uploads/posts",
  express.static(__dirname + "/public/uploads/posts")
);
app.use(
  "/public/uploads/profile",
  express.static(__dirname + "/public/uploads/profile")
);

var userRoutes = require("./routes/user");
var postsRoutes = require("./routes/posts");

app.use("/user", userRoutes);
app.use("/posts", postsRoutes);

http.listen(3000, function() {
  console.log("listening on *:3000");
});
