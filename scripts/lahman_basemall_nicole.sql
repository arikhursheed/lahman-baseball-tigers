--Q1. What range of years does the provided database cover?
SELECT DISTINCT salaries.yearid as salaries_year, yearid as teams_year,
FROM teams
FULL JOIN salaries
USING(yearid)
ORDER BY salaries_year



--Q2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?

--Q3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
WITH vandyplay AS (SELECT distinct (playerid)
				FROM collegeplaying
                WHERE schoolid = 'vandy')
SELECT DISTINCT CONCAT(namefirst,' ',namelast)AS FullName, salary, salaries.playerid
FROM vandyplay 
INNER JOIN people on vandyplay.playerid = people.playerid
INNER JOIN salaries on vandyplay.playerid = salaries.playerid
GROUP BY fullname, salary
ORDER BY salaries.playerid
	
	
	
--Q4. Using the fielding table, group players into three groups based on their position: 
--label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
--and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
WITH putouts_2016 AS (SELECT pos, po, --sum(po)as total_po,
	 				CASE WHEN pos = 'OF' THEN 'Outfield'
	 				WHEN pos = 'P'OR pos = 'C' THEN 'Battery'
	 				ELSE 'Infield' END AS position_group 
					FROM fielding
					WHERE yearid = 2016
					GROUP BY pos, po, position_group
					ORDER BY position_group)
SELECT sum(po),position_group
FROM putouts_2016
GROUP BY position_group;

--Battery:37,630 ; Infield:54,080 ; Outfield:22,332

select DISTINCT pos from fielding --7 possible position types
select pos from fielding where yearid = 2016 --1953 rows



--Q5. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. 
--Do the same for home runs per game. Do you see any trends?
--do i need to include battingpost (SO)and pitchingpost(SO) tables?
--do we need so(so by pitchers)and soa(so by batters)?
--batting (SO), pitching(SO), teams (SO-2132, SOA-2132); teams(HR) for homeruns table per games(G) per yearid.

select yearid, sum(hr) as total_hr, sum(g) as total_g 
from teams 
group by yearid,hr,g 
order by yearid

WITH strikeouts_decade AS
		(SELECT SUM(so) AS total_so,
			CASE WHEN yearid >= 1920
		 		ELSE yearid + 10 
				END AS decade
				FROM teams
	 GROUP BY decade),
select decade from strikeouts_decade order by decade desc;
	 
SELECT yearid, round(AVG((so)/g),2) as avg_so_per_game,  --round(avg(so) OVER(PARTITION BY yearid ORDER BY yearid, yearid ROWS BETWEEN 10 PRECEDING AND CURRENT ROW),2)AS avg_so_per_game
			round(AVG((hr)/g),2) as avg_hr_per_game
FROM teams
WHERE yearid >= 1920
GROUP BY yearid, so
ORDER BY yearid;

select avg(so/g) from teams  --4.318
select avg(so), avg(g) from teams --when you divide avg(so)/avg(g) = 4.945
 
select * from teams
select sum(g) from teams  --batting g sum: 5278927, teams g sum: 426582

WITH strikeouts_per_decade AS
		(SELECT SUM(so) AS total_strikeouts,	
	 	concat(yearid::numeric, '-', yearid::numeric + 9) as decade_group
		from teams --should this be from batting????
		where yearid BETWEEN 1920 AND 2019 --AND yearid = 1930 --AND yearid = 1940
		group by decade_group),
games_per_decade AS
		(SELECT(SUM(g)/2) AS total_games, 
		   	concat(yearid::numeric, '-', yearid::numeric + 9) as decade_group
		FROM teams	  
	 	WHERE yearid BETWEEN 1920 AND 2019 --need this to be by 9 year intervals!!!
		GROUP BY decade_group
		ORDER BY decade_group DESC)
SELECT total_strikeouts, total_games, ROUND((total_strikeouts / total_games),2) AS avg_so_per_game, decade_group
FROM strikeouts_per_decade
INNER JOIN games_per_decade
USING (decade_group)
GROUP BY decade_group, total_strikeouts, total_games



--Q6. Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.


--Q7. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?


--Q8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.


--Q9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.