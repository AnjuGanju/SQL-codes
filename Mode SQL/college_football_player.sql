/*
Write a query that displays the number of players in each state, with FR, SO, JR,
and SR players in separate columns and another column for the total number of players.
Order results such that states with the most players come first. */

SELECT state, COUNT(*) as total_count,
SUM(CASE WHEN year = 'FR' THEN 1 ELSE 0 END) as Fr_count,
SUM(CASE WHEN year = 'SO' THEN 1 ELSE 0 END) as So_count,
SUM(CASE WHEN year = 'JR' THEN 1 ELSE 0 END) as Jr_count,
SUM(CASE WHEN year = 'SR' THEN 1 ELSE 0 END) as Sr_count
FROM benn.college_football_players
GROUP BY state
ORDER BY 2 DESC

/*
Write a query that calculates the combined weight of all
underclass players (FR/SO) in California as well as
the combined weight of all upperclass players (JR/SR) in California. */

SELECT
 CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
      WHEN year IN ('JR','SR') THEN 'upperclass'
      ELSE 'other' END as class,
      SUM(weight) as total
      FROM benn.college_football_players
  WHERE state ='CA'
  GROUP BY 1

  SELECT
 SUM(CASE WHEN year IN ('FR', 'SO') THEN weight ELSE 0 END) as underclass,
SUM(CASE WHEN year IN ('JR','SR') THEN weight ELSE 0 END) as upperclass
      FROM benn.college_football_players
      WHERE state ='CA'

/*
Write a query that counts the number of 300lb+
players for each of the following regions: West Coast (CA, OR, WA), Texas, and
Other (Everywhere else). */

SELECT
 CASE WHEN state IN ('CA','OR','WA') THEN 'West Coast'
      WHEN state = 'TX' THEN 'Texas'
      ELSE 'Other'
      END as random,
  COUNT(1)  as players
  FROM benn.college_football_players
  WHERE weight >= 300
  GROUP BY 1

/*
Write a query that selects all columns from benn.college_football_players
and adds an additional column that displays the player's name
if that player is a junior or senior.
*/

Select *,
CASE WHEN year = 'SR' or year ='JR' THEN player_name
 ELSE NULL
 END as random
 FROM benn.college_football_players


 /*
 Write a query that includes players' names and a column that classifies them into four categories
 based on height. Keep
 in mind that the answer we provide is only one of many possible answers,
 since you could divide players' heights in many ways.
 */

 SELECT player_name,
       height,
       CASE WHEN height > 74 THEN 'over 74'
            WHEN height > 72 AND height <= 74 THEN '73-74'
            WHEN height > 70 AND height <= 72 THEN '71-72'
            ELSE 'under 70' END AS height_group
  FROM benn.college_football_players

  
