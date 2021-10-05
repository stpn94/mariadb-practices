-- 테이블간 조인(JOIN) SQL 문제입니다.
use employees;

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.

SELECT 
    employees.emp_no, first_name, salary
FROM
    employees
        JOIN
    salaries ON employees.emp_no = salaries.emp_no
ORDER BY salary DESC;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.

SELECT 
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.to_date > CURRENT_DATE
ORDER BY e.first_name;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..

SELECT 
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    d.dept_name
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    de.to_date > CURRENT_DATE
ORDER BY e.first_name
;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.

SELECT 
    e.emp_no,
    CONCAT(first_name, ' ', last_name) AS name,
    salary,
    title,
    d.dept_name
FROM
    dept_emp de
        JOIN
    employees e ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
        JOIN
    titles t ON de.emp_no = t.emp_no
WHERE
    s.to_date > CURRENT_DATE
        AND t.to_date > CURRENT_DATE
;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.

SELECT 
    e.emp_no, first_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    title = 'Technique Leader'
        AND t.to_date < CURRENT_DATE
;

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.

SELECT 
    CONCAT(first_name, ' ', last_name) AS name, dept_name, title
FROM
    dept_emp de
        JOIN
    employees e ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
        JOIN
    titles t ON t.emp_no = e.emp_no
WHERE
    last_name LIKE 'S%'
;

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.

SELECT 
    e.emp_no, e.first_name, salary, title, t.to_date, s.to_date
FROM
    employees e
        JOIN
    titles t ON t.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    title = 'Engineer' AND salary > 40000
        AND s.to_date >= CURRENT_DATE
        AND t.to_date >= CURRENT_DATE
ORDER BY salary DESC
;

-- 문제8.
-- 현재 직책 평균 급여가 50000이 넘는 직책을 직책, 평균 급여로 평균 급여가 큰 순서대로 출력하시오

SELECT 
    title, AVG(salary) avg_salary
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
GROUP BY title
HAVING avg_salary > 50000
ORDER BY avg_salary
;

-- 현재 직책 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
SELECT 
    title, salary
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    salary > 50000
ORDER BY salary
;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.

SELECT 
    dept_name, AVG(salary)
FROM
    dept_emp de
        JOIN
    departments d ON d.dept_no = de.dept_no
        JOIN
    employees e ON e.emp_no = de.emp_no
        JOIN
    salaries s ON s.emp_no = de.emp_no
WHERE
    s.to_date >= CURRENT_DATE
GROUP BY d.dept_no
ORDER BY salary DESC
;

-- 문제10. 
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.

SELECT 
    title, AVG(salary)
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
WHERE
    t.to_date > CURRENT_DATE
        AND s.to_date > CURRENT_DATE
GROUP BY title
ORDER BY AVG(salary) DESC
;