CREATE DATABASE ratingsandreviews;

USE ratingsandreviews;

CREATE TABLE reviews (
  id int NOT NULL AUTO_INCREMENT,
  product_id int NOT NULL,
  rating int NOT NULL,
  `date` int NOT NULL,
  summary varchar(60) NOT NULL,
  body varchar(100) NOT NULL,
  recommend boolean NOT NULL,
  reported boolean NOT NULL,
  reviewer_name varchar(60) NOT NULL,
  reviewer_email varchar(60) NOT NULL,
  response varchar(200),
  helpfulness int NOT NULL DEFAULT 0,
  PRIMARY KEY (ID)
);

CREATE TABLE reviews_photos (
  id int NOT NULL AUTO_INCREMENT,
  review_id int NOT NULL,
  `url` varchar(300),
  PRIMARY KEY (ID)
);

CREATE TABLE characteristics (
  id int NOT NULL AUTO_INCREMENT,
  product_id int NOT NULL,
  `name` varchar(7) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE characteristics_reviews (
  id int NOT NULL AUTO_INCREMENT,
  characteristic_id int NOT NULL,
  review_id int NOT NULL,
  `value` int NOT NULL DEFAULT 0,
  PRIMARY KEY (ID)
);