--Average rental rate for each type of property.
CREATE VIEW View1_AverageRate AS
SELECT pt.type, ROUND(AVG(rate), 2) AS avg_rental_rate
FROM rates r
JOIN property_type pt ON pt.property_type_id = r.property_type_id
GROUP BY pt.type;

--Contact and property info for owners of “non-rented” properties.
CREATE VIEW View2_NonRentalProperty AS
SELECT p.property_id, o.owner_id, o.street, o.city, o.state, o.zip, o.first_name, o.last_name, o.phone, o.email
FROM property p
JOIN owner o ON p.owner_id = o.owner_id
LEFT JOIN reservations  r
ON p.property_id = r.property_id
WHERE r.reservation_id IS NULL;

--Most frequent renter(s).
CREATE VIEW View3_MostFreqRenters AS
SELECT c.client_id, c.first_name, c.last_name, COUNT(r.reservation_id) AS num_rentals
FROM client c
LEFT JOIN reservations r ON c.client_id = r.client_id
GROUP BY c.client_id
ORDER BY num_rentals DESC
LIMIT 3;

--2019 renters.
CREATE VIEW View4_SummerCoupon AS
SELECT c.first_name, c.last_name, c.street, c.city, c.state, c.zip
FROM reservations r
JOIN client c ON r.client_id = c.client_id
WHERE YEAR(r.arrival_date) = 2019 OR YEAR(r.depart_date) = 2019;

--Oceanview condos with current rate and with a 6% increase. 
CREATE VIEW View5_Rate_NewRate AS
SELECT pt.type AS 'Condo Type', r.rate AS 'Rate', r.rate * 1.06 AS 'New Rate'
FROM rates r
JOIN property_type pt on r.property_type_id = pt.property_type_id
WHERE type LIKE '%OV%'
GROUP BY pt.type;

--Properties by ID 
CREATE VIEW View6a_PropertyID AS
SELECT property_id AS 'Property ID', property_alt_id AS 'Original Property ID'
FROM property
GROUP BY property_id;

--Total Rent (total rent collected for a particular property)
CREATE VIEW View6b_TotalRent AS
SELECT p.property_id, p.property_alt_id, SUM(r.rate) as 'Total Rent'
FROM property p 
JOIN reservations res on res.property_id = p.property_id
JOIN rates r on r.rate_id = res.rate_id
GROUP BY property_id;

--Cleaning fees (total cleaning fees collected for a particular property)
CREATE VIEW View6c_TotalCleaningFees AS
SELECT p.property_id AS 'Property ID', p.property_alt_id AS 'Original Property ID', SUM(res.cleaning_fee) AS 'Total Cleaning Fee'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
GROUP BY p.property_id;

--Pets (total pet deposits collected for a particular property)
CREATE VIEW View6d_TotalPetDeposits AS
SELECT p.property_id AS 'Property ID', p.property_alt_id AS 'Original Property ID', SUM(res.pet_deposit) AS 'Total Pet Deposit'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
GROUP BY p.property_id;

--Property Total Collected (total rent + cleaning fees + pet deposits)  
CREATE VIEW View6e_PropertyTotal AS
SELECT p.property_id AS 'Property ID', p.property_alt_id AS 'Original Property ID', (IFNULL(SUM(res.pet_deposit),0) + SUM(res.cleaning_fee) + SUM(r.rate))  AS 'Total Collected'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
JOIN rates r ON r.rate_id = res.rate_id
GROUP BY p.property_id;

--SFRC Fees (amount of the Total Rent which goes to SFRC)
CREATE VIEW View6f_SFRCFees AS
SELECT p.property_id AS 'Property ID', p.property_alt_id AS 'Original Property ID', ROUND((SUM(r.rate) * .25),2)  AS 'SFRC Fee'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
JOIN rates r ON r.rate_id = res.rate_id
GROUP BY p.property_id;

--Owner Amount (amount of the Total Rent which goes to the owner)
CREATE VIEW View6g_OwnerAmt AS
SELECT p.property_id AS 'Property ID', p.property_alt_id AS 'Original Property ID', ROUND((SUM(r.rate) * .75),2)  AS 'Owner Amount'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
JOIN rates r ON r.rate_id = res.rate_id
GROUP BY p.property_id;

--Property Totals SQL statement 
CREATE VIEW View6_PropertyTotals AS
SELECT p.property_id AS 'Property ID', 
	p.property_alt_id AS 'Original Property ID',
    SUM(r.rate) as 'Total Rent',
    SUM(res.cleaning_fee) AS 'Total Cleaning Fee',
    SUM(res.pet_deposit) AS 'Total Pet Deposit',
    (IFNULL(SUM(res.pet_deposit),0) + SUM(res.cleaning_fee) + SUM(r.rate))  AS 'Total Collected',
    ROUND((SUM(r.rate) * .25),2)  AS 'SFRC Fee',
    ROUND((SUM(r.rate) * .75),2)  AS 'Owner Amount'
FROM property p 
JOIN reservations res ON res.property_id = p.property_id
JOIN rates r ON r.rate_id = res.rate_id
GROUP BY p.property_id;

--Total recieved per payment method.
CREATE VIEW View7_PaymentMethodTotal AS
SELECT res.method_of_payment AS 'Method of Payment',
(IFNULL(SUM(res.pet_deposit),0) + SUM(res.cleaning_fee) + SUM(r.rate))  AS 'Total Recieved',
ROUND((SUM(r.rate) * .25),2)  AS 'SFRC Portion of Total Recieved'
FROM reservations res 
JOIN rates r ON r.rate_id = res.rate_id
GROUP BY res.method_of_payment;

--Owners allowing pets at property types.
CREATE VIEW View8_TwoTable AS
SELECT o.first_name AS 'Owner First Name', o.last_name AS 'Owner Last Name', p.type AS 'Property Type'
FROM owner o
JOIN property p on p.owner_id = o.owner_id
WHERE p.accepts_pets = 1;

--Date range with the highest amount of money recieved.
CREATE VIEW View9_ThreeTable AS
SELECT  
CONCAT(DATE_FORMAT(dr.start_date, '%m/%d'), ' - ' , DATE_FORMAT(dr.end_date, '%m/%d')) AS 'Date Range',
(IFNULL(SUM(res.pet_deposit),0) + SUM(res.cleaning_fee) + SUM(r.rate))  AS 'Total Amount'
FROM reservations res
JOIN rates r on r.rate_id = res.rate_id
JOIN date_range dr on dr.date_range_id = r.date_range_id
GROUP BY dr.date_range_id
ORDER BY 'Total Amount';

--Update query to set all properties to having high speed internet.
UPDATE property SET high_speed_internet = 1;
