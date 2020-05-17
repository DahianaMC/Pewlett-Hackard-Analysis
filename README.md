# Pewlett-Hackard-Analysis
## Challenge 7 SQL

### Summary
- A client is requesting 2 Technical Analysis for his employees.  The client would like to use sql to make the analysis.
- The Technical Analysis consists:
  - Deliverable 1: Technical Analysis 1: Number of Retiring Employees by Title.  Client would like to create the retirement information in 3 tables:
    - Table 1: Provide a table with employee number, first and last name, title, from_date and salary for employees born between 1952-1955.  This table includes duplicate rows.
    - Table 2: Provide a table only showing the employees with the most recent title using table 1.
    - Table 3: Provide a table showing the number of employees per title.
  
  - Deliverable 2: Technical Analysis 2: Mentorship Eligibility.  Provide mentorship eligibility as follow:
    - Table 1: Provide a table with employee number, first and last name, title, from_date and to_date for employees born between Jan 1, 1965 and Dec 31, 1965, and check for duplicates.  

### Files for the analysis:
- CSV provided by client:
  - Departments
  - Employees
  - Managers
  - Dept_emp
  - Salaries
  - Titles
- Result Tables (cvs files):
  - Folder Tables_for_Technical_Analysis1 contains:
    - retirement_emp_bytitle (using from_date)
    - retire_empbytitle_to_date (using to_date)
    - emp_no_bylasttitle_from_Retire_empbytitle_to_date (table after handling the employees duplicate)
    - count_bytitle (employees count by title)
  - Folder Tables_for_Technical_Analysis2 contains:
    - mentorship_elegibility (with employees duplicate)
    - mentorship_elegibility_lasttitle (table after handling the employees duplicate)
- ERD:EmployeeDB.png
- Queries files:
  - Queries_Challenge7.sql (queries used for challenge)
  - schema.sql (queries used to create the tables provided by client)

## Analysis
### Information provided by client:
  - The client made available 6 tables that includes employee information.  The summary of the information is presented in an Entity Relationship Diagram (ERD), where we can understand the relationship between the tables:
  ![EmployeeDB](https://github.com/DahianaMC/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)
  - We created the tables showed in the ERD and import the information provided by client to each table.  The schema.sql file has the queries to create the 6 tables presented in the ERD.
  
### Technical Analysis 1.  Number of Retiring Employees by Title
  - Using the ERD we can understand where we need to extract the data to accomplish the requirements from the client.
  - To generate the table 1 we need to use 3 tables from the ERD, Employees, Title and Salaries.
  - We used 2 inner joins to get the information for the employees. First inner join was used to join employees and title tables using the employee number (emp_no) to make the join.  Only emp_no matching in both tables (Employees and Titles) are going to be presented in table1.  First and last name is taking from employees table, titles and from_date from titles table.  The second inner join was used to join employees and salaries tables using emp_no to have the salaries for the employees (only emp_no matching in both tables are going to be presented in table1).  Finally we only select the employees that born between 1952 and 1955.  Notice this table has duplicated emp_no(like employee ID), because there are employees that has changed the job position (title) and have more that one title while has been working with the client.  This process generates table 1: "retirement_emp_bytitle". 
  - In table 2 we only select the employee with the most recent title, so we should not have more employees duplicate.  We used Partitioning to generate table 2: "emp_no_bylasttitle_from_Retire_empbytitle_to_date".  NOTE: on the first table the challenge requested from_date, the partition suggested to use to_date, we generated another table with to_date to make table 2, also notice if we use from_date (descending order) for the partition we get same information as we were using to_date, query is included on Queries_Challenge7.sql)
  - Total number of employees to retire from table 1 was: 133776 employees.  After handling the employee duplicates the number of employees was: 90398 employees (from table 2).  Both queries are included on Queries_Challenge7.sql.
  - Table 3: "count_bytitle", shows the number of employees by each title.  This give us an idea how many people are going to be retired by title.  Table is showing below:
  - ![count_bytitle.csv](https://github.com/DahianaMC/Pewlett-Hackard-Analysis/blob/master/Tables_for_Technical_Analysis1/count_bytitle.png)
  - Table3 shows there is a higher number of Senior employees about to retire.  Client could take advantage of this information and plan to get employees trained before the Senior employees retire.
  
### Technical Analysis 2: Mentorship Eligibility.
  - Using the ERD again, we find the tables needed to create the mentorship eligibility table required by client.  In this case client is asking for a table containing employee number, first and last name, title and from_date and to_date.  Tables Employees and Titles has the information requested.
  - We used one inner join to generate table 4: "mentorship_elegibility".  Only the employee ID (emp_no) matching in both tables (Employees and Titles) are going to be presented in table 4. The first and last name came from Employees table, and title, from_date and to_date came from Titles table.  Also client requested to generate this table only for employees born between Jan 1, 1965 and Dec 31, 1965.  This table contains duplicate employees ID because there are some employees that have more than one job position (title) during the time working with the client.
  - In table5: "mentorship_elegibility_lasttitle", we are handling the duplicate rows.  We only leave the emp_no with the most updated title reported.  In this case we also used partitioning, and used to_date to make the partition. 
  - The total of employees for mentorship eligibility from table 4 (table with duplicates) is 2846 employees.  After handling the duplicates the total of employees eligible for mentorship is 1940 employees.  Both queries are included on Queries_Challenge7.sql. 
  
## Conclusions and Recommendations
- It is very important to hand the duplicates in this case because there is only one emp_no (employee ID) per employee.  Counting the total of employees in the tables were emp_no is duplicated, generates the count to be wrong, there are employees that will be counted twice or more times, as we can see when we make the count of the tables after handling the duplicate rows.

- Since the list of employees about to retire is still very long, client can use more conditions to make several tables of the employees identifying for example the department where they are working, and also they can create a table with managers about to retire.  Having tables with more concise information, make it easier for the client to review.

- It is important for the client to know the age distribution of the employees.  Client can have a table where can use conditions based on birth date and have the employees on these ranges.  The tables can include information like title, salary, hire_date, department.

