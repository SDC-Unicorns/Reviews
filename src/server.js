require("dotenv").config();
const express = require("express");
const path = require("path");
const cors = require('cors');

// Establishes connection to the database on server start
const db = require("./db.js");
const controller = require("./controller.js");

const app = express();
app.use(cors());
app.use(express.json());

app.post('/reviews', controller.postReview);
app.get('/reviews', controller.getReviews);

app.listen(process.env.PORT);
console.log(`Listening at http://localhost:${process.env.PORT}`);