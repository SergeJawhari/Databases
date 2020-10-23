-- Parth Patel
-- Sirage El-Jawhari

-- Problem 1

-- name of department
-- number of managers
-- maximum salary of manager category
SELECT d.dept_name AS "Department",
       COUNT(DISTINCT dm.emp_no) AS "Count",
       MAX(s.salary) AS "Maximum Salary"
       FROM departments d
INNER JOIN dept_manager dm ON d.dept_no = dm.dept_no
INNER JOIN employees e on dm.emp_no = e.emp_no
INNER JOIN salaries s on e.emp_no = s.emp_no
GROUP BY d.dept_name;



-- Problem 2

-- employees with average salary increase > $4400
-- employee name
-- average salary increase
-- get salary of previous year, get salary of current year, subtract all,
-- and then average all.
SELECT first_name, last_name, salary - LAG(s.salary) OVER
    (ORDER BY s.emp_no) AS difference
FROM employees e
    INNER JOIN salaries s on e.emp_no = s.emp_no
WHERE ((SELECT salary from salaries s2
        WHERE s.emp_no = s2.emp_no
        AND s2.from_date = s.to_date) - salary) > 4400;



-- Problem 3

-- year > 1995
-- number of employees that were engineers for that year
-- maximum salary among all of the engineers for that year
-- 2000 will have 102 AE with a maximum salary of $77,117
SELECT DISTINCT YEAR(DATE_ADD(t.from_date, INTERVAL 1 YEAR)) as year,
                COUNT(DISTINCT e.emp_no),
                MAX(salary)
FROM titles t
INNER JOIN employees e on t.emp_no = e.emp_no
INNER JOIN salaries s on e.emp_no = s.emp_no
WHERE t.title LIKE '%Engineer%'
GROUP BY year
HAVING year >= 1995;