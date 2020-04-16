/*
--1. What range of years does the database cover?
/*Final answer: The database covers the years 1871-2016, 146 years. The exceptions to this are the following tables:
		people - birth years range from 1820 to 1996 (176 years total with 166 year in database as having someone born in that year)
		collegeplaying - 1864 to 2014 (151 years)
	However, we clarified that the intent was to ask what years of professional baseball are in the database so the answer is 146 years (1871-2016).*/

--initial exploratory approach (repeat for each table with years), got differing ranges.
/* select distinct yearid
from teams
order by yearid;*/

--combine results from initial approach into a single table
SELECT DISTINCT teams.yearid AS teams_year, salaries.yearid as salaries_year, homegames.year as homegames_year, allstarfull.yearid as allstarfull_year, 
	   appearances.yearid as appearances_year, awardsmanagers.yearid as awardsmanager_year, awardsplayers.yearid as awardsplayers_year
FROM teams
FULL JOIN salaries
	using (yearid)
full join homegames
	on teams.yearid = homegames.year
full join allstarfull
	using (yearid)
full join appearances
	using (yearid)
full join awardsmanagers
	using (yearid)
full join awardsplayers
	using (yearid)
ORDER BY teams_year;
--tried running code at this point and it takes too long.

--New approach: data dictionary says the database covers the years 1871-2016. Confirmed by running simple sueries on main tables.

select distinct yearid
from teams
order by yearid;
--1871 to 2016 - 146 years

select distinct yearid
from batting
order by yearid;
--1871 to 2016 - 146 years

select distinct year
from homegames
order by year;
--1871 to 2016 - 146 years

select distinct yearid
from pitching
order by yearid;
--1871 to 2016 - 146 years

select distinct yearid
from fielding
order by yearid;
--1871 to 2016 - 146 years

select distinct birthyear
from people
where birthyear is not null
order by birthyear;
--birth years range from 1820 to 1996 (176 years total with 166 year in database as having someone born in that year)

select distinct yearid
from collegeplaying
order by yearid;
--1864 to 2014 - 151 years
*/

/*
8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 
(where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.
*/
/*
select *
from homegames
where year = 2016
order by team;
--There's 1 team (ATL) that played a single game at a different park, but since the question asks for average attendance as a function of team *and*
--park I'm not combining the lines.

select park, team, attendance/games as avg_attendance
from homegames as h1
where year = 2016
and games > 10
order by avg_attendance desc
limit 5;

select park, team, attendance/games as avg_attendance
from homegames h2
where year = 2016
and games > 10
order by avg_attendance
limit 5;
*/

/*
3. Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors?
*/

/*
select *
from collegeplaying
where schoolid like 'vand%'

select *
from salaries

select concat(namefirst,' ', namelast) as fullname, sum(salary) as total_salary
from salaries
	inner join collegeplaying
	using (playerid)
	inner join people
	using (playerid)
where schoolid ilike 'vand%'
group by fullname
order by total_salary desc
*/

/*
9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.
*/

--list of managers and year they won specified award, still working on structuring the join to managers and people tables to get full name and team
select playerid, yearid
from awardsmanagers
where awardid like 'TSN%'
and (lgid like 'NL' or lgid like 'AL');
