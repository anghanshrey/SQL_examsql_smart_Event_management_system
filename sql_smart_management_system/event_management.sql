CREATE DATABASE IF NOT EXISTS smart_event_management_system;

USE smart_event_management_system;

CREATE TABLE venues (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100),
    location VARCHAR(100),
    capacity INT
);

CREATE TABLE organizers (
    organizer_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_name VARCHAR(100),
    contact_email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE attendees (
    attendee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100),
    event_date DATE,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10,2),
    total_seats INT,
    available_seats INT,
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
    FOREIGN KEY (organizer_id) REFERENCES organizers(organizer_id)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT,
    attendee_id INT,
    booking_date DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id),
    UNIQUE (event_id, attendee_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT,
    amount_paid DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATETIME,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id),
    UNIQUE (ticket_id)
);

INSERT INTO venues (venue_name, location, capacity)
VALUES
('Grand Hall', 'Surat', 500),
('City Center', 'Vadodara', 300),
('Royal Garden', 'Ahmedabad', 400),
('Community Hall', 'Rajkot', 200);

INSERT INTO organizers (organizer_name, contact_email, phone_number)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9876543210'),
('Amit Patel', 'amit@gmail.com', '9876543211'),
('Neha Shah', 'neha@gmail.com', '9876543212');

INSERT INTO attendees (name, email, phone_number)
VALUES
('Shrey', 'shrey@gmail.com', '9876543213'),
('Karan', 'karan@gmail.com', '9876543214'),
('Priya', 'priya@gmail.com', '9876543215'),
('Ravi', 'ravi@gmail.com', '9876543216'),
('Jay', 'jay@gmail.com', '9876543217');

INSERT INTO events
(event_name, event_date, venue_id, organizer_id,
 ticket_price, total_seats, available_seats)
VALUES
('Music Festival', '2026-12-10', 1, 1, 500, 500, 100),
('Tech Conference', '2026-12-15', 2, 2, 800, 300, 200),
('Dance Show', '2026-12-20', 3, 3, 400, 400, 300),
('Business Meeting', '2026-12-25', 4, 1, 1000, 200, 50),
('Coding Competition', '2026-12-30', 1, 2, 300, 500, 250);

INSERT INTO tickets
(event_id, attendee_id, booking_date, status)
VALUES
(1, 1, '2026-11-01 10:00:00', 'Confirmed'),
(1, 2, '2026-11-02 11:00:00', 'Confirmed'),
(2, 1, '2026-11-03 12:00:00', 'Confirmed'),
(3, 3, '2026-11-03 13:00:00', 'Pending'),
(4, 4, '2026-11-04 14:00:00', 'Cancelled'),
(5, 5, '2026-11-04 15:00:00', 'Confirmed');

INSERT INTO payments
(ticket_id, amount_paid, payment_status, payment_date)
VALUES
(1, 500, 'Success', '2026-11-01 10:30:00'),
(2, 500, 'Success', '2026-11-02 11:30:00'),
(3, 800, 'Success', '2026-11-03 12:30:00'),
(4, 0, 'Pending', '2026-11-03 13:30:00'),
(5, 0, 'Failed', '2026-11-04 14:30:00'),
(6, 300, 'Success', '2026-11-04 15:30:00');

SELECT * FROM venues;
SELECT * FROM organizers;
SELECT * FROM attendees;
SELECT * FROM events;
SELECT * FROM tickets;
SELECT * FROM payments;

UPDATE venues
SET location = "Jamnager"
WHERE venue_id = 3;

UPDATE organizers
SET contact_email = "rahul1@gmail.com"
WHERE organizer_id = 1;

UPDATE attendees
SET name = "Vatsal"
WHERE attendee_id = 1;

UPDATE events
SET ticket_price = 2500
WHERE event_id = 3;

UPDATE tickets
SET status = "Pending"
WHERE ticket_id = 3;

DELETE FROM events
WHERE event_id = 5;

SELECT * FROM events
WHERE event_name = "Music Festival";

-- 2. USE SQL Clauses (WHERE,HAVING,LIMIT)

SELECT e.event_name, e.event_date, v.location
FROM events e
JOIN venues v ON e.venue_id = v.venue_id
WHERE v.location = 'Surat'
AND e.event_date > '2026-11-05';

SELECT event_name , ticket_price
FROM events
ORDER BY ticket_price DESC
LIMIT 5;

SELECT *
FROM tickets
WHERE booking_date >= '2026-11-01 00:00:00'
AND booking_date < '2026-11-08 00:00:00';

-- 3. Apply SQL Operators

SELECT *
FROM events
WHERE MONTH(event_date) = 12
AND available_seats > total_seats * 0.50;


SELECT a.name, t.status
FROM attendees a
JOIN tickets t ON a.attendee_id = t.attendee_id
WHERE t.status = 'Confirmed'
OR t.status = 'Pending';


SELECT *
FROM events
WHERE NOT (available_seats = 0);

-- 4. Sorting & GROUP BY

SELECT *
FROM events
ORDER BY event_date;

SELECT e.event_name, COUNT(t.ticket_id) AS total_attendees
FROM events e
LEFT JOIN tickets t ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name;

SELECT e.event_name, SUM(p.amount_paid) AS total_revenue
FROM events e
JOIN tickets t ON e.event_id = t.event_id
JOIN payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name;

-- 5. USE Aggregate Function


SELECT SUM(amount_paid) AS total_revenue
FROM payments;


SELECT MAX(ticket_price) AS highest_price
FROM events;


SELECT AVG(ticket_price) AS average_ticket_price
FROM events;

SELECT MIN(ticket_price) AS average_ticket_price
FROM events;

SELECT COUNT(*) AS average_ticket_price
FROM events;


SELECT e.event_name, COUNT(t.ticket_id) AS total_attendees
FROM events e
JOIN tickets t ON e.event_id = t.event_id
GROUP BY e.event_id, e.event_name
ORDER BY total_attendees DESC
LIMIT 1;


-- 6. PRIMARY KEY AND FOREIGN KEY

DESCRIBE events;
DESCRIBE tickets;
DESCRIBE payments;

SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'event_management'
AND REFERENCED_TABLE_NAME IS NOT NULL;

7. JOINS

SELECT e.event_name, v.venue_name, v.location
FROM events e
INNER JOIN venues v
ON e.venue_id = v.venue_id;


SELECT a.name, t.ticket_id, t.status
FROM attendees a
LEFT JOIN tickets t
ON a.attendee_id = t.attendee_id;


SELECT e.event_name, t.ticket_id
FROM tickets t
RIGHT JOIN events e
ON t.event_id = e.event_id;


SELECT a.name, t.ticket_id
FROM attendees a
LEFT JOIN tickets t
ON a.attendee_id = t.attendee_id

UNION

SELECT a.name, t.ticket_id
FROM attendees a
RIGHT JOIN tickets t
ON a.attendee_id = t.attendee_id;


SELECT a.name
FROM attendees a
LEFT JOIN tickets t
ON a.attendee_id = t.attendee_id
WHERE t.ticket_id IS NULL;

-- 8. SUBQUERIES

SELECT event_name, ticket_price
FROM events
WHERE ticket_price > (
    SELECT AVG(ticket_price)
    FROM events
);

SELECT e.event_name, SUM(p.amount_paid) AS revenue
FROM events e
JOIN tickets t ON e.event_id = t.event_id
JOIN payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_id, e.event_name
HAVING SUM(p.amount_paid) > (
    SELECT AVG(event_revenue)
    FROM (
        SELECT SUM(p2.amount_paid) AS event_revenue
        FROM events e2
        JOIN tickets t2 ON e2.event_id = t2.event_id
        JOIN payments p2 ON t2.ticket_id = p2.ticket_id
        GROUP BY e2.event_id
    ) AS revenue_table
);


SELECT organizer_name
FROM organizers
WHERE organizer_id IN (
    SELECT organizer_id
    FROM events
    GROUP BY organizer_id
    HAVING COUNT(*) > 3
);

-- 13. DATE AND TIME FUNCTIONS

SELECT event_name, MONTH(event_date) AS event_month
FROM events;

SELECT event_name,
DATEDIFF(event_date, CURDATE()) AS days_remaining
FROM events;


SELECT payment_id,
DATE_FORMAT(payment_date, '%Y-%m-%d %H:%i:%s')
AS formatted_date
FROM payments;



SELECT event_name, YEAR(event_date) AS event_year
FROM events;



SELECT event_name, DAY(event_date) AS event_day
FROM events;


-- 14. STRING MANIPULATION FUNCTIONS

SELECT UPPER(organizer_name) AS organizer_name
FROM organizers;


SELECT TRIM(name) AS attendee_name
FROM attendees;


SELECT name,
COALESCE(email, 'Not Provided') AS email
FROM attendees;


SELECT LOWER(name) AS attendee_name
FROM attendees;


SELECT organizer_name,
LENGTH(organizer_name) AS name_length
FROM organizers;

-- 11 . Window Function

SELECT event_name, total_revenue,
RANK() OVER (ORDER BY total_revenue DESC) AS event_rank
FROM (
    SELECT e.event_name,
    SUM(p.amount_paid) AS total_revenue
    FROM events e
    LEFT JOIN tickets t ON e.event_id = t.event_id
    LEFT JOIN payments p ON t.ticket_id = p.ticket_id
    GROUP BY e.event_id, e.event_name
) AS revenue_data;


SELECT ticket_id, amount_paid,
SUM(amount_paid) OVER (
    ORDER BY ticket_id
) AS cumulative_sales
FROM payments;


SELECT event_name, attendee_name,
COUNT(*) OVER (
    PARTITION BY event_name
    ORDER BY booking_date
) AS running_attendees
FROM (
    SELECT e.event_name, a.name AS attendee_name,
    t.booking_date
    FROM events e
    JOIN tickets t ON e.event_id = t.event_id
    JOIN attendees a ON t.attendee_id = a.attendee_id
) AS attendee_data;

-- 12. SQL CASE Expressions


SELECT event_name, available_seats, total_seats,

CASE
    WHEN available_seats < total_seats * 0.20
        THEN 'High Demand'

    WHEN available_seats BETWEEN
        total_seats * 0.20 AND total_seats * 0.50
        THEN 'Moderate Demand'

    ELSE 'Low Demand'
END AS event_demand

FROM events;


SELECT payment_id, payment_status,

CASE
    WHEN payment_status = 'Success'
        THEN 'Successful'

    WHEN payment_status = 'Failed'
        THEN 'Failed'

    ELSE 'Pending'
END AS payment_result

FROM payments;

-- END OF SMART EVENT MANAGEMENT SYSTEM












