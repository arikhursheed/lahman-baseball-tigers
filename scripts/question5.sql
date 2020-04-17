--Q5. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. 
--Do the same for home runs per game. Do you see any trends?
	 
WITH so_pergame_year AS (SELECT yearid, SUM(so)::numeric/(SUM(g)/2)::numeric AS so_pergame 
						  FROM teams GROUP BY yearid),
    hr_pergame_year AS (SELECT yearid, SUM(hr)::numeric/(SUM(g)/2)::numeric AS hr_pergame 
					  	FROM teams GROUP BY yearid)
SELECT CASE WHEN yearid BETWEEN '1920' AND '1929' THEN '1920s'
	        WHEN yearid between '1930' and '1939' then '1930s'
			WHEN yearid between '1940' and '1949' then '1940s'
			WHEN yearid between '1950' and '1959' then '1950s'
			WHEN yearid between '1960' and '1969' then '1960s'
			WHEN yearid between '1970' and '1979' then '1970s'
			WHEN yearid between '1980' and '1989' then '1980s'
			WHEN yearid between '1990' and '1999' then '1990s'
			WHEN yearid between '2000' and '2009' then '2000s'
			WHEN yearid between '2010' and '2019' then '2010s' ELSE 'notcounted' END AS decade,
			ROUND(AVG(hr_pergame), 2) AS avg_hr_pergame,
			ROUND(AVG(so_pergame), 2) AS avg_so_pergame
FROM teams
JOIN hr_pergame_year USING (yearid)
JOIN so_pergame_year USING (yearid)
GROUP BY decade
ORDER BY decade;