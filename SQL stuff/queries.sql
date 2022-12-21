-- aggregate functions and nested subqueries (print player with highest wage)
SELECT id, skill, reputation, wages
FROM Player
WHERE wages = (select max(wages) from Player)

-- logic operators (print Club with highest training ground quality and budget below 1000)
SELECT id, reputation, country_of_origin, training_ground_quality, budget
FROM Club
WHERE (training_ground_quality = 5 AND budget < 1000)

-- group by (print highest prize for a competitions taking part in each country)
SELECT max(prize), country
FROM Competition
GROUP BY country

--  having clause (print how many stadiums were build in each year)
SELECT COUNT(id), build_year
FROM Stadium
GROUP BY build_year
HAVING count(id) < 1000

-- correlated, nested subqueries (

-- join (print how much manager earns in each club)
SELECT Club.id AS Club_id, Manager.id AS Manager_id, Club.reputation AS Club_reputation, Manager.wage AS Manager_wage
FROM Club
INNER JOIN Manager ON Club.Manager_id = Manager.id