/*
9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.
*/

with tsn_award as (select playerid, yearid as award_year
				   from awardsmanagers
				   where awardid like 'TSN%'
				   and (lgid like 'NL' or lgid like 'AL'))
select concat(namefirst,' ',namelast) as full_name, teamid, award_year
from people
	join managers
	using (playerid)
	join tsn_award
	using (playerid)
where managers.yearid = award_year;