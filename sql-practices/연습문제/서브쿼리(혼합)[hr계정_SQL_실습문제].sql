-- 서브쿼리(SUBQUERY) SQL 문제입니다.

select *
from employees e join salaries s on e.emp_no = s.emp_no
				join titles t on e.emp_no = t.emp_no
                
-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select count(*) as '평균 연봉보다 많은 월급 받는 직원 수'
from employees e
join salaries s on e.emp_no = s.emp_no
where salary > (select avg(salary) 
				from salaries
                where to_date >= current_date)
and s.to_date >= current_date;

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 (및?)연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

-- sol1 : where subquery any
SELECT 
    e.emp_no,
    CONCAT(first_name, ' ', last_name) name,
    dept_name,
    salary
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no
        JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    (dept_no , salary) IN (SELECT 
            d.dept_no, MAX(salary)
        FROM
            dept_emp de
                JOIN
            departments d ON de.dept_no = d.dept_no
                JOIN
            employees e ON de.emp_no = e.emp_no
                JOIN
            salaries s ON de.emp_no = s.emp_no
        WHERE
            s.to_date > CURRENT_DATE
                AND de.to_date > CURRENT_DATE
        GROUP BY d.dept_no)
        AND s.to_date > CURRENT_DATE
        AND de.to_date > CURRENT_DATE
ORDER BY salary DESC
;
                    
-- sol2 : from subquery
SELECT 
    e.emp_no,
    CONCAT(first_name, ' ', last_name) name,
    dept_name,
    salary
FROM
    dept_emp de,
    departments d,
    employees e,
    salaries s,
    (SELECT 
        dept_no, MAX(salary) 'max_salary'
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    WHERE
        s.to_date > CURRENT_DATE
            AND de.to_date > CURRENT_DATE
    GROUP BY dept_no) temp
WHERE
    salary = max_salary
        AND d.dept_no = temp.dept_no
        AND s.to_date > CURRENT_DATE
        AND de.to_date > CURRENT_DATE
        AND de.dept_no = d.dept_no
        AND de.emp_no = e.emp_no
        AND de.emp_no = s.emp_no
ORDER BY max_salary DESC
;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

SELECT 
    e.emp_no, dept_no, first_name, salary
FROM
    dept_emp de,
    employees e,
    salaries s,
    (SELECT 
        AVG(salary) AS avg_salary
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    GROUP BY dept_no) a_s
WHERE
    salary > avg_salary
        AND de.to_date > CURRENT_DATE
        AND s.to_date > CURRENT_DATE
        AND de.emp_no = e.emp_no
        AND de.emp_no = s.emp_no
ORDER BY dept_no
;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

SELECT 
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) name,
    manager_name,
    dept_name,
    de.to_date,
    manager.to_date
FROM
    employees e,
    departments d,
    dept_emp de,
    (SELECT 
        dept_no AS manager_dept_no,
            CONCAT(e.first_name, ' ', e.last_name) AS manager_name,
            to_date
    FROM
        dept_manager dm
    JOIN employees e ON dm.emp_no = e.emp_no
    WHERE
        to_date > CURRENT_DATE) manager
WHERE
    manager_dept_no = d.dept_no
        AND e.emp_no = de.emp_no
        AND d.dept_no = de.dept_no
        AND de.to_date > CURRENT_DATE
ORDER BY e.emp_no
;

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
-- sub : 부서별 평균연봉 
SELECT 
    e.emp_no,
    de.dept_no,
    CONCAT(e.first_name, ' ', e.last_name) name,
    title,
    salary
FROM
    employees e,
    titles t,
    dept_emp de,
    salaries s,
    (SELECT 
        dept_no, MAX(avg_salary)
    FROM
        (SELECT 
        dept_no, AVG(salary) AS avg_salary
    FROM
        salaries s
    JOIN dept_emp de ON s.emp_no = de.emp_no
    WHERE
        s.to_date > CURRENT_DATE
            AND de.to_date > CURRENT_DATE
    GROUP BY dept_no) dept_salary) max_avg_dept
WHERE
    max_avg_dept.dept_no = de.dept_no
        AND e.emp_no = de.emp_no
        AND e.emp_no = t.emp_no
        AND e.emp_no = s.emp_no
        AND t.to_date > CURRENT_DATE
        AND de.to_date > CURRENT_DATE
        AND s.to_date > CURRENT_DATE
ORDER BY salary
;

-- 질문
SELECT 
    dept_no, MAX(avg_salary)
FROM
    (SELECT 
        dept_no, AVG(salary) AS avg_salary
    FROM
        salaries s
    JOIN dept_emp de ON s.emp_no = de.emp_no
    WHERE
        s.to_date > CURRENT_DATE
            AND de.to_date > CURRENT_DATE
    GROUP BY dept_no) a
;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 

SELECT 
    dept_name
FROM
    departments d,
    (SELECT 
        dept_no, MAX(avg_salary) AS max_salary
    FROM
        (SELECT 
        dept_no, AVG(salary) AS avg_salary
    FROM
        salaries s
    JOIN dept_emp de ON s.emp_no = de.emp_no
    WHERE
        s.to_date > CURRENT_DATE
            AND de.to_date > CURRENT_DATE
    GROUP BY dept_no) avg_sal_dept) max_sal_dept
WHERE
    max_sal_dept.dept_no = d.dept_no
;
 
-- 문제7.
-- 평균 연봉이 가장 높은 직책?

SELECT 
    title
FROM
    (SELECT 
        title, MAX(avg_salary)
    FROM
        (SELECT 
        title, AVG(salary) avg_salary
    FROM
        titles t
    JOIN salaries s ON s.emp_no = t.emp_no
    GROUP BY title) avg_title) max_avg_title
;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

-- manager table

SELECT 
    dept_name,
    CONCAT(first_name, ' ', last_name) name,
    salary,
    manager_name,
    manager_salary
FROM
    departments d,
    dept_emp de,
    employees e,
    salaries s,
    (SELECT 
        dept_no AS manager_dept_no,
            CONCAT(e.first_name, ' ', e.last_name) AS manager_name,
            salary AS manager_salary
    FROM
        dept_manager dm
    JOIN employees e ON dm.emp_no = e.emp_no
    JOIN salaries s ON s.emp_no = dm.emp_no
    WHERE
        dm.to_date > CURRENT_DATE
            AND s.to_date > CURRENT_DATE) manager
WHERE
    de.emp_no = e.emp_no
        AND de.dept_no = d.dept_no
        AND s.emp_no = e.emp_no
        AND manager_dept_no = d.dept_no
        AND de.to_date > CURRENT_DATE
        AND s.to_date > CURRENT_DATE
        AND salary > manager_salary
;
