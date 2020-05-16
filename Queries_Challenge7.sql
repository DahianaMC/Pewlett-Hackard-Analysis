-- Create table for Deliverables 1 - 1st Table using from_date
DROP TABLE Retirement_employees_by_Title;
SELECT 	e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	s.salary
INTO Retirement_employees_by_Title
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- Number of individuals to retire born btw 1952-01-01 to 1955-12-31 inlcuding duplicates
SELECT COUNT(emp_no)
FROM Retirement_employees_by_Title;

-- Checking info from table Retirement_employees_by_Title
SELECT * FROM Retirement_employees_by_Title;

-- Partition the data to show only most recent title per employee using from date
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date
FROM
(SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
 ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM Retirement_employees_by_Title
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Make Table1 Deliverable1 using to date
SELECT 	e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.to_date,
	s.salary
INTO Retire_empbytitle_to_date
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


-- Partition the data to show only most recent title per employee from 
-- table emp_no_bylasttitle_from_Retire_empbytitle_to_date
SELECT emp_no,
	first_name,
	last_name,
	title,
	to_date
INTO emp_no_bylasttitle_from_Retire_empbytitle_to_date
FROM
(SELECT emp_no,
	first_name,
	last_name,
	title,
	to_date,
 ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM Retire_empbytitle_to_date
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Check table emp_no_bylasttitle_from_Retire_empbytitle_to_date
SELECT * FROM emp_no_bylasttitle_from_Retire_empbytitle_to_date;

-- Number of individuals retiring
SELECT COUNT(emp_no) "Number_of_individuals_retiring"
FROM emp_no_bylasttitle_from_Retire_empbytitle_to_date;

-- Getting count for employees by title
SELECT COUNT(ret.emp_no) AS "Total_emp_to_retire_by_Title", ret.title
INTO count_bytitle
FROM emp_no_bylasttitle_from_Retire_empbytitle_to_date AS ret
GROUP BY ret.title
ORDER BY ret.title;

-- Check table count_bytitle
SELECT * FROM count_bytitle;

-- Number of [titles] retiring
SELECT COUNT(title) "Number_of_Titles_Retiring"
from count_bytitle;

-- Create table for Deliverables 2 - Mentorship Eligibility
SELECT 	e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO mentorship_elegibility
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31';

-- Number of individuals for mentorship role including duplicates emp_no
SELECT COUNT(emp_no)
FROM mentorship_elegibility;

-- Check table mentorship_elegibility
SELECT * FROM mentorship_elegibility;

-- Checking for duplicates in mentorship_elegibility, leave last title
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO mentorship_elegibility_lasttitle
FROM
(SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date,
 ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM mentorship_elegibility
 ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Check table mentorship_elegibility_lasttitle
SELECT * FROM mentorship_elegibility_lasttitle;

-- Number of individuals for mentorship role
SELECT COUNT(emp_no) Number_of_individuals_for_mentorship
FROM mentorship_elegibility_lasttitle;