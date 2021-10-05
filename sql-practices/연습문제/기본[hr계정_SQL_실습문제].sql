-- 문제1.
-- 사번이 10944인 사원의 이름은(전체 이름)

SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    employees
WHERE
    emp_no = '10944'
-- 가장 선임부터 출력이 되도록 하세요. 출력은
-- 이름, 성별, 입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해
-- 보세요.

select concat(first_name, ' ', last_name) as 이름, gender as 성별, hire_date as 입사일
  from employees 
 order by hire_date asc;


-- 문제3.(count), 쿼리 두 개 써도 괜찮
-- 여직원과 남직원은 각 각 몇 명이나 있나요?

SELECT 
    (SELECT 
            COUNT(gender)
        FROM
            employees
        WHERE
            gender = 'M') AS '남직원 인원수',
    (SELECT 
            COUNT(gender)
        FROM
            employees
        WHERE
            gender = 'F') AS '여직원 인원수';

SELECT 
    gender, SUM(gender)
FROM
    employees
GROUP BY gender;
-- 문제4.(where to_date='9999-01-01')
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.)

select count(to_date) from salaries where to_date='9999-01-01';

-- 문제5.
-- 부서는 총 몇 개가 있나요?

SELECT 
    MAX(dept_no)
FROM
    departments;


-- 문제6.
-- 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외, 현재 매니저)

SELECT 
    COUNT(emp_no)
FROM
    dept_manager
WHERE
    to_date = '9999-01-01';


-- 문제7.
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
-- (order by/ length(afsdfasd)

SELECT 
    *
FROM
    departments
ORDER BY LENGTH(dept_name) DESC;
 
-- 문제8.
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
-- where, count

SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    to_date = '9999-01-01'
        AND salary >= 120000;
        
        

-- 문제9.
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
-- length, order by, title

SELECT DISTINCT
    title
FROM
    titles
ORDER BY LENGTH(title) DESC;

-- 문제10
-- 현재,(9999) Engineer 직책의 사원은 총 몇 명입니까?

SELECT 
    COUNT(emp_no)
FROM
    titles
WHERE
    to_date = '9999-01-01'
        AND title = 'Engineer';

-- 문제11
-- 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
-- order by 

SELECT 
    *
FROM
    titles
WHERE
    emp_no = '13250'
ORDER BY from_date ASC;
