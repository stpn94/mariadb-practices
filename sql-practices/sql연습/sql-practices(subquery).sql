-- < subquery >
use employees;

-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요.
SELECT 
    *
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale';
	
SELECT 
    a.emp_no, a.first_name
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.dept_no = 'd004';      

-- 아래 위 두 쿼리를 합쳐보자.

SELECT 
    a.emp_no, a.first_name
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.dept_no = (SELECT 
							 b.dept_no
						 FROM
							 employees a,
							 dept_emp b
						 WHERE
							 a.emp_no = b.emp_no
								 AND b.to_date = '9999-01-01'
								 AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale');        

-- 1) from 절 
SELECT NOW() AS n, SYSDATE() s, 3 + 1 c;

SELECT 
    s.n, s.s, s.c
FROM
    (SELECT NOW() AS n, SYSDATE() s, 3 + 1 c) AS s;

-- 2-1) where : 단일행
-- 단일행 연산자 : = > < <= >= !=

-- ex ) print emp_no, full name of each employee who works in the department which "Fai Bale" currently works
SELECT 
    e.emp_no, CONCAT(first_name, ' ', last_name) AS name
FROM
    dept_emp de
        JOIN
    employees e ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
WHERE
    d.dept_name = (SELECT 
            d.dept_name
        FROM
            dept_emp de
                JOIN
            employees e ON e.emp_no = de.emp_no
                JOIN
            departments d ON d.dept_no = de.dept_no
        WHERE
            de.to_date >= CURRENT_DATE
                AND e.first_name = 'Fai'
                AND e.last_name = 'Bale')
;

-- ex ) show name, salary of each employee who's current salary is less than average employees' salary
SELECT 
    first_name, salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date >= CURRENT_DATE)
        AND s.to_date >= CURRENT_DATE
ORDER BY salary DESC
;

-- ex ) show current lowest average salary of the title
-- 		method 1) min(avg(salary))
SELECT 
    title, MIN(s.title_salary)
FROM
    (SELECT 
        title, AVG(salary) AS title_salary
    FROM
        titles t
    JOIN salaries s ON s.emp_no = t.emp_no
    WHERE
        t.to_date >= CURRENT_DATE
            AND s.to_date >= CURRENT_DATE
    GROUP BY title) AS s
;
-- 		method 2) top-k : mysql에서만 제공하는 것
SELECT 
    title, AVG(salary) AS title_salary
FROM
    titles t
        JOIN
    salaries s ON s.emp_no = t.emp_no
WHERE
    t.to_date >= CURRENT_DATE
        AND s.to_date >= CURRENT_DATE
GROUP BY title
ORDER BY title_salary
LIMIT 0 , 1
;
-- 		method 3) having
SELECT 
    title, AVG(salary) AS title_salary
FROM
    titles t
        JOIN
    salaries s ON s.emp_no = t.emp_no
WHERE
    t.to_date >= CURRENT_DATE
        AND s.to_date >= CURRENT_DATE
GROUP BY title
HAVING title_salary = (SELECT 
        MIN(title_salary)
    FROM
        (SELECT 
            AVG(salary) AS title_salary
        FROM
            titles t
        JOIN salaries s ON s.emp_no = t.emp_no
        WHERE
            t.to_date >= CURRENT_DATE
                AND s.to_date >= CURRENT_DATE
        GROUP BY title) AS a)
;

-- 2-2) where : 복수행
-- 복수행 연산자 : in, not in, any, all

-- any 사용법
-- 1. = any : equals with "in"
-- 2. > any : minimum
-- 3. > any : maximum
-- 4. <> any : equals with "not in"

-- ex ) show employee's name who currently got paid more than 50000 
SELECT 
    first_name, salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    to_date >= CURRENT_DATE
        AND salary IN (SELECT 
            salary
        FROM
            salaries
        WHERE
            to_date >= CURRENT_DATE
                AND salary > 50000)
ORDER BY salary;
