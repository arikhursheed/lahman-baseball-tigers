--QUESTION_2
	--Find the name and height of the shortest player in the database.
	--How many games did he play in? What is the name of the team for which he played?
with shortest_player as (SELECT concat(namefirst,' ',namelast) AS name,
						        playerid, 
						        height*0.083333 as shortest_height_feet
                          from people
                          where height= (SELECT min(height) from people))
						  
SELECT DISTINCT shortest_player.name,
                 G_all,
				 teams.teamid, 
	             teams.name AS team_name,
				 shortest_player.shortest_height_feet
from appearances inner join shortest_player
using (playerid)
inner join teams 
on teams.teamid = appearances.teamid



--The shortes player Eddie 3.58, he played 1 game, and the team is SLA
------------------------------------------------