CREATE DATABASE ratingsandreviews;

USE ratingsandreviews;

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  rating INT NOT NULL,
  `date` DATE NOT NULL,
  summary VARCHAR(60) NOT NULL,
  body VARCHAR(100) NOT NULL,
  recommend BOOLEAN NOT NULL,
  reported BOOLEAN NOT NULL,
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
  `name` VARCHAR(7) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE characteristics_reviews (
  id INT NOT NULL AUTO_INCREMENT,
  characteristic_id INT NOT NULL,
  review_id INT NOT NULL,
  `value` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

LOAD DATA INFILE '../../reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '../../reviews_photos.csv'
INTO TABLE reviews_photos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '../../characteristics.csv'
INTO TABLE characteristics
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '../../characteristics_reviews.csv'
INTO TABLE characteristics_reviews
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;