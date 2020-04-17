		
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

--notes/checking answer:
--select DISTINCT pos from fielding --7 possible position types
--select pos from fielding where yearid = 2016 --1953 rows





