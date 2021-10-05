-- join

-- 예제1
-- employees 테이블과 titles 테이블을 join하여 직원의 이름과 직책을 모두 출력 하세요.

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name, b.title
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no;
        
-- employees 테이블과 titles 테이블을 join하여 직원의 이름과 직책을 출력하되 여성엔지니어만 출력하세요.
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name, b.title
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no AND a.gender = 'f'
        AND b.title = 'engineer';
        
-- natural join
-- 두 테이블에 공통 칼럼이 있으면 별다른 조인 조건없이 묵시적으로 조인됨
-- 쓸일이 없음
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name, b.title
FROM
    employees a
        JOIN
    titles b;
    
-- on a. emp_no = b.emp_no 생략


-- join ~ using
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name, b.title
FROM
    employees a
        JOIN
    titles b USING (emp_no);
    
    
--  예제 3: 직원의 이름과 직책을 모두 출력 하되 여성 엔지니어만 출력 하세요(join~on)
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name, b.title
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no
        JOIN
    salaries c ON b.emp_no = c.emp_no
WHERE
    a.gender = 'f' AND b.title = 'engineer';
    

        
        
-- 실습문제 1:
-- 현재 직원별 근무부서를 사번, 직원전체이름, 근무부서 형태로 출력해 보세요.
select count(*)
from
	employees a
	join
        dept_emp b on a.emp_no = b.emp_no
        join 
	departments c on b.dept_no = c.dept_no
        where b.to_date = '9999-01-01';
        
        
select * from employees;
select * from titles;


--  실습문제 2:  현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요.사번,  전체이름, 연봉  이런 형태로 출력하세요.    
SELECT 
    a.emp_no,
    CONCAT(b.first_name, ' ', b.last_name) AS name,
    a.salary
FROM
    salaries a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01';

-- 예제5 : 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.   
  select a.title, avg(salary), count(*)
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
group by a.title
  having count(*) >= 100
order by avg(salary) desc; 

-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요. 
   select d.dept_name, avg(b.salary)
     from dept_emp a, salaries b, titles c, departments d
    where a.emp_no = b.emp_no
	  and b.emp_no = c.emp_no
      and a.dept_no = d.dept_no
	  and a.to_date = '9999-01-01'
      and b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and c.title = 'Engineer'
 group by d.dept_name;     


-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요. 
-- 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.
  select a.title, sum(b.salary) as sum_salary
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
     and a.title != 'Engineer'
group by a.title
  having  sum_salary > 2000000000
order by sum_salary desc;  
   