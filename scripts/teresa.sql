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