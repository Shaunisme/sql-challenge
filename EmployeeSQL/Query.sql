--List the following details of each employee: employee number, last name, first name, sex, and salary.
select
	a.emp_no as "Employee Number",
	a.last_name as "Last Name",
	a.first_name as "First Name",
	a.sex as "Sex",
	b.salary as "Salary"
FROM
	employees a, salaries b
where
	a.emp_no=b.emp_no
;

--List first name, last name, and hire date for employees who were hired in 1986.
set datestyle to 'Postgres, MDY'
;
select
	first_name as "First Name",
	last_name as "Last Name",
	hire_date as "Hire Date"
FROM
	employees
where
	date_part('year', hire_date) = '1986'
;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
create index idx1 on employees(emp_no)
;
analyze employees
;

select
	a.dept_no as "Department Number",
	b.dept_name as "Department Name",
	a.emp_no as "Manager Employee Number",
	c.last_name as "Last Name",
	c.first_name as "First Name"
FROM
	dept_manager a,
	department b,
	employees c
where
	a.dept_no = b.dept_no and
	a.emp_no = c.emp_no
;
a.emp_title_id

--List the department of each employee with the following information: employee number, last name, first name, and department name.
create index idx2 on dept_emp(emp_no)
;
create index idx3 on dept_emp(dept_no)
;
analyze dept_emp
;
select
	a.emp_no as "Employee Number",
	a.last_name as "Last Name",
	a.first_name as "First Name",
	b.dept_name as "Department Name"
FROM
	employees a,
	department b,
	dept_emp c
WHERE
	a.emp_no = c.emp_no and
	b.dept_no = c.dept_no
;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
create index idx4 on employees(first_name)
;
analyze employees
;
select
	first_name as "First Name",
	last_name as "Last Name",
	sex as "Sex"
from
	employees
where
	first_name = 'Hercules' and
	last_name like 'B%'
;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select
	a.emp_no as "Employee Number",
	a.last_name as "Last Name",
	a.first_name as "First Name",
	b.dept_name as "Department"
from
	employees a,
	department b,
	dept_emp c
where
	a.emp_no = c.emp_no and
	b.dept_no = c.dept_no and
	b.dept_name = 'Sales'
;

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select
	a.emp_no as "Employee Number",
	a.last_name as "Last Name",
	a.first_name as "First Name",
	b.dept_name as "Department"
from
	employees a,
	department b,
	dept_emp c
where
	a.emp_no = c.emp_no and
	b.dept_no = c.dept_no and
	b.dept_name = 'Development'
union
select
	a.emp_no as "Employee Number",
	a.last_name as "Last Name",
	a.first_name as "First Name",
	b.dept_name as "Department"
from
	employees a,
	department b,
	dept_emp c
where
	a.emp_no = c.emp_no and
	b.dept_no = c.dept_no and
	b.dept_name = 'Sales'
;

--List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
create index idx5 on employees(last_name)
;
analyze employees
;
select
	last_name as "Last Name",
	count(*) as "Count of Last Name"
from employees
group by last_name
order by 2 desc