/*CREATE DATABASE ratingsandreviews;*/

USE ratingsandreviews;

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  rating INT NOT NULL,
  `date` INT NOT NULL,
  summary VARCHAR(60) NOT NULL,
  body VARCHAR(100) NOT NULL,
  recommend VARCHAR(5) NOT NULL,
  reported VARCHAR(5) NOT NULL,
  reviewer_name VARCHAR(60) NOT NULL,
  reviewer_email VARCHAR(60) NOT NULL,
  response VARCHAR(200) DEFAULT NULL,
  helpfulness INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE reviews_photos (
  id INT NOT NULL AUTO_INCREMENT,
  review_id INT NOT NULL,
  `url` VARCHAR(300),
  PRIMARY KEY (id)
);

CREATE TABLE characteristics (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE characteristic_reviews (
  id INT NOT NULL AUTO_INCREMENT,
  characteristic_id INT NOT NULL,
  review_id INT NOT NULL,
  `value` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

LOAD DATA LOCAL INFILE '/Users/jackpape/Desktop/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/jackpape/Desktop/reviews_photos.csv'
INTO TABLE reviews_photos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/jackpape/Desktop/characteristics.csv'
INTO TABLE characteristics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/jackpape/Desktop/characteristic_reviews.csv'
INTO TABLE characteristic_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;