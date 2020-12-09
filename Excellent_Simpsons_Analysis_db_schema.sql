-- Create all 8 tables for Excellent_Simpson_Analysis db

-- Drop tables using CASCADE to remove dependencies as well
DROP TABLE IF EXISTS Season_Year CASCADE;

DROP TABLE IF EXISTS All_Episodes CASCADE;

DROP TABLE IF EXISTS Baby_Names_Popularity CASCADE;

DROP TABLE IF EXISTS Guest_Stars_All CASCADE;

DROP TABLE IF EXISTS Guest_Stars_Season CASCADE;

DROP TABLE IF EXISTS Viewers CASCADE;

DROP TABLE IF EXISTS Ratings CASCADE;

DROP TABLE IF EXISTS Episode_Phrases CASCADE;

CREATE TABLE titles (
	title_id VARCHAR(30) NOT NULL,
	title VARCHAR(50) NOT NULL,
 	PRIMARY KEY(title_id)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_data DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE departments (
	dept_no VARCHAR(30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY(dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY(dept_no, emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);