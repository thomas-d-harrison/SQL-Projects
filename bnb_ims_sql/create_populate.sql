USE bnb_db;

DROP TABLE IF EXISTS reservations, property, rates, date_range, owner, client, property_type;

CREATE TABLE owner (
  owner_id int NOT NULL AUTO_INCREMENT,
  first_name varchar(100),
  last_name varchar(100),
  street varchar (100),
  city varchar(100),
  state char(2),
  zip char(5),
  phone char(12),
  email varchar(100),
  PRIMARY KEY (owner_id)
);

CREATE TABLE client (
  client_id int NOT NULL AUTO_INCREMENT,
  first_name varchar(100),
  last_name varchar(100),
  street varchar(100),
  city varchar(100),
  state char(2),
  zip char(5),
  phone char(12),
  email varchar(100),
  PRIMARY KEY (client_id)
);

CREATE TABLE date_range (
  date_range_id int NOT NULL AUTO_INCREMENT,
  start_date datetime,
  end_date datetime,
  PRIMARY KEY (date_range_id)
);

CREATE TABLE property_type(
  property_type_id int NOT NULL AUTO_INCREMENT,
  type varchar(10),
  PRIMARY KEY (property_type_id)
);

CREATE TABLE property (
  property_id int NOT NULL AUTO_INCREMENT,
  owner_id int,
  property_type_id int,
  accepts_pets boolean,
  high_speed_internet boolean,
  property_alt_id varchar(6),
  type varchar(10),
  PRIMARY KEY (property_id),
  FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
  FOREIGN KEY (property_type_id) REFERENCES property_type(property_type_id)
);

CREATE TABLE rates (
  rate_id int NOT NULL AUTO_INCREMENT,
  date_range_id int,
  property_type_id int,
  rate decimal(10,2),
  PRIMARY KEY (rate_id),
  FOREIGN KEY (date_range_id) REFERENCES date_range(date_range_id),
  FOREIGN KEY (property_type_id) REFERENCES property_type(property_type_id)
);

CREATE TABLE reservations (
  reservation_id int NOT NULL AUTO_INCREMENT,
  property_id int,
  client_id int,
  rate_id int,
  arrival_date datetime,
  depart_date datetime,
  rental_deposit decimal(10,2),
  cleaning_fee decimal(10,2),
  pet_deposit decimal(10,2),
  pet_type varchar(10),
  rental_fee decimal(10,2),
  method_of_payment varchar(10),
  PRIMARY KEY (reservation_id),
  FOREIGN KEY (client_id) REFERENCES client(client_id),
  FOREIGN KEY (property_id) REFERENCES property(property_id),
  FOREIGN KEY (rate_id) REFERENCES rates(rate_id)
);

INSERT INTO client (first_name, last_name, street, city, state, zip, phone, email) 
VALUES 
('Harriet', 'O''Casey', '4088 Ottumwa Way', 'Mentira', 'IL', '61788', '3034174438', 'harrieto@com.net'),
('John', 'Grainger', '2256 N Santa Fe Dr.', 'Iliase', 'MD', '23456', '3034444475', 'johnny@com.net'),
('Steve',  'Snider', '39430 Big Rock Road', 'Flame Throw', 'TN', '59012', '7174201212', 'snidley@com.net'),
('David', 'Stocking', '291-A Gorgonzola', 'Cleo', 'KS', '81029', '6164102990', 'stockingfeet@com.net'),
('Frank', 'Wheeler', '2225 Iola Ave', 'Catuchi', 'PA', '56231', '3034140404', 'fwheeler@com.net'),
('Brittany', 'Foxe', '297-B Gorgonzola', 'Cleo', 'KS', '81029', '6164102942', 'bfoxy@com.net'),
('Fran', 'McCoy', '1440 Manchester Way', 'Mountain View', 'CO', '87757', '3034778787', 'franm@com.net'),
('Joan', 'Thomas', '667438 E. 91st St.', 'Baseboard', 'PA', '56987', '6166849385', 'joanie@com.net'),
('Ted', 'Stiggle', '12920 Industrial Workers', 'Scraggy View', 'CO', '82191', '3034211410', 'thestig@com.net'),
('Dean', 'Farrell', '121 Highway 80', 'Excelsior', 'MD', '23498', '7174833111', 'farrelld@com.net'),
('Marsha', 'Waltz', '1900 Industrial Way', 'Fargone', 'NC', '41923', '2154192349', 'waltzer@com.net'),
('Janet', 'Logan', '860 Charleston St.', 'Oxalys', 'NY', '54133', '3034411321', 'janetlogan@com.net'),
('Linda', 'Paloma', '1928 Highway 12', 'Portugal', 'NC', '82394', '3174239417', 'palomafam@com.net'),
('Gregory', 'Hansen', '6065 Rainbow Falls Rd', 'Roselle', 'PA', '57203', '5054720398', 'gregghansen@com.net'),
('Pat', 'Carroll', '4018 Landers Lane', 'Lafayette', 'OH', '34548', '3034762718', 'pcarroll@com.net'),
('Bee', 'Wolf', '1775 Bear Trail', 'Outcroppin', 'WY', '74345', '4044434863', 'beew@com.net'),
('Scott', 'Crumple', '580 E Main St.', 'La Garita', 'CO', '88413', '3034441324', NULL),
('Elliot', 'Harvey', '34 Kerry Drive', 'El Mano', 'MD', '23646', '5054064647', NULL),
('Carrie', 'Zygote', '8607 Ferndale St', 'Montgomery', 'AL', '60631', '3034063104', 'carriez@com.net'),
('Abbie', 'Loftus', '8077 Montana Place', 'Big Fish', 'MT', '86505', '6064680858', 'aloftus@com.net'),
('Micah', 'Dowenger', '1515 Elliot Way', 'Asheville', 'NC', '28801', '8281216445', 'mdowenger@com.net');

INSERT INTO owner (first_name, last_name, street, city, state, zip, phone, email) 
VALUES
('Sandy', 'Claus', '123 North Pole Dr.', 'Snowshoe', 'PA', '23987', '4046780909', 'sandyclaus@com.net'),
('Richard', 'Compote', '645 Snowpass Road', 'Plymouth', 'MD', '48170', '4135559876', 'richc@com.net'),
('Lucille', 'Livingood', '63 Park Avenue', 'New York', 'NY', '12340', '0075553636', 'livingood@com.net'),
('Charles', 'Brown', '8706 Main Street', 'Snowshoe', 'CO', '48000', '3035551236', 'charlie@com.net'),
('Jack', 'Bauer', '469 Carriage Hill Dr', 'Washington', 'DC', '20001', '7135553872', 'jackbauer@com.net'),
('Barbie', 'Beckwith', '9010 Upper Crust Way', 'Littleton', 'NY', '20127', '0075559999', 'babs@com.net'),
('Barney', 'Rubble', '1616 Stonehenge', 'Granite', 'CO', '80234', '7205551456', 'rockhead@com.net'),
('Fred', 'Flintstone', '26 Quarry Drive', 'Granite', 'CO', '80234', '7205557676', 'freddie@com.net'),
('Larry', 'Lizard', '908 Green Mtn Rd.', 'Green Mountain', 'UT', '23987', '7655554392', 'lizard@com.net'),
('Gwen', 'Grizzlie', '56231 Bear Lane', 'Bear Lake', 'MD', '23123', '4136789808', 'griz@com.net'),
('Olivia', 'Pope', '878 Fort Road', 'Washington', 'DC', '20001', '4045558877', 'opa@com.net'),
('Robert', 'Smith', '5223 Mountain Lane', 'Ft. Morgan', 'WV', '34665', '5055551456', 'bobbys@com.net'),
('Luke', 'Taylors', '375 Windward Way', 'Asheville', 'NC', '28801', '8284459776', 'luket@com.net');

INSERT INTO property_type (type)
VALUES
('SandsOF2BR'),
('SandsOF3BR'),
('SandsOV2BR'),
('SandsOV3BR'),
('Tides2BR'),
('Tides3BR');

INSERT INTO property (owner_id, property_type_id, accepts_pets, high_speed_internet, property_alt_id, type)
VALUES 
(1, 2, TRUE, TRUE, '301S', 'SandsOF3BR'),
(2, 4, TRUE, TRUE, '207S','SandsOV3BR'),
(3, 6, FALSE, FALSE, '1100T', 'Tides3BR'),
(4, 6, FALSE, TRUE, '1201T', 'Tides3BR'),
(5, 1, FALSE, TRUE, '317S', 'SandsOF2BR'),
(6, 5, FALSE, TRUE, '110T', 'Tides2BR'),
(7, 3, FALSE, FALSE, '1010S', 'SandsOV2BR'),
(8, 1, TRUE, TRUE, '409S', 'SandsOF2BR'),
(9, 5, TRUE, FALSE, '505T', 'Tides2BR'),
(10, 6, TRUE, TRUE, '1005T', 'Tides3BR'),
(11, 3, TRUE, FALSE, '656S', 'SandsOV2BR'),
(12, 2, FALSE, FALSE, '942S', 'SandsOF3BR'),
(13, 6, TRUE, TRUE, '517T', 'Tides3BR');

INSERT INTO date_range (start_date, end_date)
VALUES 
('2019-01-01', '2019-03-31'),
('2019-04-01', '2019-05-31'),
('2019-06-01', '2019-08-31'),
('2019-09-01', '2019-10-31'),
('2019-11-01', '2019-12-31'),
('2020-01-01', '2020-03-31'),
('2020-04-01', '2020-05-31'),
('2020-06-01', '2020-08-31'),
('2020-09-01', '2020-10-31'),
('2020-11-01', '2020-12-31');

INSERT INTO rates (date_range_id, property_type_id, rate)
VALUES 
(1, 1, 400.00),
(2, 1, 475.00),
(3, 1, 600.00),
(4, 1, 475.00),
(5, 1, 400.00),
(1, 2, 450.00),
(2, 2, 525.00),
(3, 2, 650.00),
(4, 2, 525.00),
(5, 2, 450.00),
(1, 3, 375.00),
(2, 3, 425.00),
(3, 3, 575.00),
(4, 3, 425.00),
(5, 3, 375.00),
(1, 4, 425.00),
(2, 4, 475.00),
(3, 4, 625.00),
(4, 4, 475.00),
(5, 4, 425.00),
(1, 5, 350.00),
(2, 5, 375.00),
(3, 5, 450.00),
(4, 5, 375.00),
(5, 5, 350.00),
(1, 6, 375.00),
(2, 6, 400.00),
(3, 6, 500.00),
(4, 6, 400.00),
(5, 6, 375.00);

INSERT INTO reservations (property_id, client_id, rate_id, arrival_date, depart_date, rental_deposit, cleaning_fee, pet_deposit, pet_type, rental_fee, method_of_payment)
VALUES 
  (3, 19, 26, '2019-01-06', '2019-01-13', 100.00, 60.00, NULL, NULL, 375.00, 'Cash'),
  (5, 8, 1, '2019-01-13', '2019-01-27', 100.00, 50.00, NULL, NULL, 800.00, 'AMEX'),
  (10, 9, 26, '2019-01-20', '2019-02-03', 100.00, 60.00, NULL, NULL, 750.00, 'Check'),
  (9, 6, 21, '2019-02-03', '2019-02-24', 100.00, 50.00, 150.00, 'cat', 1050.00, 'Check'),
  (2, 19, 16, '2019-02-17', '2019-02-24', 100.00, 60.00, 150.00, 'dog', 375.00, 'Visa'),
  (12, 7, 6, '2019-02-10', '2019-02-24', 100.00, 60.00, NULL, NULL, 900.00, 'AMEX'),
  (6, 4, 21, '2019-02-24', '2019-03-03', 100.00, 50.00, NULL, NULL, 350.00, 'PayPal'),
  (10, 14, 26,  '2019-03-03', '2019-03-10', 100.00, 60.00, NULL, NULL, 375.00, 'Visa'),
  (12, 7, 6, '2019-03-17', '2019-03-24', 100.00, 60.00, NULL, NULL, 450.00, 'MasterCard'),
  (12, 7, 7, '2019-04-07', '2019-04-14', 100.00, 60.00, NULL, NULL, 525.00, 'MasterCard'),
  (10, 1, 27, '2019-04-07', '2019-04-17', 100.00, 60.00, 150.00, 'dog', 400.00, 'Check'),
  (4, 13, 27, '2019-04-14', '2019-04-21', 100.00, 60.00, NULL, NULL, 400.00, 'MasterCard'),
  (8, 8, 2, '2019-05-05', '2019-05-19', 100.00, 50.00, 150.00, 'cat', 950.00, 'AMEX'),
  (3, 7, 27, '2019-05-05', '2019-05-12', 100.00, 60.00, NULL, NULL, 400.00, 'MasterCard'),
  (5, 4, 2, '2019-05-05', '2019-05-19', 100.00, 50.00, NULL, NULL, 950.00, 'PayPal'),
  (12, 6, 7, '2019-05-05', '2019-05-12', 100.00, 60.00, NULL, NULL, 525.00, 'Cash'),
  (4, 13, 27, '2019-05-12', '2019-05-19', 100.00, 60.00, NULL, NULL, 400.00, 'MasterCard'),
  (10, 9, 27, '2019-05-12', '2019-05-19', 100.00, 60.00, NULL, NULL, 400.00, 'Visa'),
  (11, 2, 12, '2019-05-19', '2019-05-26', 100.00, 50.00, 150.00, 'dog', 425.00, 'Visa'),
  (5, 3, 3, '2019-06-02', '2019-06-16', 100.00, 50.00, NULL, NULL, 1200.00, 'PayPal'),
  (12, 7, 8, '2019-06-02', '2019-06-23', 100.00, 60.00, NULL, NULL, 1950.00, 'PayPal'),
  (10, 1, 28, '2019-06-09', '2019-06-16', 100.00, 60.00, 150.00, 'dog', 500.00, 'Check'),
  (4, 13, 28, '2019-06-16', '2019-06-23', 100.00, 60.00, NULL, NULL, 500.00, 'MasterCard'),
  (10, 9, 26, '2020-01-05', '2020-01-12', 100.00, 60.00, NULL, NULL, 375.00, 'Check'),
  (12, 7, 6, '2020-01-19', '2020-02-02', 100.00, 60.00, NULL, NULL, 900.00, 'MasterCard'),
  (6, 4, 21, '2020-02-02', '2020-02-09', 100.00, 50.00, NULL, NULL, 350.00, 'PayPal'),
  (10, 1, 26, '2020-02-09', '2020-02-16', 100.00, 60.00, 150.00, 'dog', 375.00, 'Check'),
  (8, 8, 1, '2020-03-02', '2020-03-23', 100.00, 50.00, 150.00, 'cat', 1200.00, 'AMEX');