/*
SELECT total.playerid, sb/total
FROM(SELECT playerid, sb, cs, SUM (sb+cs) as total
	FROM fielding
	group by playerid, sb, cs)
WHERE CHART.total > 20
GROUP BY total.playerid

SELECT playerid, ((sb::numeric/sum)*100) as success
FROM (SELECT playerid, sb, cs, SUM (sb+cs)
			      FROM fielding
	              GROUP BY playerid, sb, cs) AS simple
WHERE sum > 20 
ORDER BY success DESC
*/

SELECT playerid, yearid, (ROUND((sb::numeric/sum)*100)) as success
FROM (SELECT playerid, sb, cs, SUM (sb+cs), yearid
			      FROM fielding
	              GROUP BY playerid, sb, cs, yearid) AS simple
WHERE sum > 20 and yearid = 2016
ORDER BY success DESC

