/*
SQL Schema
Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
*/

WITH CTE
AS
(
SELECT *,
LEAD(num,1) OVER (ORDER BY id) as second,
LEAD(num,2) OVER (ORDER BY id) as third
FROM logs
)
SELECT  DISTINCT num as consecutivenums
FROM CTE
WHERE num=second AND num=third
