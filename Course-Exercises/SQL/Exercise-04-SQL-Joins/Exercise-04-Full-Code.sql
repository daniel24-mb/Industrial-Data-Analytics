/* =========================================================
   EXERCISE 04 - SQL JOINS
   ========================================================= *


/* =========================================================
   TABLE 1: users
   ========================================================= */

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT,
    user_name STRING,
    country STRING
);

INSERT INTO users VALUES
(1, 'Nomvula', 'Johannesburg'),
(2, 'David', 'Cape Town'),
(3, 'Anele', 'Durban'),
(4, 'Kabelo', 'Pretoria'),
(5, 'Lerato', 'Port Elizabeth');


/* =========================================================
   TABLE 2: plans
   ========================================================= */

DROP TABLE IF EXISTS plans;

CREATE TABLE plans (
    plan_id INT,
    plan_name STRING,
    monthly_price INT
);

INSERT INTO plans VALUES
(10, 'Basic', 79),
(11, 'Standard', 129),
(12, 'Premium', 199),
(13, 'Family', 249),
(14, 'Mobile', 59);


/* =========================================================
   TABLE 3: subscriptions
   ========================================================= */

DROP TABLE IF EXISTS subscriptions;

CREATE TABLE subscriptions (
    subscription_id INT,
    user_id INT,
    plan_id INT,
    start_date DATE
);

INSERT INTO subscriptions VALUES
(501, 1, 10, '2026-01-15'),
(502, 2, 11, '2026-02-01'),
(503, 1, 12, '2026-03-10'),
(504, 6, 11, '2026-03-20'),
(505, 3, 13, '2026-04-05');


/* =========================================================
   TABLE 4: shows
   ========================================================= */

DROP TABLE IF EXISTS shows;

CREATE TABLE shows (
    show_id INT,
    show_title STRING,
    genre STRING
);

INSERT INTO shows VALUES
(701, 'Comedy Hour', 'Comedy'),
(702, 'Crime Time', 'Drama'),
(703, 'Tech Tales', 'Documentary'),
(704, 'Cooking Lab', 'Lifestyle'),
(706, 'Wild Earth', 'Documentary');


/* =========================================================
   TABLE 5: viewing_sessions
   ========================================================= */

DROP TABLE IF EXISTS viewing_sessions;

CREATE TABLE viewing_sessions (
    session_id INT,
    user_id INT,
    show_id INT,
    watch_minutes INT
);

INSERT INTO viewing_sessions VALUES
(901, 1, 701, 45),
(902, 2, 703, 30),
(903, 1, 702, 60),
(904, 7, 701, 20),
(905, 3, 705, 90);


/* =========================================================
   PART A - INNER JOIN
   ========================================================= */


/* Q1: Join users and subscriptions */

SELECT
    u.user_id,
    u.user_name,
    s.subscription_id,
    s.start_date
FROM users u
INNER JOIN subscriptions s
    ON u.user_id = s.user_id;


/* Q2: Join subscriptions and plans */

SELECT
    s.subscription_id,
    s.user_id,
    p.plan_name,
    p.monthly_price
FROM subscriptions s
INNER JOIN plans p
    ON s.plan_id = p.plan_id;


/* Q3: Join viewing sessions and shows */

SELECT
    v.session_id,
    v.user_id,
    s.show_title,
    s.genre,
    v.watch_minutes
FROM viewing_sessions v
INNER JOIN shows s
    ON v.show_id = s.show_id;


/* Q4: Join users and viewing sessions */

SELECT
    u.user_name,
    u.country,
    v.session_id,
    v.show_id,
    v.watch_minutes
FROM users u
INNER JOIN viewing_sessions v
    ON u.user_id = v.user_id;


/* Q5: Join users, subscriptions, and plans */

SELECT
    u.user_name,
    u.country,
    p.plan_name,
    p.monthly_price,
    s.start_date
FROM users u
INNER JOIN subscriptions s
    ON u.user_id = s.user_id
INNER JOIN plans p
    ON s.plan_id = p.plan_id;


/* =========================================================
   PART B - LEFT JOIN
   ========================================================= */


/* Q6: Show all users and their subscriptions */

SELECT
    u.user_id,
    u.user_name,
    s.subscription_id,
    s.start_date
FROM users u
LEFT JOIN subscriptions s
    ON u.user_id = s.user_id;


/* Q7: Show all plans and matching subscriptions */

SELECT
    p.plan_id,
    p.plan_name,
    s.subscription_id,
    s.user_id
FROM plans p
LEFT JOIN subscriptions s
    ON p.plan_id = s.plan_id;


/* Q8: Show all shows and matching viewing sessions */

SELECT
    s.show_id,
    s.show_title,
    v.session_id,
    v.watch_minutes
FROM shows s
LEFT JOIN viewing_sessions v
    ON s.show_id = v.show_id;


/* Q9: Show all viewing sessions and matching users */

SELECT
    v.session_id,
    v.show_id,
    v.watch_minutes,
    u.user_id,
    u.user_name
FROM viewing_sessions v
LEFT JOIN users u
    ON v.user_id = u.user_id;


/* Q10: Show all users and their plan information if available */

SELECT
    u.user_name,
    u.country,
    p.plan_name,
    p.monthly_price
FROM users u
LEFT JOIN subscriptions s
    ON u.user_id = s.user_id
LEFT JOIN plans p
    ON s.plan_id = p.plan_id;


/* =========================================================
   PART C - FULL OUTER JOIN
   ========================================================= */


/* Q11: Show all users and subscriptions, including unmatched rows */

SELECT
    COALESCE(u.user_id, s.user_id) AS user_id,
    u.user_name,
    s.subscription_id,
    s.start_date
FROM users u
FULL OUTER JOIN subscriptions s
    ON u.user_id = s.user_id;


/* Q12: Show all plans and subscriptions, including unmatched rows */

SELECT
    COALESCE(p.plan_id, s.plan_id) AS plan_id,
    p.plan_name,
    s.subscription_id,
    s.user_id
FROM plans p
FULL OUTER JOIN subscriptions s
    ON p.plan_id = s.plan_id;


/* Q13: Show all shows and viewing sessions, including unmatched rows */

SELECT
    COALESCE(s.show_id, v.show_id) AS show_id,
    s.show_title,
    v.session_id,
    v.watch_minutes
FROM shows s
FULL OUTER JOIN viewing_sessions v
    ON s.show_id = v.show_id;


/* Q14: Show all users and viewing sessions, including unmatched rows */

SELECT
    COALESCE(u.user_id, v.user_id) AS user_id,
    u.user_name,
    v.session_id,
    v.show_id,
    v.watch_minutes
FROM users u
FULL OUTER JOIN viewing_sessions v
    ON u.user_id = v.user_id;


/* Q15: Show all users, subscriptions, and plans using FULL OUTER JOIN */

SELECT
    COALESCE(u.user_id, s.user_id) AS user_id,
    u.user_name,
    s.subscription_id,
    COALESCE(s.plan_id, p.plan_id) AS plan_id,
    p.plan_name
FROM users u
FULL OUTER JOIN subscriptions s
    ON u.user_id = s.user_id
FULL OUTER JOIN plans p
    ON s.plan_id = p.plan_id;


/* =========================================================
   BONUS QUESTIONS
   ========================================================= */


/* B1: Find users who do not have a subscription */

SELECT
    u.user_id,
    u.user_name
FROM users u
LEFT JOIN subscriptions s
    ON u.user_id = s.user_id
WHERE s.subscription_id IS NULL;


/* B2: Find subscriptions linked to users that do not exist */

SELECT
    s.subscription_id,
    s.user_id,
    s.plan_id
FROM subscriptions s
LEFT JOIN users u
    ON s.user_id = u.user_id
WHERE u.user_id IS NULL;


/* B3: Find shows that have never been watched */

SELECT
    s.show_id,
    s.show_title
FROM shows s
LEFT JOIN viewing_sessions v
    ON s.show_id = v.show_id
WHERE v.session_id IS NULL;


/* B4: Find viewing sessions linked to shows that do not exist */

SELECT
    v.session_id,
    v.user_id,
    v.show_id
FROM viewing_sessions v
LEFT JOIN shows s
    ON v.show_id = s.show_id
WHERE s.show_id IS NULL;


/* B5: Find plans with no subscribers */

SELECT
    p.plan_id,
    p.plan_name
FROM plans p
LEFT JOIN subscriptions s
    ON p.plan_id = s.plan_id
WHERE s.subscription_id IS NULL;
