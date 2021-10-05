-- 집계(통계) SQL 문제입니다.

-- 문제 1. 
-- 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.

select max(salary) as '최고임금', min(salary) as '최저임금', (max(salary) - min(salary)) as '최고임금 - 최저임금' from salaries;

-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일

select date_format(max(hire_date),'%Y년 %m월 %d일') as'마지막 신입사원 입사날' from employees;

-- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일

select *
from titles;

select date_format(min(hire_date),'%Y년 %m월 %d일') as '가장 오래 근속 직원 입사일',e.first_name,e.hire_date,t.from_date
  from employees e join titles t on e.emp_no=t.emp_no
 where t.to_date='9999-01-01';
 

-- 
select *
from titles;

select timestampdiff(curdate(), '1999-01-01');

SELECT 
    max(datediff(a.to_date,a.from_date))
FROM
    (SELECT 
        from_date,
            (IF(to_date = '9999-01-01', curdate(), to_date)) as to_date
    FROM
        titles
	WHERE
	WHERE
		
        ) a;

 SELECT 
        from_date,
            IF(to_date = '9999-01-01', curdate(), to_date)
    FROM
        titles;


-- 문제4.
-- 현재 이 회사의 평균 연봉은 얼마입니까?

select avg(salary) as 'mean salary' from salaries;

-- 문제5.
-- 현재 이 회사의 최고/최저 연봉은 얼마입니까?

select concat(max(salary),'원') as '최고연봉', concat(min(salary),'원') as '최저연봉' from salaries;

-- 문제6.
-- 최고 어린 사원의 나이와 최고 연장자의 나이는?

-- 1. 한국식으로 계산한건 아닌 듯 개월 수로 계산
select max(cast(period_diff(date_format(current_date,'%Y%m'),date_format(birth_date,'%Y%m'))/12 as int)) as '최고 연장자',
min(cast(period_diff(date_format(current_date,'%Y%m'),date_format(birth_date,'%Y%m'))/12 as int)) as '최고 어린 사원'
from employees;

-- 2. 한국식 나이 계산
select date_format(curdate(),'%Y') - date_format(max(birth_date),'%Y') as '최고 어린 사원',
       date_format(curdate(),'%Y') - date_format(min(birth_date),'%Y') as '최고 연장자'
from employees;