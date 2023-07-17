const db = "./db.js";

exports.postReview = function (req, res) {

}

exports.getReviews = function (req, res) {
  let qString = 'SELECT * FROM movies';
  db.query(qString, (err, results) => {
    if (err) {
      throw err;
    } else {
      res.json(results);
    }
  });
}