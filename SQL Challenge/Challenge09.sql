CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" CHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;



--1.-List the employee number, last name, first name, 
--sex, and salary of each employee.


SELECT e.last_name, e.first_name,e.sex, s.salary FROM employees e
JOIN salaries s ON e.emp_no = s.salary

--2.-List the first name, last name, and hire date for the 
--employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e 
WHERE EXTRACT (YEAR FROM e.hire_date)=1986

--3.-List the manager of each department along with their department 
--number, department name, employee number, last name, and first name.
SELECT 
    e.emp_no,
	e.last_name,
	e.first_name,
    dm.emp_no, 
    dp.dept_no,
	dp.dept_name
FROM 
    employees AS e
INNER JOIN 
    dept_manager AS dm ON e.emp_no = dm.emp_no
INNER JOIN 
    departments AS dp ON dm.dept_no = dp.dept_no;
--4.-List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.
SELECT 
    e.emp_no,
	e.first_name,
	e.last_name,
    dp.dept_no,
	dp.dept_name
FROM 
    employees AS e
INNER JOIN 
    dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN 
    departments AS dp ON de.dept_no = dp.dept_no;

--5.- List first name, last name, and sex of each employee whose first name 
--is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.-List each employee in the Sales department, including their employee number,
--last name, and first name.
SELECT e.emp_no,e.first_name,e.last_name, d.dept_name 
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no WHERE d.dept_name IN ('Sales');
	
--7.-List each employee in the Sales and Development departments, including their employee number,
--last name, first name, and department name.
SELECT e.emp_no,e.first_name,e.last_name, d.dept_name 
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no WHERE d.dept_name IN ('Sales', 'Development');

--8.- List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;



