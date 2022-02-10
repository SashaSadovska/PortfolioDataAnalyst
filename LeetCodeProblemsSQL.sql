/*  Problem 183 @ LeetCode: 
Write an SQL query to report all customers who never order anything. */

SELECT Customers.name AS Customers
FROM Customers 
LEFT JOIN Orders ON Customers.id = Orders.customerId
WHERE Orders.id IS NULL



/*  Problem 182 @ LeetCode: 
Write an SQL query to report all the duplicate emails.*/

SELECT email AS Email FROM 
    (SELECT email, COUNT(email) AS email_count 
    FROM Person
    GROUP BY email) AS temp
WHERE email_count > 1

-- OR option 2:

SELECT Email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1



/*  Problem 181 @ LeetCode: 
Write an SQL query to find the employees who earn more than their managers. */

SELECT E.name AS Employee
FROM Employee E LEFT JOIN Employee M
ON E.managerId = M.id
WHERE E.salary > M.salary



/*  Problem 180 @ LeetCode: 
Write an SQL query to find all numbers that appear at least three times consecutively. */

WITH Logs1 AS (SELECT num, ROW_NUMBER() OVER(ORDER BY id) 'rowid' FROM Logs) -- if original id sequence has gaps

SELECT DISTINCT t1.num AS ConsecutiveNums
FROM Logs1 AS t1
INNER JOIN Logs1 AS t2 ON t2.rowid=t1.rowid+1 AND t2.num=t1.num
INNER JOIN Logs1 AS t3 ON t3.rowid=t2.rowid+1 AND t3.num=t2.num



/* Problem 178 @ LeetCode: Write an SQL query to rank the scores:
- The scores should be ranked from the highest to the lowest.
- If there is a tie between two scores, both should have the same ranking.
- After a tie, the next ranking number should be the next consecutive integer value */

SELECT score,
	DENSE_RANK () OVER ( 
		ORDER BY score DESC
	) 'rank' 
FROM Scores;



/*  Problem 176 @ LeetCode: 
Write an SQL query to report the second highest salary from the "Employee" table. 
If there is no second highest salary, the query should report null. */

SELECT 
    (SELECT DISTINCT salary 
    FROM Employee 
    ORDER BY salary DESC 
    LIMIT 1 OFFSET 1) AS SecondHighestSalary



/*  Problem 175 @ LeetCode: 
Write an SQL query to report the first name, last name, city, and state of each person in the "Person" table. 
If the address of a personId is not present in the "Address" table, report null instead. */



SELECT Person.firstName, Person.lastName, Address.city, Address.state
FROM Person
LEFT JOIN Address ON Person.personId = Address.personId