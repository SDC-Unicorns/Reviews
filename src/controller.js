const db = require("./db.js");

exports.postReview = function (req, res) {
  //console.log(req.body);
  let i = req.body;
  let qString = 'INSERT INTO reviews '
  + '(product_id,rating,date,summary,body,recommend,reported,reviewer_name,reviewer_email,response,helpfulness) '
  + 'VALUES("' + i.product_id + '","' + i.rating + '","' + Math.floor(Date.now() / 1000) + '","' + i.summary + '","' + i.body
  + '","' + i.recommend + '","false","' + i.name + '","' + i.email + '","null","0")';
  db.query(qString, (err, results) => {
    if (err) {
      res.status(404);
      throw err;
    } else {
      qString = 'INSERT INTO characteristic_reviews (characteristic_id,review_id,value) VALUES';
      let values = [];
      for (let p in i.characteristics) {
        values.push('("' + p + '","' + results.insertId + '","' + i.characteristics[p] + '")');
      }
      qString += values.join(',');
      db.query(qString, (err, results2) => {
        if (err) {
          res.status(404);
          throw err;
        } else {
          if (i.photos !== undefined && i.photos.length > 0) {
            qString = 'INSERT INTO reviews_photos (review_id,url) VALUES'
            values = [];
            for (let p in i.photos) {
              values.push('("' + i.product_id + '","' + i.photos[p] + '")');
            }
            qString += values.join(',');
            db.query(qString, (err, results3) => {
              if (err) {
                res.status(404);
                throw err;
              } else {
                res.sendStatus(201);
              }
            });
          } else {
            res.sendStatus(201);
          }
        }
      });
    }
  });
};

exports.getReviews = function (req, res) {
  let response = [];
  let qString = 'SELECT * FROM reviews WHERE product_id = ' + req.query.product_id;
  db.query(qString, (err, results) => {
    if (err) {
      res.status(404);
      throw err;
    } else {
      res.status(200);
      res.json(results.slice((req.query.page - 1) * req.query.count, req.query.page * req.query.count));
    }
  });
};

exports.getReviewMeta = function (req, res) {
  let response = {
    product_id: req.query.product_id,
    ratings: {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
    recommended: {true: 0, false: 0},
    characteristics: {}
  };

  let qString = 'SELECT rating, recommend'
  + ' FROM reviews'
  + ' WHERE product_id = ' + req.query.product_id;
  db.query(qString, (err, results) => {
    if (err) {
      res.status(404);
      throw err;
    } else {
      let revCount = results.length;
      for (let f = 0; f < revCount; f++) {
        response.recommended[results[f].recommend]++;
        response.ratings[results[f].rating]++;
      }

      let qString = 'SELECT characteristics. ' + `name` + ', characteristic_reviews. ' + `value`
      + ' FROM characteristics'
      + ' INNER JOIN characteristic_reviews ON characteristics.id=characteristic_reviews.characteristic_id'
      + ' WHERE product_id = ' + req.query.product_id;
      db.query(qString, (err, results2) => {
        if (err) {
          res.status(404);
          throw err;
        } else {
          res.status(200);
          for (let f = 0; f < results2.length; f++) {
            if (!response.characteristics[results2[f].name]) {
              response.characteristics[results2[f].name] = 0;
            }
            response.characteristics[results2[f].name] += results2[f].value;
          }
          for (let p in response.characteristics) {
            response.characteristics[p] /= revCount;
          }
          res.json(response);
        }
      });
    }
  });
};