/*
--1. What range of years does the database cover?
/*Final answer: The database covers the years 1871-2016, 146 years. The exceptions to this are the following tables:
		people - birth years range from 1820 to 1996 (176 years total with 166 year in database as having someone born in that year)
		collegeplaying - 1864 to 2014 (151 years)
	The years covered is stated in the data dictionary, and confirmed by checking main tables.
	However, we clarified that the intent was to ask what years of professional baseball are in the database so the answer is 146 years (1871-2016).*/

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