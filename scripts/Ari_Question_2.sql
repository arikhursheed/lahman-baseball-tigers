--QUESTION_2
	--Find the name and height of the shortest player in the database.
	--How many games did he play in? What is the name of the team for which he played?
with shortest_player as (SELECT namefirst,playerid, height as shortest_player
                          from people
                          where height= (SELECT min(height) from people))
						  
SELECT namefirst , G_all, teamid
from appearances inner join shortest_player
using (playerid)