/*
SQL Schema
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |


Your query should return the following result for the sample case above.


| seat_id |
|---------|
| 3       |
| 4       |
| 5       |
Note:
The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.
*/

WITH CTE
As
(
SELECT *,
LAG(free,1) OVER (ORDER BY seat_id) as previous_seat,
LEAD(free,1) OVER (ORDER BY seat_id) as next_seat
FROM cinema
)
SELECT seat_id
FROM CTE
WHERE (free =1 AND previous_seat = 1) OR (free =1 AND next_seat = 1)
ORDER BY 1
