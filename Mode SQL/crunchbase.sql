/*
Write a query that performs an inner join between the tutorial.crunchbase_acquisitions
table and the tutorial.crunchbase_companies table, but instead of listing individual
rows, count the number of non-null rows in each table. */

SELECT COUNT(a.company_permalink) , COUNT(c.permalink)
FROM tutorial.crunchbase_acquisitions a
INNER JOIN tutorial.crunchbase_companies c
ON a.company_permalink = c.permalink

/*
Modify the query above to be a LEFT JOIN. Note the difference in results.
*/

SELECT COUNT(a.company_permalink) , COUNT(c.permalink)
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
ON a.company_permalink = c.permalink


/*
Count the number of unique companies (don't double-count companies) and unique
acquired companies by state. Do not include results for which there is no state
data, and order by the number of acquired companies from highest to lowest.*/

SELECT state_code, COUNT(DISTINCT c.permalink), COUNT(DISTINCT a.company_permalink)
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
ON a.company_permalink = c.permalink
WHERE state_code IS NOT NULL
GROUP BY state_code
ORDER BY 3 DESC

/*
Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.
*/
SELECT companies.state_code,
COUNT(DISTINCT companies.permalink) AS unique_companies,
COUNT(DISTINCT acquisitions.company_permalink) AS unique_companies_acquired
  FROM tutorial.crunchbase_acquisitions acquisitions
  RIGHT JOIN tutorial.crunchbase_companies companies
ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC

 /*
 Write a query that shows a company's name, "status" (found in the Companies table),
 and the number of unique investors in that company. Order by the number of investors
 from most to fewest. Limit to only companies in the state of New York.
 */

SELECT ci.company_name, cc.status, COUNT(DISTINCT ci.investor_name) as unique_investors
FROM tutorial.crunchbase_investments ci
LEFT JOIN tutorial.crunchbase_companies cc
ON ci.company_permalink = cc.permalink
WHERE company_state_code = 'NY'
GROUP BY 1, 2
ORDER BY 3 DESC
