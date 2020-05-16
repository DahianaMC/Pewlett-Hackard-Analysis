# Pewlett-Hackard-Analysis
## Challenge 7 SQL

### Review
- Client provided information about their employees and requested to use SQL to get two Tecnical Analysis.
  - Tecnical Analysis 1: Number of Retiring Employees by Title.  We are going to create the retirement information in 3 tables:
    - Table 1: Provide a table with employee number, first and last name, title, from_date and salary for employees born between 1952-1955.  This table includes duplicate rows.
    - Table 2: Provide a table only showing the employees with the most recent title using table 1.
    - Table 3: Provide a table showing the number of employees per title.
  
  - Technical Analysis 2: Mentorship Eligibility.  Provide mentorship eligibility as follow:
    - Table 1: Provide a table with employee number, first and last name, title, from_date and to_date and check for duplicates.

### Files Summary:
- Tables (cvs files)
  -
  -
  -
  -
  -
- ERD:EmployeeDB.png
- Queries_Challenge7.sql (queries used in postgres pgadmin4.)

## Analysis
### Information provided by client:
  - The client made available 6 tables that includes employees information.  The summary of the information is presented in an Entity Relationship Diagram (ERD), where we can understand the relationship between tables:
  ![EmployeeDB](https://github.com/DahianaMC/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)
  
### Technical Analysis 1.  Number of Retiring Employees by Title
  - Using the RED we can define where we need to extract the data to accomplish the requirements from the client.
  - To generate the table 1 we need to use 3 tables from the ERD, Employees, Title and Salaries.
  - We used 2 inner joins to get the informartion for the employees. First inner join was used to join employees and title tables using the employee number (emp_no) to make the join.  First and last name is taking from employees table and from_date from titles table.  The second inner join was used to join employees and salaries tables uisng emp_no to have the salaries for the employees.  Finally we only select the employees that born between 1952 and 1955.  Notice this table has duplicated emp_no(like employee ID), because there are employees that has changed the job position (title) and have more that one title while has been working with the client.  This process generates table 1: "retirement_emp_bytitle". 
  - In table 2 we only select the employee with the most recent title, so we should not have more employees duplicate.  We used Partitioning to generate table 2: "emp_no_bylasttitle_from_Retire_empbytitle_to_date".  NOTE: on the first table the challenge requested from_date, the partition suggested to use to_date, we generated another table with to_date to make table 2, also notice if we use from_date (descending order) for the partition we get same information as we were using to_date, query is included on Queries_Challenge7.sql)
  - Total number of employees to retire from table 1 was: 133776 employees.  After handling the employee duplicates the number of employees was: 90398 employees (from table 2).  Both queries are included on Queries_Challenge7.sql.
  


### Technical Analysis 2: Mentorship Eligibility.
  
_____________________________ 
    1. Information provided by client include ERD diagram
    - The information provided includes the tables showed in the ERD diag
    
    2. Include both tables for mentorship and let them know there is one table with duplicates
