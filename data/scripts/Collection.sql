--Q2 Part 1
with vandyplay AS (SELECT distinct (playerid)
				FROM collegeplaying
                WHERE schoolid = 'vandy')
SELECT CONCAT(namefirst,' ',namelast)AS FullName
FROM vandyplay INNER JOIN people on vandyplay.playerid = people.playerid

--Part2
with vandyplay AS (SELECT distinct (playerid)
				FROM collegeplaying
                WHERE schoolid = 'vandy')
SELECT salary, vandyplay.playerid
FROM vandyplay INNER JOIN salaries on vandyplay.playerid = salaries.playerid
WHERE SELECT DISTINCT playerid
---?

select concat(namefirst,' ', namelast) as fullname, sum(salary) as total_salary
from salaries
	inner join collegeplaying
	using (playerid)
	inner join people
	using (playerid)
where schoolid ilike 'vand%'
group by fullname
order by total_salary desc

with average as(SELECT SUM AS ATTEMPT
				FROM batting
				 
SELECT
