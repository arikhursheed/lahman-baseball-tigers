--QUESTION_7
	--From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?
	--What is the smallest number of wins for a team that did win the world series?
	--Doing this will probably result in an unusually small number of wins for a world series champion – determine 
	--why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the
	--case that a team with the most wins also won the world series? What percentage of the time?

WITH year_filter AS (SELECT w , teamid, wswin
                     FROM teams
					--filter to 1970 up to 2016
					 WHERE yearid BETWEEN 1970 AND 2016
					 --AND "wswin" ILIKE '%y%' -- change to y or no
					GROUP by  w , teamid , wswin),
					 

max_filter AS (SELECT DISTINCT year_filter.teamid , year_filter.w AS number_win 
				--get yearid=(1970-2016) and wswin=N or y from CTE
				FROM year_filter INNER JOIN teams
				USING(teamid)
				--compare W with the subquery
				--get MIN(W) OR MAX(w) FROM year_filter
				WHERE year_filter.W= (SELECT max(w) from year_filter)) --subquery to get only largest or smallest #win from W column
/*SELECT DISTINCT teamid,number_win    -- join both CTE
FROM max_filter inner join year_filter
USING (teamid)*/
---------------------------------------
-- call both CTE tables to get the count of times team played and the percentage
SELECT count(*) , SUM (case when "wswin" ILIKE '%y%' then 1 else 0 end)*100/count(*) as percentage_time
FROM max_filter inner join year_filter
USING(teamid)

--largest win is 116 _SEA
--smallest  is 63 _LAN
-- 29 times the most win has won the world series too.
