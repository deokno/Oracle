set hidden param parseThreshold = 150000;

SHOW USER;
-- USER이(가) "HR"입니다.

SELECT
    *
FROM
    dba_users;
-- ORA-00942: table or view does not exist
-- dba_users 은 관리자만 조회할 수 있는 것이지 일반사용자인 hr은 조회가 불가능하다는 말이다.


--//////////////////////////////////////////--

/*
    Oracle은 관계형 데이터베이스 (Relation DataBase) 관리(Menagement System) 이다.
    
    RDBMS(Relation DataBase Menagement System) 란?
    ==> 데이터를 열(Column, Field)과 행(Row, Record, Tuple) 으로 이루어진 테이블(Table, Entity(개체), Relation)형태로 
        저장해서 관리하는 시스템을 말한다.
*/

-- ** 현재 오라클 서버에 접속되어진 사용자(지금은 hr)가 만든(소유의) 테이블(Table) 목록을 조회하겠다.
SELECT
    *
FROM
    tab;
/*
------------------------------
TNAME               TABTYPE
------------------------------
COUNTRIES	        TABLE
DEPARTMENTS	        TABLE
EMPLOYEES	        TABLE
EMP_DETAILS_VIEW	VIEW    (VIEW는 테이블은 아니지만 select 되어진 결과물을 마치 테이블처럼 보는 것)
JOBS	            TABLE
JOB_HISTORY	        TABLE
LOCATIONS	        TABLE
REGIONS	            TABLE
*/

-- sql 명령어는 대,소문자를 구분하지 않습니다.
-- 테이블명과 컬럼명도 대,소문자를 구분하지 않습니다.
SELECT
    *
FROM
    departments;

SELECT
    *
FROM
    departments;

SELECT
    *
FROM
    departments;

SELECT
    *
FROM
    departments;

SELECT
    department_id,
    department_name
FROM
    departments;

SELECT
    department_id,
    department_name
FROM
    departments;

--- !!! 저장되어진 데이터 값 만큼은 반드시 대,소문자를 구분합니다. !!! ---
SELECT
    *
FROM
    departments
WHERE
    department_name = 'IT'; -- 조회되어서 나온다.

SELECT
    *
FROM
    departments
WHERE
    department_name = 'it'; -- 아무것도 안나온다.

SELECT
    *
FROM
    departments
WHERE
    department_name = 'It'; -- 아무것도 안나온다.

SELECT
    *
FROM
    departments
WHERE
    department_name = 'Sales'; 

------------------------------------------------------------------------

-- 어떤 테이블의 컬럼에 구성을 알고자 한다라면 아래와 같이 하면 됩니다.
DESCRIBE departments; -- departments 테이블의 컬럼(column)의 정보를 알려주는 것이다.
-- 또는 
DESC departments; --"부서" 테이블
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    
*/

SELECT
    *
FROM
    employees;  --"사원" 테이블

DESC employees;
/*
이름                                           널?       유형           
-------------------------                   -------- ------------ 
EMPLOYEE_ID     (사원번호)                   NOT NULL   NUMBER(6)           -999999 ~ 999999 이내의 값만 들어온다. 
FIRST_NAME      (이름)                                 VARCHAR2(20)          문자열 최대 20 byte 까지만 들어온다.
LAST_NAME       (성)                        NOT NULL   VARCHAR2(25)          문자열 최대 25 byte 까지만 들어온다.
EMAIL           (이메일)                     NOT NULL  VARCHAR2(25) 
PHONE_NUMBER    (연락처)                               VARCHAR2(20) 
HIRE_DATE       (입사일자)                   NOT NULL   DATE                   날짜만 들어온다. 
JOB_ID          (직종ID)                    NOT NULL   VARCHAR2(10)   
SALARY          (기본급여)                              NUMBER(8,2)         -999999.99 ~ 999999.99  
COMMISSION_PCT  (커미션[수당]퍼센티지)                    NUMBER(2,2)         -0.99 ~ 0.99
MANAGER_ID      (직종상관[사수]의 사원번호)               NUMBER(6)    
DEPARTMENT_ID   (해당사원이 근무하는 부서번호)             NUMBER(4) 
*/

SELECT
    *
FROM
    locations -- 부서의 위치정보를 알려주는 테이블

select *
from countries; -- 국가정보를 알려주는 테이블

select *
From REGIONS; -- 대륙정보를 알려주는 테이블

---------------------------------------------------------------------------------------

/*
    === 아주아주아주아주아주아주아주아주 중요!!!! ===
    === !!! 필수 암기 !!! ===
    
    ==== 어떠한 테이블(또는 뷰)에서 데이터 정보를 꺼내와 보는 명령어인 select 의 처리 순서 ====
    
    select 컬럼명, 컬럼명, .. -- 5  컬럼명 대신에 *(아스테리크)을 쓰면 모든 컬럼을 뜻하는 것이다.
    from 테이블명(또는 뷰명)   -- 1
    where 조건절             -- 2  where 조건절이 뜻하는 것은 해당 테이블명(또는 뷰명)에서 조건에 만족하는 행(row)을 메모리(RAM)에 로딩(올리는것)을 해주는 것이다.
    group by 절             -- 3
    having 그룹함수조건절     -- 4
    order by 절             -- 6 
*/

------------------------------------------------------------------------------

----- *** NULL 을 처리해주는 함수 *** ------
----- NULL은 존재하지 않는 것이므로 4칙연산(+ - * /)에 NULL이 포함되어지면 그 결과는 무조건 NULL이 된다.

-- 1. NVL

    select '안녕하세요'
    from dual; -- dual은 select 다음에 나오는 값들을 화면에 보여주기 위한 용도로 쓰이는 가상테이블이다.
    
    select 1+2, 2-1, 3*2, 5/2,
           1+null, 2-null, 0*null, 5/null
    from dual;
    
    select nvl(7,3), nvl(null,3),
           nvl('이순신','거북선'), nvl(null, '거북선'), nvl(null,null)
    from dual;

-- 2. NVL2
    select nvl2(7,3,2), nvl2(null,3,2),
           nvl2('이순신','거북선','구국영웅'), nvl2(null, '거북선','구국영웅'), nvl2(null,7,null)
    from dual;

    
-- employees (직원) 테이블에서 부서번호(department_id) 60번에 근무하는 사원들만 
-- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 부서번호를 나타내세요.
    
    select employee_id, first_name, last_name, Salary, commission_pct, department_id
    from employees;
    where department_id = 60; -- where 절이 있으므로 department_id 컬럼의 값이 60인 행들만 메모리(RAM)에 올라간다. 

 -- employees (직원) 테이블에서 모든 사원들에 대해 
 -- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 부서번호를 나타내세요.
 
    select
    employee_id,
    first_name,
    last_name,
    salary,
    commission_pct, department_id 
    FROM employees ;
    -- where 절이 없으므로 employees 테이블에 있는 모든 행들이 메모리(RAM)에 올라간다.
    
-- commission_pct 컬럼이 뜻하는 바는 다음과 같다.
-- commission_pct 컬럼의 값이 null이라면 수당이 존재하지 않는다는 말이고,
-- commission_pct 컬럼의 값이 0.3이라면 salary(기본급여)의 30%가 수당이 된다는 말이다.
-- SALARY  COMMISSION_PCT   SALARY*COMMISSION_PCT
--  1000        0.3                 300
--  2000        0.3                 600
--  4000        0.3                1200
--  5000        null               null

 -- employees (직원) 테이블에서 모든 사원들에 대해 
 -- 사원번호, 사원명, 기본급여, 커미션퍼센티지, 월급, 부서번호를 나타내세요.
 --> 월급은 기본급여 + 수당액을 합친것을 말한다. 
     SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , COMMISSION_PCT , SALARY + (
    SALARY * COMMISSION_PCT ) , DEPARTMENT_ID 
    FROM EMPLOYEES ; -- 잘못 구한것
     SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , COMMISSION_PCT ,
    NVL ( SALARY + ( SALARY * COMMISSION_PCT ) , SALARY ) , DEPARTMENT_ID 
    FROM EMPLOYEES ; -- 올바르게 구한것
     SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME ,
    SALARY , COMMISSION_PCT , NVL ( SALARY + ( SALARY * COMMISSION_PCT ) , SALARY ) , NVL2 ( COMMISSION_PCT , SALARY + ( SALARY *
    COMMISSION_PCT ) , SALARY ) , DEPARTMENT_ID 
    FROM EMPLOYEES ; -- 올바르게 구한것


    --- *** 컬럼에 대해 별칭(Alias) 부여하기 *** ---
     SELECT EMPLOYEE_ID AS "사원번호" , FIRST_NAME "이름"  -- 별칭(Alias)에서 as는 생략가능함
     , LAST_NAME 성       -- 별칭(Alias)에서 ""는 생략가능함
     , SALARY "기본 급여"  -- 별칭(Alias)에서 공백을 주고자 한다라면 반드시 ""로 해주어야 한다.
     , COMMISSION_PCT 커미션퍼센티지 
     , NVL ( SALARY + ( SALARY * COMMISSION_PCT ) , SALARY ) 월급1 , NVL2 ( COMMISSION_PCT 
     , SALARY + (SALARY * COMMISSION_PCT ) 
    , SALARY ) 월급2 , DEPARTMENT_ID 부서번호 
    FROM EMPLOYEES ;
    
    
    -------------------- **** 비교연산자 **** --------------------
   /* 
   1. 같다                    = 
   2. 같지않다                !=  <>  ^= 
   3. 크다. 작다              >   <
   4. 같거나크다. 같거나작다    >=       <= 
   5. NULL 은 존재하지 않는 것이므로 비교대상이 될 수가 없다.
      그러므로 비교연산( =  != <> ^= >  <  >=  <= )을 할수가 없다.
      그래서 비교연산을 하려면 nvl()함수, nvl2()함수를 사용하여 처리한다. 
    */
    -- 오라클에서 컬럼들을 붙일때(연결할때)는 문자 타입이든 숫자 타입이든 날짜 타입이든 관계없이 || 를 쓰면 된다. 
    
    
    select sysdate
    from dual;
    
    select '서울시'||' '||'마포구 쌍용강북교육센터'|| 1234 || sysdate
    from dual;
    
    
-- employees (직원) 테이블에서 부서번호(department_id) 60번에 근무하는 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내세요.

    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where department_id = 60
    
    desc employees;
    
    select first_name, department_id, nvl(department_id, -9999)
    from employees;
    
    select department_id
    from departments; -- "부서" 테이블
    
    
-- employees (직원) 테이블에서 부서번호(department_id) NULL인 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
    
    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where nvl(department_id, -9999) = -9999;
    
    -- 또는
    
     select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where department_id is null;    -- null 은 is를 사용하여 구한다.
                                    -- department_id 컬럼의 값이 null인 행들만 메모리(RAM)에 퍼올리는 것이다.
   
-- employees (직원) 테이블에서 부서번호(department_id) 60번에 근무하지 않는 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내세요.

    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
 -- where nvl(department_id, -9999) != 60
 -- where nvl(department_id, -9999) <> 60
    where nvl(department_id, -9999) ^= 60

-- employees (직원) 테이블에서 부서번호(department_id) NULL이 아닌 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내세요.  
    
    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where nvl(department_id, -9999) != -9999;
    
 -- 또는
    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where department_id is not null;
    
-- 또는
    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where not department_id is null; 
    
-- 또는
    select employee_id 사원번호
    , first_name ||' '|| last_name as "사원명"
    , nvl(salary+(salary*commission_pct),salary)as "월급"
    , department_id as "부서번호" 
    from employees
    where not (department_id is null);
    
    -------------------------------------------------------------------
    
    ---- ** select 되어져 나온 데이터를 정렬(오름차순정렬, 내림차순정렬)하여 보여주기 **-----
    
    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary asc; -- salary 컬럼의 값을 asc(오름차순)하여 보여라는 말이다.

    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary desc; -- salary 컬럼의 값을 desc(내림차순)하여 보여라는 말이다.

    select employee_id, first_name, last_name, salary, department_id
    from employees
    order by salary;  -- asc는 생략가능하다. 
    
-- employees (직원) 테이블에서 부서번호(department_id) NULL이 아닌 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내는데 월급의 내림차순으로 보여주세요.

    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary+(salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by nvl(salary+(salary*commission_pct),salary) desc;

-- 또는
    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by "월급" desc ;

-- 또는
    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by 3 desc ;

-- employees (직원) 테이블에서 부서번호(department_id) NULL이 아닌 사원들만 
-- 사원번호, 사원명, 월급, 부서번호를 나타내는데 
-- 먼저 부서번호의 오름차순으로 정령한 후, 
-- 동일한 부서 번호 내에서는 월급의 내림차순으로 보여주세요.

    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by "부서번호" asc, "월급" desc;

-- 또는 
    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by "부서번호" , "월급" desc; -- asc 생략
    
-- 또는
    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    where department_id is not null
    order by 4 , 3 desc; -- asc 생략

-- employees (직원) 테이블에서 모든 사원들에 대해 
-- 사원번호, 사원명, 월급, 부서번호를 나타내는데 
-- 먼저 부서번호의 오름차순으로 정령한 후, 
-- 동일한 부서 번호 내에서는 월급의 내림차순으로 보여주세요.

    select employee_id as"사원번호"
        , first_name || ' '|| last_name as "사원명"
        , nvl(salary + (salary*commission_pct),salary) as "월급"
        , department_id as "부서번호"
    from employees
    order by "부서번호" asc, "월급" desc;
    -- 오라클에서 null은 존재하지 않는 것이므로 정렬 시 가장 큰 것으로 간주한다.
    -- 그러므로 오름차순정렬 시 null은 가장 뒤에 나오고,
    -- 내림차순정렬 시 null은 가장 처음에 나온다. 
 /*
     참고로 Microsoft 사에서 만든 MS-SQL 서버에서는 null은 정렬 시 가장 작은 것으로 간주하기에
     오라클과 반대로 나온다. 
     즉, 오름차순 정렬시 null은 맨 처음에 나오고, 내림차순 정렬시 null은 맨 뒤에 나온다.
 */
    
/*
    employees 테이블에서 수당퍼센티지가 null인 사원들만 
    사원번호, 사원명, 월급(기본급여+수당액), 부서번호를 나타내되 
    먼저 부서번호의 오름차순으로 정렬한 후 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요. 
*/

    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , nvl( salary+(salary*commission_pct), salary) as "월급"
        , department_id as "부서번호"
    From employees
    where commission_pct is null
    order by "부서번호", "월급" desc;
    
/*
    employees 테이블에서 수당퍼센티지가 null이 아닌 사원들만 
    사원번호, 사원명, 월급(기본급여+수당액), 부서번호를 나타내되 
    먼저 부서번호의 오름차순으로 정렬한 후 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요. 
*/

    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , nvl( salary+(salary*commission_pct), salary) as "월급"
        , department_id as "부서번호"
    From employees
    where commission_pct is not null
    order by "부서번호" asc, "월급" desc;

/*
    employees 테이블에서 부서번호가 50번 부서에서 근무하지 않는 사원들만
    사원번호, 사원명, 월급(기본급여+수당액), 부서번호를 나타내되 
    먼저 부서번호의 오름차순으로 정렬한 후 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요. 
*/

    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , nvl( salary+(salary*commission_pct), salary) as "월급"
        , department_id as "부서번호"
    From employees
    where nvl(commission_pct, -9999) != 50
    order by "부서번호" asc, "월급" desc;


/*
    employees 테이블에서 월급(기본급여+수당액)이 10000보다 큰 사원들만 
    사원번호, 사원명, 월급(기본급여+수당액), 부서번호를 나타내되 
    먼저 부서번호의 오름차순으로 정렬한 후 동일한 부서번호 내에서는 월급의 내림차순으로 나타내세요. 
*/

    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , nvl( salary+(salary*commission_pct), salary) as "월급"
        , department_id as "부서번호"
    From employees
    where  nvl( salary+(salary*commission_pct), salary)>10000 
    order by  "부서번호", "월급" desc;

------------------ *** AND OR IN() NOT 연산자 *** ----------------

/*
    employees 테이블에서 80번 부서에 근무하는 사원들 중에 기본급여가 10000 이상인 
    사원들만 사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/
 
    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where department_id = 80 and
          salary >= 10000 ;
          
 /*
    employees 테이블에서 30번, 60분, 80번 부서에 근무하는 사원들만 
    사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/   

    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where department_id = 80 or
        department_id = 60 or
        department_id = 30
    order by "부서번호" asc;
        
-- 또는 
    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where department_id in(30,60,80)
     order by "부서번호" asc;     
     
 /*
    employees 테이블에서 30번, 60분, 80번 부서에 근무하지 않는 사원들만 
    사원번호, 사원명, 기본급여, 부서번호를 나타내세요.
*/  
    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where nvl(department_id,-9999) != 30 and
          nvl(department_id,-9999) != 60 and  
          nvl(department_id,-9999) != 80  
    order by "부서번호" asc;     
 
 -- 또는
    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where NVL(department_id,-9999) not in (30,60,80)
    order by "부서번호" asc;   

-- 또는 
    select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , salary as "기본급여"
        , department_id as "부서번호"
    from employees
    where not NVL(department_id,-9999) in (30,60,80)
    order by "부서번호" asc;   
    
/*
    [퀴즈]
    employees 테이블에서 부서번호가 30, 50, 60번 부서에 근무하는 사원들중에 
    연봉(월급*12)이 20000 이상 60000 이하인 사원들만 
    사원번호, 사원명, 연봉(월급*12), 부서번호를 나타내되 
    부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서는 연봉의 내림차순으로 나타내세요.
*/
    select employee_id as "사원번호"
         , first_name || ' ' || last_name as "사원명"
         , (NVL(salary+(salary*commission_pct),salary))*12 as "연봉"
         , department_id as "부서번호"
    from employees
    where department_id in(30,50,60) 
    and 20000<=(NVL(salary+(salary*commission_pct),salary))*12 
    and (NVL(salary+(salary*commission_pct),salary))*12<=60000
    order by "부서번호" , "연봉" desc;
    -- 올바른 풀이
    -- IN() 은 괄호가 있는 OR이다. 
    
-- 틀린 풀이 --   
    select employee_id as "사원번호"
         , first_name || ' ' || last_name as "사원명"
         , (NVL(salary+(salary*commission_pct),salary))*12 as "연봉"
         , department_id as "부서번호"
    from employees
    where department_id = 30 or  department_id = 50 or department_id = 60
    and 20000<=(NVL(salary+(salary*commission_pct),salary))*12 
    and (NVL(salary+(salary*commission_pct),salary))*12<=60000
    order by "부서번호" , "연봉" desc;
/*
    !!! and 와 or가 혼용되어지면 우선순위는 and가 먼저 실행된다. !!!
    연산자에서 있어서 가장 최우선은 괄호( ) 가 제일 우선한다. 
*/
-- 올바른 풀이 -- 
    select employee_id as "사원번호"
         , first_name || ' ' || last_name as "사원명"
         , (NVL(salary+(salary*commission_pct),salary))*12 as "연봉"
         , department_id as "부서번호"
    from employees
    where (department_id = 30 or  department_id = 50 or department_id = 60)
    and 20000<=(NVL(salary+(salary*commission_pct),salary))*12 
    and (NVL(salary+(salary*commission_pct),salary))*12<=60000
    order by "부서번호" , "연봉" desc;
    
    ----- *** == 범위 연산자 == *** ------
    /*
        범위 연산자에 사용되는 데이터는 숫자, 문자, 
        >   <   >=  <=  
        between A and B --> A 부터 B까지  
    
    */
    
    
    ----- *** == 현재시각을 알려주는 것 == *** -----
    
    select sysdate, current_date, 
           localtimestamp, current_timestamp, 
           systimestamp
    from dual;
    -- 22/01/05  22/01/05
    -- 22/01/05 12:06:04.000000000 22/01/05 12:06:04.000000000 ASIA/SEOUL
    -- 22/01/05 12:08:02.698000000 +09:00
    /*
       날짜타입은 date 이다.
       date 타입의 기본적인 표현방식은 'RR/MM/DD' 으로 나타내어진다.
       RR 은 년도의 2자리만 나타내어주는데 50 ~ 99 는  1950 ~ 1999 을 말하는 것이다.
       RR 은 년도의 2자리만 나타내어주는데 00 ~ 49 는  2000 ~ 2049 을 말하는 것이다.
       MM 은 월이고, DD 는 일이다.
   */
   
   select sysdate
        , to_char(sysdate, 'yyyy-mm-dd pm hh:mi:ss')
        , to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss')
        , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')
        , to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
   from dual; 
   
   desc employees;
   -- HIRE_DATE 컬럼의 타입은 date(날짜) 이다. 
   
   select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , hire_date as "입사일자"   -- 'RR/MM/DD'
        , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') as "입사일자2"
   from employees;
   
   -- employees 테이블에서 employee_id 컬럼의 값이 154인 사원의 hire_date 칼럼의 값을 
   -- '2006-12-31 09:00:00' 로 변경하겠다.
   
   
   update employees set hire_date = '2006-12-31 09:00:00' -- set hire_date = to_char'2006-12-31 09:00:00' 의 =은 대입한다라는 말이다.                                                                
   where employee_id = 154; -- employee_id = 154 의 = 은 같다라는 말이다.
   /*
    오류 보고 -
    ORA-01861: literal does not match format string
   */
   
    update employees set hire_date = to_date('2006-12-31 09:00:00', 'yyyy-mm-dd hh24:mi:ss')
    where employee_id = 154;
    
    commit;
    -- 커밋완료
    
    
   -- employees 테이블에서 입사일자가 2005년 1월 1일 부터 2006년 12월 31일 까지 입사한 사원들만 
   -- 사원번호, 사원명, 입사일자를 나타내세요.
   
   
   select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , hire_date as "입사일자1"   -- 'RR/MM/DD'
        , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') as "입사일자2"
   from employees
   where '05/01/01' <= hire_date and hire_date <= '06/12/31'
   order by  "입사일자1" asc; -- 틀린풀이 !!
   --- !!!! 중요 !!!! 날짜를 나타낼때 시,분,초 가 없는 년,월,일만 나타내어 주면 자동적으로 00시 00분으로 나타난다.  
   ---              즉, 자정(그날의 시작)을 뜻한다.
      select employee_id as "사원번호"
        , first_name || ' ' || last_name as "사원명"
        , hire_date as "입사일자1"   -- 'RR/MM/DD'
        , to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') as "입사일자2"
   from employees
   where '05/01/01' <= hire_date and hire_date < '07/01/01'
   order by  "입사일자1" asc; -- 올바른풀이 !!
   
   
   'A' --> 65
   'a' --> 97
   '0' --> 48
   ' ' --> 32
   
   select ascii('A'), ascii('a'), ascii('0'), ascii(' ')
   from dual;
   --       65            97         48          32
   
   select chr(65), chr(97), chr(48), chr(32)
   from dual;
   --       A         a         0         
   
   
   -- employees 테이블에서 first_name 컬럼의 값이 'Elj' 부터 'I'까지인 데이터를 가지는
   -- 사원들만 first_name 을 출력하세요. 
   
   select first_name
   from employees
   where 'Elj' <=  first_name and first_name <= 'I'
   order by 1;
   
   -- 'Elj' 'Elja' 'Eljast' El......' ~~~~~ 'Hasdf' 'Haysdf' 'I' / 'Ia
   
   select first_name
   from employees
   where first_name between 'Elj' and 'I'
   order by 1;
   
   /*
       대용량 데이터베이스인 경우 IN 연산자 보다는 OR 를 사용하기를 권장하고,
       대용량 데이터베이스인 경우 between A and B 보다는 >= and <= 을 사용할 것을 권장한다.
       왜냐하면 IN 연산자는 내부적으로 OR 로 변경된 후 실행되고, 
       between A and B 도 내부적으로 >= and <= 으로 변경된 후 실행되기 때문이다. 
       
       -- 대용량 데이터베이스의 기준은 어떤 테이블의 행의 개수가 100만건을 넘을 경우를 말한다.
       -- 소규모 데이터베이스의 기준은 어떤 테이블의 행의 개수가 1만건 미만인 경우를 말한다.
   */
   
   ------ *** employees 테이블에 jubun(주민번호) 이라는 컬럼을 추가해봅니다. *** --------
   /*
       jubun(주민번호) 컬럼의 값을 입력할때는 '-' 는 빼고 숫자로만 입력할 것입니다.
       jubun(주민번호) 컬럼의 값을 입력할 때 맨 처음 첫자리에 0 이 들어올 수 있다라면 
       number 타입이 아니라 varchar2 타입으로 해야 한다.
       왜냐하면 number 타입으로 해주면 맨 앞에 입력한 값이 0 일때는 0이 생략 되어지기 때문이다.
       맨 앞의 0 도 나오게 하려면 컬럼의 데이터 타입은 varchar2 가 되어야 한다.
   */
   
   select 010503234567, '0105054234567'
   from dual;
   -- 10503234567	0105054234567
   
   alter table employees 
   add jubun varchar2(13); -- employees 테이블에 jubun이라는 컬럼을 추가해주는 것.
   --Table EMPLOYEES이(가) 변경되었습니다.
   
   desc employees;
   
   select *
   from employees
   
   update employees set jubun = '6010151234567'
   where employee_id = 100;
   -- 1 행 이(가) 업데이트되었습니다.
   
   rollback; 
   -- 롤백 완료.
   -- commit; 한 이후에 DML(data Manulation Language[데이터조작어] -- insert, update, delete, merge) 
   -- 명령어로 변경되어진 것을 이전상태로 되돌리는 것 
   
   update employees set jubun = '6010151234567'
   where employee_id = 100;
   -- 1 행 이(가) 업데이트되었습니다.
   
   commit;
   -- 커밋 완료.
   -- DML(data Manulation Language[데이터조작어] -- insert, update, delete, merge)
   -- 명령어로 변경되어진 것을 디스크에 적용시키는 것이다.
   -- commit; 한 이후로  rollback; 해봐야 이전 상태로 되돌아가지 않는다.
   
   update employees set jubun = '8510151234567'
   where employee_id = 101;
   -- 1 행 이(가) 업데이트되었습니다.

   update employees set jubun = '6510151234567'
   where employee_id = 102;
   -- 1 행 이(가) 업데이트되었습니다.
   
   select *
   from employees
   
   rollback; 
   
   select *
   from employees
   
---------------------------------------------------------------------------------------------------\

    update employees set jubun = '6010151234567'  
    where employee_id = 100;

    update employees set jubun = '8510151234567'
    where employee_id = 101;
    
    update employees set jubun = '6510152234567'
    where employee_id = 102;
    
    update employees set jubun = '7510151234567'
    where employee_id = 103;
    
    update employees set jubun = '6110152234567'
    where employee_id = 104;
    
    update employees set jubun = '6510151234567'
    where employee_id = 105;
    
    update employees set jubun = '6009201234567'
    where employee_id = 106;
    
    update employees set jubun = '0803153234567'
    where employee_id = 107;
    
    update employees set jubun = '0712154234567'
    where employee_id = 108;
    
    update employees set jubun = '8810151234567'
    where employee_id = 109;
    
    update employees set jubun = '8908152234567'
    where employee_id = 110;
    
    update employees set jubun = '9005052234567'
    where employee_id = 111;
    
    update employees set jubun = '6610151234567'
    where employee_id = 112;
    
    update employees set jubun = '6710151234567'
    where employee_id = 113;
    
    update employees set jubun = '6709152234567'
    where employee_id = 114;
    
    update employees set jubun = '6110151234567'
    where employee_id = 115;
    
    update employees set jubun = '6009301234567'
    where employee_id = 116;
    
    update employees set jubun = '6110152234567'
    where employee_id = 117;
    
    update employees set jubun = '7810151234567'
    where employee_id = 118;
    
    update employees set jubun = '7909151234567'
    where employee_id = 119;
    
    update employees set jubun = '7702152234567'
    where employee_id = 120;
    
    update employees set jubun = '7009151234567'
    where employee_id = 121;
    
    update employees set jubun = '7111011234567'
    where employee_id = 122;
    
    update employees set jubun = '8010131234567'
    where employee_id = 123;
    
    update employees set jubun = '8110191234567'
    where employee_id = 124;
    
    update employees set jubun = '9012132234567'
    where employee_id = 125;
    
    update employees set jubun = '9406251234567'
    where employee_id = 126;
    
    update employees set jubun = '9408252234567'
    where employee_id = 127;
    
    update employees set jubun = '9204152234567'
    where employee_id = 128;
    
    update employees set jubun = '8507251234567'
    where employee_id = 129;
    
    update employees set jubun = '6511111234567'
    where employee_id = 130;
    
    update employees set jubun = '0010153234567'
    where employee_id = 131;
    
    update employees set jubun = '0005254234567'
    where employee_id = 132;
    
    update employees set jubun = '0110194234567'
    where employee_id = 133;
    
    update employees set jubun = '0412154234567'
    where employee_id = 134;
    
    update employees set jubun = '0503253234567'
    where employee_id = 135;
    
    update employees set jubun = '9510012234567'
    where employee_id = 136;
    
    update employees set jubun = '9510021234567'
    where employee_id = 137;
    
    update employees set jubun = '9610041234567'
    where employee_id = 138;
    
    update employees set jubun = '9610052234567'
    where employee_id = 139;
    
    update employees set jubun = '7310011234567'
    where employee_id = 140;
    
    update employees set jubun = '7310092234567'
    where employee_id = 141;
    
    update employees set jubun = '7510121234567'
    where employee_id = 142;
    
    update employees set jubun = '7612012234567'
    where employee_id = 143;
    
    update employees set jubun = '7710061234567'
    where employee_id = 144;
    
    update employees set jubun = '7810052234567'
    where employee_id = 145;
    
    update employees set jubun = '6810251234567'
    where employee_id = 146;
    
    update employees set jubun = '6811062234567'
    where employee_id = 147;
    
    update employees set jubun = '6712052234567'
    where employee_id = 148;
    
    update employees set jubun = '6011251234567'
    where employee_id = 149;
    
    update employees set jubun = '6210062234567'
    where employee_id = 150;
    
    update employees set jubun = '6110191234567'
    where employee_id = 151;
    
    update employees set jubun = '5712062234567'
    where employee_id = 152;
    
    update employees set jubun = '5810231234567'
    where employee_id = 153;
    
    update employees set jubun = '6311051234567'
    where employee_id = 154;
    
    update employees set jubun = '6010182234567'
    where employee_id = 155;
    
    update employees set jubun = '6110191234567'
    where employee_id = 156;
    
    update employees set jubun = '6210112234567'
    where employee_id = 157;
    
    update employees set jubun = '6311132234567'
    where employee_id = 158;
    
    update employees set jubun = '8511112234567'
    where employee_id = 159;
    
    update employees set jubun = '8710131234567'
    where employee_id = 160;
    
    update employees set jubun = '8710072234567'
    where employee_id = 161;
    
    update employees set jubun = '9010171234567'
    where employee_id = 162;
    
    update employees set jubun = '9112072234567'
    where employee_id = 163;
    
    update employees set jubun = '9110241234567'
    where employee_id = 164;
    
    update employees set jubun = '9212251234567'
    where employee_id = 165;
    
    update employees set jubun = '9310232234567'
    where employee_id = 166;
    
    update employees set jubun = '9811151234567'
    where employee_id = 167;
    
    update employees set jubun = '9810252234567'
    where employee_id = 168;
    
    update employees set jubun = '9910301234567'
    where employee_id = 169;
    
    update employees set jubun = '0910153234567'
    where employee_id = 170;
    
    update employees set jubun = '1011153234567'
    where employee_id = 171;
    
    update employees set jubun = '1006153234567'
    where employee_id = 172;
    
    update employees set jubun = '1111154234567'
    where employee_id = 173;
    
    update employees set jubun = '1209103234567'
    where employee_id = 174;
    
    update employees set jubun = '1207154234567'
    where employee_id = 175;
    
    update employees set jubun = '0906153234567'
    where employee_id = 176;
    
    update employees set jubun = '0812113234567'
    where employee_id = 177;
    
    update employees set jubun = '9810132234567'
    where employee_id = 178;
    
    update employees set jubun = '8712111234567'
    where employee_id = 179;
    
    update employees set jubun = '8310012234567'
    where employee_id = 180;
    
    update employees set jubun = '6510191234567'
    where employee_id = 181;
    
    update employees set jubun = '6510221234567'
    where employee_id = 182;
    
    update employees set jubun = '6510232234567'
    where employee_id = 183;
    
    update employees set jubun = '8512131234567'
    where employee_id = 184;
    
    update employees set jubun = '8510182234567'
    where employee_id = 185;
    
    update employees set jubun = '7510192234567'
    where employee_id = 186;
    
    update employees set jubun = '8512192234567'
    where employee_id = 187;
    
    update employees set jubun = '9511151234567'
    where employee_id = 188;
    
    update employees set jubun = '7509302234567'
    where employee_id = 189;
    
    update employees set jubun = '8510161234567'
    where employee_id = 190;
    
    update employees set jubun = '9510192234567'
    where employee_id = 191;
    
    update employees set jubun = '0510133234567'
    where employee_id = 192;
    
    update employees set jubun = '0810194234567'
    where employee_id = 193;
    
    update employees set jubun = '0910183234567'
    where employee_id = 194;
    
    update employees set jubun = '1010134234567'
    where employee_id = 195;
    
    update employees set jubun = '9510032234567'
    where employee_id = 196;
    
    update employees set jubun = '9710181234567'
    where employee_id = 197;
    
    update employees set jubun = '9810162234567'
    where employee_id = 198;
    
    update employees set jubun = '7511171234567'
    where employee_id = 199;
    
    update employees set jubun = '7810172234567'
    where employee_id = 200;
    
    update employees set jubun = '7912172234567'
    where employee_id = 201;
    
    update employees set jubun = '8611192234567'
    where employee_id = 202;
    
    update employees set jubun = '7810252234567'
    where employee_id = 203;
    
    update employees set jubun = '7803251234567'
    where employee_id = 204;
    
    update employees set jubun = '7910232234567'
    where employee_id = 205;
    
    update employees set jubun = '8010172234567'
    where employee_id = 206;
    
    commit;
        
    select *
    from employees;
    
    -------------------------------------------------------------------------------------------
    
    ----- ***** ==== like 연산자 ==== ***** -----
    
    select *
    from employees
    where department_id = 30;
   
    select *
    from employees
    where department_id like 30;
    
    /*
        like 연산자와 함께 사용되어지는 % 와 _ 를 wild character 라고 부른다.
        like 연산자와 함께 사용되어지는 % 의 뜻은 글자수와는 관계없이 글자가 있든지 없든지 관계없다라는 말이고,
        like 연산자와 함께 사용되어지는 _ 의 뜻은 반드시 아무글자 1개만을 뜻하는 것이다.
    */
    
    -- employees 테이블에서 여자 1990년생과 남자 1991년 생의 사원들만 
    -- 사원번호, 사원명, 주민번호를 나타내세요.
    
    select employee_id as "사원번호"
           , first_name || ' ' || last_name as "사원명"
           , jubun as "주민번호"
    from employees
    where jubun like '90____2%' or 
          jubun like '91____1%';
          
    -- employees 테이블에서 first_name 컬럼의 값이 'J'로 시작하는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
    
    select employee_id as "사원번호"
    , first_name as "성"
    , last_name as "이름"
    , salary as "기본급여"
    from employees
    where first_name like 'J%';
    
    -- employees 테이블에서 first_name 컬럼의 값이 's'로 끝나는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
      select employee_id as "사원번호"
      , first_name as "성"
      , last_name as "이름"
      , salary as "기본급여"
      from employees
      where first_name like '%s';
      
    -- employees 테이블에서 first_name 컬럼의 값중에 'ee'라는 글자가 들어있는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
   
      select employee_id as "사원번호"
      , first_name as "성"
      , last_name as "이름"
      , salary as "기본급여"
      from employees
      where first_name like '%ee%';
 
    -- employees 테이블에서 first_name 컬럼의 값중에 'e'가 2개이상 들어있는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
      select employee_id as "사원번호"
      , first_name as "성"
      , last_name as "이름"
      , salary as "기본급여"
      from employees
      where first_name like '%e%e%';

    -- employees 테이블에서 last_name 컬럼의 값이 첫글자는 'F' 이고 두번째 글자는 아무거나 이고
    -- 세번째 글자는 소문자 'e' 이며 4번째 부터는 글자가 있든지 없든지 상관없는 사원들만 
    -- 사원번호, 이름, 성, 기본급여를 나타내세요. 
    
    select employee_id as "사원번호"
     , first_name as "성"
     , last_name as "이름"
     , salary as "기본급여"
    from employees
    where last_name like 'F_e%';
    
    --- *** like 연산자와 함께 사용되어지는 % 와 _ 인 wild Character 의 기능을 escape(탈출) 시키기 *** ---
    select * from tab;

    create table TBL_watch
    (watch_name varchar2(10) -- watch_name 컬럼에 들어올 수 있는 데이터는 문자열 최대 10 byte 까지만 허용한다. 
    , bigo      Nvarchar2(100) -- bigo 컬럼에 들어올 수 있는 데이터는 문자열 최대 100글자 까지만 허용한다. 
    );
    -- Table TBL_WATCH이(가) 생성되었습니다.
    
    
    
    -- tbl_watch 테이블 속에 데이터를 입력해주는 것이다.
    insert into tbl_watch(watch_name, bigo) values('금시계', '순금고급시계');
    -- 1 행 이(가) 삽입되었습니다.
    
    select *
    from tbl_watch;
    
 -- rollback;
    commit;
    
     insert into tbl_watch(watch_name, bigo) values('고급순은시계', '아주좋은시계');
/*
    오류 보고 -
    ORA-12899: value too large for column "HR"."TBL_WATCH"."WATCH_NAME" (actual: 18, maximum: 10)
 */
    
    insert into tbl_watch(watch_name, bigo) values('은시계', '아주좋은시계');
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    delete from tbl_watch; -- tbl_watch 테이블에 저장된 모든 행들을 삭제시키는 것이다.
    -- 2개 행 이(가) 삭제되었습니다.
   
    select *
    from tbl_watch;
    
    rollback;
    
    delete from tbl_watch
    where watch_name = '금시계';
    -- tbl_watch 테이블에 저장된 행들중에서 watch_name 컬럼의 값이 '금시계'인 행을 삭제시키는 것이다.
    
    delete from tbl_watch;
    
    commit;
    
    insert into tbl_watch(watch_name, bigo) values('금시계', '순금 99.99% 함유 고급시계');
    insert into tbl_watch(watch_name, bigo) values('은시계', '고객만족도 99.99점 획득한 고급시계');
    
    commit;
    
    drop table tbl_watch purge;
    --Table TBL_WATCH이(가) 삭제되었습니다.
    
    -- tbl_watch 테이블에서 bigo 칼럼에 99.99% 라는 글자가 들어있는 행만 추출하세요.
    select *
    from tbl_watch
    where bigo like '%99.99%%'
    
    select *
    from tbl_watch
    where bigo like '%99.99\%%' escape '\';
    -- 다 가능하지만 왠만하면 \를 사용한다. 
    --  escape 문자로 '\' 을 주었으므로 '\' 다음에 나오는 % 1개만 wild character 기능에서 탈출시켜 버리므로 % 는 진짜 글자 퍼센트(%) 로 된다.
 /*
    select *
    from tbl_watch
    where bigo like '%99.99a%%' escape 'a';
    
    select *
    from tbl_watch
    where bigo like '%99.991%%' escape '1';
*/
 
--------------------------------------------------------------------------------

    ------ >> 단일행 함수 <<-------
    /*
        ※ 단일행 함수의 종류
        
        1. 문자 함수
        2. 숫자 함수
        3. 날짜 함수
        4. 변환 함수
        5. 기타 함수
    */
    
 
 
 
 
    ------------------ >> 1. 문자 함수 << -------------------
    
    -- 1.1 upper('문자열') ==> '문자열'을 모두 대문자로 변환시켜주는 것 
    select 'kOreA SEoul', upper('kOreA SEoul')
    from dual;
    -- kOreA SEoul	KOREA SEOUL
   
    -- 1.2 lower('문자열') ==> '문자열'을 모두 소문자로 변환시켜주는 것 
    select 'kOreA SEoul', lower('kOreA SEoul')
    from dual;
    -- kOreA SEoul	korea seoul 
   
    -- 1.3 initcap('문자열') ==> '문자열'을 단어별(구분자 공백)로 첫글자만 대문자, 나머지는 모두 소문자로 변환시켜주는 것 
    select 'kOreA SEoul', initcap('kOreA SEoul')
    from dual;    
    -- kOreA SEoul	Korea Seoul
    
    select last_name, upper(last_name), lower(last_name)
    from employees

    
    select *
    from employees
    where last_name = 'King';
    
    select *
    from employees
    where last_name = 'king';
    
    select *
    from employees
    where lower(last_name) = lower('KING');
    
    select *
    from employees
    where upper(last_name) = upper('KING');  
    
    select *
    from employees
    where initcap(last_name) = initcap('KING');  
 
    -- 1.4 substr('문자열', 시작글자번호, 뽑아야할글자수) 
    --     ==> '문자열'중에 문자열의 일부분을 선택해 올 때 사용한다. 
    select '쌍용교육센터'
          , substr('쌍용교육센터', 2,3)  -- '쌍용교육센터' 에서 2번째 글자인 '용' 부터 3글자만 뽑아온다. 
          , substr('쌍용교육센터', 2)    -- '쌍용교육센터' 에서 2번째 글자인 '용' 부터 끝까지
    from dual;
    -- 쌍용교육센터	용교육	용교육센터

--- *** substr()함수를 사용하여 employees 테이블에서 성별이 '여자'인 사원들만 
--      사원번호, 사원명, 주민번호를 나타내세요. ***    
    
    select employee_id as "사원번호"
         , first_name || ' ' || last_name as "사원명"
         , jubun as "주민번호"
    from employees
    where substr(jubun, 7, 1) in('2','4');
    
    
   select employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , jubun AS "주민번호" 
    from employees
    where substr(jubun, 7,1) = 2 or substr(jubun, 7,1) = 4;

--- *** substr()함수를 사용하여 employees 테이블에서 1990년 ~ 1995년에 태어난 사원들중 
--      성별이 '남자'인 사원들만 사원번호, 사원명, 주민번호를 나타내세요. ***
   select employee_id AS "사원번호"
        , first_name || ' ' || last_name AS "사원명"
        , jubun AS "주민번호" 
   from employees
   where substr(jubun, 1, 2) between '90' and '95' AND
         substr(jubun, 7, 1) = '1';
         
   -- 1.5  instr : 어떤 문자열에서 명명된 문자열의 위치를 알려주는 것 **** ---
    select '쌍용교육센터 서울교육대학교 교육문화원'
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1) --3
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 2) -- 10
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 1 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 1) -- 10
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4, 3)-- 0
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 4 번째 부터 3 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         --  그러한 값이 없다라면 0 이 나온다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1)
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         --  출발점만 나오면 뒤에 , 1 이 생략된 것이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 4)
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 4 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         --  출발점만 나오면 뒤에 , 1 이 생략된 것이다.
         
    from dual; 
    
             
    -- 1.6  reverse : 어떤 문자열을 거꾸로 보여주는 것이다. **** ---
    select 'ORACLE', reverse('ORACLE')
         , '대한민국', reverse('대한민국'),  reverse( reverse('대한민국') )
    from dual;
   
   ------ [퀴즈] -------
    create table tbl_files
    (fileno      number(3)
    ,filepath    varchar2(200)
    );
    
    insert into tbl_files(fileno, filepath) values(1, 'c:\myDocuments\resume.hwp');
    insert into tbl_files(fileno, filepath) values(2, 'd:\mymusic.mp3');
    insert into tbl_files(fileno, filepath) values(3, 'c:\myphoto\2021\07\face.jpg');
    
    commit;
    
    select fileno, filepath
    from tbl_files;
    
    --- 아래와 같이 나오도록 select 문을 완성하세요 --- 
    /*
        -------------------------------
        파일번호    파일명
        -------------------------------
           1       resume.hwp            
           2       mymusic.mp3
           3       face.jpg
    
    */
    select fileno as "파일번호", reverse(substr(reverse(filepath),1,(instr( (reverse(filepath)), '\', 1)-1 )) )
    from tbl_files;
    
    
       -- 1.5  instr : 어떤 문자열에서 명명된 문자열의 위치를 알려주는 것 **** ---
    select '쌍용교육센터 서울교육대학교 교육문화원'
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 1) --3
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -1, 1) -- 16
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 역순으로 1 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 1) -- 10
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 역순으로 6번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 2)-- 3
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 역순으로 6 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6, 3) -- 0
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 역순으로 6 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         --  값이 없으면 0이 나온다.
         
         , instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -6)-- 10
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 역순으로 6 번째 부터 1 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
         --  출발점만 나오면 뒤에 , 1 이 생략된 것이다.
         
    from dual; 
   ----- 아침  
    select fileno, filepath
      --   substr(filepath, filepath에서 마지막으로 나오는 '\'의 위치값 +1
      --   
         , substr(filepath, instr(filepath,'/',-1,1)+1)  
    from tbl_files;    
    
    
    
   --1.7 lpad : 왼쪽부터 문자를 자리채움 **** ---
   -- 1.8  rpad : 오른쪽부터 문자를 자리채움 **** ---
    select lpad('교육센터',10,'*')   
        -- 10 byte를 확보해서 거기에 '교육센터' 를 넣습니다. 넣은 후 빈공간(2byte)이 있으면 왼쪽부터 '*' 로 채워라 
        ,  rpad('교육센터',10,'*')
        -- 10 byte를 확보해서 거기에 '교육센터' 를 넣습니다. 넣은 후 빈공간(2byte)이 있으면 오른쪽부터 '*' 로 채워라 
    from dual;
    
 --   1.9  ltrim : 왼쪽부터 문자를 제거한다. **** ---
 --   1.10 rtrim : 오른쪽부터 문자를 제거한다. **** ---
 --   1.11 trim : 왼쪽, 오른쪽부터 공백을 제거한다. **** ---
    select ltrim('abbbaaacccddaabcdTabcdaabcd','abcd'),
           rtrim('abbbaaacccddaabcdTabcdaabcd','abcd'), 
           rtrim (ltrim('abbbaaacccddaabcdTabcdaabcd','abcd'),'abcd' )
    from dual;

    select '쌍용' || '               교육               센터',
           '쌍용' ||trim('               교육               센터')     
    from dual;
    
    select '쌍용          ' || '교육               센터',
           rtrim('쌍용          ') || '교육               센터'     
    from dual;
    
    select '쌍용' || '        교육         '||'센터',
           '쌍용' || trim('        교육         ')||'센터'    
    from dual;    
    
    -- 1.12 translate ---
    select translate('010-2345-6789'
                    ,'0123456789'
                    ,'공일이삼사오육칠팔구')
    from dual;
    
    -- 1.13 replace ---
    
    select replace('쌍용교육센터 서울교육대학교 교육문화원'
                 , '교육'
                 , 'education')
    from dual;
    
    -- 1.14 length ==> 문자열의 길이를 알려주는 것 ---
    select length('쌍용center') --8
    from dual;
    
    -- 1.15 lengthhb ==> 문자열의 byte수를 알려주는 것 ---
    select lengthhb('쌍용center') --12
    from dual;
    
   
   
   
   
   
   
    ------------------ >> 2. 숫자 함수 << -------------------
    
    -- 2.1 mod : 나머지를 구해주는 것 
    
    select 5/2, mod(5,2)
    from dual;
    
    
    -- 2.2 round : 반올림을 해주는 것
    select 94.547
        ,  round(94.547)   -- 95
        ,  round(94.547,0)   --  0은 정수 1자리까지만 나타내어준다. 
        ,  round(94.547,1)   --  1은 소수 첫째자리까지만 나타내어준다. 
        ,  round(94.547,2)   --  2은 소수 둘째자리까지만 나타내어준다. 
        ,  round(94.547,-1)   -- -1은 정수 10의자리까지만 나타내어준다. 
        ,  round(94.547,-2)   -- -1은 정수 100의자리까지만 나타내어준다. 
    from dual;
    
    -- 2.3 trunc : 절삭해주는 것
    select 94.547
        ,  trunc(94.547)   -- 94
        ,  trunc(94.547,0)   -- 94      0은 정수 1자리까지만 나타내어준다. 
        ,  trunc(94.547,1)   -- 94.5    1은 소수 첫째자리까지만 나타내어준다. 
        ,  trunc(94.547,2)   -- 94.54   2은 소수 둘째자리까지만 나타내어준다. 
        ,  trunc(94.547,-1)   -- 90     -1은 정수 10의자리까지만 나타내어준다. 
        ,  trunc(94.547,-2)   -- 0 -    1은 정수 100의자리까지만 나타내어준다. 
    from dual;
    
    -- *** [성적처리] *** --
    create table tbl_sungjuk
    (hakbun      varchar2(20)
    ,name        varchar2(20)
    ,kor         number(3)
    ,eng         number(3)
    ,math        number(3)
    );
    
    select *
    from tbl_sungjuk;
    
    --- *** 데이터 입력하기 *** ---
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist001','한석규',90,92,93);
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist002','두석규',100,100,100);
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist003','세석규',71,72,73);
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist004','네석규',89,87,81);
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist005','오석규',60,50,40);
    insert into tbl_sungjuk(hakbun, name, kor, eng, math) values('sist006','육석규',80,81,87);
    
    commit;
    -- 커밋 완료.
    
    -----------------------------------------------------------------------------------------------------------------------------------
    학번  성명  국어  영어  수학  총점  평균(소수부 첫째자리까지 나타내되 반올림) 학점(평균이 90이상이면 'A' 90미만 80이상이면 'B' ..... 60미만이면 'F'
    -----------------------------------------------------------------------------------------------------------------------------------
   
    select hakbun as 학번 
          ,name as 성명
          ,kor as 국어
          ,eng as 영어
          ,math as 수학
          ,kor+eng+math as 총점
          ,round((kor+eng+math)/3, 1) as 평균
       -- ,trunc(round((kor+eng+math)/3, 1),-1)
          
          ,case trunc(round((kor+eng+math)/3, 1),-1)
          when 100 then 'A'
          when 90 then 'A'
          when 80 then 'B'
          when 70 then 'C'
          when 60 then 'D'
          else         'F'
          end
          as 학점1
          
          ,decode(trunc(round((kor+eng+math)/3, 1),-1), 100, 'A'
                                                      , 90 , 'A'
                                                      , 80, 'B'
                                                      , 70, 'C'
                                                      , 60, 'D'
                                                          , 'F') as 학점2
          , case
            when trunc(round((kor+eng+math)/3, 1),-1) in(100, 90)then 'A' 
            when trunc(round((kor+eng+math)/3, 1),-1) = 80 then 'B'
            when trunc(round((kor+eng+math)/3, 1),-1) = 70 then 'C'
            when trunc(round((kor+eng+math)/3, 1),-1) = 60 then 'D'
            else 'F'
            end as "학점3"
          
    from tbl_sungjuk
    
    --- 2.4 power : 거듭제곱
    
    select 2*2*2*2*2, power(2,5)  -- 2의 5승
    from dual;
        
    --- 2.5 sqrt : 제곱근
    select sqrt(16), sqrt(3), sqrt(2)
    from dual;
    
    --- 2.6 sin, cos, tan, asin, acos, atan
    select sin(90), cos(90), tan(90), asin(0.3), acos(0.3), atan(0.3)
    from dual;
    
    --- 2.7 log 
    select log(10,100)
    from dual;
    
    --- 2.8 sign ==> 결과값이 양수라면 1, 결과값이 0이면 0, 결과값이 음수라면 -1
    select sign(5-2), sign(5-5), sign(2-5)
    from dual;
    
    --- 2.9 ceil(실수) ==> 입력되어진 실수보다 큰 최소의 정수를 나타내어준다. 
    --      ceil(정수) ==> 입력되어진 정수를 그대로 나타내어준다. 
    select ceil(10.1), ceil(-10.1), ceil(10), ceil(-10)
    from dual;
    
    --- 2.10 floor(실수) ==> 입력되어진 실수보다 작은 최대의 정수를 나타내어준다. 
    --       floor(정수) ==> 입력되어진 정수를 그대로 나타내어준다. 
    select floor(10.1), floor(-10.1), floor(10), floor(-10)
    from dual;
    
    
    
    
    
    ------------------ >> 3. 날짜 함수 << -------------------
    
    /*
        날짜1 + 숫자 = 날짜2  ==> 날짜1 에서 숫자(단위가 일수)만큼 더한 값이 날짜2가 된다.
        날짜1 - 숫자 = 날짜2  ==> 날짜1 에서 숫자(단위가 일수)만큼 뺀 값이 날짜2가 된다.
        
        여기서 중요한 것은 숫자의 단위는 일수 이다. 
        
        날짜1 - 날짜2 = 숫자 ==> 결과값인 숫자의 단위는 일수 이다.
    */
    
    select
        sysdate-1, to_char(sysdate-1, 'yyyy-mm-dd hh24:mi:ss') as 어제시각,
        sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as 현재시각,
        sysdate+1, to_char(sysdate+1, 'yyyy-mm-dd hh24:mi:ss') as 내일시각
    from dual    
    
    ---- 단위환산 ----
    /*
        1 kg = 1000 g
        1 g = 1/1000 kg
        
        1일 = 24시간
        1시간 = 60분
        1분 = 1/60 시간
        1분 = 60초
        1초 = 1/60분
    */

    --- *** [퀴즈] 현재시각으로 부터 1일 2시간 3분 4초 뒤를 나타내세요. *** ---
    select sysdate+1+(2/24)+(3*((1/24)/60))+(4*(((1/24)/60)/60)) , to_char(sysdate+1+(2/24)+(3*((1/24)/60))+(4*(((1/24)/60)/60)), 'yyyy-mm-dd hh24:mi:ss') as "1일 2시간 3분 4초 뒤"
    -- 1일 : 1
    -- 2시간 : 2*(1/24)  ,(2/24)
    -- 3분 : 3*((1/24)/60), 3/(24*60) 
    -- 4초 : 4*(((1/24)/60)/60), 4/(24*60*50)
    from dual;
    
    --- 3.1 to_yminterval('년-월') , to_dsinterval('일 시:분:초')
    /*
        to_yminterval 은 년과 월을 나타내어 
        연산자가 +이면 날짜에서 더해주는 것이고,
        연산자가 -이면 날짜에서 빼주는 것이다. 
        
        to_dsinterval 은 일 시간,분,초를 나타내어 
        연산자가 +이면 날짜에서 더해주는 것이고,
        연산자가 -이면 날짜에서 빼주는 것이다. 
    */
    -- 현재시각으로 부터 1년 2개월 3일 4시간 5분 6초 뒤를 나타내세요
    select
        sysdate, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as 현재시각,
        sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'), 
        to_char(sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'), 'yyyy-mm-dd hh24:mi:ss') as "1년2개월3일4시간5분6초"
    from dual;    
    
    
    --- 3.2 add_months(날짜, 숫자)
    /*
        ==> 숫자가 양수이면 날짜에서 숫자 개월 수 만큼 더해준 날짜를 나타내는 것이고,
            숫자가 음수이면 날짜에서 숫자 개월 수 만큼 뺀 날짜는 나타내는 것이다.
        
        여기서 숫자의 단위는 개월 수 이다. 
    */
    
    select to_char(add_months(sysdate, -2), 'yyyy-mm-dd hh24:mi:ss') as "2개월 전",
           to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as 현재시각,
           to_char(add_months(sysdate, 2), 'yyyy-mm-dd hh24:mi:ss') as "2개월 후"
    from dual;

    -- *** 내일 홍길동이가 군대에 입대를 한다. 복무기간이 18개월 이라면 제대일자(년-월-일)를 구하세요.
    
    select  to_char(sysdate+1, 'yyyy-mm-dd') as 입대일,
            to_char(add_months(sysdate+1,18), 'yyyy-mm-dd') as 제대일자
    from dual;
    
    --- 3.3 months_between(날짜1, 날짜2)
    /*
          날짜1 에서 날짜2 를 뺀 값으로 그 결과는 숫자가 나오는데 결과물 숫자의 단위는 개월수 이다.
          즉, 두 날짜의 개월차이를 구할 때 사용한다.
     */
     
     select sysdate+3 - sysdate 
     from dual;
     --  날짜1 - 날짜2 = 숫자 ==> 결과값인 숫자의 단위는 일수 이다.
    
    select months_between(add_months(sysdate,3), sysdate), --3
           months_between( sysdate, add_months(sysdate,3))  -- -3
    from dual;
    
    --- 3.4 last_day(특정날짜)
    --      ==> 특정날짜가 포함된 달력에서 맨 마지막날짜를 알려주는 것이다.
    select sysdate, last_day(sysdate)
    from dual;
    
    select last_day('2022-02-01'),
           last_day(to_date('2022-02-01', 'yyyy-mm-dd')),
           last_day('2020-02-01'), 
           last_day('2023-02-01'), last_day('2024-02-01')
    from dual;
    
    --- 3.5 next_day(특정날짜, '일') '일'~'토'
    --      ==> 특정날짜로 부터 다음번에 돌아오는 가장 빠른 '일'~'토'의 날짜를 알려주는 것이다. 
    select sysdate
         , next_day(sysdate, '금')      
         , next_day(sysdate, '월')      
         , next_day(sysdate, '목')      
    from dual;
    -- 22/01/06	22/01/07	22/01/10	22/01/13
    
    -- 3.6  extract ==> 날짜에서 년, 월, 일을 숫자형태로 추출해주는 것이다. 
    --      참고로 to_char() ==> 날짜에서 년, 월, 일을 문자형태로 추출해주는 것이다.
    
    select sysdate
           , to_char(sysdate, 'yyyy')       -- 2022
           , extract (year from sysdate)    -- 2022
           , to_char(sysdate, 'mm')         -- 01
           , extract (month from sysdate)   -- 1
           , to_char(sysdate, 'dd')         -- 06
           , extract (day from sysdate)     -- 6 

    from dual; 
    
    
    ------------------ >> 4. 변환 함수 << -------------------    
    
    --- 4.1  to_char(날짜, '형태')  ==> 날짜를 '형태' 모양으로 문자형태로 변환시켜주는 것이다. 
    --       to_char(숫자, '형태')  ==> 숫자를 '형태' 모양으로 문자형태로 변환시켜주는 것이다.    
    
    --- 날짜를 문자형태로 변환하기 ---
     select to_char(sysdate, 'yyyy') AS 년도
          , to_char(sysdate, 'mm')   AS 월
          , to_char(sysdate, 'dd')   AS 일
          , to_char(sysdate, 'hh24') AS "24시간"
          , to_char(sysdate, 'am hh') AS "12시간"
          , to_char(sysdate, 'pm hh') AS "12시간"
          , to_char(sysdate, 'mi')   AS 분
          , to_char(sysdate, 'ss')   AS 초
          , to_char(sysdate, 'q')    AS 분기       -- 1월~3월 => 1,   4월~6월 => 2,   7월~9월 => 3,    10월~12월 => 4 
          , to_char(sysdate, 'day')  AS 요일명     -- 월요일(Windows) , Monday(Linux) 
          , to_char(sysdate, 'dy')   AS 줄인요일명  -- 월(Windows) , Mon(Linux)
     from dual;
     
     select to_char(sysdate, 'd')  -- sysdate 의 주의 일요일 부터(지금은 2022년 1월 2일)  sysdate(지금은 2022년 1월 6일) 까지 며칠째 인지를 알려주는 것이다.
                                   --  1(일요일)  2(월요일) 3(화요일) 4(수요일) 5(목요일) 6(금요일) 7(토요일) 
     from dual;
    
    select case to_char(sysdate, 'd')
           when '1' then '일'
           when '2' then '월'
           when '3' then '화'
           when '4' then '수'
           when '5' then '목'
           when '6' then '금'
           when '7' then '토'
           end as "오늘의 요일명"
    from dual;
    
    
    select decode ( to_char(sysdate, 'd'), 1, '일'
                                         , 2, '월'
                                         , 3, '화'
                                         , 4, '수'
                                         , 5, '목'
                                         , 6, '금'
                                         , 7, '토'
                                         ) as "오늘의 요일명2"
    from dual;

    
     select to_char(sysdate, 'dd') -- sysdate 의 월 1일 부터 (지금은 2022년 1월 1일) sysdate까지 며칠째 인지를 알려주는 것이다.
          , to_char(sysdate, 'ddd') -- sysdate 의 년도의 1월 1일 부터 (지금은 2022년) sysdate까지 며칠째 인지를 알려주는 것이다.              
     from dual;
        
     select to_char(add_months(sysdate, 1), 'dd') -- add_months(sysdate, 1)은 2022년 2월 6일이다.  
          , to_char(add_months(sysdate, 1), 'ddd') -- add_months(sysdate, 1)은 2022년 2월 6일이다.  
     from dual;
     
     -- ** 숫자를 문자형태로 변환하기 ** --
     
     select 1234567890
          , to_char(1234567890, '9,999,999,999')
          , to_char(1234567890, '$9,999,999,999')
          , to_char(1234567890, 'L9,999,999,999') -- L은 그 나라의 화폐기호가 나온다.
     from dual;
    --   1234567890	 1,234,567,890	 $1,234,567,890	        ￦1,234,567,890
    
    select 100
         , to_char(100, '999.0') -- 100.0       
         , 95.7
         , to_char(95.7,'999.0') -- 95.7 
         , to_char(95.7,'999.00') -- 95.70
         , to_char(95.78,'999.00') -- 95.78 
    from dual;

    --- 4.2 to_date(문자, '형태') ==> 문자를 '형태'모양으로 날짜형태로 변환시켜주는 것
    
    select '2022-01-06' + 1  
    from dual;
    -- ORA-01722: invalid number
    
    select to_date('2022-01-06', 'yyyy-mm-dd') + 1  
         , to_date('2022/01/06', 'yyyy-mm-dd') + 1       
         , to_date('20220106', 'yyyy-mm-dd') + 1
    from dual;
    -- 22/01/07     22/01/07        22/01/07
    
    select to_date('2022-02-28', 'yyyy-mm-dd') + 1  
    from dual;
    -- 20/03/01
    
    select to_date('2022-02-29', 'yyyy-mm-dd') + 1  -- 2022-02-29 은 달력에 없으므로 날짜로 변환이 불가하다.
    from dual;
    -- ORA-01839: date not valid for month specified
     
    select to_date('2020-02-29', 'yyyy-mm-dd') + 1  
    from dual;
     -- 20/03/01
    
    --- 4.3 to_number(문자) ==> 숫자모양을 가지는 문자를 숫자형태로 변환시켜주는 것
    
    select '12345', to_number('12345')
    from dual;
    
    select '50'+10  -- 자동형변환이 되어짐.
          , to_number('50')+10
    from dual;
    
    select to_number('홍길동')
    from dual;
    -- ORA-01722: invalid number
    
    
    select * from tab;
    
    desc view_employee_retire
    
    select *
    from view_employee_retire5
    
    select *
    from view_employee_retire
    where gender = '여' and trunc(age, -1) in (40,50)
    
    select *
    from view_employee_retire
    where gender = '남' and RETIRE_WORKING_MONTHS_NUM >= 500
    
    
    
    
    
    ---- Strored view(저장된 뷰) 가 뭐가 있는지 알아본디ㅏ. ---
    
    select *
    from user_views;
    
    
    
     ------------------ >> 5. 기타 함수 << -------------------    
    
    -- 5.1 case when then else end ==> !!! 암기 !!!
    
    select case 5-2
           when 4 then '5-2=4입니다.'
           when 1 then '5-2=1입니다.'
           when 0 then '5-2=0입니다.'
           else '나는 수학을 몰라요ㅜㅜ'
           end
    from dual;    
    
    select case
           when 4>5 then '4'는 '5'보다 큽니다.' 
           when 5>7 then '5'는 '7'보다 큽니다.'
           when 3>2 then '3'는 '2'보다 큽니다.'
           else '나는 수학을 몰라요ㅜㅜ'
           end as "결과"
    from dual;
    
    -- 5.2 decode ==> !!! 암기 !!!
    select decode(5-2, 4, '5-2=4입니다.'
                     , 1, '5-2=1입니다.' 
                     , 0, '5-2=0입니다.'
                     , '나는 수학을 몰라요ㅜㅜ') as "결과"
    from dual;
    
    -- 5.3  greatest, least
    
    select greatest(10, 90, 100, 80)  -- 나열되어진것들 중에 제일 큰 값을 알려주는 것
         , least(10, 90 ,100, 80)     -- 나열되어진것들 중에 제일 작은 값을 알려주는 것  
    from dual; 
    
    select greatest('김유신','허준','고수','엄정화')
         , least('김유신','허준','고수','엄정화')     
    from dual;
    
    -- 5.4 rank ==> 등수(석차) 구하기, dense_rank ==> 서열구하기
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , nvl(salary+(salary*commission_pct), salary) as 월급
         , rank() over( order by nvl(salary+(salary*commission_pct), salary)desc ) as 월급등수
         , dense_rank() over( order by nvl(salary+(salary*commission_pct), salary)desc ) as 월급서열   
    from employees;
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , nvl(salary+(salary*commission_pct), salary) as 월급
         , rank() over( order by nvl(salary+(salary*commission_pct), salary)desc ) as 전체월급등수
         , dense_rank() over( order by nvl(salary+(salary*commission_pct), salary)desc ) as 전체월급서열
         , department_id as 부서번호               
         , dense_rank() over( partition by department_id
                              order by nvl(salary+(salary*commission_pct), salary)desc ) as 부서내월급서열   
         , rank() over( partition by department_id
                        order by nvl(salary+(salary*commission_pct), salary)desc ) as 부서내월급등수

    from employees
    order by 부서번호;
    
    -- employees 테이블에서 월급이 가장 많이 버는 등수로 1등부터 10등까지인 사원들만 
    -- 사원번호, 사원명, 월급, 등수를 나타내세요. 
    select *
    from employees
    where rank() over( order by nvl(salary+(salary*commission_pct), salary)desc ) between 1 and 10;
    -- 오류!! rank() 및 dense_rank() 함수는 where절에 바로 사용할 수 없기 때문이다. 
    
    -- *** rank() 및 dense_rank() 함수는 where절에 바로 사용할 수 없기 때문에 
    -- inline view를 통해서 해야한다.  *** -- 
    
    
    
    
    select V.*
    from
    (
        select employee_id, first_name || ' ' || last_name as FULL_NAME,
               nvl(salary+(salary*commission_pct), salary) as MONTH_SAL,
               rank() over( order by nvl(salary+(salary*commission_pct), salary)desc as RANK_MONTH_SAL              
        from employees
     ) V
    where V.RANK_MONTH_SAL between 1 and 10;
    
    -- V는 생략가능하다.
    
    select *
    from
    (
        select employee_id, first_name || ' ' || last_name as FULL_NAME,
               nvl(salary+(salary*commission_pct), salary) as MONTH_SAL,
               rank() over( order by nvl(salary+(salary*commission_pct), salary)desc) as RANK_MONTH_SAL              
        from employees
     ) V
    where RANK_MONTH_SAL between 1 and 10;
    
            
   /*
        --- [퀴즈] ---
        employees 테이블에서 모든 사원들에 대해
        사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자, 정년퇴직일, 정년까지근무개월수, 퇴직금 을 나타내세요.
        
        여기서 정년퇴직일이라 함은 
        해당 사원의 생월이 3월에서 8월에 태어난 사람은 
        해당사원의 나이(한국나이)가 63세가 되는 년도의 8월 31일로 하고,
        해당사원의 생월이 9월에서 2월에 태어난 사람은 
        해당사원의 나이(한국나이)가 63세가 되는 년도의 2월말일(2월28일 또는 2월29일)로 한다.
   
        정년까지근무개월수 ==> 입사일자로 부터 정년퇴직일 까지 개월차이 
        months_between(정년퇴직일, 입사일자)
        
        퇴직금 ==> 근무년수 * 월급       26개월근무 ==> 2년2개월 ==> 2년*월급
        
    */
    
    desc employees
    
    /*
    select employee_id as "사원번호"
         , first_name || ' ' || last_name as "사원명"
         , jubun as "주민번호"
         , decode (substr(jubun, 7, 1) , 1 , '남자'
                                       , 2 , '여자'          
                                       , 3 , '남자'
                                       , 4 , '여자'
           ) as "성별"
         , case
           when to_number(substr(jubun, 7, 1))<=2 then (extract(year from sysdate)) - (to_number(substr(jubun, 1, 2))+1900)+1    
           when to_number(substr(jubun, 7, 1))> 2 then (extract(year from sysdate)) - (to_number(substr(jubun, 1, 2))+2000)+1
           end as "현재나이"
         , NVL(salary+(salary*commission_pct), salary) as "월급"
         , hire_date as "입사일자"
         -- 정년퇴직일은 해당사원의 나이가 63세가 되는 년도
         -- 어떤 사원의 현재나이가 62세 => 63세가 되는 년도 add_months(sysdate, (63-62)*12)
         -- 어떤 사원의 현재나이가 40세 => 63세가 되는 년도 add_months(sysdate, (63-40)*12)
         -- 어떤 사원의 현재나이가 x세 => 63세가 되는 년도 add_months(sysdate, (63-x)*12)
         -- to_char(add_months(sysdate,  (63-현재나이*12), 'yyyy') || '-08-31'
         , last_day(to_char(add_months(sysdate, (63- (extract(year from sysdate) - (substrsubstr(jubun, 1, 2) + 
           case when to_number(substr(jubun,3,2))between 3 and 8 then '-08-01' else '-02-01'
           end) as "정년퇴직일"
   --    , as "정년까지근무개월수"
   --    , as "퇴직금"
    from employees
    
    */
    
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS 성별
    
    --   , 현재년도 - 태어난년도( 주민번호앞의2자리 + 1900 OR 주민번호앞의2자리 + 2000 ) + 1 AS 현재나이
         , extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 AS 현재나이
         
         , nvl(salary + (salary * commission_pct), salary) AS 월급
         , hire_date AS 입사일자
         
         --  정년퇴직일은 해당사원의 나이(한국나이)가 63세가 되는 년도 
         --  어떤 사원의 현재 나이가 62세 => 63세가 되는 년도  add_months(sysdate, (63-62)*12)
         --  어떤 사원의 현재 나이가 40세 => 63세가 되는 년도  add_months(sysdate, (63-40)*12)
         --  어떤 사원의 현재 나이가 57세 => 63세가 되는 년도  add_months(sysdate, (63-57)*12) 
         --  to_char( add_months(sysdate, (63-현재나이)*12), 'yyyy') || '-08-31'
         
         ,  last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                      case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end  
                     ) AS 정년퇴직일
       --,  months_between(정년퇴직일, hire_date) as "정년까지근무개월수"           
                     
         , trunc( 
         months_between((last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                      case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end)  
                     ), hire_date)
                     ) as "정년까지근무개월수"                        
      -- , 근무년수 * 월급    26개월근무 ==> 2년 2개월 ==> 2년 * 월급
       --, trunc(정년까지 근무개월수/12 ) * 월급
         , trunc( trunc( 
                 months_between((last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                                  case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end)  
                                 ), hire_date)
                         )/12) * nvl(salary + (salary * commission_pct), salary)
         as "퇴직금"            
    from employees;
     
     
         select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , jubun AS 주민번호
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS 성별
         , extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 AS 현재나이
         , nvl(salary + (salary * commission_pct), salary) AS 월급
         , hire_date AS 입사일자
         ,  last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                      case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end  
                     ) AS 정년퇴직일
         , trunc( 
         months_between((last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                      case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end)  
                     ), hire_date)
                     ) as "정년까지근무개월수"                        
         , trunc( trunc( 
                 months_between((last_day( to_char( add_months(sysdate, (63-( extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 ))*12), 'yyyy') || 
                                  case when to_number( substr(jubun,3,2) ) between 3 and 8 then '-08-01' else '-02-01' end)  
                                 ), hire_date)
                         )/12) * nvl(salary + (salary * commission_pct), salary)
         as "퇴직금"            
    from employees;
 
 ---------------------------------------------------------------------------------------------------------
 ---- !!!! "inline view" 를 사용하여 구해봅시다. !!!! ----  
    select employee_id, full_name, jubun, GENDER, AGE, MONTH_SAL, hire_date
         , last_day( 
                     to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                     case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
           ) as 정년퇴직일
       --,  months_between(정년퇴직일, hire_date) as "정년까지근무개월수"        
         ,  trunc(
                    months_between(last_day( 
                                             to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                                             case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
                                            ), hire_date) 
                    ) as "정년까지근무개월수"  
       --, trunc(정년까지 근무개월수/12 ) * 월급           
         , trunc( 
                (trunc(
                    months_between(last_day( 
                                             to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                                             case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
                                            ), hire_date) 
                    )
                    )/12 ) * MONTH_SAL  as 퇴직금        
    from 
    (
    select employee_id
         , first_name || ' ' || last_name AS FULL_NAME
         , jubun
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
         , extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 AS AGE
         , nvl(salary + (salary * commission_pct), salary) AS MONTH_SAL
         , hire_date
    from employees
    )V; -- V를 "inline view"라고 부른다.
    
    ----- **** !!!!! 아주 중요중요중요중요중요중요중요중요중요중요 !!!!! **** -----
    
    -- VIEW(뷰)란? 테이블은 아니지만 select 되어진 결과물을 마치 테이블 처럼 보는것(간주하는 것)이다.
    
    -- VIEW(뷰) 는 2가지 종류가 있다.
    -- 첫번째로 inline view 가 있고, 두번째로 stored view 가 있다. 
    -- inline view 는 바로 위의 예제에 보이는 V 인 것이다. 즉, select 구문을 괄호( )를 쳐서 별칭(예 : V)을 부여한 것을 말한다.
    -- stored view 는 복잡한 SQL(Structured Query Language == 정형화된 질의어)을 저장하여 select 문을 간단하게 사용하고자 할 때 쓰인다.
    -- 그래서 inline view 는 1회성이고, stored view는 언제든지 불러내서 재사용이 가능하다.
     
     
       
    --- *** Stored view(저장된 뷰) 생성하기  *** ---
    /*
        create or replace view 뷰명  --> 만약에 저장된 뷰로 뷰명이 없으면 새로이 생성(create)해주고, 뷰명이 이미 존재한다라면 그 이전의 select문은 없애고 지금의 select문으로 바꾸어라(replace)는 말이다.
        as 
        select 문;
    */
    
    create or replace view view_employee_retire
    as 
    select employee_id, first_name || ' ' || last_name as full_name
         , salary, department_id 
    from employees
    where department_id in(20,30);
    
    select *
    from view_employee_retire
   
   
    create or replace view view_employee_retire
    as 
    select employee_id, full_name, jubun, GENDER, AGE, MONTH_SAL, hire_date
         , last_day( 
                     to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                     case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
           ) as RETIREMENT_DATE
         ,  trunc(
                    months_between(last_day( 
                                             to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                                             case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
                                            ), hire_date) 
                    ) as RETIRE_WORKING_MONTHS_NUM 
         , trunc( 
                (trunc(
                    months_between(last_day( 
                                             to_char( add_months(sysdate, (63-AGE)*12), 'yyyy') || 
                                             case when to_number(substr(jubun,3,2)) between 3 and 8 then '-08-01' else '-02-01' end 
                                            ), hire_date) 
                    )
                    )/12 ) * MONTH_SAL  as SEVERANCE_PAY        
    from 
    (
    select employee_id
         , first_name || ' ' || last_name AS FULL_NAME
         , jubun
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
         , extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 AS AGE
         , nvl(salary + (salary * commission_pct), salary) AS MONTH_SAL
         , hire_date
    from employees
    )V;  
  -- View VIEW_EMPLOYEE_RETIRE이(가) 생성되었습니다.
    
    
    ---- Stored view(저장된 뷰) 중에  VIEW_EMPLOYEE_RETIRE 의 원본 소스를 알아봅니다. ------
    select *
    from user_views
    where view_name = 'VIEW_EMPLOYEE_RETIRE' ;
    
    
   --- 5.5 lag 함수, lead 함수
   --      ==> 게시판에서 특정글을 조회할 때 많이 사용합니다. !!!
    
   delete from tbl_board;    

   create table tbl_board
    (boardno       number                -- 글번호 
    ,subject       varchar2(4000)        -- 글제목   varchar2 의 최대크기는 4000 이다. 4000 보다 크면 오류!!!
    ,content       Nvarchar2(2000)       -- 글내용   Nvarchar2 의 최대크기는 2000 이다. 2000 보다 크면 오류!!!
    ,userid        varchar2(40)          -- 글쓴이의 ID
    ,registerday   date default sysdate  -- 작성일자   default sysdate 은 데이터 입력시 registerday 컬럼의 값을 생략하면 기본적으로 sysdate 가 입력된다는 말이다. 
    ,readcount     number(10)            -- 조회수
    );
    
    insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
    values(1, '안녕하세요', '글쓰기 연습입니다', 'leess',  sysdate, 0);  
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_board
    values(2, '반갑습니다', '모두 취업대박 나십시오', 'eomjh',  sysdate, 0);  
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_board(subject, boardno, content, userid, registerday, readcount)
    values('건강하세요', 3, '로또 1등을 기원합니다', 'youks',  sysdate, 0); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
    values(4, '기쁘고 감사함이 넘치는 좋은 하루되세요', '늘 행복하세요', 'leess',  default, 0);
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_board(boardno, subject, content, userid, readcount)
    values(5, '오늘도 좋은 하루되세요', '늘 감사합니다', 'hongkd', 0);
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    -- 커밋 완료.
   
    select *
    from tbl_board;
   
    select boardno
         , case when length(subject) > 7 then substr(subject, 1,5)||'..' else subject end as SUBJECT 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss')
    from tbl_board
    order by boardno desc;   
   
/*
     ---------------------------------------------------------------------------------------------------------------------------------------
      이전글번호   이전글제목     이전글작성일자          글번호   글제목      글작성일자             다음글번호     다음글제목   다음글작성일자
     ---------------------------------------------------------------------------------------------------------------------------------------
       4        기쁘고 감..    2022-01-07 10:24:35     5    오늘도 좋..   2022-01-07 10:26:01  null        null         null 
       3        건강하세요     2022-01-07 10:23:46     4    기쁘고 감..   2022-01-07 10:24:35  5           오늘도 좋..    2022-01-07 10:26:01
       2        반갑습니다     2022-01-07 10:22:51     3    건강하세요    2022-01-07 10:23:46    4          기쁘고 감..    2022-01-07 10:24:35
       1        안녕하세요     2022-01-07 10:21:37     2    반갑습니다    2022-01-07 10:22:51    3          건강하세요     2022-01-07 10:23:46
       null      null         null                   1    안녕하세요    2022-01-07 10:21:37    2          반갑습니다     2022-01-07 10:22:51
    */
    
    
    select lead(boardno, 1) over(order by boardno desc) as 이전글번호
           -- boardno(글번호) 칼럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 boardno 값을 가져오는 것이다.
         , lead(SUBJECT, 1) over(order by boardno desc) as 이전글제목
           -- SUBJECT 칼럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 SUBJECT 값을 가져오는 것이다.           
         , lead(REGISTERDAY, 1) over(order by boardno desc) as 이전글작성일자
           -- REGISTERDAY 칼럼의 값을 내림차순으로 정렬했을 때 아래쪽으로 1칸 내려간 행의 REGISTERDAY 값을 가져오는 것이다.           
         
         , boardno as 글번호
         , SUBJECT as 글제목
         , REGISTERDAY as  글작성일자
         
         , lag(boardno, 1) over(order by boardno desc) as 다음글번호
         -- boardno 칼럼의 값을 내림차순으로 정렬했을 때 위쪽으로 1칸 올라간 행의 boardno 값을 가져오는 것이다.           
         , lag(SUBJECT, 1) over(order by boardno desc) as 다음글제목
         -- SUBJECT 칼럼의 값을 내림차순으로 정렬했을 때 위쪽으로 1칸 올라간 행의 SUBJECT 값을 가져오는 것이다.           
         , lag(REGISTERDAY, 1) over(order by boardno desc) as 다음글작성일자
         -- SUBJECT 칼럼의 값을 내림차순으로 정렬했을 때 위쪽으로 1칸 올라간 행의 SUBJECT 값을 가져오는 것이다.           
    from 
    (
    select boardno
         , case when length(subject) > 7 then substr(subject, 1,5)||'..' else subject end as SUBJECT 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
    from tbl_board
    ) V;
    
     select lead(boardno) over(order by boardno desc) as 이전글번호
           -- (boardno, 1)에 숫자가 없으면 1이 생략된 것이다.
         , lead(SUBJECT) over(order by boardno desc) as 이전글제목
         , lead(REGISTERDAY) over(order by boardno desc) as 이전글작성일자
         
         , boardno as 글번호
         , SUBJECT as 글제목
         , REGISTERDAY as  글작성일자
         
         , lag(boardno) over(order by boardno desc) as 다음글번호
         -- (boardno, 1)에 숫자가 없으면 1이 생략되어진 것이다.       
         , lag(SUBJECT) over(order by boardno desc) as 다음글제목
         , lag(REGISTERDAY) over(order by boardno desc) as 다음글작성일자
    from 
    (
    select boardno
         , case when length(subject) > 7 then substr(subject, 1,5)||'..' else subject end as SUBJECT 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
    from tbl_board
    ) V;
    
    select T.*
    from
    (
    select lead(boardno) over(order by boardno desc) as 이전글번호
         , lead(SUBJECT) over(order by boardno desc) as 이전글제목
         , lead(REGISTERDAY) over(order by boardno desc) as 이전글작성일자
         
         , boardno as 글번호
         , SUBJECT as 글제목
         , REGISTERDAY as  글작성일자
         
         , lag(boardno) over(order by boardno desc) as 다음글번호
         , lag(SUBJECT) over(order by boardno desc) as 다음글제목
         , lag(REGISTERDAY) over(order by boardno desc) as 다음글작성일자
    from 
    (
    select boardno
         , case when length(subject) > 7 then substr(subject, 1,5)||'..' else subject end as SUBJECT 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS REGISTERDAY
    from tbl_board
    ) V
    ) T
    where T.글번호 = 3;
   
   
   ---------------------------------------------------------------------------------
   -- *** case when then else end 구문을 사용하여 로그인 메시지 보여주기 *** --
   
    create table tbl_members
    (userid    varchar2(20)
    ,passwd    varchar2(20)
    ,name      varchar2(20)
    ,addr      varchar2(100)
    );
    
    insert into tbl_members(userid, passwd, name, addr)
    values('kimys','abcd','김유신','서울');
    
    insert into tbl_members(userid, passwd, name, addr)
    values('young2','abcd','이영이','서울');
    
    insert into tbl_members(userid, passwd, name, addr)
    values('leesa','abcd','이에리사','서울');
    
    insert into tbl_members(userid, passwd, name, addr)
    values('park','abcd','박이남','서울');
    
    insert into tbl_members(userid, passwd, name, addr)
    values('leebon','abcd','이본','서울');
    
    commit;  
    
    select *
    from tbl_members;
   
    select count(*) -- select 되어져 나온 결과물에 행의 개수 ==> 5
    from tbl_members;  
   
    select count*
    from tbl_members;
    where userid = 'kimys' and passwd='abcd';
    
    select count(*) -- select 되어져 나온 결과물에 행의 개수 ==> 1
    from tbl_members
    where userid = 'kimys' and passwd='abcd';
    
    select count*
    from tbl_members;
    where userid = 'kimys' and passwd='asdadabcd';
    
    select count(*) -- select 되어져 나온 결과물에 행의 개수 ==> 0
    from tbl_members
    where userid = 'kimys' and passwd='asdadabcd';
    
    select count*
    from tbl_members;
    where userid = 'kimyshgf' and passwd='abcd';
    
    select count(*) -- select 되어져 나온 결과물에 행의 개수 ==> 0
    from tbl_members
    where userid = 'kimyshgf' and passwd='abcd';
    
    /*
       -- [퀴즈] --
       tbl_members 테이블에서
       userid 및 passwd 가 모두 올바르면 '로그인성공' 을 보여주고,
       userid 는 올바르지만 passwd 가 틀리면 '암호가 틀립니다' 을 보여주고,
       userid 가 존재하지 않으면 '아이디가 존재하지 않습니다' 을 보여주려고 한다.
    */
   
   select case ( select count(*)
                 from tbl_members
                 where userid = 'kimys' and passwd = 'abcd' )
          when 1 then '로그인 성공'
          else ( 
                 case (select count(*)
                 from tbl_members
                 where userid = 'kimys')
                 when 1 then '암호가 틀립니다.'
                 else '아이디가 존재하지 않습니다.'
                 end
                )
          end AS 로그인결과     
   from dual;
    
 -- =========================================================================== --
 ---------------------------------------------------------------------------------
 
 
            ----- >> 그룹함수(집계함수) << ------
/*
    1. sum      -- 합계
    2. avg      -- 평균
    3. max      -- 최대값
    4. min      -- 최소값
    5. count    -- select 되어서 나온 결과물 행의 개수
    6. variance -- 분산
    7. stddec   -- 표준편차
    
    분산    :  분산의 제곱근이 표준편차 (평균에서 떨어진 정도)
    표준편차 : 표준편차의 제곱승이 분산 (평균과의 차액)
    
    >> 주식투자 <<
    A - 50  60  40  50  55  45  52  48  평균 50 A는 B보다 상대적으로 편차가 적음   -- 안정투자 
    B - 10  90  20  80  30  70  90  10  평균 50 B는 A보다 상대적으로 편차가 큼     -- 투기성투자(위험을 안고서 투자함)
    
    분산과 표준편차는 어떤 의사결정시 도움이 되는 지표이다. 
    
*/
    
    select salary , to_char(salary, '$99,999')
    from employees;  -- 107개의 행 , 107개의 행
    
    select sum(salary)  -- 그룹함수는 결과물이 1개행만 나온다. 
    from employees;
    
    select salary, sum(salary)  
    from employees; -- 테이블은 다각형이 아니므로 오류이다!!!!
    
    ---- !!! 중요중요중요중요 !!! ----
    -- 그룹함수(집계함수)에서는 null 이 있으면 무조건 null은 제외시킨 후 연산을 한다. !!!
    -- 그룹함수(집계함수)를 사용하면 1개의 결과물을 가진다. 
    
    select 1+100+5234+null -- null
    from dual; 
    
    select sum(salary*commission_pct) -- 73690
    from employees; 
    
    select sum(salary*commission_pct) -- 73690
    from employees
    where commission_pct is not null;
    
    select sum(salary * commission_pct)
         , count(salary)         -- 107
         , count(commission_pct) --  35
    from employees;
    
    select count(*)              -- 107 전체사원수
          ,count(department_id)  -- 106 department_id 컬럼의 값이 null이 아닌 개수
          ,count(commission_pct) --  35 commission_pct 컬럼의 값이 null이 아닌 개수
          ,count(EMPLOYEE_ID)    -- 107   
          ,count(EMAIL)          -- 107       
    from employees;
    
    select sum(salary * commission_pct) -- 합계
         , avg(salary * commission_pct) -- 평균
         , max(salary * commission_pct) -- 최대값
         , min(salary * commission_pct) -- 최소값
         , count(salary * commission_pct) -- null을 제외한 개수
         , variance(salary * commission_pct) -- 분산
         , stddev(salary * commission_pct) -- 표준편차
    from employees;
    
    
    ----  **** avg() 평균을 구할때는 주의를 요한다. **** -----
    -- employees 테이블에서 수당(salary * commission_pct)의 평균을 나타내세요.
    
    select sum(salary * commission_pct)/count(salary * commission_pct)
         -- 2105.428571428571428571428571428571428571	
         --       73690 / 35
         , avg(salary * commission_pct)
         -- 2105.428571428571428571428571428571428571
         , sum(salary * commission_pct)/count(*)
         -- 73690 / 107
         -- 688.691588785046728971962616822429906542
         , sum(nvl(salary * commission_pct),0) / count(nvl(salary * commission_pct),0)
         -- 73690 / 107
         -- 688.691588785046728971962616822429906542
         , avg(nvl(salary * commission_pct),0)
         -- 73690 / 107
         -- 688.691588785046728971962616822429906542        

    from employees;
    
    select salary * commission_pct
         , nvl(salary * commission_pct, 0)       
    from employees;
    
    select count(salary * commission_pct)
         , count(nvl(salary * commission_pct, 0))      
    from employees;
    
--    sum(10+20+null+30)  ==> 60
--    sum(10+20+0+30)     ==> 60   

    select avg(salary * commission_pct)
         -- 수당액을 받는 사람들 그들만의 수당액 평균
         , avg(nvl(salary * commission_pct),0)
         -- 수당이 null인 사람은 0으로 간주한 모든 사원들의 수당액 평균
    from employees;
    
    ---- *** 그룹함수(집계함수)와 함께 사용되어지는 group by 절에 대해서 알아봅니다. *** ---
    
    --- employees 테이블에서 부서번호별로 인원수를 나타내세요. ---
    
    /*
        -----------------
        부서번호   인원수
        -----------------
          10        1
          20        2
          30        6
          40        1
          50       45
          ...      ...
    */
    
    select department_id as 부서번호
         , count(*)      as 인원수 
    from employees 
    group by department_id  -- department_id 컬럼의 값이 같은 것 끼리 그룹을 짓는다.
    order by 1 asc;
    
    --- employees 테이블에서 성별로 인원수를 나타내세요. ---
    
    /*
        --------------------
          성별     인원수
        --------------------
          남       56
          여       51 
    */
    
    select gender as 성별
         , count(*) as 인원수      
    from
    (
    select case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end  as gender
    from employees 
    ) V 
    group by gender
    order by 1;
    
    ---- [퀴즈] employees 테이블에서 연령대별로 인원수를 나타내세요. ----
   
   -- 나이 = (현재년도)-( 주민번호 앞자리 2개 + 1900 or 2000) +1 
   -- 현재년도 = (to_char(sysdate, 'yyyy'))
   -- 주민번호 앞자리 2개 = (substr(jubun,1,2))
   -- 1900 or 2000 = (case when substr(jubun,7,1) in(1,2) then 1900 else 2000)
   -- 연령대는 = 나이- 
  
  select Age_line as 연령대
       , count(*) as 인원수
  from
  (  
  select (round(age/10,0)*10) as age_line

  from 
  (
   select (to_char(sysdate, 'yyyy'))-((substr(jubun,1,2))+(case when substr(jubun,7,1) in(1,2) then 1900 else 2000 end))+1 as age
   from employees 
   ) V
   ) V2
   group by Age_line
   order by 1; -- 내가 푼것
   
   -- 강사님 풀이 --
     /*
       ----  ------
       나이   연령대  trunc(나이, -1)
       ----  ------
        25     20    trunc(25, -1)
        29     20    trunc(29, -1)
        20     20    trunc(20, -1)
        
      나이 ==>  현재년도 - 태어난년도 + 1
               extract(year from sysdate)
               substr(jubun,1,2) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end + 1 
   */
   select V.AGE_LINE AS 연령대
        , count(*) AS 인원수 
   from 
   (
    select trunc( extract(year from sysdate) - (substr(jubun,1,2) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1 , -1) AS AGE_LINE
    from employees
   ) V
   group by V.AGE_LINE
   order by 1;
   
   ----- *** 1차 그룹, 2차 그룹 짓기 **** -----
   
   ----- employees 테이블에서 부서번호별, 성별 인원수를 나타내세요. ---
   
/*
    ------------------------
    부서번호   성별   인원수
    ------------------------
    ....     ....   ....
    50        남      23
    50        여      22
    60        남       4                                          
    60        여       1
    ....................
    
*/
    
    select department_id as 부서번호 , gender as 성별, count(*) as 인원수
    from
    (
    select department_id 
         , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end as gender
    from employees
    )V
    group by department_id, gender
    order by 1;
    
    ---- [퀴즈] employees 테이블에서 연령대별, 성별 인원수를 나타내세요. ----
   /*
      -------------------------
       연령대     성별    인원수
      -------------------------
        10        남
        10        여
        20        남
        20        여
        30        남
        30        여
        ...       ...
   */
   
   select AGE_LINE as 연령대, GENDER as 성별 , count(*) as 인원수
   from 
   (
   select case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end  as gender
        , trunc( extract(year from sysdate) - (substr(jubun,1,2) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1 , -1) AS AGE_LINE    
   from employees
   ) V
   group by AGE_LINE, GENDER
   order by 1;
   
   -------------------------------------------------------------------------------
   
   ---- *** 요약값을 보여주는 rollup, cube, grouping sets, grouping 에 대해서 알아보자 *** ---
   
      ----- >>>>> 요약값(rollup, cube, grouping sets) <<<<< ------
  /*
      1. rollup(a,b,c) 은 grouping sets( (a,b,c),(a,b),(a),() ) 와 같다.
    
         group by rollup(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), () ) 와 같다.
  
      2. cube(a,b,c) 은 grouping sets( (a,b,c),(a,b),(b,c),(a,c),(a),(b),(c),() ) 와 같다.
 
         group by cube(department_id, gender) 은
         group by grouping sets( (department_id, gender), (department_id), (gender), () ) 와 같다.
  */
   
   -- employees 테이블에서 부서번호별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
   
   
   select department_id as 부서번호
         ,count(*)      as 인원수
   from employees 
   group by rollup(department_id);
   
   select department_id as 부서번호
         ,grouping(department_id) -- grouping(department_id)은 결과값이 오로지 2개만 나온다. 0또는 1인데, 0이라함은 department_id 컬럼의 값으로 그룹을 지었다는 말이고, 1이라함은 그룹을 안지었다는 말이다.   
         ,count(*)      as 인원수
   from employees 
   group by rollup(department_id);
    
    
   select department_id as 부서번호
         ,count(*)      as 인원수
   from employees 
   group by rollup(department_id);
   
   select decode(grouping(department_id), 0, nvl(to_char(department_id),'부서없음')
                                           , '전체' ) as 부서번호 
         ,count(*)      as 인원수
   from employees 
   group by rollup(department_id);
   
   select decode(grouping(department_id), 0, nvl(to_char(department_id),'부서없음')
                                           , '전체' ) as 부서번호 
         , count(*)      as 인원수
         , round(count(*) /  (select count(*) from employees) * 100, 1) as 퍼센티지
   from employees 
   group by rollup(department_id);
   
   
   -- employees 테이블에서 성별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
/*
    -------------------------------------------
        성별     인원수     퍼센티지
    -------------------------------------------    
        남       56          52        
        여       51          48 
        전체     107         100 
*/


    select decode(grouping(v.gender),0,gender,'전체') as 성별
         , count(*) as 인원수
         , round(count(*)/(select count(*) from employees)*100,0) as 퍼센티지           
    from
    (
    select case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
    from employees
    ) V
    group by rollup(v.gender);
    
    
   -- employees 테이블에서 부서번호별, 성별로 인원수를 나타내면서 동시에 전체인원수도 나타내세요.
   
   /*
   ----------------------------------------
     부서번호     성별    인원수    퍼센티지
   ----------------------------------------
        ...      ...    ....     ......   
       50        남       20        
       50        여       25
       50       전체       45
       60        남        3
       60        여        2
       60       전체        5
       ........................
      
      전체       전체      107     
   */
   
   ------ rollup 사용 시 -----  
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , '전체') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , '전체') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by rollup(v.department_id, v.gender);
   
  
   select decode(grouping(v.gender), 0, v.gender
                                           , '전체') as 성별
        , decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , '전체') as 부서번호                                  
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by rollup(v.gender, v.department_id);
  
  
   ------ cube 사용시 -----------  
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , ' ') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , ' ') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by cube(v.department_id, v.gender)
-- order by 1 asc ;
   order by v.department_id;
   
 ------ grouping sets 사용시 ------------
 
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , ' ') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , ' ') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by grouping sets((v.department_id, v.gender), v.department_id, v.gender, ())
   order by v.department_id;
   


   
   
   
 -------------- grouping sets 사용시 ------------ 
 
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , '전체') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , '전체') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by grouping sets((v.department_id, v.gender), v.department_id, ());
   


   select decode(grouping(v.gender), 0, v.gender
                                           , '전체') as 성별
        , decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , '전체') as 부서번호                                  
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by grouping sets((v.gender, v.department_id),v.gender, ());
   
   
   
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , ' ') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , ' ') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by grouping sets((v.department_id, v.gender), ())
   order by v.department_id;
   
   select decode(grouping(v.department_id), 0,nvl(to_char(v.department_id), '인턴')
                                             , ' ') as 부서번호
       
        , decode(grouping(v.gender), 0, v.gender
                                           , ' ') as 성별
        , count(*) as 인원수
        , round(count(*)/(select count(*) from employees)*100,1) as 퍼센티지     
   from
   (
       select department_id
            , case when substr(jubun, 7, 1) in(1,3) then '남' else '여' end  AS GENDER
       from employees
   ) V
   group by grouping sets((v.department_id), (v.gender), ())
   order by v.department_id;   
   
   
 
 
 -----------------------------------------------------------------------------------------
 ---------- ======= ****   having 그룹함수조건절   **** ======= ----------
   /*
       group by 절을 사용하여 그룹함수의 값을 나타내었을때
       그룹함수의 값이 특정 조건에 해당하는 것만 추출하고자 할때는 where 절을 사용하는 것이 아니라
       having 그룹함수조건절 을 사용해야 한다.
   */
   
   -- employees 테이블에서 사원이 10명 이상 근무하는 부서번호와 그 인원수를 나타내세요.
   
   select department_id, count(*)
   from employees
   where count(*) >= 10
   group by department_id --오류 !!
   
   
   
   select department_id as 부서번호
        , count(*) as 인원수
   from employees
   group by department_id
   having count(*) >= 10
   order by 인원수 desc;
   
   --- [퀴즈] employees 테이블에서 부서번호별로 월급의 합계를 나타내었을 때
   --        부서번호별 월급의 합계가 50000 이상인 부서에 대해서만
   --        부서번호, 월급의 합계를 나타내세요.
   
    select department_id as 부서번호
        ,to_char( sum(month_pay),'999,999') as 월급의합    
    from
    (
       select department_id 
            , nvl(salary+(salary*commission_pct),salary) as month_pay
       from employees
    ) V 
    group by department_id
    having sum(month_pay) >= 50000
    order by 2 desc;
    
   
   
   
   ------- **** !!! 누적(누계)에 대해서 알아봅니다. !!! **** ---------
   /*
        sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
        
        sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                                   order by 누적되어질 기준이 되는 컬럼명 asc[desc] )
   */ 
    
    
    create table tbl_panmae
          (panmaedate  date
          ,jepumname   varchar2(20)
          ,panmaesu    number
          );
  -- Table TBL_PANMAE이(가) 생성되었습니다.
    
    delete from tbl_panmae
    
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-2), '새우깡', 10);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-2)+1, '새우깡', 15); 
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-2)+2, '감자깡', 20);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-2)+3, '새우깡', 10);
     
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-2)+3, '새우깡', 3);
     
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-1), '고구마깡', 7);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-1)+1, '새우깡', 8); 
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-1)+2, '감자깡', 10);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( add_months(sysdate,-1)+3, '감자깡', 5);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate - 4, '허니버터칩', 30);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate - 3, '고구마깡', 15);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate - 2, '고구마깡', 10);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate - 1, '허니버터칩', 20);
    
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '새우깡', 10);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '새우깡', 10);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '감자깡', 5);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '허니버터칩', 15);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '고구마깡', 20);
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '감자깡', 10); 
    
     insert into tbl_panmae(panmaedate, jepumname, panmaesu)
     values( sysdate, '새우깡', 10);
    
     commit;
     
    select *
    from tbl_panmae;
  
    --- *** tbl_panmae 테이블에서 '새우깡'에 대한 일별판매량과 일별누적판매량을 나타내세요. *** ---
    
    
    select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') as panmaedate
         , panmaesu
    from tbl_panmae
    where jepumname = '새우깡';
    
    
/*
    -----------------------------------
    판매일자     일별판매량    일별누적판매량
    -----------------------------------
    2021-11-10 	10          10
    2021-11-11 	15          25
    2021-11-13 	13          38    
    2021-12-11 	8           46
    2022-01-10 	30          76
    ------------------------------------
*/
------------
    select to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
         , sum(panmaesu) as 일별판매량
    --   , sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc] ) 
         ,  sum(sum(panmaesu)) over(order by to_char(panmaedate, 'yyyy-mm-dd') asc) as 일별누적판매량    
    from tbl_panmae
    where jepumname = '새우깡'
    group by to_char(panmaedate, 'yyyy-mm-dd');
   
    --- *** tbl_panmae 테이블에서 모든 제품에 대한 일별판매량과 일별누적판매량을 나타내세요. *** ---
    
/*
    ------------------------------------------------
    제품명       판매일자     일별판매량    일별누적판매량
    ------------------------------------------------
    감자깡       2021-11-12  20          20
    감자깡       2021-12-12  10          30
    감자깡       2021-12-13   5          35
    감자깡       2021-01-10  15          50
    
    새우깡       2021-11-10 	10          10
    새우깡       2021-11-11 	15          25
    새우깡       2021-11-13 	13          38    
    새우깡       2021-12-11 	8           46
    새우깡       2022-01-10 	30          76
    -------------------------------------------------
*/


    select jepumname as 제품명, to_char(panmaedate, 'yyyy-mm-dd') as 판매일자 
         , sum(panmaesu) as 일별판매량
--       , sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
--                                 order by 누적되어질 기준이 되는 컬럼명 asc[desc] ) 
         ,  sum(sum(panmaesu)) over(partition by jepumname
                                   order by to_char(panmaedate, 'yyyy-mm-dd') asc ) 
                                   as 일별누적판매량
    from tbl_panmae
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd'); 
    
    
    create or replace view view_NUJUKPANMAE
    as
    select jepumname 
         , to_char(panmaedate, 'yyyy-mm-dd') as PANMAEDATE 
         , sum(panmaesu) as DAILY_SALES
         , sum(sum(panmaesu)) over(partition by JEPUMNAME
                                   order by to_char(panmaedate, 'yyyy-mm-dd') asc ) 
                                   as DAILY_NUJUK_SALES
    from tbl_panmae
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd'); 
    -- View VIEW_NUJUKPANMAE이(가) 생성되었습니다.
    
    
    select *
    from view_nujukpanmae
    where jepumname in('감자깡', '새우깡'); 
    
    
    --- *** [퀴즈] tbl_panmae 테이블에서 판매일자가 1개월 전 '01'일(즉, 현재가 2022년 01월 10일 이므로 2021년 12월 01일) 부터 판매된
    -- 모든 제품에 대해 일별판매량과 일별누적판매량을 나타내세요.. *** ---
    
    
    
    select jepumname
         , to_char(panmaedate, 'yyyy-mm')
         , sum(panmaesu)
         , sum(sum(panmaesu)) over(partition by jepumname
                                   order by to_char(panmaedate, 'yyyy-mm') asc ) 
                                   as 일별누적판매량
         
    from tbl_panmae
    group by jepumname, to_char(panmaedate, 'yyyy-mm')
    having (add_month(sysdate,-1))
    
    select sysdate
         , add_months(sysdate, -1)
         , to_date( to_char(add_months(sysdate,-1),'yyyy-mm-') || '01', 'yyyy-mm-dd')
         , last_day(add_months(sysdate, -2))+1
    from dual;
    
    
        select jepumname as 제품명, to_char(panmaedate, 'yyyy-mm-dd') as 판매일자 
         , sum(panmaesu) as 일별판매량
         ,  sum(sum(panmaesu)) over(partition by jepumname
                                   order by to_char(panmaedate, 'yyyy-mm-dd') asc ) 
                                   as 일별누적판매량
    from tbl_panmae
    where panmaedate >= to_date( to_char(add_months(sysdate,-1),'yyyy-mm-') || '01', 'yyyy-mm-dd')
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd'); 
    
    select sysdate
         , add_months(sysdate, -1)
         , to_date( to_char(add_months(sysdate,-1),'yyyy-mm-') || '01', 'yyyy-mm-dd')
         , last_day(add_months(sysdate, -2))+1
    from dual;
    
    
   select jepumname as 제품명, to_char(panmaedate, 'yyyy-mm-dd') as 판매일자 
         , sum(panmaesu) as 일별판매량
         ,  sum(sum(panmaesu)) over(partition by jepumname
                                   order by to_char(panmaedate, 'yyyy-mm-dd') asc ) 
                                   as 일별누적판매량
    from tbl_panmae
    where panmaedate >= last_day(add_months(sysdate, -2))+1
    group by jepumname, to_char(panmaedate, 'yyyy-mm-dd'); 
   
    --- ==== *** 아래처럼 나오도록 하세요 *** ==== ---
 /*   
    ------------------------------------------------------------
    전체사원수    10대    20대    30대    40대    50대    60대
    ------------------------------------------------------------
      107       12      9       15     20       8        5
    ------------------------------------------------------------
 */
/* 
    select trunc( extract(year from sysdate) - (태어난년도) + 1 , -1) as ageline
    from employees
    
    태어난년도 => substr(jubun, 1, 2) + 1900 or 2000
                                    + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end
*/

    select ageline
         ,(decode(ageline, 10, 1)) as "10대" 
         ,(decode(ageline, 20, 1)) as "20대"
         ,(decode(ageline, 30, 1)) as "30대"
         ,(decode(ageline, 40, 1)) as "40대"
         ,(decode(ageline, 50, 1)) as "50대"
         ,(decode(ageline, 60, 1)) as "60대"
    from  
    (
    select trunc( extract(year from sysdate) - ((substr(jubun, 1, 2))+(case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) ) + 1 , -1) as ageline 
    from employees
    ) V;

    select count(ageline) as 전체사원수
         , sum(decode(ageline, 10, 1)) as "10대"  -- 별칭에 있어서 첫글자가 숫자라면 반드시 ""로 처리해야한다.
         , sum(decode(ageline, 20, 1)) as "20대"
         , sum(decode(ageline, 30, 1)) as "30대"
         , sum(decode(ageline, 40, 1)) as "40대"
         , sum(decode(ageline, 50, 1)) as "50대"
         , sum(decode(ageline, 60, 1)) as "60대"
    from  
    (
    select trunc( extract(year from sysdate) - ((substr(jubun, 1, 2))+(case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) ) + 1 , -1) as ageline 
    from employees
    ) V;
    
    
        ---------- ===== *** [퀴즈] 아래처럼 나오도록 하세요 *** ===== ----------
       
       select employee_id, first_name, job_id
       from employees;
       
       --------------------------------------------------------------------------------------------------------------------------------------
         직종ID          남자기본급여평균    여자기본급여평균     기본급여평균    (남자기본급여평균 - 기본급여평균)       (여자기본급여평균 - 기본급여평균)
       --------------------------------------------------------------------------------------------------------------------------------------
         ........           ....              ....             ....                   ...                                 ...     
         FI_ACCOUNT         7900              7950             7920                   -20                                  30 
         IT_PROG            5700              6000             5760                   -60                                 240 
         ........           ....              ....             ....                   ...                                 ...   
       --------------------------------------------------------------------------------------------------------------------------------------
    
        -- 성별 => when (substr(jubun,1,7) in(1,3)) then '남' else '여' end
        -- 남자기본급여평균 => sum(남자월급)/남자(count)
        -- 여자기본급여평균 => sum(여자월급)/여자(count)
        -- 평균 = avg()
        
       ---------------------------------------------------------------------------------------       
       
        select job_id  
             , gender 
             , count(*) 
        from
        (
        select job_id 
             , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end as gender
        from employees
        )V
        group by job_id, gender, 
       
     -------------------------------------------------------------------------   
        
        
       
        select job_id as "직종ID"
             , trunc(avg(MAN_SALARY),0) as 남자기본급여평균 
             , trunc(avg(WOMAN_SALARY),0) as 여자기본급여평균
             , trunc(avg(salary),0) as 기본급여평균
             , trunc(avg(MAN_SALARY),0) - trunc(avg(salary),0) as "남자평균차액"
             , trunc(avg(WOMAN_SALARY),0) - trunc(avg(salary),0) as "여자평균차액"
             
        from
        (
        select job_id  
        --   , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end as gender
             , salary 
             , case when substr(jubun, 7, 1) in('1','3') then salary end as MAN_SALARY
             , case when substr(jubun, 7, 1) in('2','4') then salary end as WOMAN_SALARY
        from employees
        )V
        group by job_id
        order by 1;
        
        
      
      
      
    ----------------------------------------------------------------------------
    
    ------- ====== ***** sub Query(서브쿼리) ***** ====== ----------
    
    /*
       -- Sub Query (서브쿼리)란?
       select 문속에 또 다른 select 문이 포함되어져 있을 때 포함되어진 select 문을 Sub Query (서브쿼리)라고 부른다.
       
       
       select ...
       from .....  ==> Main Query(메인쿼리 == 외부쿼리)
       where ... in (select ... 
                     from .....) ==> Sub Query (서브쿼리 == 내부쿼리)
   */
   
    
    /*
       employees 테이블에서
       기본급여가 제일 많은 사원과 기본급여가 제일 적은 사원의 정보를
       사원번호, 사원명, 기본급여로 나타내세요...
   */
   
   
   
    from employees
    where salary = (employees 테이블에서 salary의 최대값) or 
          salary = (employees 테이블에서 salary의 최소값);
    employees 테이블에서 salary의 최대값 ==> select max(salary) from employees ==> 24000
    employees 테이블에서 salary의 최대값 ==> select min(salary) from employees ==>  2100    
    
    select employee_id as 사원번호
           first_name || ' ' || last_name as 사원명
           salary as 기본급여
    from employees
    where salary = (select max(salary) from employees) or
          salary = (select min(salary) from employees);
          
    /*
      [퀴즈]
      employees 테이블에서 부서번호가 60, 80번 부서에 근무하는 사원들중에
      월급이 50번 부서 직원들의 '평균월급' 보다 많은 사원들만 
      부서번호, 사원번호, 사원명, 월급을 나타내세요....
   */
    
     select department_id as 부서번호
           ,employee_id as 사원번호
           ,first_name || ' ' || last_name as 사원명
           ,NVL(salary+(salary*commission_pct),salary) as 월급 
     from employees
     where avg(select avg(salary) from employees where department_id = 50) <  avg(select avg(salary) from employees where department_id  in(60,80)


    from employees
    where department_id in(60,80) and
          NVL(salary+(salary*commission_pct),salary)  > 50번 부서 직원들의 월급 평균  
          
    50번 부서 직원들의 월급평균 => 
    select avg(NVL(salary+(salary*commission_pct),salary))
    from employees
    where department_id = 50;
    
    select department_id as 부서번호
           ,employee_id as 사원번호
           ,first_name || ' ' || last_name as 사원명
           ,NVL(salary+(salary*commission_pct),salary) as 월급 
    from employees
    where department_id in(60,80) and
          NVL(salary+(salary*commission_pct),salary)  >  (select avg(NVL(salary+(salary*commission_pct),salary))
                                                         from employees
                                                         where department_id = 50)
    order by 1, 4 desc;
    
    ------------------------------------------------------------------------------------------------------
    
    create table tbl_authorbook
   (bookname       varchar2(100)
   ,authorname     varchar2(20)
   ,loyalty        number(5)
   );
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('자바프로그래밍','이순신',1000);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','한석규',800);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','이순신',500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('조선왕조실록','엄정화',2500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','유관순',1200);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','이혜리',1300);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','서강준',1700);

   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('어린왕자','김유신',1800);
   
   commit;
   
   
   select * 
   from tbl_authorbook;
   
   ---  tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명이 다른 도서)로 지어진 도서정보를 나타내세요... ---
   
   /*
       ---------------------------------
         도서명         작가명    로얄티
       ---------------------------------  
         로빈슨크루소    한석규    800
         로빈슨크루소    이순신    500
         그리스로마신화  유관순   1200
         그리스로마신화  이혜리   1300
         그리스로마신화  서강준   1700
       ---------------------------------  
   */
     
  -- 내가 푼 풀이    
    select bookname
         , authorname
         , loyalty
    from tbl_authorbook     
    where  1 <(select count(*)
               from tbl_authorbook 
               group by bookname) 
    
------------------------------------   
    select bookname,count(*)
    from tbl_authorbook 
    group by bookname 
    
    select bookname
    from tbl_authorbook 
    group by bookname
    having count(*) > 1;
 -- 정답   
    select *
    from tbl_authorbook 
    where bookname in(select bookname
                      from tbl_authorbook 
                      group by bookname
                      having count(*) > 1)
                    
   
    ------- **** Sub Query (서브쿼리)에서 사용되어지는 ANY , ALL 에 대해서 알아봅니다. **** --------
   /*
       Sub Query (서브쿼리) 에서 사용되어지는 ANY 는 OR 와 흡사하고, 
       Sub Query (서브쿼리) 에서 사용되어지는 ALL 은 AND 와 흡사하다.
   */
   
   -- employees 테이블에서 salary 가 30번 부서에 근무하는 사원들의 salary 와 동일한 사원들만 추출하세요..
   -- 단, 출력시 30번 부서에 근무하는 사원은 제외합니다. 
   
   
   from employees
   where salsary = (30번 부서에 근무하는 사원들의 salary)
   
   
   select salary
   from employees
   where department_id = 30
 /*
    11000
    3100
    2900
    2800
    2600
    2500
*/
   select employee_id, first_name, salary, department_id
   from employees
   where department_id != 30 and
                             salary in(select salary
                             from employees
                             where department_id = 30)
    order by 4, 3 desc;

-- 또는 
   select employee_id, first_name, salary, department_id
   from employees
   where department_id != 30 and
         salary = any (select salary
         from employees
         where department_id = 30)
    order by 4, 3 desc;
    
    /*
        기본급여(salary)가 제일 많은 사원만 
        사원번호, 사원명, 기본급여(salary) 를 나타내세요.
    */

    select employee_id as 사원번호, first_name || ' ' || last_name as 사원명 , salary as 기본급여
    from employees
    where salary = (select max(salary) from employees);  
    
    select employee_id as 사원번호, first_name || ' ' || last_name as 사원명 , salary as 기본급여
    from employees
    where salary >= ALL(select salary from employees);  
    -- ALL 은 모든 것이 참일때만 보여진다.
    
    
     /*
        기본급여(salary)가 제일 많은 사원만 제외한 나머지 사원들만
        사원번호, 사원명, 기본급여(salary) 를 나타내세요.
    */
    
    select employee_id as 사원번호, first_name || ' ' || last_name as 사원명 , salary as 기본급여
    from employees
    where salary != (select max(salary) from employees); 
    
    select employee_id as 사원번호, first_name || ' ' || last_name as 사원명 , salary as 기본급여
    from employees
    where salary < (select max(salary) from employees); 
    
    -- or 는 참이 1개만이라도 포함되면 참이다.
    select employee_id as 사원번호, first_name || ' ' || last_name as 사원명 , salary as 기본급여
    from employees
    where salary <ANY (select salary from employees); -- 자동으로 salary 컬럼에 대해 오름차순으로 정렬되어져 나온다.
    /*
        salary < (24000
                  17000
                   9000
                   ....
                   2100
        24000만 거짓 나머지 참 
    */
 /*
        commision_pct 가 제일 많은 사원만 
        사원번호, 사원명, 기본급여(salary) 를 나타내세요.
 */

    from employees
    where commission_pct = (commission_pct가 제일 큰값);
    
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct = (select max(commission_pct) from employees);
    -- 145	John	0.4	80
   
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct >= ALL(select commission_pct from employees);
    -- 위 처럼 하면 결과물은 아무것도 안나온다.
    -- ***  SUB Query 절에서 사용하는 ALL은 사용 시 주의를 요한다. 
    --      SUB Query 절에서 select 되어지는 결과물에 Null이 존재하지 않도록 만들어야 한다. !!!
    
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct >= ALL(select commission_pct from employees
                                where commission_pct is not null );
    -- 145	John	0.4	80
    -- 위 처럼 SUB Query 절에서 select 되어지는 결과물에 Null이 존재하지 않도록 만들어야 한다. !!!
    
    
/*
        commision_pct 가 제일 많은 사원만 제외한 나머지 사원들만
        사원번호, 사원명, 기본급여(salary) 를 나타내세요.
 */

    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct != (select max(commission_pct) from employees);   
    -- 34명 출력됨.
    
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct < (select max(commission_pct) from employees);   
    -- 34명 출력됨.
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct = (select max(commission_pct) from employees);   
    -- 145	John	0.4	80
    
    select employee_id , first_name , commission_pct , department_id
    from employees
    where commission_pct <any (select commission_pct from employees); 
            -- NULL
    -- 34명 출력됨
    -- 자동으로 commission_pct 컬럼에 대해 오름차순으로 정렬되어져 나온다.
    
    select employee_id , first_name , commission_pct , department_id
    from employees
    where NVL(Commission_pct,0) != (select max(NVL(Commission_pct,0)) from employees);   
    -- 번외 106명 출력
    
    
    
    
    
    
    ------------ ====== *** Pairwise (쌍) sub Query *** ====== -------------
    
    /*
        employees 테이블에서 
        부서번호별로 salary 가 최대인 사원과
        부서번호별로 salary 가 최소인 사원의 정보를 
        부서번호, 사원번호, 사원명, 기본급여를 나타내세요.
    */
    
    
    select department_id, salary
    from employees
    order by 1, 2;
    
    /*
        원하는 값
        --------------------------------------------
        department_id          salary
        --------------------------------------------
         10	                    4400
         20	                    6000
         20	                   13000
         30                  	2500
         30	                   11000
         40	                    6500
         50                  	2100
         50                  	8200
         60                  	4200
         60                 	9000
         ..                     ....
    */
        select department_id as 부서번호
             , employee_id as 사원번호
             , first_name || ' ' || last_name as 사원명
             , salary as 기본급여
        from employees
        where (department_id, salary) in (select department_id, min(salary))
                                          from employees
                                          group by department_id)
                or 
              (department_id, salary) in (select department_id, max(salary)
                                          from employees
                                          group by department_id)
             
        order by 부서번호, 기본급여; -- null 처리 안해준 것
 
        select department_id as 부서번호
             , employee_id as 사원번호
             , first_name || ' ' || last_name as 사원명
             , salary as 기본급여
        from employees
        where (NVL(department_id, -9999), salary) in (select NVL(department_id, -9999), min(salary)
                                                      from employees
                                                      group by department_id)
                or 
              (NVL(department_id, -9999), salary) in (select NVL(department_id, -9999), max(salary)
                                                      from employees
                                                      group by department_id)
             
        order by 부서번호, 기본급여;  -- null 처리 한것   
        
       
        --------- ===== **** 상관서브쿼리(== 서브상관쿼리) ****  ===== ---------    
   /*
      상관서브쿼리 이라함은 Main Query(== 외부쿼리)에서 사용된 테이블(뷰)에 존재하는 컬럼이
      Sub Query(== 내부쿼리)의 조건절(where절, having절)에 사용되어질때를 
      상관서브쿼리(== 서브상관쿼리)라고 부른다.
   */
   
   -- employees 테이블에서 기본급여에 대해 전체등수 및 부서내 등수를 구하세요
   -- 첫번째 방법은 rank() 함수를 사용하여 구해본다.
     
     select department_id as 부서번호
           ,employee_id as 사원번호 
           ,first_name || ' ' || last_name as 사원명
           ,salary as 기본급여
           ,rank() over(order by salary desc) as 전체등수
           ,rank() over(partition by department_id
                        order by salary desc) as 부서내등수
        
     from employees
     order by 부서번호, 기본급여 desc;
   
   -- employees 테이블에서 기본급여에 대해 전체등수 및 부서내 등수를 구하세요
   -- 두번째 방법은 count(*)를 이용하여 상관서브쿼리를 사용하여 구해본다.
   
     select salary
     from employees
     order by salary desc; 
     
     -- 자신의 급여가 14000이라면 몇등일까?
     select count(*)+1 as 등수 -- salary가 14000보다 큰 갯수
     from employees
     where salary > 14000
     
     update employees set department_id = null
     where employee_id = 100;
     
      select department_id as 부서번호
           , employee_id as 사원번호 
           , first_name || ' ' || last_name as 사원명
           , salary as 기본급여
       
       ,(select count(*)+1 
         from employees
         where salary > E.salary ) as 전체등수
       ,(select count(*)+1
         from employees
         where NVL(department_id, -9999) = NVL(e.department_id, -9999) and
               salary > E.salary )as 부서내등수
        
      from employees E
      order by 부서번호, 기본급여 desc;
      
      rollback;
      
    select  employee_id as 사원번호 
          , first_name || ' ' || last_name as 사원명
           ,(select count(*)+1 
             from employees
             where salary > E.salary ) as 전체등수
           ,(select count(*)+1
             from employees
             where NVL(department_id, -9999) = NVL(e.department_id, -9999) and
                   salary > E.salary )as 부서내등수
            
      from employees E
      order by 전체등수 asc;
      
      ------- === *** Sub Query를 사용하여 테이블을 생성할 수 있습니다. *** === ---------
      
      create table tbl_employees_3060
      as
      select department_id
        , employee_id
        , first_name || ' ' || last_name AS ENAME
        , nvl(salary + (salary * commission_pct), salary) AS MONTHSAL
        , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
        , jubun
      from employees
      where department_id in (30, 60);
      --  Table TBL_EMPLOYEES_3060이(가) 생성되었습니다. 
      
      select * from tab;
      
      select *
      from tbl_employees_3060
      
    
    
      ------- === *** employees 테이블을 가지고 데이터 없이
      --              employees 테이블의 구조만 동일한 TBL_EMPLOYEES_SUB이라는
      --              테이블을 생성하겠습니다. *** === ---------
      select *
      from employees
      where 1=1;
      
      select *
      from employees
      where 1=2;

      create table TBL_EMPLOYEES_SUB
      as
      select *
      from employees
      where 1=2;
      -- Table TBL_EMPLOYEES_SUB이(가) 생성되었습니다.
      
      select * from tab;
      
      select *
      from TBL_EMPLOYEES_SUB;
      
      desc TBL_EMPLOYEES_SUB;
      
      ---- **** !!!! 필수로 꼭 알아두시길 바랍니다. !!!! **** ----
      -- === 상관서브쿼리(=서브상관쿼리)를 사용한 update 처리하기 === --
      /*
        회사에 입사하셔서 delete 또는 update를 할 때 먼저 반드시 해당 테이블을 백업해 두시고 
        그런 다음에 작업을 하시길 바랍니다. 백업본이 있으면 실수를 하더라도 복구가 가능하기 때문이다.
      */
      
      create table tbl_employees_backup_220111
      as
      select *
      from employees;
      -- Table TBL_EMPLOYEES_BACKUP_220111이(가) 생성되었습니다.
        
      select *  
      from TBL_EMPLOYEES_BACKUP_220111;
      
      update employees set first_name = '순신', last_name = '이';
      -- 107개 행 이(가) 업데이트되었습니다.
      
      commit;
      -- 커밋 완료.
      
      select *
      from employees;
              
      update employees E set first_name = (select first_name
                                         from TBL_EMPLOYEES_BACKUP_220111
                                         where employee_id = E.employee_id)
                         , last_name = (select last_name
                                        from TBL_EMPLOYEES_BACKUP_220111
                                        where employee_id = E.employee_id); \
      -- 107개 행 이(가) 업데이트되었습니다.                                 
      -- 위와 같이 올바르게 복구 되기위해서는 SUB Query 절의 where에서 사용된
      -- employee_id 컬럼은 고유한 값만 가지는 컬럼이어야 한다.
      
      
      select *
      from employees;
      
      commit;
      -- 커밋 완료.
      
 
 
 
 
 
 ------- === *** Sub Query 절을 사용하여 데이터를 입력(insert) 할 수 있다. *** === --------- 
      select *
      from tbl_employees_3060
      
      insert into tbl_employees_3060
      select department_id
        , employee_id
        , first_name || ' ' || last_name AS ENAME
        , nvl(salary + (salary * commission_pct), salary) AS MONTHSAL
        , case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end AS GENDER
        , jubun
      from employees
      where department_id in (40, 50)
      order by 1;
      -- 46개 행 이(가) 삽입되었습니다.
      
      rollback;
      -- 롤백 완료.
 
 ------- === *** Sub Query 절을 사용하여 데이터를 수정(update) 할 수 있다. *** === ---------
 
      update tbl_employees_3060 set monthsal = ( select trunc(avg(nvl(salary+(salary*commission_pct),salary)) )
                                                 from employees
                                                 where department_id = 50
                                                 )
      where department_id = 30;
      -- 6개 행 이(가) 업데이트되었습니다.
      
      commit;
      -- 커밋 완료.
      
      select *
      from tbl_employees_3060
 
 ------- === *** Sub Query 절을 사용하여 데이터를 삭제(delete) 할 수 있다. *** === ---------
 
    delete from tbl_employees_3060
    where department_id = (
                           select department_id
                           from employees
                           where employee_id = 118
                            )
    -- 6개 행 이(가) 삭제되었습니다.
    
    rollback;
    
    
    ----------------------------------------------------------------------------------
        -- !!!!!!!!!!! 중요  JOIN은 면접에 가시면 무조건 물어봅니다.  중요 !!!!!!!!!!!!
    ----------------------------------------------------------------------------------
               ------- ====== **** JOIN **** ====== --------
   /*
       JOIN(조인)은 테이블(뷰)과 테이블(뷰)을 합치는 것을 말하는데 
       행(ROW) 과 행(ROW)을 합치는 것이 아니라, 컬럼(COLUMN) 과 컬럼(COLUMN)을 합치는 것을 말한다.
       위에서 말한 행(ROW) 과 행(ROW)을 합치는 것은 UNION 연산자를 사용하는 것이다.
   
       -- 면접질문 : INNER JOIN(내부조인) 과 OUTER JOIN(외부조인)의 차이점에 대해 말해보세요.
       -- 면접질문 : JOIN 과 UNION 의 차이점에 대해서 말해보세요.
       
       
       A = {1, 2, 3}    원소가 3개
       B = {a, b}       원소가 2개
       
       A ⊙ B = { (1,a), (1,b)
                 ,(2,a), (2,b)
                 ,(3,a), (3,b) }
                 
       데카르트곱(수학)  ==> 원소의 곱 :   3 * 2 = 6개(모든 경우의 수)
       --> 수학에서 말하는 데카르트곱을 데이터베이스에서는 Catersian Product(카테시안 프로덕트) 라고 부른다.
       
       
       JOIN  =>  SQL 1992 CODE 방식  -->  테이블(뷰) 과 테이블(뷰) 사이에 콤마(,)를 찍어주는 것.  
                                         콤마(,)를 찍어주는 것을 제외한 나머지 문법은 데이터베이스 밴더(회사) 제품마다 조금씩 다르다.   
       
       JOIN  =>  SQL 1999 CODE 방식(ANSI) --> 테이블(뷰) 과 테이블(뷰) 사이에 JOIN 이라는 단어를 넣어주는 것.
                                             ANSI(표준화) SQL
   */
   
   select *
   from employees;
   
   select count(*)
   from employees;   -- 107개 행
   
   select *
   from departments;  
   
   select count(*)
   from departments;  -- 27개 행
   
   
   select *
   from employees, departments;  --> SQL 1992 CODE 방식, Catersian Product(카테시안 프로덕트)
   
   select count(*)
   from employees, departments;  -- SQL 1992 CODE 방식, 2889개 행
   
   select 107 * 27
   from dual;
   
   select *
   from employees Cross JOIN departments;  --> SQL 1999 CODE 방식, Catersian Product(카테시안 프로덕트)
   
   select count(*)
   from employees cross join departments;  -- SQL 1999 CODE 방식, 2889개 행
   
   
   /*
      1. CROSS JOIN 은 프로야구를 예로 들면 10개팀이 있는데 
         각 1팀당 경기를 몇번해야 하는지 구할때 쓰인다. 1팀당 모든 팀과 경기를 펼쳐야 한다. 
         
      2. CROSS JOIN 은 그룹함수로 나온 1개의 행을 가지고 어떤 데이터 값을 얻으려고 할때 사용된다. 
  */
  
  ---  100개행 * 1개행 = 100개행
   
   -- [ CROSS JOIN 사용 예 ]
  /*
      사원번호    사원명    부서번호    기본급여    모든사원들의기본급여평균    기본급여평균과의차액    
      이 나오도록 하세요..
  */
  
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , department_id AS 부서번호
         , salary AS 기본급여
         , AVG(salary) AS 기본급여평균
    from employees; -- 오류!! 테이블모양이 안맞음( 기본급여평균은 1개의 값)
   
   
    select employee_id AS 사원번호
         , first_name || ' ' || last_name AS 사원명
         , department_id AS 부서번호
         , salary AS 기본급여
    from employees  -- 107개행
    
    select trunc(AVG(salary)) AS 기본급여평균 -- 6461
    from employees  -- 1개행
    
    -- (사원번호    사원명    부서번호    기본급여) + (기본급여평균)
    
    select employee_id as 사원번호
         , FULLNAME as 사원명
         , department_id as 부서번호
         , salary as 기본급여
         , AVG_SALARY as 기본급여평균
         , salary - AVG_SALARY as "평균차액" 
    from    
    (select employee_id 
         , first_name || ' ' || last_name AS FULLNAME
         , department_id 
         , salary 
    from employees
    ) A
    ,
    (
    select trunc(AVG(salary)) AS AVG_SALARY 
    from employees
    ) B; -- SQL 1992 CODE 방식
    
    select employee_id as 사원번호
         , FULLNAME as 사원명
         , department_id as 부서번호
         , salary as 기본급여
         , AVG_SALARY as 기본급여평균
         , salary - AVG_SALARY as "평균차액" 
    from    
    (select employee_id 
         , first_name || ' ' || last_name AS FULLNAME
         , department_id 
         , salary 
    from employees
    ) A
    CROSS JOIN
    (
    select trunc(AVG(salary)) AS AVG_SALARY 
    from employees
    ) B; -- -- SQL 1999 CODE 방식   
    
    
    
    ---- **** EQUI JOIN (SQL 1992 CODE 방식) **** ----
    /*
        [EQUI JOIN 예]
        
        부서번호    부서명     사원번호    사원명     기본급여
        이 나오도록 하세요...
    */
    
    /*   부서번호                       부서명         사원번호    사원명     기본급여
       -----------                     ------       ------------------------------
       departments.department_id       departments             employees
       employees.department_id
    */
    
    select *
    from employees, departments  -- SQL 1992 code 방식
    where employees.department_id = departments.department_id   -- 조인조건절
    
    -- 또는
    select *
    from employees E, departments D  -- SQL 1992 code 방식
    where E.department_id = D.department_id;   -- 조인조건절
    -- E.department_id(부서번호) 값이 NULL 인 것은 출력되지 않는다.
    
    
    select *
    from employees E, departments D  -- SQL 1992 code 방식
    where E.department_id = D.department_id(+);   -- 조인조건절
    -- (+)가 없는 쪽의 테이블인 E 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉 107개 행을 모두 출력한 후 그런 다음에 조인조건절에 들어간다.   
    -- E.department_id(부서번호) 값이 NULL 인 것도 출력된다.
    
    select *
    from employees E, departments D  -- SQL 1992 code 방식
    where E.department_id(+) = D.department_id;   -- 조인조건절
    -- (+)가 없는 쪽의 테이블인 D 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉 27개 행을 모두 출력한 후 그런 다음에 조인조건절에 들어간다.   
    -- E.department_id(부서번호) 값이 NULL 인 것은 출력되지 않는다.
     
    
    select *
    from employees E, departments D  -- SQL 1992 code 방식
    where E.department_id(+) = D.department_id(+);   -- 양쪽 모두 (+)을 하면 오류이다. 
    -- 이렇게 하고자 한다라면 SQL 1999 code 인 Full outer join 을 써야한다. 
    
    
     ---- **** INNER JOIN[내부조인] (SQL 1999 CODE 방식) **** ----
     
    select *
 -- from employees E INNER JOIN departments D  -- SQL 1999 code 방식
    from employees E JOIN departments D -- INNER는 생략가능하다.
    on E.department_id = D.department_id;   -- 조인조건절
    
  
     
     
     ---- **** LEFT (OUTER) JOIN[외부조인] (SQL 1999 CODE 방식) **** ----
         
    select *
--  from employees E LEFT OUTER JOIN departments D  -- SQL 1999 code 방식
    from employees E LEFT JOIN departments D  -- outer는 생략이 가능하다.
    ON E.department_id = D.department_id;   -- 조인조건절
    -- LEFT OUTER JOIN 글자를 기준으로 왼쪽에 기술된 E 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉 107개 행을 모두 출력한 후 그런 다음에 조인조건절에 들어간다.   
    -- E.department_id(부서번호) 값이 NULL 인 것도 출력된다.
     
     ---- **** RIGHT (OUTER) JOIN[외부조인] (SQL 1999 CODE 방식) **** ---- 
    select *
--  from employees E RIGHT OUTER JOIN departments D  -- SQL 1999 code 방식
    from employees E RIGHT JOIN departments D  -- OUTER는 생략가능하다.
    on E.department_id = D.department_id;   -- 조인조건절
    -- RIGHT OUTER JOIN 글자를 기준으로 오른쪽에 기술된 D 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉 27개 행을 모두 출력한 후 그런 다음에 조인조건절에 들어간다.   
    -- E.department_id(부서번호) 값이 NULL 인 것은 출력되지 않는다.
     
    ㄴ
    
     ---- **** FULL (OUTER) JOIN[외부조인] (SQL 1999 CODE 방식) **** ---- 
    select *
--  from employees E FULL OUTER JOIN departments D  -- SQL 1999 code 방식
    from employees E FULL JOIN departments D  -- FULL은 생략가능하다.
    on E.department_id = D.department_id;   -- 조인조건절
    -- FULL OUTER JOIN 글자를 기준으로 양쪽에 기술된 E 테이블과 D 테이블의 모든 행들을 먼저 출력해준다. 
    -- 즉 27개 행을 모두 출력한 후 그런 다음에 조인조건절에 들어간다.   
    -- E.department_id(부서번호) 값이 NULL 인 것도 출력되고
    -- 페이퍼 부서인 부서번호 120번 부터 270번 부서까지도 출력된다.
    
    
    ---- ======== *** JOIN을 사용한 응용문제 *** ======== ---
    
    /*
        아래와 같이 나오도록 하세요.
        
        -----------------------------------------------------------------------
         부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액
        -----------------------------------------------------------------------
        
        
        ---------------------------       --------------------------------------------
          부서번호   부서평균기본급여          부서번호   사원번호   사원명    기본급여
        ---------------------------       --------------------------------------------
            10          3500                 10        1001     홍길동    3700
            20          4000                 10        1002     이순신    2500
            30          2800                 20        2001     엄정화    3500
            ..          ....                 20        2002     유관순    4500
            110         3200                 ..        ....     .....    .....
         --------------------------       ---------------------------------------------
    */
    
    --- *** 아래의 풀이는 부서번호가 NULL인 Kimberely Grant는 나오지 않는다. 
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    ) V2
    on V1.department_id = V2.department_id
    order by 1, 4 desc;
    
    
    --- *** 아래의 풀이는 틀린 풀이다. 
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    left join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    ) V2
    on V1.department_id = V2.department_id
    order by 1, 4 desc;
    
    --- *** 아래의 풀이는 틀린 풀이다. 
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    right join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    ) V2
    on V1.department_id = V2.department_id
    order by 1, 4 desc;
    
    
    --- *** 아래의 풀이는 틀린 풀이다. 
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    FULL join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    ) V2
    on V1.department_id = V2.department_id
    order by 1, 4 desc;
    
    
    --- *** 아래의 풀이가 올바른 풀이다. 
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    ) V2
    on NVL(V1.department_id,-9999) = NVL(V2.department_id,-9999)
    order by 1, 4 desc;
    
/*    
    [퀴즈] 아래와 같이 나오도록 하세요.
    
     --------------------------------------------------------------------------------------------------------
      부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액    부서내기본급여등수   전체기본급여등수
     --------------------------------------------------------------------------------------------------------
     
*/     

    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         , DEPT_RANK as 부서내기본급여등수
         , RANK_SAL as 전체기본급여등수
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
         , rank() over(partition by department_id
                       order by salary desc) as DEPT_RANK                        
         , rank() over( order by salary desc) as RANK_SAL
    from employees
    
    ) V2
    on NVL(V1.department_id,-9999) = NVL(V2.department_id,-9999)
    order by 1, 4 desc;
    
    -- 또는
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         , rank() over(partition by v2.department_id order by salary desc) as 부서내기본급여등수
         , rank() over(order by salary desc) as 전체기본급여등수
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
    from employees
    
    ) V2
    on NVL(V1.department_id,-9999) = NVL(V2.department_id,-9999)
    order by 1, 4 desc;
    
/*    
    [퀴즈] 부서번호가 10번 30번 50번 부서에 근무하는 사원들만 아래와 같이 나오도록 하세요.
    
     --------------------------------------------------------------------------------------------------------
      부서번호   사원번호   사원명   기본급여   부서평균기본급여    부서평균과의차액    부서내기본급여등수   전체기본급여등수
     --------------------------------------------------------------------------------------------------------
     
*/         
    
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         , DEPT_RANK as 부서내기본급여등수
         , RANK_SAL as 전체기본급여등수
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
         , rank() over(partition by department_id
                       order by salary desc) as DEPT_RANK                        
         , rank() over( order by salary desc) as RANK_SAL
    from employees
    ) V2
    on NVL(V1.department_id,-9999) = NVL(V2.department_id,-9999)
    where v2.department_id in(10, 30, 50) 
    order by 1, 4 desc;
    
    --- *** 위의 풀이과정도 맞지만 아래처럼 하기를 권장한다. !!! *** ---
    
    select v1.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         , DEPT_RANK as 부서내기본급여등수
         , RANK_SAL as 전체기본급여등수
         
    from
    (
    select department_id
         , trunc(avg(salary),0) as DEPT_AVG_SAL
    from employees
    where department_id in (10, 30, 50)
    group by department_id 
    ) V1
    join
    (
    select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
         , rank() over(partition by department_id
                       order by salary desc) as DEPT_RANK                        
         , rank() over( order by salary desc) as RANK_SAL
    from employees
    where department_id in(10, 30, 50) 
    ) V2
    on V1.department_id = V2.department_id
    order by 1, 4 desc;
    
    
    --- 또는 
    ---- ===== *** WITH 절을 사용한 inline view 를 통해 JOIN 하기 *** ====== ----
    with 
    V1 AS (
        select department_id
             , trunc(avg(salary),0) as DEPT_AVG_SAL
        from employees
        where department_id in (10, 30, 50)
        group by department_id 
    ),
    V2 AS (
        select department_id
         , employee_id
         , first_name || ' ' || last_name as FULLNAME
         , salary
         , rank() over(partition by department_id
                       order by salary desc) as DEPT_RANK                        
         , rank() over( order by salary desc) as RANK_SAL
        from employees
        where department_id in(10, 30, 50)
    )
    select v2.department_id as 부서번호   -- V1 과 V2에 양쪽에 포함되는 컬럼은 V1, V2 표시를 생략할 수 없다.
         , employee_id as 사원번호
         , FULLNAME as 사원명   
         , salary as 기본급여   
         , DEPT_AVG_SAL as 부서평균기본급여    
         , (salary - DEPT_AVG_SAL) as 부서평균과의차액
         , DEPT_RANK as 부서내기본급여등수
         , RANK_SAL as 전체기본급여등수
    from V1 JOIN V2
    ON V1.department_id = V2.department_id
    order by 1, 4;
    
    
    
    
    ---------- ======= **** NON-EQUI JOIN  **** ======= ---------- 
    /*
         조인조건절에 사용되는 컬럼의 값이 특정한 범위에 속할 때 사용하는 것이 NON-EQUI JOIN 이다.
         NON-EQUI JOIN 에서는 조인조건절에 = 을 사용하는 것이 아니라 between A and B 를 사용한다.
    */
    
    
    -- 소득세율 지표 관련 테이블을 생성한다. 
      create table tbl_taxindex
      (lowerincome   number       -- 연봉의 최저
      ,highincome    number       -- 연봉의 최대
      ,taxpercent    number(2,2)  -- 세율  -0.99 ~ 0.99 
      );
       
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(1, 99999, 0.02);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(100000, 149999, 0.05);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(150000, 199999, 0.08);
    
      insert into tbl_taxindex(lowerincome,highincome,taxpercent)
      values(200000, 10000000000000000, 0.1);
    
      commit;
      
      select * 
      from tbl_taxindex;
      
      ------------------------------------------------------
       사원번호     사원명     연봉     세율      소득세액
      ------------------------------------------------------
        1001       홍길동    50000    0.02      50000 *  0.02
        1002       엄정화   170000    0.08     170000 *  0.08
        ....       ......  ......    .....     .............
        
        
    --- SQL 1992 CODE ---
    /*
      사원번호     사원명     연봉     세율
      ---------------------------  -----
      employees 테이블             + tbl_taxindex 테이블  
    */
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명 
         , NVL(salary+(salary*commission_pct),salary)*12 as 연봉
         , taxpercent as 세율
         , (NVL(salary+(salary*commission_pct),salary)*12)*taxpercent as 소득세액
    from employees E, tbl_taxindex T -- SQL1992 CODE 
--  where nvl(E.salary+(E.salary*E.commission), E.salary)*12 between T.Lowerincome and T.highincome -- 조인조건절
    where nvl(salary+(salary*commission_pct), salary)*12 between Lowerincome and highincome; -- 조인조건절 (중복이 안됐기 때문에 생략가능)
    
    --- SQL 1999 CODE ---
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명 
         , NVL(salary+(salary*commission_pct),salary)*12 as 연봉
         , taxpercent as 세율
         , (NVL(salary+(salary*commission_pct),salary)*12)*taxpercent as 소득세액
    from employees E join tbl_taxindex T -- SQL1999 CODE 
    on nvl(salary+(salary*commission_pct), salary)*12 between Lowerincome and highincome; -- 조인조건절 (중복이 안됐기 때문에 생략가능)
    
    
    
    
    
    
    
    
    
    ------------------ ===== **** SELF JOIN(자기조인) **** ===== ------------------ 
   /*
       자기자신의 테이블(뷰)을 자기자신의 테이블(뷰)과 JOIN 시키는 것을 말한다.
       이때 반드시 테이블(뷰)에 대한 alias(별칭)를 달리 주어서 실행해야 한다.
   */
   
   --- 아래처럼 나오도록 하세요... ---
   -------------------------------------------------------------------------------------------------------
    사원번호              사원명             이메일     급여      직속상관번호             직속상관명
  employee_id   first_name || last_name    email     salary   employee_id      first_name || last_name
  -------------------------------------------------------------------------------------------------------
     100             Steven King           SKING     24000     null                 null 
     102             Lex De Haan           LDEHAAN   17000     100                  Steven King
     103             Alexander Hunold      AHUNOLD   9000      102                  Lex De Haan
     104             Bruce Ernst           BERNST    6000      103                  Alexander Hunold
     
     select *
     from employees
     order by employee_id asc;
     
     --- SQL 1992 CODE
     
     select *
     from employees E1 , employees E2
     where E1.Manager_id = E2.employee_id(+) 
     
     select E1.employee_id as 사원번호
          , E1.first_name || ' ' || E1.last_name as 사원명             
          , E1.email as 이메일
          , E1.salary as 급여
          , E2.employee_id as 직속상관번호
          , E2.first_name || ' ' || E2.last_name as 직속상관명
     from employees E1 , employees E2
     where E1.Manager_id = E2.employee_id(+) 
     order by 1;
     
     --- SQL 1999 CODE
     
     select E1.employee_id as 사원번호
          , E1.first_name || ' ' || E1.last_name as 사원명             
          , E1.email as 이메일
          , E1.salary as 급여
          , E2.employee_id as 직속상관번호
          , E2.first_name || ' ' || E2.last_name as 직속상관명
     from employees E1 left join employees E2
     on E1.Manager_id = E2.employee_id 
     order by 1;
     
   select * 
   from tbl_authorbook;
   
   ---  self join(자기조인)을 사용하여 
   ---  tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명이 다른 도서)로 지어진 도서정보를 나타내세요... ---
   
   /*
       ---------------------------------
         도서명         작가명    로얄티
       ---------------------------------  
         로빈슨크루소    한석규    800
         로빈슨크루소    이순신    500
         그리스로마신화  유관순   1200
         그리스로마신화  이혜리   1300
         그리스로마신화  서강준   1700
       ---------------------------------  
   */
   
   --- SQL 1992 CODE
   
   -- select 되어진 행의 결과물에서 중복된 행이 여러번 안나오고 1번만 나오도록 하려면 
   -- select 바로 다음에 distinct 를 사용하면 된다.
   select distinct A1.*
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname;
   
  
  
   /*   !!!! select 문에서 distinct 와 order by 절을 함께 사용할때는 조심해야 한다. !!!!
        select 문에 distict 가 있는 경우 order by 절에는 select 문에서 사용된 컬럼만 들어올 수 있다.
        또는 select 문에 distict 가 있는 경우 order by 절을 사용하지 않아야 한다.
   */
   
   select distinct A1.*
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by 1;  

   select distinct A1.*
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by 1, 3 desc ; 
   
   select A1.bookname, A1.authorname
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by A1.bookname, A1.Loyalty desc ; -- distinct 를 쓰지 않으면 order by에 셀렉트에 없는 컬럼을 적어도 잘 나온다.
   
   select distinct A1.bookname, A1.authorname
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by A1.bookname, A1.Loyalty desc ; -- distinct 를 쓰면 order by에 셀렉트에 없는 컬럼을 적으면 오류!!
   -- ORA-01791: not a SELECTed expression
   -- select 다음에 distinct 를 사용했는데 order by 절에서는 select 다음에 보여지는
   -- 컬럼이 아닌 컬럼을 사용했기에 오류가 발생한다. 
   
   select distinct A1.bookname, A1.authorname
   from tbl_authorbook A1 , tbl_authorbook A2
   where A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by A1.bookname, A1.authorname desc ; 
   
   
   --- SQL 1999 CODE
   select distinct A1.bookname as 도서명
        , A1.authorname as 작가명
        , A1.Loyalty as 로얄티
   from tbl_authorbook A1 join tbl_authorbook A2
   on  A1.bookname = A2.bookname and A1.authorname != A2.authorname
   order by 1;
   
   ----- ==== **** Multi Table JOIN(다중 테이블 조인) **** ==== -----
   
   --> 3개 이상의 테이블(뷰)을 가지고 조인 시켜주는 것이다. 
  /*
       
      -------------------------------------------------------------------------------------------------------------------------
         대륙명        국가명                       부서주소                    부서번호   부서명      사원번호  사원명       기본급여
      --------------------------------------------------------------------------------------------------------------------------   
         Americas     United States of America     Seattle 2004 Charade Rd      90      Executive   100    Steven King   24000
   
   
         대륙명   ==>  regions.region_name                                    regions.region_id 
         국가명   ==>  countries.country_name                                 countries.region_id       countries.country_id
         부서주소  ==> locations.city || ' ' || locations.street_address      locations.country_id      locations.location_id
         부서명   ==> departments.department_name                             departments.location_id   departments.department_id 
         사원명   ==> employees.first_name || ' ' || employees.last_name      employees.department_id
   */ 
   
   select * from tab;
   
   select *
   from regions;
   
   select *
   from countries;
   
   select *
   from LOCATIONS;
   
   select *
   from DEPARTMENTS;
   
   select *
   from employees;
   
    대륙명        국가명                       부서주소                    부서번호   부서명      사원번호  사원명       기본급여
    select *
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    JOIN employees E
    on D.department_id = E.department_id
    order by 1;
    
    
    
    select *
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    right JOIN employees E
    on D.department_id = E.department_id
    order by 1;
    
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    right JOIN employees E
    on D.department_id = E.department_id
    order by 1;
    
     /*
        부서번호가 30번, 90 번에 근무하는 사원들만 아래와 같이 나오도록 하세요.
      -------------------------------------------------------------------------------------------------------------------------
         대륙명        국가명                       부서주소                    부서번호   부서명      사원번호  사원명       기본급여
      --------------------------------------------------------------------------------------------------------------------------   
         Americas     United States of America     Seattle 2004 Charade Rd      90      Executive   100    Steven King   24000
    */
    
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    JOIN employees E
    on D.department_id = E.department_id
    where e.department_id in(30, 90)
    order by 1;
    
    -- 또는 
    select R.region_name AS 대륙명
         , C.country_name AS 국가명
         , L.city || ' ' || L.street_address AS 부서주소
         , E.department_id AS 부서번호
         , D.department_name AS 부서명
         , E.employee_id AS 사원번호
         , E.first_name || ' ' || E.last_name AS 사원명
         , E.salary AS 기본급여
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    JOIN ( select *
           from employees 
           where department_id in(30, 90)  
           ) E     
    on D.department_id = E.department_id
    order by 1;
    
    
   --- [대분류 검색]
   --- *** 'Americas' 대륙에 근무하는 사원들만 
   --      국가명     부서주소     부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.
    WITH
    V AS
    (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id, 
                 employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
        from regions R
        JOIN countries C
        on R.region_id = C.region_id
        JOIN LOCATIONS L
        on C.country_id = L.country_id
        JOIN DEPARTMENTS D
        on L.location_id = D.location_id
        JOIN employees E
        on D.department_id = E.department_id
    )
    select country_name AS 국가명
        , city || ' ' || street_address AS 부서주소
        , department_id AS 부서번호
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from v
    where region_name = 'Americas';
    
   --- [중분류 검색] 
   --- *** 'Seattle' 도시에 근무하는 사원들만 
   --      부서주소     부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.
   WITH
    V AS
    (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id, 
                 employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
        from regions R
        JOIN countries C
        on R.region_id = C.region_id
        JOIN LOCATIONS L
        on C.country_id = L.country_id
        JOIN DEPARTMENTS D
        on L.location_id = D.location_id
        JOIN employees E
        on D.department_id = E.department_id
    )
    select city || ' ' || street_address AS 부서주소
        , department_id AS 부서번호
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from v
    where region_name = 'Americas' 
          and city = 'Seattle';
          
   
   --- [소분류 검색]
   --- *** 'Finance' 부서명에 근무하는 사원들만 
   --      부서번호   부서명    사원번호  사원명   기본급여 를 나타내세요.           
   
   WITH
    V AS
    (
        select R.region_id, region_name,
               C.country_id, country_name,
               L.location_id, street_address, postal_code, city, state_province,
               D.department_id, department_name, D.manager_id, 
                 employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, E.manager_id AS SASUNO, jubun
        from regions R
        JOIN countries C
        on R.region_id = C.region_id
        JOIN LOCATIONS L
        on C.country_id = L.country_id
        JOIN DEPARTMENTS D
        on L.location_id = D.location_id
        JOIN employees E
        on D.department_id = E.department_id
    )
    select city || ' ' || street_address AS 부서주소
        , department_id AS 부서번호
        , department_name AS 부서명
        , employee_id AS 사원번호
        , first_name || ' ' || last_name AS 사원명
        , salary AS 기본급여
    from v
    where region_name = 'Americas' 
          and city = 'Seattle'
          and department_name = 'Finance';
          
          
          
    --- [퀴즈] 아래와 같이 나오도록 하세요..
   /*
       -------------------------------------------------------------------------------------------------
        부서번호           부서명                부서장성명                     사원번호   사원명   입사일 
       ------------------------------------------------------------------------------------------------- 
       D.department_id    D.department_name    E.first_name || E.last_name
       E.department_id 
       
                   D.manager_id                E.employee_id
                 (부서장의 사원번호)              (사원번호)
   */
   
   with
   V1 AS
   (
       select D.department_id 
            , department_name 
            , D.manager_id 
            , employee_id 
            , first_name || ' ' || last_name as manager_name
            
       from departments D JOIN employees E
       on D.manager_id = E.employee_id
    )
   ,
   V2 AS
   (
       select employee_id 
            , first_name || ' ' || last_name as ENAME
            , hire_date
            , department_id
       from employees
   )
   select v1.department_id as 부서번호
        , department_name as 부서명
        , manager_name as 부서장성명
        , v2.employee_id as 사원번호
        , ENAME as 사원명
        , to_char(hire_date, 'yyyy-mm-dd') as 입사일 
   from v1 JOIN v2
   on v1.department_id = v2.department_id
   order by 1;
   
   -- 부서번호 null도 나오게 하려면 
   with
   V1 AS
   (
       select D.department_id 
            , department_name 
            , D.manager_id 
            , employee_id 
            , first_name || ' ' || last_name as manager_name
            
       from departments D JOIN employees E
       on D.manager_id = E.employee_id
    )
   ,
   V2 AS
   (
       select employee_id 
            , first_name || ' ' || last_name as ENAME
            , hire_date
            , department_id
       from employees
   )
   select v1.department_id as 부서번호
        , department_name as 부서명
        , manager_name as 부서장성명
        , v2.employee_id as 사원번호
        , ENAME as 사원명
        , to_char(hire_date, 'yyyy-mm-dd') as 입사일 
   from v1 right JOIN v2 -- 여기를 수정 V2는 employees 테이블 이기 때문에 
   on v1.department_id = v2.department_id
   order by 1;
   
   
       select v1.department_id as 부서번호
        , department_name as 부서명
        , manager_name as 부서장성명
        , v2.employee_id as 사원번호
        , ENAME as 사원명
        , to_char(hire_date, 'yyyy-mm-dd') as 입사일 
      from 
      (
       select D.department_id 
            , department_name 
            , D.manager_id 
            , employee_id 
            , first_name || ' ' || last_name as manager_name
            
       from departments D JOIN employees E
       on D.manager_id = E.employee_id
       ) V1
       left join
       (
       select employee_id 
         , first_name || ' ' || last_name as ENAME
         , hire_date
         , department_id
       from employees      
       ) V2
       on v1.department_id = v2.department_id
   order by 1;
       
   
   
   ------ ====== **** SET Operator(SET 연산자, 집합연산자) **** ======= ------
    /*
        -- 종류 --
        1. UNION 
        2. UNION ALL
        3. INTERSECT
        4. MINUS
        
        -- 면접시 JOIN 과 UNION 의 차이점에 대해서 말해 보세요~~~ !! --
        
    ==>  UNION 은 테이블(뷰)과 테이블(뷰)을 합쳐서 보여주는 것으로써,
         이것은 행(ROW)과 행(ROW)을 합친 결과를 보여주는 것이다.

    A = { a, x, b, e, g }
          -     -
    B = { c, d, a, b, y, k, m}    
                -  -    
    A ∪ B = {a, b, c, d, e, g, k, m, x, y}  ==> UNION               
                                             {a, b, c, d, e, g, k, m, x, y} -- 중복된 것을 없애주고 오름차순으로 정렬

                                             ==> UNION ALL 
                                             {a, x, b, e, g, c, d, a, b, y, k, m} -- 

    A ∩ B = {a,b}  ==> INTERSECT
                       {a,b}

    A - B = {x,e,g} ==> MINUS 
                        {x,e,g}

    B - A = {c,d,y,k,m} ==> MINUS 
                           {c,d,y,k,m}
 */
   
   select *
   from tbl_panmae;
   
   -- tbl_panmae 테이블에서 2달 전에 해당하는 월(현재가 2022년 1월 이므로 2021년 11월)에 판매되어진 정보만 추출해서
   -- tbl_panmae_202111 이라는 테이블로 생성하세요.
   delete from tbl_panmae_202111
   drop table tbl_panmae_202111;
   
   
   create table tbl_panmae_202111
   as
   select *
   from tbl_panmae
   where to_char(panmaedate, 'yyyy-mm') = to_char(add_months(sysdate, -2),'yyyy-mm');
   -- Table TBL_PANMAE_202111이(가) 생성되었습니다.
   select *
   from tbl_panmae_202111;
   
   -- tbl_panmae 테이블에서 1달 전에 해당하는 월(현재가 2022년 1월 이므로 2021년 12월)에 판매되어진 정보만 추출해서
   -- tbl_panmae_202112 이라는 테이블로 생성하세요.
   delete from tbl_panmae_202112
   drop table tbl_panmae_202112;
   
   create table tbl_panmae_202112
   as
   select *
   from tbl_panmae
   where to_char(panmaedate, 'yyyy-mm') = to_char(add_months(sysdate, -1),'yyyy-mm');
   -- Table TBL_PANMAE_202112이(가) 생성되었습니다.
   select *
   from tbl_panmae_202112;
   
   -- tbl_panmae 테이블에서 이번달에 해당하는 월 (현재가 2022년 1월)에 판매되어진 정보만 남겨두고
   -- 나머지는 모두 삭제하세요. 
   
   delete from tbl_panmae
   where to_char(panmaedate, 'yyyy-mm') < to_char(sysdate,'yyyy-mm');
   
   commit;
   
   --- *** 최근 3개월간 판매되어진 정보를 가지고 제품별 판매량의 합계를 추출하세요 *** ---
   
   
   select *
   from tbl_panmae_202111; -- 2달전
   
   select *
   from tbl_panmae_202112; -- 1달전
   
   select *
   from tbl_panmae -- 이번달
   
   
   
   select *
   from tbl_panmae_202111 -- 2달전
   union
   select *
   from tbl_panmae_202112 -- 1달전
   union
   select *
   from tbl_panmae; -- 이번달
   
   
   select *
   from tbl_panmae -- 이번달
   union
   select *
   from tbl_panmae_202111 -- 2달전
   union
   select *
   from tbl_panmae_202112; -- 1달전
   -- union을 하면 항상 첫번째 컬럼(지금은 panmaedate)을 기준으로 오름차순 정렬되어 나온다. 
   -- 그래서 2021년 11월 데이터 부터 먼저 나온다. 
   
   
   select *
   from tbl_panmae -- 이번달
   union all
   select *
   from tbl_panmae_202111 -- 2달전
   union all
   select *
   from tbl_panmae_202112; -- 1달전
   -- union all을 하면 정렬 없이 그냥 순서대로 행을 붙여서 보여줄 뿐이다. 
   -- 그래서 맨처음이 tbl_panmae 테이블이고, 그 다음이 tbl_panmae_202111 테이블이고,
   -- 마지막이 tbl_panmae_202112 테이블이므로 순서대로 보여질 뿐이다. 
   
   
   
   select jepumname as 제품명
        , sum(panmaesu) as 판매합계
   from
   (
   select *
   from tbl_panmae_202111 -- 2달전
   union
   select *
   from tbl_panmae_202112 -- 1달전
   union
   select *
   from tbl_panmae
   ) V
   group by jepumname
   order by 2 desc;
   
   -- 또는
   with 
   V as
   (
    select *
   from tbl_panmae_202111 -- 2달전
   union
   select *
   from tbl_panmae_202112 -- 1달전
   union
   select *
   from tbl_panmae
   )
   select jepumname as 제품명
        , sum(panmaesu) as 판매합계
   from V
   group by jepumname
   order by 2 desc;
   
   
   ---- *** [퀴즈] 최근 3개월간 판매되어진 정보를 가지고 
     --             아래와 같이 제품명, 판매년월, 판매량의합계, 백분율(%) 을 추출하세요 *** ----  
     
     ------------------------------------------------
      제품명     판매년월     판매량의합계    백분율(%)
     ------------------------------------------------
      감자깡     2021-11       20            8.2
      감자깡     2021-12       15            6.2
      감자깡     2022-01       15            6.2
      감자깡                   50           20.6
      새우깡     2021-11       38           15.6
      새우깡     2021-12        8            3.3
      새우깡     2022-01       30           12.3
      새우깡                   76           31.3
      .....     .......       ...          ....
      전체                    243          100.0
     ------------------------------------------------  
     --- !!!!!!!!! 중요 조심해야 합니다. !!!!!!!!!!_----
     -- 최근 3개월간 판매되어진 판매량의 합계는 ?
     -- 틀린 것 
        
        select sum(panmaesu) -- 98 오류!
        from
       (
           select panmaesu
           from tbl_panmae_202111 -- 2달전
           union
           select panmaesu
           from tbl_panmae_202112 -- 1달전
           union
           select panmaesu
           from tbl_panmae
       ) V
        
     -- 올바른 것 
     
     select sum(panmaesu) -- 243 
        from
       (
           select panmaesu
           from tbl_panmae_202111 -- 2달전
           union all
           select panmaesu
           from tbl_panmae_202112 -- 1달전
           union all
           select panmaesu
           from tbl_panmae
       ) V
       
       
   select decode( grouping(jepumname), 0, jepumname, '전체' ) as 제품명
   -- 또는 , NVL(jepumname , '전체') as 제품명
         
          , decode(grouping (to_char(panmaedate, 'yyyy-mm')), 0, (to_char(panmaedate, 'yyyy-mm')), ' ') as 판매년월
   -- 또는 , NVL( to_char(panmaedate, 'yyyy-mm'), ' ') as 판매년월
         
          , sum(panmaesu) as 판매량의합계
          , round(sum(panmaesu)/(select sum(panmaesu) -- 243 
            from
               (
                   select panmaesu
                   from tbl_panmae_202111 -- 2달전
                   union all
                   select panmaesu
                   from tbl_panmae_202112 -- 1달전
                   union all
                   select panmaesu
                   from tbl_panmae
               ) V2
       )*100, 1) as "백분율(%)"
   from
   (
   select *
   from tbl_panmae_202111 -- 2달전
   union
   select *
   from tbl_panmae_202112 -- 1달전
   union
   select *
   from tbl_panmae
   ) V
   group by grouping sets((jepumname, to_char(panmaedate, 'yyyy-mm')), jepumname, ())
   -- 또는
   -- group by rollup((jepumname, to_char(panmaedate, 'yyyy-mm')), jepumname, ())
   
  
   
   ---- with 절
   with
   V as
   (
       select *
       from tbl_panmae_202111 -- 2달전
       union 
       select *
       from tbl_panmae_202112 -- 1달전
       union 
       select *
       from tbl_panmae
   )
   ,
   V_2 as
   (
       select panmaesu
       from tbl_panmae_202111 -- 2달전
       union all
       select panmaesu
       from tbl_panmae_202112 -- 1달전
       union all
       select panmaesu
       from tbl_panmae
   )
   select decode( grouping(jepumname), 0, jepumname, '전체' ) as 제품명
   -- 또는 , NVL(jepumname , '전체') as 제품명
          
          , decode(grouping (to_char(panmaedate, 'yyyy-mm')), 0, (to_char(panmaedate, 'yyyy-mm')), ' ') as 판매년월
   -- 또는 , NVL( to_char(panmaedate, 'yyyy-mm'), ' ') as 판매년월
        
          , sum(panmaesu) as 판매량의합계
          , round(sum(panmaesu)/(select sum(panmaesu) from V_2)*100, 1) as "백분율(%)"
   from V
   --group by grouping sets((jepumname, to_char(panmaedate, 'yyyy-mm')), jepumname, ())
   -- 또는
   group by rollup(jepumname, to_char(panmaedate, 'yyyy-mm'));
   
   
   
       -------------------------------------------------------------------
     
     
    
    ---- ======= **** INTERSECT(교집합) **** ======== -------
    
    insert into tbl_panmae_202111(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'), '쵸코파이', 10);

    insert into tbl_panmae_202111(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 10:00:00', 'yyyy-mm-dd hh24:mi:ss'), '쵸코파이', 10);
        
    insert into tbl_panmae_202112(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'), '쵸코파이', 10);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01', 'yyyy-mm-dd'), '쵸코파이', 10);
    
    -----------------------------------------------------------------------
    
    insert into tbl_panmae_202111(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 10:00:00', 'yyyy-mm-dd hh24:mi:ss'), '쵸코파이', 2);
    
    insert into tbl_panmae_202112(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 14:00:00', 'yyyy-mm-dd hh24:mi:ss'), '쵸코파이', 2);
    
    insert into tbl_panmae(panmaedate, jepumname, panmaesu)
    values( to_date('2021-09-01 16:00:00', 'yyyy-mm-dd hh24:mi:ss'), '쵸코파이', 2);
    
    commit;
    
    
       select *
       from tbl_panmae_202111 -- 2달전
       intersect
       select *
       from tbl_panmae_202112 -- 1달전
       intersect
       select *
       from tbl_panmae
       -- 21/09/01	쵸코파이	10
       
       delete from tbl_panmae_202111
       where to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu 
       in(
           select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
           from tbl_panmae_202111 -- 2달전
           intersect
           select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
           from tbl_panmae_202112 -- 1달전
           intersect
           select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
           from tbl_panmae
          );
          -- 1 행 이(가) 삭제되었습니다.
          
          
      delete from tbl_panmae_202112
       where to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu 
       in(
           select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
           from tbl_panmae_202112 -- 1달전
           intersect
           select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') || jepumname || panmaesu
           from tbl_panmae
          );    

      commit; 
      
      
      ----- ===== **** MINUS(차집합) **** ===== -----
      
      select * from tab; 
      
      select *
      from TBL_EMPLOYEES_BACKUP_220111;
  
      select *  
      from employees
      where employee_id IN(173, 185, 195);
      
      select *  
      from TBL_EMPLOYEES_BACKUP_220111
      where employee_id IN(173, 185, 195);
      
      delete from employees
      where employee_id IN(173, 185, 195);
      -- 3개 행 이(가) 삭제되었습니다.
      
      commit;
      -- 커밋 완료.
      
      -- *** 개발자가 실수로 employees 테이블에 있던 사원들을 삭제(delete)했다. 그런데 누구를 삭제했는지 모른다.!!!!
  --     백업받은 TBL_EMPLOYEES_BACKUP 테이블을 이용하여 삭제된 사원들을 다시 복구하도록 하겠다. *** ---
  
  
      select *  
      from TBL_EMPLOYEES_BACKUP_220111
      minus
      select *  
      from employees;
      
      select *  
      from employees
      where employee_id IN(173, 185, 195);
      -- 없음
      
      insert into employees
      select *  
      from TBL_EMPLOYEES_BACKUP_220111
      minus
      select *  
      from employees;
      -- 3개 행 이(가) 삽입되었습니다.
      
      commit;
      
      select *  
      from employees
      where employee_id IN(173, 185, 195);
      -- 있음. 즉, 복구완료함.
      
      
      
      
  ----------- ====== **** Pseudo(의사, 유사, 모조) Column **** ====== -----------
  ------ Pseudo(의사) Column 은 rowid 와 rownum 이 있다.
  
  /*
    1. rowid
       rowid 는 오라클이 내부적으로 사용하기 위해 만든 id 값으로써 행에 대한 id값 인데
       오라클 전체내에서 고유한 값을 가진다.
  */
     create table tbl_heowon
     (userid     varchar2(20),
      name       varchar2(20),
      address    varchar2(100)
     );
    
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
    
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
    insert into tbl_heowon(userid, name, address) values('leess','이순신','서울');
    insert into tbl_heowon(userid, name, address) values('eomjh','엄정화','인천');
    insert into tbl_heowon(userid, name, address) values('kangkc','강감찬','수원');
        
    commit;
    
    select *
    from tbl_heowon;    
      
    select userid, name, address, rowid
    from tbl_heowon; 
    
    select userid, name, address, rowid
    from tbl_heowon
    where rowid in('AAAE8jAAEAAAAG2AAA', 'AAAE8jAAEAAAAG2AAB', 'AAAE8jAAEAAAAG2AAC');
      
    delete from tbl_heowon
    where rowid  > 'AAAE8jAAEAAAAG2AAC'
    
    commit;




      
  /*
       2. rownum (!!!! 게시판 등 웹에서 아주 많이 사용됩니다. !!!!)
   */    
    
    select boardno as 글번호
         , subject as 글제목
         , userid as 글쓴이
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as 작성일자
    from tbl_board                  
    order by boardno desc;
    
    -----------------------------------------------------------------------------
    번호  글번호  글제목                               글쓴이   작성일자
    -----------------------------------------------------------------------------
    1       5	오늘도 좋은 하루되세요	                hongkd	2022-01-07 11:45:47
    2       4	기쁘고 감사함이 넘치는 좋은 하루되세요 	leess	2022-01-07 11:45:47
    3       3	건강하세요	                        youks	2022-01-07 11:45:47
    4       2	반갑습니다	                        eomjh	2022-01-07 11:45:47
    5       1	안녕하세요	                        leess	2022-01-07 11:45:47
   -------------------------------------------------------------------------------
               1  2  3  ==> 페이지바             
    
    select rownum  -- rownum(행번호) 은 기본적으로 insert 되어진 순서대로 나온다. 
         , boardno as 글번호
         , subject as 글제목
         , userid as 글쓴이
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as 작성일자
    from tbl_board ;
    
    
    select rownum
         , boardno 
         , subject 
         , userid 
         , registerday
    from 
    (
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
    from tbl_board                  
    order by boardno desc
    ) V
    
    -- 또는 
    
    with V as
    (
        select boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board                  
        order by boardno desc
    )
    select rownum
         , boardno 
         , subject 
         , userid 
         , registerday
    from V
    
    -- 또는 rownum을 사용하지 않고 row_number() 함수를 사용해서 나타낼 수 있다. 
    
        select row_number() over(order by boardno desc)                                         
             , boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board;                  
    
    
    /*
        한 페이지당 2개씩 보여주고자 한다.
        
        1 페이지 ==>  rownum : 1 ~ 2   boardno : 5 ~ 4      
        2 페이지 ==>  rownum : 3 ~ 4   boardno : 3 ~ 2     
        3 페이지 ==>  rownum : 5 ~ 6   boardno : 1          
    */
    
    -- [ 틀린 SQL 문] -- 
    --  1 페이지 ==>  rownum : 1 ~ 2  /  boardno : 5 ~ 4
    
    select rownum
         , boardno 
         , subject 
         , userid 
         , registerday
    from 
    (
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
    from tbl_board                  
    order by boardno desc
    ) V
    where rownum between 1 and 2;
    
    --  2 페이지 ==>  rownum : 3 ~ 4  /  boardno : 3 ~ 2
    
    select rownum
         , boardno 
         , subject 
         , userid 
         , registerday
    from 
    (
    select boardno 
         , subject 
         , userid 
         , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
    from tbl_board                  
    order by boardno desc
    ) V
    where rownum between 3 and 4;
    -- rownum 은 where절에 바로 쓸 수가 없다. 
    -- 그래서 rownum 을 가지는 컬럼의 별칭을 만든 후에 inline view를 사용해야만 한다. 
    
    
    
    
    
    -- [ 올바른 SQL 문] -- 
    
    --  1 페이지 ==>  rownum : 1 ~ 2  /  boardno : 5 ~ 4
            
        /*
            >>> rownum : 1~ 2를 구하는 공식 <<<
            (currentShowPageNo * sizePerPage) - (sizePerPage - 1);
                             1 * 2 - ( 2 - 1 ) ==> 1   
                sizePerPage 가 10일 서울교대 게시판
                       1 * 10 - ( 10 - 1 ) ==> 1
                    
                    
            (currentShowPageNo * sizePerPage);
                             1 * 2 ==> 2
                sizePerPage 가 10일 서울교대 게시판
                           1 * 10  ==> 10           
                                        
        */
            
            
      select boardno, subject, userid, registerday   
      from  
      (
        select rownum AS RNO, boardno, subject, userid, registerday
        from 
        (
        select boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board                  
        order by boardno desc
        ) V
     ) T
     where T.RNO between 1 and 2; -- 1페이지  
 
 
 
    --  2 페이지 ==>  rownum : 3 ~ 4  /  boardno : 3 ~ 2
   /*
            >>> rownum : 3~ 4를 구하는 공식 <<<
            (currentShowPageNo * sizePerPage) - (sizePerPage - 1);
                             2 * 2 - ( 2 - 1 ) ==> 3   
                sizePerPage 가 10일 서울교대 게시판
                       2 * 10 - ( 10 - 1 ) ==> 11 
                    
                    
            (currentShowPageNo * sizePerPage);
                             2 * 2 ==> 4
                sizePerPage 가 10일 서울교대 게시판
                           2 * 10  ==> 20           
                                        
        */ 
    select boardno, subject, userid, registerday   
      from  
      (
        select rownum AS RNO, boardno, subject, userid, registerday
        from 
        (
        select boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board                  
        order by boardno desc
        ) V
     ) T
     where T.RNO between 3 and 4; -- 2페이지
    
    
    --  3 페이지 ==>  rownum : 5 ~ 6  /  boardno : 1
    /*
            >>> rownum : 5~ 6를 구하는 공식 <<<
            (currentShowPageNo * sizePerPage) - (sizePerPage - 1);
                             3 * 2 - ( 2 - 1 ) ==> 5   
                sizePerPage 가 10일 서울교대 게시판
                       3 * 10 - ( 10 - 1 ) ==> 21 
                    
                    
            (currentShowPageNo * sizePerPage);
                             3 * 2 ==> 6
                sizePerPage 가 10일 서울교대 게시판
                           3 * 10  ==> 30           
                                        
        */ 
    select boardno, subject, userid, registerday   
      from  
      (
        select rownum AS RNO, boardno, subject, userid, registerday
        from 
        (
        select boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board                  
        order by boardno desc
        ) V
     ) T
     where T.RNO between 5 and 6; -- 3페이지
     
     
     -- 또는 
     -- rownum을 사용하지 않고 row_number() 함수를 사용하여 페이징 처리를 해봅니다.
     -- [ 틀린 SQL문] --   
        select row_number() over(order by boardno desc)                                         
             , boardno 
             , subject 
             , userid 
             , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
        from tbl_board
        where row_number() over(order by boardno desc) between 1 and 2;  
        -- 오류!!! row_number() over(order by boardno desc) 은 where 절에 바로 쓸 수가 없다.!!!!
        -- 그러므로 이것 또한 inline view 를 사용해야 한다.
      select *
      from tbl_board
      -- [올바른 SQL문] --
      --  1 페이지 ==>  row_number() : 1 ~ 2  /  boardno : 5 ~ 4
        
        select boardno, subject, userid, registerday 
        from
        (
            select row_number() over(order by boardno desc) as RNO                                        
                 , boardno 
                 , subject 
                 , userid 
                 , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
            from tbl_board
        ) V
        where RNO between 1 and 2 -- 1페이지
        
        
        
      --  2 페이지 ==>  row_number() : 3 ~ 4  /  boardno : 3 ~ 2
        select boardno, subject, userid, registerday 
        from
        (
            select row_number() over(order by boardno desc) as RNO                                        
                 , boardno 
                 , subject 
                 , userid 
                 , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
            from tbl_board
        ) V
        where RNO between 3 and 4 -- 2페이지


      --  3 페이지 ==>  row_number() : 5 ~ 6  /  boardno : 1
              select boardno, subject, userid, registerday 
        from
        (
            select row_number() over(order by boardno desc) as RNO                                        
                 , boardno 
                 , subject 
                 , userid 
                 , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as registerday
            from tbl_board
        ) V
        where RNO between 5 and 6 -- 3페이지
        
        
   -------- **** 데이터 조작어(DML == Data Manuplation Language) **** ---------
   --- DML 문은 기본적으로 수동 commit 이다.
   --- 즉, DML 문을 수행한 다음에는 바로 디스크(파일)에 적용되지 않고 commit 해야만 적용된다.
   --- 그래서 DML 문을 수행한 다음에 디스크(파일)에 적용치 않고자 한다라면 rollback 하면 된다.
   
   1. insert  --> 데이터 입력
   2. update  --> 데이터 수정
   3. delete  --> 데이터 삭제
   4. merge   --> 데이터 병합 
    
   insert 는 문법이
   insert into 테이블명(컬럼명1,컬럼명2,...) values(값1,값2,...); 
   이다.
   
   ※ Unconditional insert all  -- ==> 조건이 없는 insert 
    [문법] insert all 
           into 테이블명1(컬럼명1, 컬럼명2, ....)
           values(값1, 값2, .....)
           into 테이블명2(컬럼명3, 컬럼명4, ....)
           values(값3, 값4, .....)
           SUB Query문;
    
    create table tbl_emp1
       (empno            number(6)
       ,ename            varchar2(50)
       ,monthsal         number(7)
       ,gender           varchar2(6)
       ,manager_id       number(6)
       ,department_id    number(4)
       ,department_name  varchar2(30)
       );       
   -- Table TBL_EMP1이(가) 생성되었습니다.
   
   
   create table tbl_emp1_backup
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(6)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );  
   -- Table TBL_EMP1_BACKUP이(가) 생성되었습니다.  
   
   select *
   from tbl_emp1;
   
   select *
   from tbl_emp1_backup;
   
   
   insert all 
   into tbl_emp1(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender||'자', manager_id, department_id, department_name)
   into tbl_emp1_backup(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender||'자', manager_id, department_id, department_name)
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   order by E.department_id asc, employee_id asc;
   
   -- 214개 행 이(가) 삽입되었습니다.

   
   
   
   
   
   
   ※ Conditional insert all -- ==> 조건이 있는 insert 
   조건(where절)에 일치하는 행들만 특정 테이블로 찾아가서 insert 하도록 하는 것이다.
      
   create table tbl_emp_dept30
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );

   create table tbl_emp_dept50
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   );

   create table tbl_emp_dept80
   (empno            number(6)
   ,ename            varchar2(50)
   ,monthsal         number(7)
   ,gender           varchar2(4)
   ,manager_id       number(6)
   ,department_id    number(4)
   ,department_name  varchar2(30)
   ); 
   
   insert all 
   when department_id = 30 then 
   into tbl_emp_dept30(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender, manager_id, department_id, department_name)
   when department_id = 50 then 
   into tbl_emp_dept50(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender, manager_id, department_id, department_name)
   when department_id = 80 then 
   into tbl_emp_dept80(empno, ename, monthsal, gender, manager_id, department_id, department_name)
   values(employee_id, ename, month_sal, gender, manager_id, department_id, department_name)
   
   select employee_id
        , first_name || ' ' || last_name AS ename 
        , nvl(salary + (salary * commission_pct), salary) AS month_sal
        , case when substr(jubun,7,1) in('1','3') then '남' else '여' end AS gender
        , E.manager_id
        , E.department_id
        , department_name
   from employees E LEFT JOIN departments D 
   on E.department_id = D.department_id
   where E.department_id in(30, 50, 80)
   order by E.department_id asc, employee_id asc;
   -- 85개 행 이(가) 삽입되었습니다.\
   
   commit;
   
   select *
   from tbl_emp_dept30;
   
   select *
   from tbl_emp_dept50;
   
   select *
   from tbl_emp_dept80;
   
   
   -------- ====== ****   merge(병합)   **** ====== --------
   -- 어떤 2개 이상의 테이블에 존재하는 데이터를 다른 테이블 한곳으로 모으는것(병합)이다.
   
   1. 탐색기에서 C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN 에 간다.
   
   2. tnsnames.ora 파일을 메모장으로 연다.
   
   3. TEACHER =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = XE)
        )
      )
     을 추가한다.
     HOST = 211.238.142.72 이 연결하고자 하는 원격지 오라클서버의 IP 주소이다.
     그런데 전제조건은 원격지 오라클서버(211.238.142.72)의 방화벽에서 포트번호 1521 을 허용으로 만들어주어야 한다.
     
     그리고 TEACHER 를 'Net Service Name 네트서비스네임(넷서비스명)' 이라고 부른다.
     
     
   4. 명령프롬프트를 열어서 원격지 오라클서버(211.238.142.72)에 연결이 가능한지 테스트를 한다. 
      C:\Users\sist>tnsping TEACHER 5

        Used TNSNAMES adapter to resolve the alias
        Attempting to contact (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = 211.238.142.72)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = XE)))
        OK (0 msec)
        OK (40 msec)
        OK (10 msec)
        OK (30 msec)
        OK (20 msec)
   
   
   5.  데이터베이스 링크(database link) 만들기
    
    create database link teacherServer -- 연결 이름
    connect to hr identified by cclass   -- 이때 hr 과 암호 cclass 는 연결하고자 하는 원격지 오라클서버(211.238.142.72)의 계정명과 암호 이다. 
    using 'TEACHER';  -- TEACHER 는 Net Service Name 네트서비스네임(넷서비스명) 이다.
    -- Database link TEACHERSERVER이(가) 생성되었습니다.
    
    update employees set first_name = '덕노', last_name = '조'
    where employee_id = 100; --- steven king
    --1 행 이(가) 업데이트되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select *
    from employees  -- 로컬서버
    order by employee_id;
    
    select *
    from employees@XE  -- 로컬서버
    order by employee_id;
   
   
   
    select *
    from employees@teacherServer  -- 원격지 오라클서버( 211.238.142.72)
    order by employee_id;
    
    ---  **** 생성되어진 데이터베이스 링크를 조회해 봅니다. **** ----
   
    select *
    from user_db_links;
   
    /*
    ---------------------------------------------------------
    DB_LINK        USERNAME  PASSWORD   HOST       CREATED
    ---------------------------------------------------------
    TEACHERSERVER	 HR		   null     TEACHER	  22/01/14
                                      -- TEACHER는 net service name (넷서비스명) 이다.                              
   */
    
    ---  **** 생성되어진 데이터베이스 링크를 삭제 해봅니다. **** ----   
   
   drop database link TEACHERSERVER;
   -- Database link TEACHERSERVER이(가) 삭제되었습니다.
   
   
   
    create database link bonjumlink 
    connect to hr identified by cclass   
    using 'TEACHER';  
    -- Database link BONJUMLINK이(가) 생성되었습니다.
    
    
    -- 각 지점은 tbl_reservation_jodeokno 이라는 테이블을 생성한다.
    
    drop table tbl_reservation_jodeokno purge;
    
    create table tbl_reservation_jodeokno
    (rsvno       varchar2(20)    -- 예약고유번호
    ,memberid    varchar2(20)    -- 회원ID
    ,ticketcnt   number          -- 티켓개수
    ,constraint PK_tbl_reservation_jodeokno primary key(rsvno)
    );
    -- Table TBL_RESERVATION_jodeokno이(가) 생성되었습니다.
    
    insert into tbl_reservation_jodeokno(rsvno, memberid, ticketcnt)
    values('jodeokno001', '조덕노', 2);
    
    commit;

   
   -------------------원격지에서 해야하는 것--------------------------
   -- 아래는 본점DB서버(샘PC)에서만 하는 것이다.
    create table tbl_reservation_merge
    (rsvno       varchar2(20)    -- 예약고유번호
    ,memberid    varchar2(20)    -- 회원ID
    ,ticketcnt   number          -- 티켓개수
    ,constraint PK_tbl_reservation_merge primary key(rsvno)
    );
    -- Table TBL_RESERVATION_MERGE이(가) 생성되었습니다.
    
    select *
    from tbl_reservation_merge; -- 샘이 하는것
    
    select *
    from tbl_reservation_merge@bonjumlink; -- 여러분들이 하는 것
    
    select * 
    from tbl_reservation_jodeokno;
    
    -- 아래는 여러분들(지사)이 하는 것
   merge into tbl_reservation_merge@bonjumlink R
   using tbl_reservation_jodeokno L
   on (L.rsvno = R.rsvno)
   when matched then 
        update set R.memberid = L.memberid
                 , R.ticketcnt = L.ticketcnt 
   when not matched then 
        insert(rsvno, memberid, ticketcnt) values(L.rsvno,L.memberid,L.ticketcnt);
   -- 1 행 이(가) 병합되었습니다.
   
   commit;
       
   -- rollback;
   
    select *
    from tbl_reservation_merge@bonjumlink;
    
    select * 
    from tbl_reservation_jodeokno;
   
    update tbl_reservation_jodeokno set memberid = 'JO D.N' , ticketcnt = 1
    where rsvno = 'jodeokno001';
    --1 행 이(가) 업데이트되었습니다.
    commit;
    -- 커밋 완료.
   
       -- 아래는 여러분들(지사)이 하는 것
       merge into tbl_reservation_merge@bonjumlink R
       using tbl_reservation_jodeokno L
       on (L.rsvno = R.rsvno)
       when matched then 
            update set R.memberid = L.memberid
                     , R.ticketcnt = L.ticketcnt 
       when not matched then 
            insert(rsvno, memberid, ticketcnt) values(L.rsvno,L.memberid,L.ticketcnt);
       -- 1 행 이(가) 병합되었습니다.
       
       commit;
       
       insert into tbl_reservation_jodeokno(rsvno, memberid, ticketcnt)
       values('jodeokno002', '조덕노2', 9);
    
       commit;
       
       select *
       from tbl_reservation_merge@bonjumlink; -- 여러분들이 하는 것
       
       
       
       
       
       
       ----- **** 데이터 질의어(DQL == Data Query Languege) **** -------
    -->  DQL 은 select 를 말한다. 
    
       ----- **** 트랜잭션 제어어(TCL == Transaction Control Languege) **** ------- 
    -->  TCL 은 commit, rollback 을 말한다.
    
    -- *** Transaction(트랜잭션) 처리 *** --
   --> Transaction(트랜잭션)이라 함은 관련된 일련의 DML로 이루어진 한꾸러미(한세트)를 말한다.
   --> Transaction(트랜잭션)이라 함은 데이터베이스의 상태를 변환시키기 위하여 논리적 기능을 수행하는 하나의 작업단위를 말한다. 
   /*
      예>   네이버카페(다음카페)에서 활동
            글쓰기(insert)를 1번하면 내포인트 점수가 10점이 올라가고(update),
            댓글쓰기(insert)를 1번하면 내포인트 점수가 5점이 올라가도록 한다(update)
           
           위와같이 정의된 네이버카페(다음카페)에서 활동은 insert 와 update 가 한꾸러미(한세트)로 이루어져 있는 것이다.
           이와 같이 서로 다른 DML문이 1개의 작업을 이룰때 Transaction(트랜잭션) 처리라고 부른다.
           
           Transaction(트랜잭션) 처리에서 가장 중요한 것은 
           모든 DML문이 성공해야만 최종적으로 모두 commit 을 해주고,
           DML문중에 1개라도 실패하면 모두 rollback 을 해주어야 한다는 것이다. 
           
           예를 들면 네이버카페(다음카페)에서 글쓰기(insert)가 성공 했다라면
           그 이후에 내포인트 점수가 10점이 올라가는(update) 작업을 해주고, update 작업이 성공했다라면
           commit 을 해준다. 
           만약에 글쓰기(insert) 또는 10점이 올라가는(update) 작업이 실패했다라면
           rolllback 을 해준다.
           이러한 실습은 자바에서 하겠습니다.
   */
   
   
   insert --> 글쓰기
   -- commit; -- 보류
   update -->  포인트증가
   -- 모두 성공해야만 commit이 가능하고 둘중 한개라도 실패를 한다면 rollback을 해야한다. 이 두개의 상관관계가 묶여있는 것이 Transaction(트랜잭션)이다.
   
   
   ---- **** ==== ROLLBACK TO SAVEPOINT ==== **** ----
        --> 특정 시점까지 rollback 을 할 수 있습니다.
       
    select *   
    from employees
    where department_id = 50;
       
    update employees set first_name = '몰라'
    where department_id = 50; 
       
    savepoint point_1;  
    -- Savepoint이(가) 생성되었습니다.  
    
    delete from employees
    where department_id is null;
    -- 1 행 이(가) 삭제되었습니다.
    
    select first_name    
    from employees
    where department_id = 50;
    -- 전부 다 '몰라'로 나온다.
    
    select *
    from employees
    where department_id is null
    -- 행이 없다.
    
    rollback to savepoint point_1;
    -- 롤백 완료.
    -- savepoint point_1; 이 선언되어진 이후로 실행된 DML문을 rollback 시킨다.
    /*
       그러므로
       delete from employees
       where department_id is null; 만 롤백시킨다.
    */
    select *
    from employees
    where department_id is null
    -- 행이 나온다. 
    
    select first_name    
    from employees
    where department_id = 50;
    -- 전부 다 '몰라'로 나온다.
   
    rollback;  --> commit; 한 이후로 수행되어진 모든 DML문을 롤백시킨다.
    -- 롤백 완료.
 
    select first_name    
    from employees
    where department_id = 50;
    -- first_name 컬럼의 값이 원상 복구되었다. 
    
    
    
    
    
    
    
    -------- **** 데이터 정의어(DDL == Data Defination Language) **** ---------
    ==> DDL : create, drop, alter, truncate 
    --> 여기서 중요한 것은 DDL 문을 실행을 하면 자동적으로 commit; 이 되어진다.**
    --  즉, auto commit 되어진다.
    
    
   
   
   
    select *
    from employees
    where employee_id = 100
    -- salary ==> 24000
    -- email ==> SKING
    
    update employees set salary = 43245, email = 'asdasds'
    where employee_id = 100
 
    create table tbl_imsi
    (no number
    ,name varchar2(20)
    );
 -- Table TBL_IMSI이(가) 생성되었습니다.
    
    -- DDL 문을 사용했으므로 자동적으로 commit; 이 되어진다.
    
    select *
    from employees
    where employee_id = 100
 
    rollback;
    -- 롤백 완료.
    select *
    from employees
    where employee_id = 100
    -- 위에서 DDL문(create)을 실행했으므로 자동적으로 commit;이 되었기 때문에
    -- rollback 안 됨.
    
    update employees set salary = 24000, email = 'SKING'
         , first_name = 'Steven'
         , last_name = 'KING'
    where employee_id = 100
    
    commit;
    
    select *
    from employees
    where employee_id = 100;
    
    
    ------ ====== **** TRUNCATE table 테이블명; **** ====== ------  
    --> TRUNCATE table 테이블명; 을 실행하면 테이블명 에 존재하던 모든 행(row)들을 삭제해주고,
    --  테이블명에 해당하는 테이블은 완전초기화 가 되어진다.
    --  중요한 사실은 TRUNCATE table 테이블명; 은 DDL 문이기에 auto commit; 되어지므로 rollback 이 불가하다.
   
    --  delete from 테이블명; 을 실행하면 이것도 테이블명 에 존재하던 모든 행(row)들을 삭제해준다.
    --  이것은 DML문 이므로 rollback 이 가능하다.
    
    create table tbl_emp_copy_1
    as
    select * from employees;
    -- Table TBL_EMP_COPY_1이(가) 생성되었습니다.
    
    select *
    from tbl_emp_copy_1
    
    delete from tbl_emp_copy_1
    
    select count(*)
    from tbl_emp_copy_1
    -- 0
    rollback;
    -- commit;을 안해서 롤백이 가능하다. 
    select count(*)
    from tbl_emp_copy_1
    -- 107
    
    truncate table tbl_emp_copy_1;
    -- Table TBL_EMP_COPY_1이(가) 잘렸습니다.
    select count(*)
    from tbl_emp_copy_1
    
    rollback;
    -- DDL문인 truncate 문을 사용하였기 때문에 자동으로 commit;이 되어 졌으므로
    -- 롤백을 해도 아무 소용이없다. 
 
 
   -------- **** 데이터 제어어(DCL == Data Control Language) **** ---------
    ==> DCL : grant(권한 부여하기) , revoke(권한 회수하기)
    --> 여기서 중요한 것은 DCL문을 실행하면 자동적으로 commit;이 되어진다. 
    -- 즉, auto commit 되어진다. 
    
    
    
    ----- *** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 *** -----
    show user;
    -- USER이(가) "SYS"입니다.
    
    -- orauser1 이라는 오라클 일반사용자 계정을 생성합니다. 암호는 cclass 라고 하겠습니다.
    create user orauser1 identified by cclass default tablespace users;
    -- User ORAUSER1이(가) 생성되었습니다.
    
    -- 생성되어진 오라클 일반사용자 계정인 orauser1에게 오라클서버에 접속이 되어지고,
    -- 접속이 되어진 후 테이블 등을 생성할 수 있는 권한을 부여해주겠다. 
    grant connect, resource, unlimited tablespace to orauser1;
    -- Grant을(를) 성공했습니다.
    
    ----- *** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 종료 *** -----
    
    
    ----- *** HR 에서 아래와 같은 작업을 한다. *** ------
    show user;
    -- SER이(가) "HR"입니다.
    
    select *
    from HR.employees; --HR스키마
    
    -- 현재 오라클 서버에 접속된 사용자가 HR이므로 HR.employees 대신에 employees을 쓰면 HR.employees로 인식해준다.
    select *
    from employees;
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select 할 수 있도록 권한을 부여하겠습니다. 
    grant select on employees to orauser1;
    -- Grant을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 update 할 수 있도록 권한을 부여하겠습니다. 
    grant update on employees to orauser1;
    -- Grant을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 delete 할 수 있도록 권한을 부여하겠습니다. 
    grant delete on employees to orauser1;
    -- Grant을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 delete 할 수 있도록 부여한 권한을 회수하겠습니다. 
    revoke delete on employees from orauser1;
    -- Revoke을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 update 할 수 있도록 부여한 권한을 회수하겠습니다. 
    revoke update on employees from orauser1;  
    -- Revoke을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select 할 수 있도록 부여한 권한을 회수하겠습니다. 
    revoke select on employees from orauser1;
    -- Revoke을(를) 성공했습니다.
    
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 있도록 권한을 부여하겠습니다. 
    -- 한번에 부여하기
    grant select, update, delete on employees to orauser1;
    -- Grant을(를) 성공했습니다.
    
    -- orauser1 에게 HR이 자신의 소유인 employees 테이블에 대해 select, update, delete 할 수 있도록 부여한 권한을 회수하겠습니다. 
    -- 한번에 회수하기
    revoke select, update, delete on employees from orauser1;
    -- Revoke을(를) 성공했습니다.
    
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from employees;
    /*
        = stored view 를 생성하는 이유 2가지 ==
        첫번째, 복잡한 SQL문을 간단히 만들어서 나중에 또 쓸려고,
        두번째, 민감한 정보가 들어있는 테이블에 있어서 공개할 행과 공개할 컬럼만 따로 
               만들어서 오라클사용자에게 부여하고자 할 때, stored view를 생성한다.  
    */
    
    
    create or replace view view_emp_3080
    as
    select employee_id, first_name, last_name, hire_date, salary, commission_pct, department_id, substr(jubun,1,6) as birthday
    from employees
    where department_id in (30, 50, 80);
    -- View VIEW_EMP_3080이(가) 생성되었습니다.
    grant select, update, delete on view_emp_3080 to orauser1;
    -- Grant을(를) 성공했습니다.
    
 ----- *** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 시작 *** -----
         show user;
         -- USER이(가) "SYS"입니다.
         grant create synonym to orauser1;
         -- Grant을(를) 성공했습니다.
 ----- *** SYS 또는 SYSTEM 에서 아래와 같은 작업을 한다. 종료 *** -----


  ----- *** orauser1 에서 아래와 같은 작업을 한다. 시작 *** -----

    select *
    from HR.view_emp_3080;
    
    --- === *** 시노님(synonym, 동의어) *** === ---
        create or replace synonym emp for HR.view_emp_3080;
    /*
        오류 보고 -
        ORA-01031: insufficient privileges -- 시노님을 할 권한이 없다.
    */
        
        create or replace synonym emp for HR.view_emp_3080;
        -- Synonym EMP이(가) 생성되었습니다.
        
    select *
    from HR.view_emp_3080;
    
    select *
    from emp;
    
    
    --- *** 생성되어진 시노님(synonym, 동의어)을 조회해 본다. *** ----
    
    select *
    from user_synonyms;
    /*
    -----------------------------------------------------
    synonym_name   Table_owner  tabla_name      db_link
      EMP	       HR	        VIEW_EMP_3080	null
    -----------------------------------------------------
    */
 
  ----- *** orauser1 에서 아래와 같은 작업을 한다. 종료 *** -----
 
   ----- *** HR 에서 아래와 같은 작업을 한다. 시작 *** -----
         show user;
         -- USER이(가) "HR"입니다.
         
   ---- **** ==== 시퀀스(sequence) ==== **** ----
         
   -- 시퀀스(sequence)란? 쉽게 생각하면 은행에서 발급해주는 대기번호표 와 비슷한 것이다.
   -- 시퀀스(sequence)는 숫자로 이루어져 있으며 매번 정해진 증가치 만큼 숫자가 증가되어지는 것이다.    
   
   /*
     create sequence seq_yeyakno   -- seq_yeyakno 은 시퀀스(sequence) 이름이다.
     start with 1    -- 첫번째 출발은 1 부터 한다.
     increment by 1  -- 증가치 값    2 3 4 5 ......
     maxvalue 5      -- 최대값이 5 이다.
  -- nomaxvalue      -- 최대값이 없는 무제한. 계속 증가시키겠다는 말이다.
     minvalue 2      -- 최소값이 2 이다. cycle 이 있을때만 minvalue 에 주어진 값이 사용된다. 
                     --                nocycle 일 경우에는 minvalue 에 주어진 값이 사용되지 않는다.
                     -- minvalue 숫자 에 해당하는 숫자 값은 start with 숫자 에 해당하는 숫자 값과 같든지 
                     -- 아니면 start with 숫자 에 해당하는 숫자보다 작아야 한다.
                     
  -- nominvalue      -- 최소값이 없다.   
     cycle           -- 반복을 한다.
  -- nocycle         -- 반복이 없는 직진.
     nocache;
  */      
         
         
    create sequence seq_yeyakno_1
    start with 1   -- 첫번째 출발은 1부터 한다. 
    increment by 1   -- 층가치는 1이다. 즉 1씩 증가한다.
    maxvalue 5      -- 최대값이 5이다.
    minvalue 2     -- 최소값이 2이다.
    cycle -- 반복을 한다.
    nocache; -- 메모리에 저장을 안한다.
    /*
        ORA-04006: START WITH cannot be less than MINVALUE
        MINVALUE 숫자에 해당하는 숫자값은 START WITH 숫자에 해당하는 숫자값과 같든지
        또는 START WITH 숫자에 해당하는 숫자보다 작아야 한다.
    */
    
    drop sequence seq_yeyakno_2;
    -- Sequence SEQ_YEYAKNO_1이(가) 삭제되었습니다.
    
    create sequence seq_yeyakno_1
    start with 2   -- 첫번째 출발은 2부터 한다. 
    increment by 1   -- 층가치는 1이다. 즉 1씩 증가한다.
    maxvalue 5      -- 최대값이 5이다.
    minvalue 1     -- 최소값이 1이다.
    cycle -- 반복을 한다.
    nocache; -- 메모리에 저장을 안한다.   
    -- 2 3 4 5 1 2 3 4 5
    -- 최소값이 0이라면 => 1 2 3 4 5 0 1 2 3 4 5 0 1 ...
    -- Sequence SEQ_YEYAKNO_1이(가) 생성되었습니다.
    
    
    ---- *** 생성되어진 시퀀스(sequence)를 조회해 봅니다. *** ----
    
    select *
    from user_sequences;
    
    
    select last_number   -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 
    from user_sequences     
    where sequence_name = 'seq_yeyakno_1';
         
    create table tbl_board_test_1
     (boardno         number
     ,subject         varchar2(100)
     ,registerdate    date default sysdate
     );     
     -- Table TBL_BOARD_TEST_1이(가) 생성되었습니다.    
    
    delete from  tbl_board_test_1;
    commit;
    
    
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '첫번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 start 값이 2 이었다. 
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '두번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다.
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '세번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다.

    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '네번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다.   
     -- seq_yeyakno_1 시퀀스의 maxvalue 값이 5 였고, cycle 이었다. 즉, 반복을 한다. 
     
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '다섯번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 minvalue 값이 1 이었고, cycle 이었으므로
    -- maxvalue 값이 사용되어진 다음에 들어오는 시퀀스 값은 minvalue 값인 1이 들어온다.     
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '여섯번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
    
    insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '일곱번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
        
     select *
     from tbl_board_test_1;   
     
     rollback;
     
     insert into tbl_board_test_1(boardno, subject) values(seq_yeyakno_1.nextval, '여덟번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_1 시퀀스의 increment 값이 1 이었다. 
    
     select *
     from tbl_board_test_1; 
     
    /*
         seq_yeyakno_1 시퀀스값의 사용은 
         2(start)  3  4  5(maxvalue) 1(minvalue) 2 3 4 5(maxvalue) 1(minvalue) 2 3 4 5 1 2 3 ...... 
         와 같이 사용된다.
     */     
         
     commit;   
     
     delete from tbl_board_test_2;
     
    create sequence seq_yeyakno_2
    start with 1   -- 첫번째 출발은 2부터 한다. 
    increment by 1   -- 층가치는 1이다. 즉 1씩 증가한다.
    nomaxvalue       -- 최대값이 무한. 계속 증가시키겠다는 말이다.
    nominvalue      -- 최소값이 없다.
    nocycle -- 반복을 안한다.
    nocache; -- 메모리에 저장을 안한다. 
    -- Sequence SEQ_YEYAKNO_2이(가) 생성되었습니다.     
    
    select *
    from user_sequences;     
    
    select *
    from tbl_board_test_2;     
         
    create table tbl_board_test_2
     (boardno         number
     ,subject         varchar2(100)
     ,registerdate    date default sysdate
     );     
     -- Table TBL_BOARD_TEST_2이(가) 생성되었습니다.    
    
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '첫번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '두번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '세번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '네번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '다섯번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '여섯번째 글입니다.');  
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '일곱번째 글입니다.');  

     select *
     from tbl_board_test_2;   
     
     rollback;
     
     -- *** 다음번에 들어올 seq_yeyakno_2 시퀀스의 값이 얼마가 들어오는지 알고 싶다. ***
     
    select last_number   -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 
    from user_sequences     
    where sequence_name = 'SEQ_yeyakno_2';
     
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '여덟번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_2 시퀀스의 increment 값이 1 이었다. 
    
    select *
    from tbl_board_test_2;
         
    insert into tbl_board_test_2(boardno, subject) values(seq_yeyakno_2.nextval, '아홉번째 글입니다.');  
    -- 1 행 이(가) 삽입되었습니다.
    -- seq_yeyakno_2 시퀀스의 increment 값이 1 이었다.      
    
    
    -- *** 시퀀스 SEQ_YEYAKNO_2 이 마지막으로 사용되어진 값을 알아보려고 한다. *** ---
    
    select SEQ_YEYAKNO_2.currval
    from dual; -- 9
         
     -- *** 다음번에 들어올 seq_yeyakno_2 시퀀스의 값이 얼마가 들어오는지 알고 싶다. ***
     
    select last_number   -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 
    from user_sequences     
    where sequence_name = 'SEQ_YEYAKNO_2'; -- 10    
    
    select last_number   -- 다음번에 들어올 시퀀스 값을 미리 알려주는 것이다. 
    from user_sequences
    where sequence_name = 'SEQ_YEYAKNO_1';
    
    --- *** 시퀀스(sequence) 삭제하기 *** ---
    drop sequence SEQ_yeyakno_2
    -- Sequence SEQ_YEYAKNO_2이(가) 삭제되었습니다.
    
    --- *** 생성되어진 시퀀스(sequence)를 조회해 봅니다. *** ---
    select *
    from user_sequences;
    
    
    --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
    --------------------------------------------------------------------------------
    -- **** == Constraint(제약조건)을 사용하여 테이블을 생성해보겠습니다. == **** -- 
    
      /*
     >>>> 제약조건(Constraint)의 종류 <<<<
     
     --   제약조건의 이름은 오라클 전체에서 고유해야 한다.
     --   제약조건의 이름은 30 Byte 이내 이어야 한다.
     
     1. Primary Key(기본키, 대표식별자) 제약 [P]  -- 하나의 테이블당 오로지 1개만 생성할 수 있다.
                                               -- 어떤 컬럼에 Primary Key(기본키) 제약을 주면 그 컬럼에는 자동적으로 NOT NULL 이 주어지면서 동시에 그 컬럼에는 중복된 값은 들어올 수 없고 오로지 고유한 값만 들어오게 되어진다.
                                               -- 컬럼 1개를 가지고 생성된 Primary Key 를 Single Primary Key 라고 부르고,
                                               -- 컬럼 2개 이상을 가지고 생성된 Primary Key 를 Composite(복합) Primary Key 라고 부른다.
     
     2. Unique 제약 [U]              -- 하나의 테이블당 여러개를 생성할 수 있다.                                 
                                    -- 어떤 컬럼에 Unique 제약을 주면 그 컬럼에는 NULL 을 허용할 수 있으며, 그 컬럼에는 중복된 값은 들어올 수 없고 오로지 고유한 값만 들어오게 되어진다.             
                                    -- Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다. 
  
     3. Foreign Key(외래키) 제약 [R]  -- 하나의 테이블당 여러개를 생성할 수 있다. 
                                     -- Foreign Key(외래키) 제약에 의해 참조(Reference)받는 컬럼은 반드시 NOT NULL 이어야 하고, 중복된 값을 허락하지 않는 고유한 값만 가지는 컬럼이어야 한다. 
                                     
     4. Check 제약 [C]               -- 하나의 테이블당 여러개를 생성할 수 있다.
                                    -- insert(입력) 또는 update(수정) 시 어떤 컬럼에 입력되거나 수정되는 데이터값을 아무거나 허락하는 것이 아니라 조건에 맞는 데이터값만 넣고자 할 경우에 사용되는 것이다.
  
     5. NOT NULL 제약 [C]            -- 하나의 테이블당 여러개를 생성할 수 있다.
                                    -- 특정 컬럼에 NOT NULL 제약을 주면 그 컬럼에는 반드시 데이터값을 주어야 한다는 말이다. 
  */
  
  
    ------ >>> 1. Primary Key(기본키, 대표식별자) 제약에 대해서 알아봅니다.  <<< -------
    
    ---- *** "고객"이라는 테이블을 생성해 보겠습니다. *** --- 
           
    create table tbl_gogek
    (gogekID     varchar2(30) primary Key -- column level 제약조건
    ,gogekNmae   varchar2(30)
    ,gogekPhone  varchar2(30) 
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
    
    create table tbl_gogek
    (gogekID     varchar2(30) 
    ,gogekNmae   varchar2(30)
    ,gogekPhone  varchar2(30) 
    ,constraint tbl_gogek_gogekID_PK  primary key(gogekID) -- Row Level 제약조건
                                    --Single Primary Key 
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    desc TBL_GOGEK;
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone) values(null, '이순신', null);
    /*
        오류 보고 -
        ORA-01400: cannot insert NULL into ("HR"."TBL_GOGEK"."GOGEKID")
        아이디가 null이 나오면 안된다.
    */
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone) values('leess', '이순신', null);     
    -- 1 행 이(가) 삽입되었습니다. 
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone) values('leess', '이삼식', '010-1234-5678');     
    /*
        gogekID 컬럼에 primary key를 column level 제약조건으로 주었을 시 
        오류 보고 -
        ORA-00001: unique constraint (HR.SYS_C007040) violated
        --------------------------------------------------------------
        gogekID 컬럼에 primary key를 Row Level 제약조건으로 주었을 시 
        오류 보고 -
        ORA-00001: unique constraint (HR.TBL_GOGEK_GOGEKID_PK) violated
        
    */
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone) values('samsik', '이삼식', '010-1234-5678');          
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone) values('soonshin', '이순신', null);   
    
    commit;
    
    select *
    from TBL_gogek;
    
    --- ***  tbl_gogek 테이블에 생성되어진 제약조건을 조회해 보겠습니다. *** ---
    select *
    from user_constraints
    where table_name = 'TBL_GOGEK';
    
    --- ***  tbl_gogek 테이블에 생성되어진 제약조건을 조회해 보는데 어떤 컬럼에 생성되어 있는지 조회해 보겠습니다. *** ---
    select *
    from user_cons_columns
    where table_name = 'TBL_GOGEK';
         
    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회한다. *** ---
    
    select *
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_GOGEK';
    
    
    create table tbl_jumun
    ( gogekID      varchar2(30)
    , productCode  varchar2(30)
    , productName  varchar2(30)
    , jumunsu      number
    , jumunDate    date default sysdate
    , constraint tbl_jumun_gogekID_PK primary key(gogekID)
    , constraint tbl_jumun_productCode_PK primary key(productCode)
    );
    /*
        오류 보고 -
        ORA-02260: table can have only one primary key
        02260. 00000 -  "table can have only one primary key"
        
        primary key는 하나의 테이블당 오로지 1개만 생성할 수 있다.
    */
         
         
    create table tbl_jumun
    ( gogekID      varchar2(30)
    , productCode  varchar2(30)
    , productName  varchar2(30)
    , jumunsu      number
    , jumunDate    date default sysdate
    , constraint tbl_jumun_gogekID_PK primary key(gogekID, productCode)
                                   -- Composite(복합) Primary Key
    );         
    -- Table TBL_JUMUN이(가) 생성되었습니다.
    
    desc tbl_jumun;
    /*
        이름          널?       유형           
    ----------- -------- ------------ 
    GOGEKID     NOT NULL VARCHAR2(30) 
    PRODUCTCODE NOT NULL VARCHAR2(30) 
    PRODUCTNAME          VARCHAR2(30) 
    JUMUNSU              NUMBER       
    JUMUNDATE            DATE       
    */
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','swk','새우깡',10); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','kjk','감자깡',20); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('samsik','swk','새우깡',10); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','swk','새우깡',50); 
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.TBL_JUMUN_GOGEKID_PK) violated
    */
      
    commit;   
    
    drop table tbl_jumun purge;
    -- Table TBL_JUMUN이(가) 삭제되었습니다.
    
    create table tbl_jumun
    ( gogekID      varchar2(30)
    , productCode  varchar2(30)
    , productName  varchar2(30)
    , jumunsu      number
    , jumunDate    date default sysdate
    , constraint tbl_jumun_gogekID_PK primary key(gogekID, productCode, jumunDate)
                                   -- Composite(복합) Primary Key
    );         
    -- Table TBL_JUMUN이(가) 생성되었습니다.     
         
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','swk','새우깡',10); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','kjk','감자깡',20); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('samsik','swk','새우깡',10); 
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_jumun(gogekID, productCode, productName, jumunsu) 
    Values('leess','swk','새우깡',50);      
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
     
    select *
    from TBL_jumun;
 
    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회한다. *** ---
    select *
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_GOGEK' and A.constraint_type = 'p';
    -- TBL_GOGEK 테이블에 존재하는 primary key 제약조건을 조회하고자 하는 것이다. 
    -- single Primary key
    
    select *
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_JUMUN' and A.constraint_type = 'p';
    -- TBL_GOGEK 테이블에 존재하는 primary key 제약조건을 조회하고자 하는 것이다. 
    -- composite(복합) Primary key
    
    
 
 
 
 
 
    ------ >>> 2. Unique Key(후보키, 후보식별자) 제약에 대해서 알아봅니다.  <<< -------
    
    --   Unique Key 중에 후보키, 후보식별자가 되려면 해당 컬럼은 NOT NULL 이어야 한다.
    --   아래의 예제에서는 gogekEmail 컬럼이 후보키, 후보식별자가 된다.
    
    
    ---- *** "고객"이라는 테이블을 생성해 보겠습니다. *** --- 
    
    drop table tbl_gogek purge;
    -- Table TBL_GOGEK이(가) 삭제되었습니다.
    
    create table tbl_gogek
    (gogekID     varchar2(30) 
    ,gogekNmae   varchar2(30) not null
    ,gogekPhone  varchar2(30) -- null  ==> null 을 허용함 
    ,gogekEmail  varchar2(50) not null             
    ,constraint PK_tbl_gogek_gogekID primary key(gogekID)
    ,constraint UQ_tbl_gogek_gogekPhone unique(gogekPhone) -- gogekphone 컬럼에 unique 제약을 준것이다.
    ,constraint UQ_tbl_gogek_gogekEmail unique(gogekEmail) -- gogekEmail 컬럼에 unique 제약을 준것이다.
    );
    -- Table TBL_GOGEK이(가) 생성되었습니다.
    
    desc tbl_gogek;
    /*
      이름         널?       유형           
    ---------- -------- ------------ 
    GOGEKID    NOT NULL VARCHAR2(30) 
    GOGEKNMAE  NOT NULL VARCHAR2(30) 
    GOGEKPHONE          VARCHAR2(30) 
    GOGEKEMAIL NOT NULL VARCHAR2(50)   
    */
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('leess', '이순신', '010-1234-5678', 'leess@gmail.com');      
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('eomjh', '엄정화', null, 'eomjh@gmail.com');      
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('youks', '유관순', null, 'youks@gmail.com');  
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-1234-5678', 'seokj@gmail.com');  
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKPHONE) violated
        폰넘버가 중복될 수 없다.
    */
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-0000-0000', 'eomjh@gmail.com');  
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.UQ_TBL_GOGEK_GOGEKEMAIL) violated
        이메일이 중복될 수 없다.
    */
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('seokj', '서강준', '010-0000-0000', 'seokj@gmail.com');  
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_gogek(gogekID, gogekNmae, gogekPhone, gogekEmail) 
    values('leeHr', '이혜리', '010-0000-0001', null); 
    /*
        오류 보고 -
        ORA-01400: cannot insert NULL into ("HR"."TBL_GOGEK"."GOGEKEMAIL")
        이메일은 반드시 입력해야 한다. (not null)
    */
    
    commit;
    
    select *
    from tbl_gogek;
 
   --- *** Composite(복합) Unique Key 예제 *** ---
    create table tbl_jumun_2
    ( gogekID      varchar2(30) not null
    , productCode  varchar2(30) not null
    , productName  varchar2(30)
    , jumunsu      number
    , jumunDate    date default sysdate not null
    , constraint UQ_tbl_jumun_2 Unique(gogekID, productCode, jumunDate)
                                   -- Composite(복합) Unique Key
    );   
    -- Table TBL_JUMUN_2이(가) 생성되었습니다.
    
    desc tbl_jumun_2;
    
    --- *** 일반적으로 제약조건을 조회할 경우에는 JOIN 을 통해서 조회한다. *** ---
    select *
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_GOGEK' and A.constraint_type = 'U';
    -- TBL_GOGEK 테이블에 존재하는 Unique key 제약조건을 조회하고자 하는 것이다. 
    -- Unique key
    -- single unique Key
    
    select *
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_JUMUN_2' and A.constraint_type = 'U';
    -- TBL_JUMUN_2 테이블에 존재하는 Unique key 제약조건을 조회하고자 하는 것이다. 
    -- Unique key
    -- Composite(복합) unique Key
    
     
     
     
     ------ >>> 3. Foreign Key(외래키, 참조키) 제약 제약에 대해서 알아봅니다.  <<< -------
     
     --- *** 고객들의 예약을 받아주는 "예약" 테이블을 생성해보겠습니다.
    select *
    from tbl_gogek;
       
    desc tbl_gogek;
        
        
    select A.constraint_name, A.constraint_type, A.search_condition,
           B.column_name, B.position
    from user_constraints A join user_cons_columns B
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_GOGEK';       
     
    --- 어떤 한명의 고객은(예: leess  이순신) 예약을 1번도 안 할 수도 있고,
    --- 예약을 딱 1번만 할 수 있고, 예약을 여러번 할 수도 있다.  
    
    select *
    from tbl_yeyak
    
    drop table tbl_yeyak purge;
    
    create table tbl_yeyak
    (  yeyakno       number       -- 예약번호 / 예약번호의 값은 not null 이면서 동시에 고유한 값만 가져야 한다.
                                  -- 그러므로 yeyakno 컬럼에는 primary key 제약을 주어야 한다. 
                                  /*
                                    예약번호는 사용자가 수동적으로 입력치 않고 자동적으로 들어와야 한다.
                                    그리고 예약번호는 매번 그 숫자가 증가되면서 고유해야 한다.
                                    이렇게 되려면 sequence 를 사용하면 된다.
                                  */      
     , fk_gogekID  VARCHAR2(30) not null   -- 고객아이디 
                                           -- fk_gogekID 컬럼에 들어올 수 있는 값은 tbl_gogek 테이블의 gogekId 컬럼의 값만 들어와야 한다. 
                                           -- 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) 반드시 고유한 값을 가지는 컬럼이어야 한다.
                                           -- 즉, 참조를 받는 컬럼은 (여기서는 tbl_gogek 테이블의 gogekid 임) Primary Key 또는 Unique 제약을 가져야 한다.
     , ticketCnt varchar(2) not null     -- 예약티켓개수   
                                         -- 데이터 타입이 number(2) 이므로 -99 ~ 99 값들이 들어온다.
                                         -- 그런데 예약티켓개수는 1번 예약에 최대 10개 까지만 허락하고자 한다.
                                         -- 즉, ticketCnt 컬럼에 들어오는 값은 1 ~ 10 까지만 가능하도록 해야 한다.
                                         -- 이러한 경우 값을 검사해야 하므로 Check 제약을 사용하면 된다.
     , registerDay date default sysdate
     
     , constraint PK_tbl_yeyak_yeyakno primary key(yeyakno)
     , constraint FK_tbl_yeyak_fk_gogekID foreign key(fk_gogekID) references tbl_gogek(gogekID)
     /*
      tbl_yeyak 테이블의 fk_gogekID 컬럼에는 foreign key 제약을 만들었는데
      그 뜻은 tbl_yeyak 테이블의 fk_gogekID 컬럼에 입력되거나 수정되어지는 값은 반드시 tbl_gogek 테이블의 gogekid 컬럼에 존재하는 값들만 가능하다는 말이다.
      즉, tbl_gogek 테이블의 gogekid 컬럼에 존재하지 않는 값은 tbl_yeyak 테이블의 fk_gogekID 컬럼에 들어올 수 없다는 말이다.
      그리고 중요한 것은 tbl_gogek 의 gogekid 컬럼은 식별자 컬럼(Primary Key, Unique Key)이어야 한다. 
     */
     , constraint CK_tbl_yeyak_ticketCnt check ( ticketCnt > 0 and ticketCnt <= 10)
     );
     -- Table TBL_YEYAK이(가) 생성되었습니다.\
     
     create sequence seq_tbl_yeyak
     start with 1
     increment by 1
     nomaxvalue
     nominvalue
     nocycle
     nocache;
     --Sequence SEQ_TBL_YEYAK이(가) 생성되었습니다.
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'leess', 5);
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'superman', 5);
     /*
        오류 보고 -
        ORA-02291: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - parent key not found
        -- 참조를 받는 테이블(부모테이블, tbl_gogek) 에서 gogek_id를 찾을 수 없습니다. 
     */
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'eomjh', 3);
     -- 1 행 이(가) 삽입되었습니다.
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'eomjh', 20);
     /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_YEYAK_TICKETCNT) violated
        -- 티켓카운트 체크제약에 의한 오류
     */
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'eomjh', 10);
     -- 1 행 이(가) 삽입되었습니다.
     
     insert into tbl_yeyak(yeyakno, fk_gogekID, ticketCnt)
     values(seq_tbl_yeyak.nextval, 'eomjh', 7);
     -- 1 행 이(가) 삽입되었습니다.
     
     commit;
     
     select *
     from tbl_yeyak;
     
  ---- **** foreign key 제약이 있는 테이블을 "자식" 테이블 이라고 하고, 
  ----      foreign key 에 의해 참조를 받는 테이블을 "부모" 테이블 이라고 한다. **** ----
  
  --- "자식" 테이블(여기서는 tbl_yeyak 테이블)에 입력되어진 데이터가 "부모" 테이블(여기서는 tbl_gogek)에 존재하는 경우에
  --- "부모" 테이블의 행을 삭제할 때 어떻게 되어지는지 알아봅니다.
  select *
  from tbl_yeyak; -- "자식" 테이블
  
  /*
    -------------------------------------------------
    yeyakno   fk_gogekid   ticketcnt   registerday
    -------------------------------------------------
       1	  leess	           5	   22/01/17
       3	  eomjh	           3	   22/01/17
       5	  eomjh	          10	   22/01/17
       6	  eomjh	           7	   22/01/17
    -------------------------------------------------
  */
     
  select *
  from tbl_gogek; -- "부모"테이블
  /*
  -------------------------------------------------------------------------------
  gogekid   gogekname   gogekphone       gogekemail
  -------------------------------------------------------------------------------
    leess	 이순신	   010-1234-5678	leess@gmail.com
    eomjh 	 엄정화		   null         eomjh@gmail.com
    youks 	 유관순		   null         youks@gmail.com
    seokj	 서강준	   010-0000-0000	seokj@gmail.com
  */  
  
   delete from tbl_gogek
   where gogekid = 'seokj';
   -- 1 행 이(가) 삭제되었습니다.
   
   delete from tbl_gogek
   where gogekid = 'leess';
   /*
      오류 보고 -
      ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found
      -- child ==> 자식 테이블인  tbl_yeyak 을 말한다.
         child record found 말은 tbl_yeyak 테이블에 존재하는 record(1 leess 5 22/01/17) 행을 말한다.
   */
   
   --- [!!중요!!! 임무] tbl_gogek 테이블에 모든 행들을 삭제하려고 한다.
    
    delete from tbl_gogek; --[부모]테이블
    /*
        오류 보고 -
        ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found
        -- 자식테이블에 나를 참조하는 행이 있다.
        HR.FK_TBL_YEYAK_FK_GOGEKID 은 tbl_gogek 테이블의 자식테이블인 곳에서 Foreign key 제약조건 이름으로 FK_TBL_YEYAK_FK_GOGEKID이 사용되어지고 있다.
        
        그러면 Foreign key 제약조건 이름으로 FK_TBL_YEYAK_FK_GOGEKID 을 사용하는 테이블명을 알아와야 한다. 
        
    */
    
    -- Foreign key 제약조건 이름으로 FK_TBL_YEYAK_FK_GOGEKID 을 사용하는 테이블명을 알아오기
    
    select table_name
    from user_constraints
    where constraint_type = 'R' and constraint_name = 'FK_TBL_YEYAK_FK_GOGEKID';
    -- TBL_YEYAK
    
    
    -- !!!!! [퀴즈] TBL_YEYAK 테이블에 존재하는 제약조건 중에 Foreign Key 제약조건을 조회하는데 아래와 같이 나오도록 하세요.. !!!!!
  ----------------------------------------------------------------------------------------------------------
   제약조건명                   제약조건타입     컬럼명          참조를받는부모테이블명       참조를받는식별자컬럼명
  ----------------------------------------------------------------------------------------------------------
   FK_TBL_YEYAK_FK_GOGEKID         R         FK_GOGEKID          TBL_GOGEK                 GOGEKID
    
   
   select constraint_name , constraint_type, r_constraint_name
   from user_constraints
   where table_name = 'TBL_YEYAK' and constraint_type = 'R';
   /*
   ------------------------------------------------------------------
    constraint_name           constraint_type    r_constraint_name
    -----------------------------------------------------------------
    FK_TBL_YEYAK_FK_GOGEKID	        R	         PK_TBL_GOGEK_GOGEKID
   */
    
    select constraint_name, column_name 
    from user_cons_columns
    where table_name = 'TBL_YEYAK';
    
    /*
    -------------------------------------------
    constraint_name           column_name 
    --------------------------------------------
    SYS_C007068	              FK_GOGEKID
    SYS_C007069	              TICKETCNT
    CK_TBL_YEYAK_TICKETCNT	  TICKETCNT
    PK_TBL_YEYAK_YEYAKNO	  YEYAKNO
    FK_TBL_YEYAK_FK_GOGEKID	  FK_GOGEKID
    */
    
    
    select constraint_name, table_name, column_name 
    from user_cons_columns 
    where constraint_name = (select r_constraint_name
                             from user_constraints
                             where table_name = 'TBL_YEYAK' and constraint_type = 'R');
    /*
    --------------------------------------------------
      constraint_name       table_name  column_name
    ---------------------------------------------------
      PK_TBL_GOGEK_GOGEKID	TBL_GOGEK	GOGEKID  
    */
    
    
   with
   A as
   (
   select constraint_name , constraint_type, r_constraint_name
   from user_constraints
   where table_name = 'TBL_YEYAK' and constraint_type = 'R'
   )
   ,
   B as 
   (
    select constraint_name, column_name 
    from user_cons_columns
    where table_name = 'TBL_YEYAK'
   )
   ,
   C as
   (
    select constraint_name, table_name, column_name 
    from user_cons_columns 
    where constraint_name = (select r_constraint_name
                             from user_constraints
                             where table_name = 'TBL_YEYAK' and constraint_type = 'R')
   )
   
   select A.constraint_name as 제약조건명 
        , A.constraint_type as 제약조건타입
        , B.column_name  as 컬럼명
        , C.table_name as 참조를받는부모테이블
        , C.column_name as 참조를받는식별자컬럼
   from A join B
   on A.constraint_name = B.constraint_name
   join C
   on A.r_constraint_name = C.constraint_name;
    
   delete from tbl_gogek; 
   /*
        오류 보고 -
        ORA-02292: integrity constraint (HR.FK_TBL_YEYAK_FK_GOGEKID) violated - child record found
   */
   
   -- *** TBL_YEYAK 테이블에 존재하는 foreign key 제약조건인 FK_TBL_YEYAK_FK_GOGEKID 을 삭제하자 *** --
   
   alter table TBL_YEYAK
   drop constraint FK_TBL_YEYAK_FK_GOGEKID;
   -- Table TBL_YEYAK이(가) 변경되었습니다.
    
   select * 
   from tbl_gogek; 
    
   delete from tbl_gogek; 
   --  3개 행 이(가) 삭제되었습니다.
   
   commit;
   
   
   --[중요]--
   ---- **** ==== !!!! Foreign Key 생성시 on delete cascade 옵션을 주는 것 !!!! ==== **** ----
   
   create table tbl_sangpum --> "상품" 테이블
   (sangpum_code    varchar2(20)
   ,sangpum_name    varchar2(20)  not null
   ,price           number(10)    not null
   ,constraint PK_tbl_sangpum_dangpum_code primary key(sangpum_code)
   );  
   -- Table TBL_SANGPUM이(가) 생성되었습니다.
   
   insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('swk','새우깡',3000);  
   insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('kjk','감자깡',4000);
   insert into tbl_sangpum(sangpum_code, sangpum_name, price) values('ypr','양파링',5000);
   
   commit;
    
    create table tbl_sangpum_review
    ( review_no           number                 -- 후기글번호
    , FK_sangpum_code     varchar2(20) not null  -- 후기를 남길 상품코드
    , review_contents     Nvarchar2(2000) not null -- 후기내용물
    , register_day        date default sysdate    -- 작성일자
    , constraint PK_tbl_sangpum_review primary key(review_no)
    , constraint FK_tbl_sangpum_review foreign key(FK_sangpum_code) references tbl_sangpum(sangpum_code) 
    );
    -- Table TBL_SANGPUM_REVIEW이(가) 생성되었습니다.
    
    insert into tbl_sangpum_review(review_no, FK_sangpum_code, review_contents )
    values(1,'swk','아주 맛있어요!!');
    
    insert into tbl_sangpum_review(review_no, FK_sangpum_code, review_contents )
    values(2,'kjk','맛이 고소해요~~');
    
    insert into tbl_sangpum_review(review_no, FK_sangpum_code, review_contents )
    values(3,'swk','가성비 만점!!');
    
    
    commit;
    
    select *
    from tbl_sangpum_review
    
    select *
    from tbl_sangpum
       
    delete from tbl_sangpum
    where sangpum_Code = 'ypr';
    -- 1 행 이(가) 삭제되었습니다.
    
    delete from tbl_sangpum
    where sangpum_Code = 'swk';
    /*
        오류 보고 -
        ORA-02292: integrity constraint (HR.FK_TBL_SANGPUM_REVIEW) violated - child record found
    -- 후기에 새우깡이 남겨져 있음 
    */
     
    delete from tbl_sangpum_review
    where FK_sangpum_code = 'swk';
    -- 2개 행 이(가) 삭제되었습니다.
    
    delete from tbl_sangpum
    where sangpum_Code = 'swk';
    -- 1 행 이(가) 삭제되었습니다.
    
    rollback;
    
    drop table tbl_sangpum_review purge;
    -- Table TBL_SANGPUM_REVIEW이(가) 삭제되었습니다.
    
    create table tbl_sangpum_review_2
    ( review_no           number                 -- 후기글번호
    , FK_sangpum_code     varchar2(20) not null  -- 후기를 남길 상품코드
    , review_contents     Nvarchar2(2000) not null -- 후기내용물
    , register_day        date default sysdate    -- 작성일자
    , constraint PK_tbl_sangpum_review_2 primary key(review_no)
    , constraint FK_tbl_sangpum_review_2 foreign key(FK_sangpum_code) references tbl_sangpum(sangpum_code) on delete cascade
    /*
        on delete cascade 를 해주었으므로 부모테이블인 tbl_sangpum 테이블에서 행을 delete 를 할 때. 
        먼저 자식 테이블인 tbl_sangpum_review_2 테이블에서 자식레코드(행)를 먼저 delete를 해준다.
    */
    );
    -- Table TBL_SANGPUM_REVIEW_2이(가) 생성되었습니다.
    --제약조건 이름이 이미 있으면 사용이 불가능하다. (제약조건이름은 고유해야한다.)
    
    
    insert into tbl_sangpum_review_2(review_no, FK_sangpum_code, review_contents )
    values(1,'swk','아주 맛있어요!!');
    
    insert into tbl_sangpum_review_2(review_no, FK_sangpum_code, review_contents )
    values(2,'kjk','맛이 고소해요~~');
    
    insert into tbl_sangpum_review_2(review_no, FK_sangpum_code, review_contents )
    values(3,'swk','가성비 만점!!');
    
    commit;
    
    select *
    from tbl_sangpum_review_2
    
    select *
    from tbl_sangpum;
       
    delete from tbl_sangpum -- 부모테이블
    where sangpum_Code = 'ypr';
    -- 1 행 이(가) 삭제되었습니다.
    /*
        on delete cascade 를 해주었으므로 부모테이블인 tbl_sangpum 테이블에서 행을 delete 를 할 때. 
        먼저 자식 테이블인 tbl_sangpum_review_2 테이블에서 자식레코드(행)를 먼저 delete를 해준다.
        즉, 아래의 DML 문이 먼저 자동적으로 실행된다.
        delete from tbl_sangpum_review_2
        where FK_sangpum_code = 'swk';
        -- 2개 행 이(가) 삭제되었습니다.
    */
    select *
    from tbl_sangpum_review_2
    
    select *
    from tbl_sangpum;
    
    rollback;
    
    
    select *
    from departments;
    
    select *
    from employees;
    -- department_id 컬럼이 foreign key로 사용된다.
    -- departments 테이블의 department_id 컬럼을 참조하는 foreign key로 사용된다.
    
    update employees set department_id = 500
    where employee_id = 100;
    
    delete from departments
    where department_id = 60;
    -- 부서 통폐합시 특정 부서가 delete 된다. 하더라도 그 부서에 근무하는 사원들은 delete가 되면 안된다.
    -- 그러므로 employees 테이블에서 department_id 컬럼에 foreign key를 생성 시 on delete cascade 옵션을 주면 안된다.
    
   
  
  
   ---- **** ==== !!!! Foreign Key 생성시 on delete set null 옵션을 주는 것 !!!! ==== **** ----
    
    create table tbl_buseo 
    ( buno       number(2)
    , buname     varchar2(30)         not null
    , constraint PK_tbl_buseo_buno primary key(buno)
    );
    -- Table TBL_BUSEO이(가) 생성되었습니다.
    
    drop table tbl_buseo purge;
    
    insert into tbl_buseo(buno, buname) values(10, '관리부');
    insert into tbl_buseo(buno, buname) values(20, '영업부');
    insert into tbl_buseo(buno, buname) values(30, '생산부');  
    commit;
    
    
    create table tbl_jikwon
    ( jikwonno     number(5)
    , name         varchar2(30) not null
    , Fk_buno      number(2) -- not null 을 주면 안된다. !! -- null로 업데이트가 안된다.
    , constraint PK_tbl_jikwon_jikwonno primary key(jikwonno)
    , constraint FK_tbl_jikwon_fk_buno foreign key(fk_buno) references tbl_buseo(buno) on delete set null
    -- on delete set null 을 넣어주면 부모테이블(tbl_buseo) 테이블에서 특정 행을 delete 시 
    -- 자식 테이블인 (tbl_jikwon) 테이블에서 참조하던 행들의 fk_buno 컬럼의 값을 먼저 null로 update 시켜버린다. 
    -- 그런 다음에 부모테이블인 tbl_buseo 테이블에서 특정 행을 delete 해준다.
    );
    
     drop table tbl_jikwon purge;
     -- Table TBL_JIKWON이(가) 삭제되었습니다.
     
    insert into tbl_jikwon(jikwonno, name, fk_buno ) values(1001, '이순신', 10);
    insert into tbl_jikwon(jikwonno, name, fk_buno ) values(1002, '삼순신', 20);
    insert into tbl_jikwon(jikwonno, name, fK_buno ) values(1003, '사순신', 20);
    insert into tbl_jikwon(jikwonno, name, Fk_buno ) values(1004, '오순신', 30);
    insert into tbl_jikwon(jikwonno, name, Fk_buno ) values(1005, '육순신', 30);
    
    commit;

    select *
    from tbl_buseo;
    
    select *
    from tbl_jikwon;
    
    delete from tbl_buseo
    where buno = 30;

    rollback;

     ------ >>> 4. Check 제약에 대해서 알아봅니다.  <<< -------
    
    create table tbl_sawon
    (sano       number                     -- 사원번호
    ,saname     varchar2(20)    not null   -- 사원명
    ,salary     number(5)       not null   -- 급여는 커미션보다 커야한다.
    ,commission number(5)                  -- 커미션은 0이상 이어야한다.
    ,jik        varchar2(20) default '사원' -- 직급의 종류는 '사장','부장','과장','대리','사원' 만 가능하다. 
    ,email      varchar2(50) not null      -- 이메일 
    ,hire_date  date default sysdate       -- 입사일자
    ,constraint PK_tbl_sawon_sano primary key(sano)
    ,constraint CK_tbl_sawon_salary_commission check(commission >= 0 and salary > commission)
    ,constraint CK_tbl_sawon_jik check(jik in('사장','부장','과장','대리','사원') )
    ,constraint UQ_tbl_sawon_email unique( email )
    );
    -- Table TBL_SAWON이(가) 생성되었습니다.
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 1000, '과장', 'hongkd@naver.com');
    /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
        커미션이 샐러리보다 커야한다.
    */
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, -100, '과장', 'hongkd@naver.com');
     /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_SALARY_COMMISSION) violated
        커미션이 0보다 커야한다.
    */
   
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 100, '장군', 'hongkd@naver.com');
    /*
        오류 보고 -
        ORA-02290: check constraint (HR.CK_TBL_SAWON_JIK) violated
        직급에 체크제약에 걸림
    */
    
    insert into tbl_sawon(sano, saname, salary, commission, jik, email)
    values(1001, '홍길동', 500, 100, '과장', 'hongkd@naver.com');
    -- 1 행 이(가) 삽입되었습니다.
 
    
    ------ >>> 5. NOT NULL 제약 [C] 제약에 대해서 알아봅니다.  <<< -------
    -- 어떤 컬럼에 값을 입력하거나 수정할 때 null을 허락하지 않는다는 말이다. 
    
    drop table tbl_jikwon purge;
    -- Table TBL_JIKWON이(가) 삭제되었습니다.
  
  create table tbl_jikwon
  (sano         number 
  ,saname       varchar2(20) constraint NN_tbl_jikwon_saname not null 
  ,salary       number(5) not null          -- 급여는 커미션 보다 커야 한다.
  ,commission   number(5)                   -- 커미션은 0 이상이어야 한다. 
  ,jik          varchar2(20) default '사원'  -- 직급의 종류는 '사장','부장','과장','대리','사원' 만 가능하다.
  ,email        varchar2(50) not null 
  ,hire_date    date default sysdate 
  ,constraint  PK_tbl_jikwon_sano  primary key(sano)
  ,constraint  UQ_tbl_jikwon_email unique(email)
  ,constraint  CK_tbl_jikwon_jik check( jik in('사장','부장','과장','대리','사원') )
  ,constraint  CK_tbl_jikwon_salaryCommission check( salary > commission and commission >= 0 )
  );
  -- Table TBL_JIKWON이(가) 생성되었습니다.
  
  insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
  values(1001, '홍길동', 500, 200, '부장', 'hongkd@gmail.com');
  
  insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
  values(1002, '엄정화', 600, 300, '과장', 'eomjh@gmail.com');
  
  insert into tbl_jikwon(sano, saname, salary, commission, jik, email)
  values(1003, '이순신', 300, 100, '대리', 'leess@gmail.com');
  
  commit;
  
  select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
  from user_constraints A join user_cons_columns B 
  on A.constraint_name = B.constraint_name
  where A.table_name = 'TBL_JIKWON';
    
  --- ***[중요] Sub Query 를 사용하여 어떤 테이블을 생성할 경우 원본테이블에 존재하던 제약조건중 NOT NULL 제약만 복사가 되어지고 
  ---     나머지 제약조건은 복사가 안 됩니다.  또한 복사되는 NOT NULL 제약의 제약조건명은 SYS_C뭐뭐뭐로 변경되어집니다.    
  create table tbl_jikwon_copy
  as
  select *
  from TBL_JIKWON; 
  -- Table TBL_JIKWON_COPY이(가) 생성되었습니다.
  
  select *
  from TBL_JIKWON_copy;
    
    
  select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
  from user_constraints A join user_cons_columns B 
  on A.constraint_name = B.constraint_name
  where A.table_name = 'TBL_JIKWON_COPY';  
  
  
  
  ---- *** 어떤 테이블에 제약조건을 추가하기 *** -----
  /*
     제약조건 추가시 not null 제약을 제외한 나머지 4개는 아래와 같이 한다.                                                                    
     
     alter table 테이블명 add constraint 제약조건명 primary key(컬럼명,..);
     alter table 테이블명 add constraint 제약조건명 unique(컬럼명,..);
     alter table 테이블명 add constraint 제약조건명 check(조건);
     
     alter table 테이블명 add constraint 제약조건명 foreign(컬럼명) references 부모테이블명(식별자컬럼명);
     alter table 테이블명 add constraint 제약조건명 foreign(컬럼명) references 부모테이블명(식별자컬럼명) on delete cascade;
     alter table 테이블명 add constraint 제약조건명 foreign(컬럼명) references 부모테이블명(식별자컬럼명) on delete set null;
  */
  /*
     Not Null 제약을 추가할 때는 아래와 같이 한다.
     
     alter table 테이블명 modify 컬럼명 not null; --> 제약조건명이 SYS_C.... 
     
     alter table 테이블명 modify 컬럼명 제약조건명 not null; -->
  */
    
    alter table TBL_JIKWON_COPY
    add constraint PK_TBL_JIKWON_copy_SANO primary key(SANO);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY
    add constraint UQ_TBL_JIKWON_copy_EMAIL unique(EMAIL);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_copy_JIK check( jik in('사장','부장','과장','대리','사원') );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.

    alter table TBL_JIKWON_COPY 
    add constraint CK_TBL_JIKWON_copy_SALCOMM check(  salary > commission and commission >= 0  );
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    ---- *** 어떤 테이블에 제약조건을 삭제하기 *** ----
  /*
      alter table 테이블명 drop constraint 제약조건명;
        
      그런데 NOT NULL 제약은 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다.
      alter table 테이블명 modify 컬럼명 null;
        
      어떤 테이블에 primary key 제약조건을 삭제할 경우에는 위의 것처럼 해도 되고, 또는 아래처럼 해도 된다.
      alter table 테이블명 drop primary key;
  */
    
    -- *** TBL_JIKWON_COPY 테이블의 check 제약 CK_TBL_JIKWON_COPY_SALCOMM 삭제하기 *** --
    alter table TBL_JIKWON_COPY drop constraint CK_TBL_JIKWON_COPY_SALCOMM;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    
    -- *** TBL_JIKWON_COPY 테이블의 salary컬럼에 존재하는 not null 제약 삭제하기 *** --
--  alter table TBL_JIKWON_COPY drop constraint SYS_C007112;
--  또는
    alter table TBL_JIKWON_COPY modify salary null;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
 
    -- *** TBL_JIKWON_COPY 테이블의 primary key 제약 삭제하기 *** --
 -- alter table TBL_JIKWON_COPY drop constraint PK_TBL_JIKWON_COPY_SANO;
 -- 또는
    alter table  TBL_JIKWON_COPY drop primary key;
 -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
 
    
  select A.constraint_name, A.constraint_type, A.search_condition, 
         B.column_name, B.position 
  from user_constraints A join user_cons_columns B 
  on A.constraint_name = B.constraint_name
  where A.table_name = 'TBL_JIKWON_COPY';  
   
   ---- *** 어떤 테이블에 생성되어진 제약조건의 내용을 변경하기 *** ----
   --->     기존 제약조건을 삭제하고서 내용이 변경되어진 제약조건을 추가하는 것이다. 
   --- TBL_JIKWON_COPY 테이블에 생성되어진 JIK 컬럼에 대한 check 제약의 내용을 변경하겠습니다.      
     
    alter table TBL_JIKWON_COPY drop constraint CK_TBL_JIKWON_COPY_JIK;
    
    alter table TBL_JIKWON_COPY add constraint CK_TBL_JIKWON_COPY_JIK check( jik in('사장','이사','부장','과장','대리','사원') )
 
    --- *** 어떤 테이블에 생성되어진 제약조건의 이름을 변경하기 *** ---- 
    
   /*
        alter table 테이블명
        rename constraint 현재사용중인제약조건명 to 새로운제약조건명;
   */
    
    alter table TBL_JIKWON_COPY
    rename constraint SYS_C007111 to NN_TBL_JIKWON_COPY_SANAME;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    --- *** 어떤 테이블에 존재하는 제약조건을 비활성화 시키기 *** ---
    /*
        alter table 테이블명 disable constraint 제약조건명;
    */
    
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';
    
    alter table TBL_JIKWON_COPY disable constraint CK_TBL_JIKWON_COPY_JIK;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다. (있지만 안쓰겠다.)
    
    --- *** 어떤 테이블에 존재하는 제약조건을 활성화 시키기 *** ---
    /*
        alter table 테이블명 enable constraint 제약조건명;
    */
    alter table TBL_JIKWON_COPY enable constraint CK_TBL_JIKWON_COPY_JIK;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    select constraint_name, constraint_type, search_condition, status
    from user_constraints
    where table_name = 'TBL_JIKWON_COPY';
    
    
    --- *** 어떤 테이블에 새로운 컬럼 추가하기 *** --- 
    /*
        alter table 테이블명 add 추가할컬럼명 데이터타입;
    */
    
    desc TBL_JIKWON_COPY;
    
    -- 주민번호 칼럼 추가하기
    alter table TBL_JIKWON_COPY add jubun varchar2(13);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    select *
    from TBL_JIKWON_COPY;
    
    
    
    --- *** TBL_JIKWON_COPY 테이블의 jubun 컬럼에 not null 제약 추가하기 *** ---
    
    alter table TBL_JIKWON_COPY
    modify jubun constraint NN_TBL_JIKWON_COPY_JUBUN not null;
    /*
        오류 보고 -
        ORA-02296: cannot enable (HR.NN_TBL_JIKWON_COPY_JUBUN) - null values found
        
        왜냐하면 TBL_JIKWON_COPY 테이블에 입력된 행들중에 JUBUN 컬럼의 값이 NULL인 것이 존재하기 때문이다. 
    */
    
    update TBL_JIKWON_COPY set jubun = ' '
    where jubun is null;
    -- 3개 행 이(가) 업데이트되었습니다.       
    
    alter table TBL_JIKWON_COPY
    modify jubun constraint NN_TBL_JIKWON_COPY_JUBUN not null;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    select *
    from TBL_JIKWON_COPY;
    
    --- *** 어떤 테이블에 존재하는 컬럼 삭제하기 *** --- 
    /*
        alter table 테이블명 drop column 삭제할컬럼명;
    */
    
    --- *** TBL_JIKWON_COPY 테이블에 존재하는 jubun 컬럼을 삭제하기 *** ---
    alter table TBL_JIKWON_COPY
    drop column jubun;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;
    
    
    --- *** 어떤 테이블에 새로운 컬럼을 추가하는데 NOT NULL을 주고 싶다. *** ---
    /*
        alter table 테이블명 add 추가할컬럼명 데이터타입 NOT NULL; 이 아니라
        
        alter table 테이블명 add 추가할컬럼명 데이터타입 default 기본값 NOT NULL; 이다.
    */
    
    alter table TBL_JIKWON_COPY
    add jubun varchar2(13) NOT NULL;
    /*
        오류 보고 -
        ORA-01758: table must be empty to add mandatory (NOT NULL) column
    */
    
    alter table TBL_JIKWON_COPY 
    add jubun varchar2(13) default ' ' NOT NULL;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;
    
    ---- ***  어떤 테이블에 존재하는 컬럼명을 변경하기 *** ----
    /*
        alter table 테이블명
        rename column 현재컬럼명 to 새로이변경할컬럼명;
    */
 
    ---- *** TBL_JIKWON_COPY 테이블에 존재하는 jubun 컬럼명을 juminbunho 컬럼명으로 변경하겠다. *** ----
    alter table TBL_JIKWON_COPY
    rename column jubun to juminbunho;
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;
    
    --- *** 어떤 테이블에 존재하는 데이터 타입 변경하기 *** ---
    /*
        alter table 테이블명 
        modify 컬럼명 새로운데이터타입;
    */
    
    desc TBL_JIKWON_COPY;
    -- EMAIL      NOT NULL VARCHAR2(50) 
    
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(100);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
    
    desc TBL_JIKWON_COPY;
    -- EMAIL      NOT NULL VARCHAR2(100) 
    
    select *
    from TBL_JIKWON_COPY;
    
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(10);
    /*
        오류 보고 -
        ORA-01441: cannot decrease column length because some value is too big 
        -- EMAIL 컬럼에 들어와있는 데이터가 이미 10byte보다 크기 때문에 오류!
    */
     
    alter table TBL_JIKWON_COPY 
    modify EMAIL VARCHAR2(20);
    -- Table TBL_JIKWON_COPY이(가) 변경되었습니다.
 
    desc TBL_JIKWON_COPY;
    -- EMAIL      NOT NULL VARCHAR2(20) 
    
    --- *** 어떤 테이블의 테이블명 변경하기 *** ---
    /*
        rename 현재테이블명 to 새로운테이블명;
    */
    -- TBL_JIKWON_COPY 테이블 이름을 TBL_JIKWON_BACKUP 이라는 테이블명으로 변경하겠다.
    rename TBL_JIKWON_COPY to TBL_JIKWON_BACKUP
    
    select *
    from TBL_JIKWON_COPY;
    -- 오류발생
    
    select *
    from TBL_JIKWON_BACKUP;
 
    
    --- *** 어떤 테이블이 부모테이블로 사용하고 있을 경우 부모테이블을 drop 하기
    
    /*
        drop table 부모테이블명 cascade constraints purge;
        
        cascade constraints  이 있으면 
        부모테이블명 을 drop 하기전 먼저 부모테이블명에 딸려진 자식테이블의 foreign key 제약조건을 먼저 drop 해준다.
        그런 다음에 부모테이블명을 drop 해준다.  
    */
    
    create table tbl_board_a  -- 게시판 테이블
    ( boardno           number
    , board_content     varchar2(4000) not null
    , constraint PK_tbl_board_a_boardno primary key(boardno)
    );
    -- Table TBL_BOARD_A이(가) 생성되었습니다.
    
    insert into tbl_board_a(boardno, board_content) values(1, '안녕하세요?');
    insert into tbl_board_a(boardno, board_content) values(2, '건강하세요~');
    commit;
    
    create table tbl_board_a_add  -- 게시판 댓글 테이블
    ( addno         number
    , add_content   varchar2(4000) not null
    , fk_boardno    number not null
    , constraint PK_tbl_board_a_add_addno primary key(addno)
    , constraint FK_tbl_board_a_fk_boardno foreign key(fk_boardno) references tbl_board_a(boardno) on delete cascade
    );
    -- Table TBL_BOARD_A_ADD이(가) 생성되었습니다.
    
    insert into TBL_BOARD_A_ADD(addno, add_content, fk_boardno)
    values(1001, '안녕하세요? 에 대한 댓글입니다.', 1);
 
    commit;
    
    select *
    from tbl_board_a
    
    select *
    from tbl_board_a_add
 
    drop table tbl_board_a purge;
    /*
        오류 보고 -
        ORA-02449: unique/primary keys in table referenced by foreign keys
        
        왜냐하면 tbl_board_a 테이블은 자식테이블(tbl_board_a_add)에 의해 참조를 받는 부코테이블이므로(foreign keys)
        바로 drop table 이 불가하다. !!
    */
    select *
    from user_constraints
    where table_name = 'TBL_BOARD_A_ADD' and constraint_type = 'R';
    -- 결과물이 나온다.
    
    drop table tbl_board_a cascade constraints purge;
    
    select *
    from tbl_board_a;
    -- ORA-00942: table or view does not exist
    
    select *
    from tbl_board_a_add;
    
    select *
    from user_constraints
    where table_name = 'TBL_BOARD_A_ADD' and constraint_type = 'R';
    -- 결과물이 없다. 왜냐하면 foreign key 제약조건을 자동으로 drop해주었기 때문이다. 
    
  
  
   ---- !!!! 테이블을 생성한 이후에 웬만하면 테이블명에 대한 주석문을 달아주도록 합시다.!!!! ----
   /*
        comment on 테이블명 
        is '테이블명에대한 주석문';
   */
   
   --- *** 테이블명에 달려진 주석문 조회하기 *** --
   select *
   from user_tab_comments;
 
    comment on table tbl_jikwon 
    is '우리회사 사원들의 정보가 들어있는 테이블';
    
   
    ---- !!!! 테이블을 생성한 이후에 웬만하면 컬럼명에 대한 주석문을 달아주도록 합시다.!!!! ----
    /*
       comment on column 
       테이블명.컬럼명 is '컬럼명에 대한 주석문';   
    */
   select * 
   from user_col_comments
   where table_name = 'EMPLOYEES';
   
   comment on column jubun
   is ''
   
   
   select * 
   from user_col_comments
   where table_name = 'TBL_JIKWON';
    
   comment on column TBL_JIKWON.SANO is '사원번호 Primary Key';  -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.SANAME is '사원명 NOT NULL';     -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.SALARY is '기본급여 0보다 크면서 COMMISSION 보다 크다';  -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.COMMISSION is '커미션 최소 0이면서 SALARY 보다 작다';    -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.JIK is '직급 사장,이사,부장,과장,대리,사원 만 가능함';     -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.EMAIL is '이메일';  -- Comment이(가) 생성되었습니다.
   comment on column TBL_JIKWON.HIRE_DATE is '입사일자 기본값은 sysdate';  -- Comment이(가) 생성되었습니다.
      
   select column_name, comments  
   from user_col_comments
   where table_name = 'TBL_JIKWON';
   
   
   
   
   
   
   
   
   
   ------------------------------------------------------------------------------------------------
   ---- !!!! 테이블을 삭제시 휴지통에 버리기 ==> drop 되어진 테이블을 복구가 가능하도록 만들어 주는 것이다. !!!! ----
   
   -- ==> drop 되어진 테이블을 복구가 가능하도록 만들어 주는 것이다. !!!! ====
   
   create table tbl_exam_01
   (name  varchar2(20));

   insert into tbl_exam_01(name) values('연습1');
   commit;
   
   create table tbl_exam_02
   (name  varchar2(20));
   
   insert into tbl_exam_02(name) values('연습2');
   commit;
   
   create table tbl_exam_03
   (name  varchar2(20));
   
   insert into tbl_exam_03(name) values('연습3');
   commit;
   
   create table tbl_exam_04
   (name  varchar2(20));
   
   insert into tbl_exam_04(name) values('연습4');
   commit;
   
   create table tbl_exam_05
   (name  varchar2(20));
  
   insert into tbl_exam_05(name) values('연습5');
   commit;
      
   create table tbl_exam_06
   (name  varchar2(20));
  
   insert into tbl_exam_06(name) values('연습6');
   commit; 
   
   drop table tbl_exam_01;  --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다.
   -- Table TBL_EXAM_01이(가) 삭제되었습니다.
   
   select * from tab;
   -- 결과물에서 tname 컬럼에 BIN$.... 시작하는 것은 휴지통에 버려진 테이블이다. 
 
   drop table tbl_exam_02;  --> tbl_exam_01 테이블을 영구히 삭제하는 것이 아니라 휴지통에 버리는 것이다.
   -- Table TBL_EXAM_02이(가) 삭제되었습니다.
   
   select * from tab;
   -- 결과물에서 tname 컬럼에 BIN$.... 시작하는 것은 휴지통에 버려진 테이블이다.   
 
    select *
    from tbl_exam_01;
    -- ORA-00942: table or view does not exist
    select *
    from tbl_exam_02;
    -- ORA-00942: table or view does not exist
    
    select *
    from "BIN$q8UfUgtKRRSiOUkWxM4HFA==$0" -- 삭제한 정보 확인하기 만드시 "" 를 붙여야 한다.
    
    ---- ===== *** 휴지통 조회하기 *** ==== ------
    
    select *
    from user_recyclebin;
    
    ---- ===== *** 휴지통에 있던 테이블을 복원하기 *** ==== ------
    
    flashback table TBL_EXAM_01 to before drop;
    -- Flashback을(를) 성공했습니다.
    -- TBL_EXAM_01 은 original_name 컬럼에 나오는 것이다. 
    
    select *
    from TBL_EXAM_01
    -- 복원됨
    
    ---- ==== *** 휴지통에 있는 테이블을 영구히 삭제하기 *** ==== ----
    
     select *
     from user_recyclebin;
    
    purge table TBL_EXAM_02;
    -- Table이(가) 비워졌습니다.
    -- TBL_EXAM_02 은 original_name 컬럼에 나오는 것이다. 
    
    
    
    ---- ==== *** 휴지통에 있는 모든 테이블을 영구히 삭제하기 *** ==== ----
    
    drop table tbl_exam_03; -- Table TBL_EXAM_03이(가) 삭제되었습니다.
    drop table tbl_exam_04; -- Table TBL_EXAM_04이(가) 삭제되었습니다.
    
    select *
    from user_recyclebin;
        purge recyclebin;  -- 휴지통에 있던 모든 테이블을 영구히 삭제하기
    -- Recyclebin이(가) 비워졌습니다.
     
    select * from tab;
     
     
    ---- **** 테이블을 영구히 삭제하기 ==> drop 되어진 테이블은 복원이 불가하다. **** ----
     
    select *
    from tbl_exam_05;
    -- Table TBL_EXAM_05이(가) 삭제되었습니다.
    drop table tbl_exam_05 purge;
    
    select *
    from user_recyclebin;
    
    
    --------- ==== *** 계층형 쿼리 *** ==== -----------
    /*
        계층형 쿼리는 Spring framework 시간에 답변형 게시판에서 사용한다.
        또한 전자결제 에서도 사용된다. 
    */
    
    /*
            1         정경은
                        |
            2         최병진
                   ----------- 
                   |         |
            3    임유리     정환모
                   |
            4    조덕노
                   
    */
    
    select *
    from employees
    order by employee_id asc;
    
    -- 결제라인을 만들어 보겠습니다. 
    -- 출발   104  ==>  103  ==>  102 ==>  100  ==>  null  
    -- level  1         2         3        4
    
    
    ---------------------------------------------------------
      level  사원번호   사원명               직속결제권자사원번호 
    ---------------------------------------------------------
        1      104    Bruce Ernst               103
        2      103    Alexander	Hunold          102
        3      102    Lex	De Haan             100
        4      100    Steven	KING            null
    
    
    select level
         , employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , manager_id as 직속결제권자사원번호
    from employees
    start with employee_id = 104 -- start with employee_id = 103  start with employee_id = 102  start with employee_id = 100 start with employee_id = null 이 될때까지 간다.  
    connect by prior manager_id = employee_id;
   
    --- *** !!! prior 다음에 나오는 manager_id 컬럼은 start with 되어지는 행의 manager_id 컬럼의 값이다. !!! *** ---
    /*
        connect by prior 103 = employee_id; 
        connect by prior 102 = employee_id;
        connect by prior 100 = employee_id; 
        connect by prior null = employee_id;
    */
    
    
    
    
    
    --------- ==== *** INDEX(인덱스, 색인) *** ==== -----------    
    
    /* 
       index(==색인)는 예를 들어 설명하면 아주 두꺼운 책 뒤에 나오는 "찾아보기" 와 같은 기능을 하는 것이다.
       "찾아보기" 의 특징은 정렬되어 있는 것인데 index(==색인) 에 저장된 데이터도 정렬되어 저장되어 있다는 것이 특징이다.
    */
    -- index(==색인)를 생성해서 사용하는 이유는 where 절이 있는 select 명령문의 속도를 향상 시키기 위함이다.
    -- index(==색인)은 어떤 컬럼에 만들어 할까요?
    /*
       1. where 절에서 "자주" 사용되어진 컬럼에 만들어야 한다.
       
       2. 조인조건절에 "자주" 사용되어진 컬럼에 만들어야 한다.
       
       3. order by 절에 "자주" 사용되어진 컬럼에 만들어야 한다.
          group by 절에 "자주" 사용되어진 컬럼에 만들어야 한다.
       
       4. 선택도(selectivity)가 높은 컬럼에 만들어야 한다.
       ※ 선택도(selectivity)가 높다라는 것은 고유한 데이터일수록 선택도(selectivity)가 높아진다.
       예: 성별컬럼 --> 선택도(selectivity)가 아주 낮다. 왜냐하면 수많은 사람중 남자 아니면 여자중 하나만 골라야 하므로 선택의 여지가 아주 낮다.
           학번    --> 선택도(selectivity)가 아주 좋다. 왜냐하면 학번은 다양하고 고유하므로 골라야할 대상이 아주 많으므로 선택도가 높은 것이다.
        
       5. 카디널리티(cardinality)가 높은 컬럼에 만들어야 한다.
       ※ 카디널리티(cardinality)의 사전적인 뜻은 집합원의 갯수를 뜻하는 것으로서,
          카디널리티(cardinality)가 높다라는 것은 중복도가 낮아 고유한 데이터일수록 카디널리티(cardinality)가 상대적으로 높다 라는 것이다.
          카디널리티(cardinality)가 낮다라는 것은 중복도가 높아 중복된 데이터가 많을수록 카디널리티(cardinality)가 상대적으로 낮다 라는 것이다.
          
          카디널리티(cardinality)는 "상대적인 개념" 이다.
          예를들어, 주민등록번호 같은 경우는 중복되는 값이 없으므로 카디널리티(cardinality)가 높다고 할 수 있다.
          이에 비해 성명같은 경우는 "주민등록번호에 비해" 중복되는 값이 많으므로, 성명은 "주민등록번호에 비해" 카디널리티가 낮다고 할 수 있다.
          이와같이 카디널리티(cardinality)는 상대적인 개념으로 이해해야 한다.
    */ 
    
    
    select level
         , employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , manager_id as 직속결제권자사원번호
    from employees
    start with employee_id = 100 
    connect by prior employee_id = manager_id;
    /*
      connect by prior 100 = manager_id;  
      connect by prior 101 = manager_id;  
      connect by prior 108 = manager_id;
      connect by prior 109 = manager_id;  
    */
    
    select *
    from employees
    where manager_id = 109;
    -- 없다. 
    
    
    select level
         , employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , manager_id as 직속결제권자사원번호
    from employees
    start with employee_id = 100 
    connect by prior employee_id = manager_id
    order by 1;
    
    create table tbl_student_1
    (hakbun      varchar2(20) not null
    ,name        varchar2(20)
    ,email       varchar2(30)
    ,address     varchar2(200)
    );
    -- Table TBL_STUDENT_1이(가) 생성되었습니다.
    
    --- *** unique 한 index 생성하기 *** ---
   /* 
      어떤 컬럼에 unique 한 index 를 생성하면 그 컬럼에 들어오는 값은 중복된 값은 들어올 수 없으며 오로지 고유한 값만 들어오게 된다.
      unique 한 index 가 뒤에 나오는 non-unique 한 index 보다 검색속도가 조금 더 빠르다.
   */ 
  /*
     [문법]
     create unique index 인덱스명
     on 해당테이블명(컬럼명 asc|desc);
  */
  
    create unique index idx_tbl_student_1_hakbun
    on tbl_student_1(hakbun); -- on tbl_student_1(hakbun asc);
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 생성되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('1', '일미자', 'ilmj@naver.com', '서울시 강동구');
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('1', '이미자', 'twomj@naver.com', '서울시 강서구');
    /*
        오류 보고 -
        ORA-00001: unique constraint (HR.IDX_TBL_STUDENT_1_HAKBUN) violated
        
        왜냐하면 hakbun 컬럼에 unique index 를 적용하였기 때문에 중복사용이 불가능하다.
    */
    
    insert into tbl_student_1(hakbun, name, email, address) values('2', '이미자', 'twomj@naver.com', '서울시 강서구');
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    ----- **** TBL_STUDENT_1 테이블에 생성 되어진 index 조회하기 **** -----
    
    select *
    from user_indexes
    where table_name = 'TBL_STUDENT_1';
    
    select *
    from user_ind_columns
    where table_name = 'TBL_STUDENT_1';
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    
   
   
    
    
    --- *** non-unique 한 index 생성하기 *** ---
  /* 
     어떤 컬럼에 non-unique 한 index 생성하면 그 컬럼에 들어오는 값은 중복된 값이 들어올 수 있다는 것이다.
     non-unique 한 index 는 unique 한 index 보다 검색속도가 다소 늦은 편이다.
  */ 
  /*
    [문법]
    create index 인덱스명
    on 해당테이블명(컬럼명 asc|desc);
  */
    
    create index idx_tbl_student_1_name
    on tbl_student_1(name asc); -- 글번호와 같은 최근 것을 많이 조회하면 desc를 쓴다.
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('3', '삼미자', 'threemj@naver.com', '서울시 강서구');
    -- 1 행 이(가) 삽입되었습니다.
    
    insert into tbl_student_1(hakbun, name, email, address) values('4', '삼미자', 'threemj2@naver.com', '서울시 강남구');
    -- 1 행 이(가) 삽입되었습니다.
    
    commit;
    
    select *
    from tbl_student_1;
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
 /*
   ----------------------------------------------------------------------- 
    index_name                  uniqueness      column_name    descend
   ----------------------------------------------------------------------- 
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	       ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	       ASC
   ----------------------------------------------------------------------- 
 */
 
    select *
    from tbl_student_1
    where hakbun = '2';  -->  unique한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해옴.
    
    
    select *
    from tbl_student_1
    where name = '이미자';  --> non-unique한 인덱스 IDX_TBL_STUDENT_1_NAME 를 사용하여 빠르게 조회해옴.
    
    
    select *
    from tbl_student_1
    where address = '서울시 강동구';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서 
                                    --  address 컬럼의 값이  '서울시 강동구' 인 데이터를 가져온다.
                                    --  이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                    --  Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.
                                    
    
    delete from tbl_student_1;  
    -- 4개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.
    
    
    
    -- drop sequence seq_tbl_student_1;
    
    create sequence seq_tbl_student_1
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    -- Sequence SEQ_TBL_STUDENT_1이(가) 생성되었습니다.
    
    
    declare
       v_cnt  number := 1;
       v_seq  number;
       v_day  varchar2(8);
    begin
        loop 
           exit when v_cnt > 10000;
        
           select seq_tbl_student_1.nextval, to_char(sysdate, 'yyyymmdd') 
                  into v_seq, v_day
           from dual;
        
           insert into tbl_student_1(hakbun, name, email, address)
           values(v_day||'-'||v_seq, '이순신'||v_seq, 'leess'||v_seq||'@gmail.com', '서울시 마포구 월드컵로 '||v_seq);
           
           v_cnt := v_cnt + 1;
        end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    commit;
    -- 커밋 완료.
    
    
    select *
    from tbl_student_1;
    
    select count(*)
    from tbl_student_1;   -- 10000
    
    select seq_tbl_student_1.currval as 최근에사용한시퀀스값
    from dual;
 
    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 1), '배수지'||(seq_tbl_student_1.currval + 1), 'baesuji'||(seq_tbl_student_1.currval + 1)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 1));        
    --       '20220120-10001' 
    
    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 2), '배수지'||(seq_tbl_student_1.currval + 1), 'baesuji'||(seq_tbl_student_1.currval + 2)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 2));        
    --       '20220120-10002' 
    
    insert into tbl_student_1(hakbun, name, email, address)
    values(to_char(sysdate, 'yyyymmdd')||'-'||(seq_tbl_student_1.currval + 3), '배수지'||(seq_tbl_student_1.currval + 3), 'baesuji'||(seq_tbl_student_1.currval + 3)||'@gmail.com', '서울시 마포구 월드컵로 '||(seq_tbl_student_1.currval + 3));        
    --       '20220120-10003' 
    
    commit;
    
    select count(*)
    from tbl_student_1; -- 10003
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
 /*
   ----------------------------------------------------------------------- 
    index_name                  uniqueness      column_name    descend
   ----------------------------------------------------------------------- 
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	       ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	       ASC
   ----------------------------------------------------------------------- 
 */
 
    -- ==== *** SQL*Developer 에서 Plan(실행계획) 확인하는 방법 *** ==== --
    /*
      select 문이 실행될 때 인덱스를 사용하여 데이터를 얻어오는지 인덱스를 사용하지 않고 
      Table Full Scan 하여 얻어오는지 알아봐야 한다.
      이럴때 사용하는 것이 SQL Plan(실행계획)이다. 
      
      SQL*Developer 에서는 "SQL편집창(SQL 워크시트)"에 Plan(실행계획) 과 Trace(자동추적) 메뉴가 상단에 있다.
      
      Plan(실행계획) 과 Trace(자동추적) 의 차이는,
      Plan(실행계획) 은 SQL을 실행하기 전에 Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행할지를 미리 알려주는 것이고,
      Trace(자동추적) 는 SQL을 실행해보고, Oracle Optimizer(옵티마이저, 최적화기)가 SQL을 어떻게 실행했는지 그 결과를 알려주는 것이다.

      그러므로, 정확도로 말하자면, Trace(자동추적)가 Plan(실행계획) 보다 훨씬 정확한 것이다.
      Plan(실행계획) 은 말그대로 계획이라서 Oracle Optimizer가 계획은 그렇게 세우긴 했으나 
      실제 실행할때는 여러가지 이유로 다르게 실행할 수도 있기 때문이다.
      그래서 Trace(자동추적)가 정확하기는 하나 Trace(자동추적)는 한번 실행해봐야 하는것이라서 
      시간이 오래 걸리는 SQL인 경우에는 한참 기다려야 하는 단점이 있기는 하다.
   */       
    
    
   /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 3번째 아이콘( 계획 설명... (F10) )을 클릭하면 현재 SQL의 Plan(실행계획)을 아래에 보여준다.
      COST(비용)의 값이 적을 수록 속도가 빠른 것이다.
   */ 
    
    
    select *
    from tbl_student_1
    where hakbun = '20220120-6789'; -- unique 한 인덱스 IDX_TBL_STUDENT_1_HAKBUN 를 사용하여 빠르게 조회해옴.
    
    -- 예시
    --    '20220120-6789' -- 'rowid'
        
    --    '이순신'  -- 148페이지
    
    select *
    from tbl_student_1
    where name = '이순신5783'; -- non-unique 한 인덱스 IDX_TBL_STUDENT_1_NAME 을 사용하여 빠르게 조회해옴.
    
    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 3987';  --> address 컬럼에는 인덱스가 없으므로 tbl_student_1 테이블에 있는 모든 데이터를 조회해서 
                                    --  address 컬럼의 값이  '서울시 마포구 월드컵로 3987' 인 데이터를 가져온다.
                                    --  이와 같이 인덱스를 사용하지 않고 데이터를 조회해올 때를 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회) 이라고 부른다.
                                    --  Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)이 속도가 가장 느린 것이다.
                                    
    select *
    from tbl_student_1
    where email = 'leess2654@gmail.com';  -- email 컬럼에는 인덱스가 없으므로 Table Full-scan(인덱스를 사용하지 않고 테이블 전체 조회)하여 조회해 오는 것임.
    
    
    -----------------------------------------------------------------------------------------------------------
    -- *** Trace(자동추적)을 하기 위해서는 SYS 또는 SYSTEM 으로 부터 권한을 부여 받은 후 HR은 재접속을 해야 한다. *** --
    show user;
    -- USER이(가) "SYS"입니다.
    
    grant SELECT_CATALOG_ROLE to HR;
    -- Grant을(를) 성공했습니다.
    
    grant SELECT ANY DICTIONARY to HR;
    -- Grant을(를) 성공했습니다.
    -----------------------------------------------------------------------------------------------------------
    
    /* 
      실행해야할 SQL문을 블럭으로 잡은 후에
      "SQL 워크시트" 의 상단 아이콘들중에 4번째 아이콘( 자동 추적... (F6) )을 클릭하면 현재 SQL의 Trace(자동추적)을 아래에 보여준다.
      
      Trace(자동추적)을 하면 Plan(실행계획) 도 나오고, 동시에 아래쪽에 통계정보도 같이 나온다.

      오른쪽에 Plan(실행계획)에서는 보이지 않던 LAST_CR_BUFFER_GETS 와 LAST_ELAPSED_TIME 컬럼이 나온다.
      LAST_CR_BUFFER_GETS 는 SQL을 실행하면서 각 단계에서 읽어온 블록(Block) 갯수를 말하는 것이고,
      LAST_ELAPSED_TIME 은 경과시간 정보이다.
      즉, 이 정보를 통해서 어느 구간에서 시간이 많이 걸렸는지를 확인할 수 있으므로, 이 부분의 값이 적게 나오도록 SQL 튜닝을 하게 된다.
    */
    
    
    
    ---- *** DML(insert, update, delete)이 빈번하게 발생하는 테이블에 index가 생성되어 있으면
    ---      DML(insert, update, delete) 작업으로 인해 Index 에 나쁜 결과를 초래하므로  
    ---      index 가 많다고 해서 결코 좋은 것이 아니기에 테이블당 index 의 개수는 최소한의 개수로 만드는 것이 좋다.
    
    ---- *** index 가 생성되어진 테이블에 insert 를 하면 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     index 가 없을시 보다 insert 의 속도가 떨어지게 된다.
    ----     그러므로 index 가 많다고 결코 좋은 것이 아니므로 최소한의 개수로 index 를 만드는 것이 좋다.
    ----     Index Split(인덱스 쪼개짐)란 Index 의 block(블럭)들이 1개에서 2개로 나뉘어지는 현상을 말한다.
    ----     Index Split(인덱스 쪼개짐)이 발생하는 이유는 Index 는 정렬이 되어 저장되기 때문에 
    ---      Index 의 마지막 부분에 추가되는 것이 아니라 정렬로 인해 중간 자리에 끼워들어가는 현상이
    ----     발생할 수 있기 때문이다. 
    
    
    ---- *** index 가 생성되어진 테이블에 delete 를 하면 테이블의 데이터는 삭제가 되어지지만 
    ----     Index 자리에는 데이터는 삭제되지 않고서 사용을 안한다는 표시만 하게 된다.
    ----     그래서 10만 건이 들어있던 테이블에 9만건의 데이터를 delete 를 하면 테이블에는 데이터가 삭제되어 지지만
    ----     Index 자리에는 10만 건의 정보가 그대로 있고 1만건만 사용하고 9만건은 사용되지 않은채로 되어있기에
    ----     사용하지 않는 9만건의 Index 정보로 인해서 index를 사용해서 select를 해올 때 index 검색속도가 떨어지게 된다.   
    ----     이러한 경우 Index Rebuild 작업을 해주어 사용하지 않는 9만건의 index 정보를 삭제해주어야만 
    ----     select를 해올 때 index 검색속도가 빨라지게 된다. 
    
    
    ---- *** index 가 생성되어진 테이블에 update 를 하면 테이블의 데이터는 "수정" 되어지지만 
    ----     Index 는 "수정" 이라는 작업은 없고 index 를 delete 를 하고 새로이 insert 를 해준다.
    ----     그러므로 index 를 delete 할 때 발생하는 단점 및 index 를 insert 를 할 때 발생하는 Index Split(인덱스 쪼개짐) 가 발생하므로
    ----     Index 에는 최악의 상황을 맞게 된다. 
    ----     이로 인해 테이블의 데이터를 update를 빈번하게 발생시켜 버리면 select를 해올 때 index 검색속도가 현저히 느려지게 된다. 
    ----     이러한 경우도 select를 해올 때 index 검색속도가 빨라지게끔 Index Rebuild 작업을 해주어야 한다.       
    
    ---- **** Index(인덱스)의 상태 확인하기 **** ----
    -- analyze index 인덱스명 validate structure;
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.
    
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
              0          <== 0 에 가까울 수록 인덱스 상태가 좋은 것이다.
    */
    
    select count(*)
    from tbl_student_1;  
    -- 10003
    
    delete from tbl_student_1
    where hakbun between '20220120-400' and '20220120-9400';
    -- 6,001개 행 이(가) 삭제되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select count(*)
    from tbl_student_1; 
    -- 4002
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
              0          <== delete 하기 전의 index를 분석한 것이므로 0 이라고 나올 뿐이다. 
    */

    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
       59.99108333467217197114534967787542374243   <== 인덱스 밸런스가 대략 60% 정도가 깨진 것이다.        
    */
    
    update tbl_student_1 set name = '홍길동' 
    where hakbun between '20220120-9401' and '20220120-9901'
    
    commit;
    -- 커밋 완료.
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다.    
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
       60.69211438160277846127781789138668936335   <== 인덱스 밸런스가 대략 60% 정도가 깨진 것이다.        
    */
    
    
    
    ----- *** ==== Index Rebuild(인덱스 재건축) 하기 ==== *** -----
    -- 인덱스 밸런스가 대략 60% 정도 깨진 IDX_TBL_STUDENT_1_NAME 을 Index Rebuild(인덱스 재건축) 하겠습니다. --
    -- alter index 인덱스명 rebuild;
    
    alter index IDX_TBL_STUDENT_1_NAME rebuild;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 변경되었습니다.
    
    analyze index IDX_TBL_STUDENT_1_NAME validate structure;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 분석되었습니다. 
    
    select (del_lf_rows_len / lf_rows_len) * 100 "인덱스상태(Balance)"
    from index_stats
    where name = 'IDX_TBL_STUDENT_1_NAME';
    
    /*
       인덱스상태(Balance)
       ------------------
               0              <== 0에 가까울 수록 인덱스 상태가 좋은 것이다.        
     ==> 인덱스를  rebuild 해서 0으로 돌아왔다.
    */
    
    
    ----- *** index 삭제하기 *** -------
    -- drop index 삭제할인덱스명;
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
 /*
   ----------------------------------------------------------------------- 
    index_name                  uniqueness      column_name    descend
   ----------------------------------------------------------------------- 
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	       ASC
    IDX_TBL_STUDENT_1_NAME	    NONUNIQUE	    NAME	       ASC
   ----------------------------------------------------------------------- 
 */
    
    
    drop index IDX_TBL_STUDENT_1_NAME;
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 삭제되었습니다.
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
 /*
   ----------------------------------------------------------------------- 
    index_name                  uniqueness      column_name    descend
   ----------------------------------------------------------------------- 
    IDX_TBL_STUDENT_1_HAKBUN	UNIQUE	        HAKBUN	       ASC
   ----------------------------------------------------------------------- 
 */
    
    drop index IDX_TBL_STUDENT_1_HAKBUN;
    -- Index IDX_TBL_STUDENT_1_HAKBUN이(가) 삭제되었습니다.
    
    select A.index_name, uniqueness, column_name, descend
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- 없음 
    
    select *
    from tbl_student_1
    -- 인덱스는 삭제했지만 테이블은 존재한다. 즉, 인덱스만 삭제되어진다. 
    
    
    -- 2022-01-20 -- 
    ------ **** !!!!! 복합인덱스(Composite index) 생성하기 !!!!! **** -------
    -- 복합인덱스(composite index)란? 
    -- 2개 이상의 컬럼으로 묶어진 인덱스를 말하는 것으로서
    -- where 절에 2개의 컬럼이 사용될 경우 각각 1개 컬럼마다 각각의 인덱스를 만들어서 사용하는 것보다
    -- 2개의 컬럼을 묶어서 하나의 인덱스로 만들어 사용하는 것이 속도가 좀 더 빠르다.
    
    select *
    from tbl_student_1
    where name = '배수지10001' and address = '서울시 마포구 월드컵로 10001';
    
    -- !!!!  중요  !!!! --
    -- 복합인덱스(composite index) 생성시 중요한 것은 선행컬럼을 정하는 것이다.
    -- 선행컬럼은 맨처음에 나오는 것으로 아래에서는 name 이 선행컬럼이 된다.
    -- 복합인덱스(composite index)로 사용되는 컬럼중 선행컬럼으로 선정되는 기준은 where 절에 가장 많이 사용되는 것이며 
    -- 선택도(selectivity)가 높은 컬럼이 선행컬럼으로 선정되어야 한다.
    
    create index idx_tbl_student_1_name_addr
    on tbl_student_1(name, address); -- name 컬럼이 선행컬럼이 된다. 
    -- Index IDX_TBL_STUDENT_1_NAME_ADDR이(가) 생성되었습니다.
    
  /*
    create index idx_tbl_student_1_name_addr
    on tbl_student_1(address, name ); -- address 컬럼이 선행컬럼이 된다. 
  */
    
    select A.index_name, uniqueness, column_name, descend
         , B.column_position
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
 /*
    --------------------------------------------------------------------------------
    index_name                  uniqueness  coiumn_name  descend   column_position
    --------------------------------------------------------------------------------
    IDX_TBL_STUDENT_1_NAME_ADDR	NONUNIQUE	NAME	     ASC	    1(숫자 1이 선행컬럼)
    IDX_TBL_STUDENT_1_NAME_ADDR	NONUNIQUE	ADDRESS	     ASC	    2
    --------------------------------------------------------------------------------
 */
    
    select *
    from tbl_student_1
    where name = '배수지10001' and address = '서울시 마포구 월드컵로 10001';
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.
    
    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001' and name = '배수지10001';
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.
    
    select *
    from tbl_student_1
    where name = '배수지10001';
    -- where 절에 선행컬럼인 name 이 사용되어지면 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하여 빨리 조회해온다.
    
    select *
    from tbl_student_1
    where address = '서울시 마포구 월드컵로 10001';
    -- where 절에 선행컬럼이 없으므로 복합인덱스(composite index)인 IDX_TBL_STUDENT_1_NAME_ADDR 을 사용하지 못하고 Table Full Scan 하여 조회해오므로 속도가 떨어진다.
    
    create table tbl_member
    (userid      varchar2(20)
    ,passwd      varchar2(30) not null
    ,name        varchar2(20) not null 
    ,address     varchar2(100)
    ,email       varchar2(50) not null 
    ,constraint  PK_tbl_member_userid primary key(userid)
    ,constraint  UQ_tbl_member_email unique(email)
    );
    -- Table TBL_MEMBER이(가) 생성되었습니다.
    
    declare 
         v_cnt  number := 1;  
    begin
         loop
             exit when v_cnt > 10000;
             
             insert into tbl_member(userid, passwd, name, address, email)
             values('hongkd'||v_cnt, 'qwer1234$', '홍길동'||v_cnt, '서울시 마포구 '||v_cnt, 'hongkd'||v_cnt||'@gmail.com');
             
             v_cnt := v_cnt + 1;
         end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    commit;
    -- 커밋 완료.
    
    select *
    from tbl_member
    
    --- 로그인을 하는데 로그인이 성공되어지면 그 회원의 성명만을 보여주도록 한다.
    
    select name
    from tbl_member
    where userid = 'hongkd5001' and passwd = 'qwer1234$';
    
    --- **** userid, passwd, name 컬럼을 가지고 복합인덱스(composite index)를 생성해 봅니다. **** ---
    
    create index idx_tbl_member_id_pwd_name
    on tbl_member(userid, passwd, name );
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 생성되었습니다.
    
    select name
    from tbl_member
    where userid = 'hongkd5001' and passwd = 'qwer1234$';
    -- where 절 및 select 에 복합인덱스(composite index)인 IDX_TBL_MEMBER_ID_PWD_NAME 에 사용되어진 컬럼만 있으므로
    -- 테이블 tbl_member 에는 접근하지 않고 인덱스 IDX_TBL_MEMBER_ID_PWD_NAME 에만 접근해서 조회하므로 속도가 빨라진다.
    
    
    select name, address
    from tbl_member
    where userod = 'hongkd5001' and passwd = 'qwer1234$';
    
    drop index idx_tbl_member_id_pwd_name;
    -- Index IDX_TBL_MEMBER_ID_PWD_NAME이(가) 삭제되었습니다.
    
    
    
    
    
    
    
    ------ **** 함수기반 인덱스(function based index) 생성하기 **** -------
    
    drop index IDX_TBL_STUDENT_1_NAME_ADDR;
    -- Index IDX_TBL_STUDENT_1_NAME_ADDR이(가) 삭제되었습니다.
    
    
    select A.index_name, uniqueness, column_name, descend
         , B.column_position
    from user_indexes A join user_ind_columns B
    on A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_1';
    -- 생성되어진 index가 없습니다. 
    
    create index idx_tbl_student_1_name
    on tbl_student_1(name);
    -- Index IDX_TBL_STUDENT_1_NAME이(가) 생성되었습니다.
    
    select *
    from TBL_STUDENT_1
    where name = '배수지10003';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다. 
    
    select *
    from tbl_student_1
    where substr(name, 2, 2) = '수지';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고, table Full Scan 하여 조회해온다.
    
    select *
    from TBL_STUDENT_1
    where name||'A' = '배수지10003A';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고, table Full Scan 하여 조회해온다.
    
    create index idx_func_student_1_name
    on tbl_student_1( substr(name,2,2 ) );  -- 함수기반 인덱스(function based index)
    -- Index IDX_FUNC_STUDENT_1_NAME이(가) 생성되었습니다.

    create index idx_func_age_jubun
    on employees(func_age(jubun));
    /*
      오류 보고 -
      ORA-30553: The function is not deterministic
      
      func_age(jubun) 함수내에 sysdate 가 사용되어지므로 년도가 바뀌면 나이도 변경되어지므로 
      인덱스로 만들수가 없다. 즉, 매번 값이 변동되어지는 sysdate는 인덱스로 생성이 불가하다. 
    */
    
    select *
    from tbl_student_1
    where substr(name,2,2) = '수지';
    -- 함수기반 인덱스인 Index IDX_FUNC_STUDENT_1_NAME 을 사용하여 조회해온다. 
    
    drop index IDX_FUNC_STUDENT_1_NAME;
    -- Index IDX_FUNC_STUDENT_1_NAME이(가) 삭제되었습니다.
    
    select *
    from TBL_STUDENT_1
    where name = '배수지10003';
    -- IDX_TBL_STUDENT_1_NAME 인덱스를 사용하여 조회해온다. 
    
    select *
    from TBL_STUDENT_1
    where name like '%배수지%';
    -- 맨 앞에 % 또는 _ 가 나오면 IDX_TBL_STUDENT_1_NAME 인덱스를 사용하지 않고,
    -- Table Full Scan 하여 조회해온다. 
    
    
    --- **** 어떤 테이블의 어떤 컬럼에 Primary Key 제약 또는 Unique 제약을 주면
    --       자동적으로 그 컬럼에는 unique 한 index가 생성되어진다.
    --       인덱스명은 제약조건명이 된다. **** 
    
    create table tbl_student_2
    (hakbun      varchar2(10) 
    ,name        varchar2(20)
    ,email       varchar2(20) not null
    ,address     varchar2(20)
    ,constraint PK_tbl_student_2_hakbun primary key(hakbun)
    ,constraint UQ_tbl_student_2_email unique(email)
    );
    -- Table TBL_STUDENT_2이(가) 생성되었습니다.
    
    select A.index_name, uniqueness, column_name, descend 
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_2';
    
    
    -- Primary Key 제약 또는 Unique 제약으로 생성되어진 index 의 제거는 
    -- drop index index명; 이 아니라
    -- alter table 테이블명 drop constraint 제약조건명; 이다.
    -- 제약조건을 삭제하면 자동적으로 index 도 삭제가 된다.

    drop index PK_tbl_student_2_hakbun;
/*
    오류 보고 -
    ORA-02429: cannot drop index used for enforcement of unique/primary key  
    -- unique/primary key 가 사용되어지면 삭제할 수 없다.
*/

    alter table tbl_student_2
    drop primary key;
    -- Table TBL_STUDENT_2이(가) 변경되었습니다. / 제약조건을 삭제하면 자동적으로 인덱스가 삭제되어진다.
    
    alter table tbl_student_2
    drop constraint UQ_tbl_student_2_email;
    -- Table TBL_STUDENT_2이(가) 변경되었습니다.


    select A.constraint_name, A.constraint_type, A.search_condition, 
           B.column_name, B.position 
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where A.table_name = 'TBL_STUDENT_2';
    -- 제약조건 검색
    
    select A.index_name, uniqueness, column_name, descend 
    from user_indexes A JOIN user_ind_columns B
    ON A.index_name = B.index_name
    where A.table_name = 'TBL_STUDENT_2';
    -- 인덱스 조회 
    
    
    
    
    
    
    
    
    
    
    
    ----- ====== **** 데이터사전( Data Dictionary) **** ======= --------
    
    ---- **** ORACLE DATA DICTIONARY VIEW(오라클 데이터 사전 뷰) **** ----
    
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from dictionary;
    -- 또는 
    
    select *
    from dict;
    /*
        USER_CONS_COLUMNS
        ALL_CONS_COLUMNS
    */
    
    select *
    from dba_tables;
    
    select *
    from dba_tables
    where owner = 'HR'
    
    --------------------------------------------------------------------------------- 
    -- ===== sys 로 접속한 것 시작 ===== --
    show user;
    -- USER이(가) "SYS"입니다.
    
    select *
    from dictionary;
    -- 또는 
    
    select *
    from dict;
    /*
        USER_CONS_COLUMNS
        ALL_CONS_COLUMNS
        DBA_CONS_COLUMNS
    */
    /*
     DBA_로 시작하는 것 
     ==> 관리자만 조회가능한 것으로 모든오라클사용자정보, 모든테이블, 모든인덱스, 모든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
     
     USER_로 시작하는 것 
     ==> 오라클서버에 접속한 사용자 소유의 자신의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것.
     
     ALL_로 시작하는 것 
     ==> 오라클서버에 접속한 사용자 소유의 즉, 자신의오라클사용자정보, 자신이만든테이블, 자신이만든인덱스, 자신이만든데이터베이스링크 등등등 의 정보가 다 들어있는 것
         과(와)
         자신의 것은 아니지만 조회가 가능한 다른사용자의오라클사용자정보, 다른사용자소유의테이블, 다른사용자소유의인덱스, 다른사용자소유의데이터베이스링크 등등등 의 정보가 다 들어있는 것. 
    */
    
    
    -- ===== sys 로 접속한 것 끝 ===== --
    -------------------------------------------------------------------------------
 
    -- ===== HR 로 접속한 것 ===== --
    show user;
    -- USER이(가) "HR"입니다.
    
    select *
    from dba_tables;
    -- ORA-00942: table or view does not exist
    
    select *
    from user_tables; -- 본인이 만든 것이므로 owner 테이블이 없다.
    
    select *
    from all_tables; -- 내 것은 아니지만 접근 할 수 있는 것 
    
    -- *** 자신이 만든 테이블에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where TABLE_NAME like 'USER_%' and lower(comments) like '%table%'; 
    
    select *
    from user_tables;
    
    -- *** USER_TABLES 에서 보여지는 컬럼에 대한 설명을 보고 싶으면 아래와 같이하면 됩니다. *** --
    
    select *
    from dict_columns
    Where table_name = 'USER_TABLES';
    
    -- *** 자신이 만든 테이블의 컬럼에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where TABLE_NAME like 'USER_%' and lower(comments) like '%column%'; 
    
    select *
    from USER_TAB_COLUMNS
    where table_name = 'TBL_JIKWON'
    
    -- ** TBL_JIKWON 테이블의 jik컬럼에 default 를 '대리'로 변경하려고 한다.** --
    alter table TBL_JIKWON modify jik default '대리'; -- 디폴트가 대리로 변경
 
    -- ** TBL_JIKWON 테이블의 jik컬럼에 default 를 삭제 ** -- 
    alter table TBL_JIKWON modify jik default null; -- 디폴트가 없다
    
    -- ** TBL_JIKWON 테이블의 jik컬럼에 default 를 복구 ** --
    alter table TBL_JIKWON modify jik default '사원'; --원래대로 복원 
    
    
    
    -- *** 자신이 만든 테이블의 제약조건에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where TABLE_NAME like 'USER_%' and lower(comments) like '%constraint%'; 
 
    select *
    from  USER_CONSTRAINTS
    where table_name = 'EMPLOYEES'
    
    select constraint_name, column_name, position
    from  USER_CONS_COLUMNS
    where table_name = 'EMPLOYEES'
 
    
 
    -- *** 자신이 만든 데이터베이스 링크에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    
    select *
    from dict
    where TABLE_NAME like 'USER_%' and lower(comments) like '%database link%'; 
 
    select *
    from USER_DB_LINKS;
 
    -- *** 자신이 만든 시퀀스에 대한 모든 정보를 조회하고 싶다. 어디서 보면 될까요? *** ---
    select *
    from dict
    where TABLE_NAME like 'USER_%' and lower(comments) like '%sequence%';
 
    select *
    from USER_SEQUENCES;
    
    
    ----------------------------------------------------------------------------
    
    ----- *** PL/SQL(Procedure Language / Structured Query Language) *** -----
    
    ---- *** PL/SQL 구문에서 변수의 사용법 *** -----
    -- 프로시저를 쓰는 이유 : 속도의 향상 
    
    execute pcd_empInfo(101);
    /*
        <결과물>
        ---------------------------------------------
          사원번호     사원명     성별      월급  
        ---------------------------------------------
            101       .....     ....     ......
    */
 
 
    exec pcd_empInfo(103);
    /*
        <결과물>
        ---------------------------------------------
          사원번호     사원명     성별      월급  
        ---------------------------------------------
            103       .....     ....     ......
    */
    
    select lpad('-',40,'-')
    from dual;
    
    select rpad('-',40,'-')
    from dual;

    create or replace procedure pcd_empInfo
    (p_employee_id IN number)    -- 파라미터에는 3가지 모드가 있다. IN, OUT, IN OUT 모드 이다.
                                     -- IN 은 입력모드를 말한다.
                                     -- IN 만큼은 생략가능하다. , OUT, IN OUT은 반드시 붙여줘야한다. (생략 불가능)  
                                     -- 중요한 것은 파라미터에 설정된 데이터 타입은 원형만 사용해야지 자리수를 표현하면 오류!! 이다. 
                                     -- 예>  p_employee_id number(5) 이렇게 하면 오류이다.
    
    is  
        -- 변수의 선언부
        V_employee_id   number(5);  --- 자리수를 사용한다.
        V_ename         varchar2(50);
        V_gender        varchar2(10); 
        V_monthsal      varchar2(15);
    begin
        -- 실행부
        select employee_id, first_name || ' ' || last_name,
               case when substr(jubun,7,1) in('1','3') then '남' else '여' end,
               to_char(nvl(salary+(salary*commission_pct),salary), '$9,999,999')
               INTO 
               V_employee_id, V_ename, V_gender, V_monthsal
        from employees
        where employee_id = p_employee_id;
        
        dbms_output.put_line( lpad('-',40,'-' ));
        dbms_output.put_line('사원번호     사원명     성별      월급'    );
        dbms_output.put_line( lpad('-',40,'-' ));
        
        dbms_output.put_line( V_employee_id|| ' ' || V_ename|| ' ' || V_gender|| ' ' || V_monthsal );
    
    end pcd_empInfo;
    -- Procedure PCD_EMPINFO이(가) 컴파일되었습니다.
 
    /* === SQL Developer 의 메뉴의 보기를 클릭하여 DBMS 출력을 클릭해주어야 한다. ===
       === 이어서 하단부에 나오는 DBMS 출력 부분의 녹색 + 기호를 클릭하여 local_hr 로 연결을 해준다. === 
    */
 
 
   create or replace procedure pcd_empInfo
   (p_employee_id IN number) 
   is
      v_employee_id   number(5);    
      v_ename         varchar2(50); 
      v_gender        varchar2(10);
      v_monthsal      varchar2(15);
      v_age           number(3);
   begin
      select employee_id, first_name || ' ' || last_name,
             case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end,
             to_char( nvl(salary +(salary*commission_pct), salary), '$9,999,999'),
             extract (year from sysdate) - (case when substr(jubun,7,1) in ('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2) )) + 1
             INTO 
             v_employee_id, v_ename, v_gender, v_monthsal, V_age
      from employees
      where employee_id = p_employee_id;
   
      dbms_output.put_line( lpad('-',40,'-') );
      dbms_output.put_line('사원번호   사원명   성별   월급   나이');
      dbms_output.put_line( lpad('-',40,'-') );
      
      dbms_output.put_line( v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal|| v_age );
   
   end pcd_empInfo;
   
    exec pcd_empInfo(101);
    
    
    
    ------ **** 생성되어진 프로시저의 소스를 조회해봅니다. **** -------
    select text
    from user_source
    where type = 'PROCEDURE' and name = 'PCD_EMPINFO';
/*    
"procedure pcd_empInfo
"
"   (p_employee_id IN number) 
"
"   is
"
"      v_employee_id   number(5);    
"
"      v_ename         varchar2(50); 
"
"      v_gender        varchar2(10);
"
"      v_monthsal      varchar2(15);
"
"   begin
"
"      select employee_id, first_name || ' ' || last_name,
"
"             case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end,
"
"             to_char( nvl(salary +(salary*commission_pct), salary), '$9,999,999')
"
"             INTO 
"
"             v_employee_id, v_ename, v_gender, v_monthsal
"
"      from employees
"
"      where employee_id = p_employee_id;
"
"
"
"      dbms_output.put_line( lpad('-',40,'-') );
"
"      dbms_output.put_line('사원번호   사원명   성별   월급');
"
"      dbms_output.put_line( lpad('-',40,'-') );
"
"
"
"      dbms_output.put_line( v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal );
"
"
"
"   end pcd_empInfo;
"
*/
  
  
  
   create or replace procedure pcd_empInfo_2
   (p_employee_id IN employees.employee_id%type ) -- p_employeeid 변수의 타입은 employees 테이블에 있는 employee_id 컬럼의 데이터타입과 동일하게 쓰겠다는 말이다. 
   is
      v_employee_id   employees.employee_id%type;    
      v_ename         varchar2(50); 
      v_gender        varchar2(10);
      v_monthsal      varchar2(15);
      v_age           number(3);
   begin
      select employee_id, 
             first_name || ' ' || last_name,
             case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end,
             to_char( nvl(salary +(salary*commission_pct), salary), '$9,999,999'),
             extract (year from sysdate) - (case when substr(jubun,7,1) in ('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2) )) + 1
             
             INTO 
             v_employee_id, v_ename, v_gender, v_monthsal, V_age
      from employees
      where employee_id = p_employee_id;
   
      dbms_output.put_line( lpad('-',50,'-') );
      dbms_output.put_line('사원번호   사원명   성별   월급   나이 ');
      dbms_output.put_line( lpad('-',50,'-') );
      
      dbms_output.put_line( v_employee_id || ' ' || v_ename || ' ' || v_gender || ' ' || v_monthsal || ' ' || v_age);
   
   end pcd_empInfo_2;
 
 
    exec pcd_empinfo_2(105);
 
 -----------------------------
    create or replace procedure pcd_empInfo_3
   (p_employee_id IN employees.employee_id%type) -- p_employeeid 변수의 타입은 employees 테이블에 있는 employee_id 컬럼의 데이터타입과 동일하게 쓰겠다는 말이다. 
   is
    -- record 타입 생성 --
    type myEmpType is record
    (  employee_id   employees.employee_id%type    
      ,ename         varchar2(50) 
      ,gender        varchar2(10)
      ,monthsal      varchar2(15)
      ,age           number(3)
     );
     v_rcd myEmpType;
   begin
      select employee_id, first_name || ' ' || last_name,
             case when substr(jubun, 7, 1) in('1','3') then '남' else '여' end,
             to_char( nvl(salary +(salary*commission_pct), salary), '$9,999,999'),
             extract (year from sysdate) - (case when substr(jubun,7,1) in ('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2) )) + 1
             INTO
             v_rcd
      from employees
      where employee_id = p_employee_id;
   
      dbms_output.put_line( lpad('-',50,'-') );
      dbms_output.put_line('사원번호   사원명   성별   월급');
      dbms_output.put_line( lpad('-',50,'-') );
      
      dbms_output.put_line( v_rcd.employee_id || ' ' || v_rcd.ename || ' ' || v_rcd.gender || ' ' || v_rcd.monthsal || ' ' || v_rcd.age );
   
   end pcd_empInfo_3;
    
    exec pcd_empinfo_2(106);
 
 
 
    create or replace procedure pcd_empInfo_4
   (p_employee_id IN employees.employee_id%type) 
   is
      v_all  employees%rowtype; -- -- v_all 변수의 타입은 employees 테이블의 모든 컬럼을 받아주는 행타입이다. 
      v_result varchar2(1000);
   begin
      select * INTO v_all
      from employees
      where employee_id = p_employee_id;
      
      v_result := v_all.employee_id || ' ' || 
                  v_all.first_name || ' ' || v_all.last_name || ' ' ||
                  case when substr(v_all.jubun, 7, 1) in('1','3') then '남' else '여' end || ' ' ||
                  to_char( nvl(v_all.salary +(v_all.salary*v_all.commission_pct), v_all.salary), '$9,999,999')|| ' ' ||
                  ( extract (year from sysdate) - (case when substr(v_all.jubun,7,1) in ('1','2') then 1900 else 2000 end + to_number(substr(v_all.jubun,1,2) )) + 1 );
   
      dbms_output.put_line( lpad('-',50,'-') );
      dbms_output.put_line('사원번호   사원명   성별   월급   나이');
      dbms_output.put_line( lpad('-',50,'-') );
      
      dbms_output.put_line( v_result );
    
   end pcd_empInfo_4;
 
    exec pcd_empinfo_4(107);
/*
    --------------------------------------------------
    사원번호   사원명   성별   월급   나이
    --------------------------------------------------
    107 Diana Lorentz 남      $4,200 15
*/
























    -----------------------------------------------------------------------------------------
                  ------- **** 사용자 정의 함수 **** -------
    -----------------------------------------------------------------------------------------           
   
   ----  주민번호를 입력받아서 성별을 알려주는 함수 func_gender(주민번호)을 생성해보겠습니다. ----
   /*
      [문법]
      create or replace function 함수명 
      (파라미터변수명  IN  파라미터변수의타입)
      return 리턴되어질타입
      is
         변수선언;
      begin
         실행문;
         return 리턴되어질값;
      end 함수명;
   */
    
    create or replace function func_gender
    (P_jubun IN varchar2)  -- varchar2(13) 과 같이 자리수를 쓰면 오류이다. !!
    return varchar2    -- varchar2(6) 와 같리 자리수를 쓰면 오류이다. !!
    is
        v_result varchar2(6); -- 여기는 varchar2(6) 와 같이 자리수를 써야한다. 
    begin
        select case when substr(p_jubun, 7, 1) in ('1', '3') then '남' else '여' end
                Into 
                v_result
        from dual;
        
        return v_result;
    end func_gender;
    
    select func_gender('9504221234567'),
           func_gender('9504222234567'),
           func_gender('0504223234567'),
           func_gender('0504224234567')
    from dual;
 
    
    
    create or replace function func_age
   (p_jubun  IN  varchar2)   
   return number           
   is
      v_result  number(3);
   begin
        select extract(year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1
               INTO
               v_result
        from dual;
   
        return v_result;
   end func_age;
   
   
   
   create or replace function func_gender_2
    (P_jubun IN varchar2)  
    return varchar2    
    is
        v_result varchar2(6);
    begin
        v_result := case when substr(p_jubun, 7, 1) in('1','3') then '남' else '여' end ;
        return v_result;
    end func_gender_2;
    
   create or replace function func_age_2
    (p_jubun  IN  varchar2)   
    return number           
   is
       v_result  number(3);
   begin
        v_result := extract(year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1;
        return v_result;
   end func_age_2;
   
   
   
   
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , jubun as 주민번호
         , func_gender(jubun) as 성별1
         , func_gender_2(jubun) as 성별2
         , func_age(jubun) as 나이1
         , func_age_2(jubun) as 나이2
    from employees;
 
    --- employees 테이블에서 25세 이상 35세 이하인 여자만 
    -- 사원번호, 사원명, 주민번호, 나이, 성별을 나타내세요.
    
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , jubun as 주민번호
         , func_gender(jubun) as 성별
         , func_age(jubun) as 나이
    from employees
    where func_age(jubun) between 25 and 35 AND 
          func_gender(jubun) = '여';  
 
 
    -- employees 테이블에서 연령대별, 성별 인원수와 퍼센티지를 나타내세요.
    
    select trunc(func_age(jubun),-1) as 연령대
         , func_gender(jubun) as 성별
         , count(*) as 인원수
         , round(count(*) / (select count(*) from employees) * 100 , 1) as 퍼센티지
    from employees
    group by  trunc(func_age(jubun),-1), func_gender(jubun)
    order by 1;
 
    select NVL(to_char(trunc(func_age(jubun),-1)), ' ') as 연령대
         , NVL(func_gender(jubun), ' ') as 성별
         , count(*) as 인원수
         , round(count(*) / (select count(*) from employees) * 100 , 1) as 퍼센티지
    from employees
    group by  rollup(trunc(func_age(jubun),-1), func_gender(jubun))
    
    
    
    
    ----- *** === 생성되어진 함수의 소스를 조회해봅니다. === *** ------
    
    select line, text
    from USER_SOURCE
    where type= 'FUNCTION' and name = 'FUNC_AGE'
 
 /*
"function func_age
"
"   (p_jubun  IN  varchar2)   
"
"   return number           
"
"   is
"
"      v_result  number(3);
"
"   begin
"
"        select extract(year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1
"
"               INTO
"
"               v_result
"
"        from dual;
"
"
"
"        return v_result;
"
   end func_age;
 */
 
 
    
    
    
    
    
    ---- [퀴즈] 아래와 같은 결과물이 나오도록 프로시저( pcd_employees_info )를 생성하세요...
   ----       성별과 나이는 위에서 만든 함수를 사용하세요..
   
   execute pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다. 
   exec    pcd_employees_info(101);  -- 여기서 숫자 101은 사원번호이다.
   
   /*
      ----------------------------------------------------
       사원번호    부서명    사원명    입사일자   성별   나이
      ----------------------------------------------------
        101       .....    ......   .......   ....  ....
   */
 
  --****************************************************************
 
   create or replace procedure pcd_employees_info
   (p_employee_id IN employees.employee_id%type) 
   is
      v_employee_id     number(5); 
      v_department_name varchar2(20);
      v_ename           varchar2(50); 
      v_hire_date       employees.hire_date%type;
      v_gender          varchar2(10);
      v_age             number(3);
   begin
      select department_name,
             E.employee_id, 
             E.first_name || ' ' || E.last_name,
             E.hire_date,
             func_gender(E.jubun),
             func_age(E.jubun)
             INTO 
             v_employee_id, v_department_name, v_ename,v_hire_date , v_gender, V_age
      from employees E left join departments D
      on E.department_id = D.department_id
         and employee_id = p_employee_id;
   
      dbms_output.put_line( lpad('-',60,'-') );
      dbms_output.put_line('사원번호    부서명    사원명    입사일자   성별   나이');
      dbms_output.put_line( lpad('-',60,'-') );
      
      dbms_output.put_line( v_employee_id || ' ' || v_department_name || ' ' || v_ename || ' ' || v_hire_date || ' ' || v_gender || ' ' || v_age );
   
   end  pcd_employees_info;
 
    -- 강사님 풀이 
   create or replace procedure pcd_employees_info
   (p_employee_id IN employees.employee_id%type) 
   is
            v_employee_id         employees.employee_id%type;
            v_department_name     departments.department_name%type;
            v_ename               varchar2(40);
            v_hiredate            varchar2(10);
            v_gender              varchar2(6);
            v_age                 number(3);
   begin
      with E AS
      (
        select employee_id
             , first_name || ' ' || last_name as ename
             , to_char(hire_date, 'yyyy-mm-dd') as hiredate
             , func_gender(jubun) as gender
             , func_age(jubun) as age
             , department_id
        from employees
        where employee_id = p_employee_id
      )
      select E.employee_id, D.department_name, E.ename, E.hiredate, E.gender, E.age
           into v_employee_id, v_department_name, v_ename, v_hiredate, v_gender, v_age
      from departments D right join E
      on D.department_id = E.department_id;
        
      dbms_output.put_line( lpad('-',50,'-') );
      dbms_output.put_line('사원번호    부서명    사원명    입사일자   성별   나이');
      dbms_output.put_line( lpad('-',50,'-') );
      
      dbms_output.put_line( v_employee_id || ' ' || v_department_name || ' ' || v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );  
     
   end  pcd_employees_info;
   
   exec    pcd_employees_info(101);
   /*
    --------------------------------------------------
    사원번호    부서명    사원명    입사일자   성별   나이
    --------------------------------------------------
    101 Executive Neena Kochhar 2005-09-21 남 38
   */
   
   
   exec pcd_employees_info(337);  -- 사원번호 337 은 존재하지 않는 사원번호이다. 
 /*
    오류 보고 -
    ORA-01403: no data found  ==> 프로시저에서 데이터(행)가 없으면 no data found 라는 오류가 발생한다.
 */
   
 
-- [데이터(행)가 없을 경우 해결책] --
--> 예외절(Exception) 처리를 해주면 된다. 
 
   create or replace procedure pcd_employees_info
   (p_employee_id IN employees.employee_id%type) 
   is
            v_employee_id         employees.employee_id%type;
            v_department_name     departments.department_name%type;
            v_ename               varchar2(40);
            v_hiredate            varchar2(10);
            v_gender              varchar2(6);
            v_age                 number(3);
   begin
      with E AS
      (
        select employee_id
             , first_name || ' ' || last_name as ename
             , to_char(hire_date, 'yyyy-mm-dd') as hiredate
             , func_gender(jubun) as gender
             , func_age(jubun) as age
             , department_id
        from employees
        where employee_id = p_employee_id
      )
      select E.employee_id, D.department_name, E.ename, E.hiredate, E.gender, E.age
           into v_employee_id, v_department_name, v_ename, v_hiredate, v_gender, v_age
      from departments D right join E
      on D.department_id = E.department_id;
        
      dbms_output.put_line( lpad('-',50,'-') );
      dbms_output.put_line('사원번호    부서명    사원명    입사일자   성별   나이');
      dbms_output.put_line( lpad('-',50,'-') );
      
      dbms_output.put_line( v_employee_id || ' ' || v_department_name || ' ' || v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );  
      
      EXCEPTION
        when no_data_found then  -- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임. 
            dbms_output.put_line('>> 사원번호' || p_employee_id  || '은 존재하지 않습니다. << ');
        
        
   end  pcd_employees_info;
 
   exec pcd_employees_info(337);
   -- >> 사원번호337은 존재하지 않습니다. << 
   
                
                
                
                
                
                ----- ==== **** 제어문(IF문) **** ==== -----  
/*
        ※ 형식 
        
        if      조건1    then  실행문장1; 
        elsif  조건2    then  실행문장2;
        elsif  조건3    then  실행문장3;
        else                  실행문장4;
        end if;
*/
   
   update employees set employee_id = 101
   where employee_id = 102;
   /*
    오류 보고 -
    ORA-00001: unique constraint (HR.EMP_EMP_ID_PK) violated
   */
   
   
   create or replace function func_age_3
    (p_jubun  IN  varchar2)   
    return number           
   is
       v_genderNum     varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다.
       
       v_year          number(4);
       error_jubun  Exception; -- error_jubun 은 사용자가 정의하는 예외절(Exception)임을 선언한다.  
       v_age           number(3);
   begin
        if    length(p_jubun) != 13 then RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;
        if       v_genderNum IN('1','2') then v_year := 1900;
        elsif    v_genderNum IN('3','4') then v_year := 2000;
        else     RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;
    
        v_age := extract(year from sysdate) - ( v_year + to_number(substr(P_jubun,1,2) ) ) + 1 ;
        return v_age;
        
        Exception 
            when error_jubun then 
                 raise_application_error(-20001, '>> 올바르지 않은 주민번호입니다. <<');
                 --     -20001은 오류번호로써, 사용자가 정의해주는 exception 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.  
   end func_age_3;
 
    -- Function FUNC_AGE_3이(가) 컴파일되었습니다.
   
   select '9001192234567', func_age_3('9001192234567')
   from dual;
   
   select '9001190234567', func_age_3('9001190234567')
   from dual;
   -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<
   
   select '900119223456', func_age_3('900119223456')
   from dual;
   -- ORA-20001: >> 올바르지 않은 주민번호 입니다. <<
   
   select '9001192s34567', func_age_3('9001192s34567')
   from dual;
   -- 정상작동?
   -- 9001192s34567	33   33=> 잘못된 주민번호 이더라도 지금은 나이가 나온다. 
   --                         잘못된 주민번호 이므로 오류가 뜨게끔 반복문을 배운다음에 고치도록 한다.
 
    select employee_id as 사원번호
         , first_name || ' ' || last_name as 사원명
         , jubun as 주민번호
         , func_age_3(jubun) as 나이
    from employees;
 
    
 
 
 
 
 
    ---------- ===== **** 반복문 **** ===== ----------
  /*
     반복문에는 종류가 3가지가 있다.
  
     1. 기본 LOOP 문
     2. FOR LOOP 문
     3. WHILE LOOP 문
  */
 
     ----- ====== ****  1. 기본 LOOP 문 **** ====== -----
  /*
      [문법]
      LOOP
          실행문장;
      EXIT WHEN 탈출조건;   -- 탈출조건이 참 이라면 LOOP 를 탈출한다.
      END LOOP;
  */   
  
    create table tbl_looptest_1
    (bunho         number
    ,name          varchar2(50)
    );
    -- Table TBL_LOOPTEST_1이(가) 생성되었습니다.
    
    --- *** tbl_looptest_1 테이블의 행을 20000 개를 insert 해보겠습니다. *** ---
    create or replace procedure pcd_tbl_looptest_1_insert
    (p_name     IN tbl_looptest_1.name%type
    ,p_count    IN number) -- p_count 에 20000 을 넣을 것이다. 
    
    is
        v_bunho  tbl_looptest_1.bunho%type := 0; -- 변수의 초기화 !! (변수에 값을 처음부터 넣어주기) 
        
    begin 
        LOOP
          V_bunho := v_bunho + 1;  -- v_bunho 은 반복할때 마다 1씩 증가한다.  
        
        EXIT WHEN v_bunho > p_count;   -- 20001 > 20000 탈출조건이 참 이라면 LOOP 를 탈출한다.
        
          insert into tbl_looptest_1(bunho,name) values( v_bunho, P_name||v_bunho  ) ;
        
        END LOOP;
    
    end pcd_tbl_looptest_1_insert;
    
    -- Procedure PCD_TBL_LOOPTEST_1_INSERT이(가) 컴파일되었습니다.
    
    
    exec pcd_tbl_looptest_1_insert('이순신',20000);
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1
    
    rollback;
    
    exec pcd_tbl_looptest_1_insert('엄정화',50000);
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
 
 
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1
    
    commit;
 
    exec pcd_tbl_looptest_1_insert('설현',30000);
    --PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;
    -- 80000
    
    commit;
 
    truncate table tbl_looptest_1;
    -- Table TBL_LOOPTEST_1이(가) 잘렸습니다. --> DDL문 오토커밋
 
    select count(*)
    from tbl_looptest_1;
    -- 0개
 
 
    --- **** 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다. **** ---
    
    declare
        V_bunho number := 0;             -- 변수의 선언 및 초기화
    begin
        loop
            V_bunho := v_bunho + 1;  -- v_bunho 은 반복할때 마다 1씩 증가한다.  
            
            exit when v_bunho > 20000;
            
            insert into tbl_looptest_1(bunho,name) values( v_bunho, '이혜리'||v_bunho  ) ;
        end loop;
    end;
    
    
    select count(*)
    from tbl_looptest_1; -- 20000
    
    rollback;
    -- 롤백완료
    
    
    
    
    
    
    ----- ====== ****  2. FOR LOOP 문 **** ====== -----
  /*
      [문법]
      
      for 변수  in  [reverse]  시작값..마지막값  loop  --reverse는 생략가능 reverse의 경우 마지막값에서 시작값으로 자동 감소
          실행문장;
      end loop;
  */
    
    select count(*)
    from tbl_looptest_1; -- 0
    
    --- **** 이름이 없는 익명 프로시저(Anonymous Procedure)로 tbl_looptest_1 테이블에 행을 20000 개를 insert 해보겠습니다. **** ---
    
    begin
        for i in 1..20000 loop -- 변수 i에 맨처음 1 이 들어가고 매번 1씩 증가된 값이 i에 들어가는데 20000 까지 i에 들어간다.        
            insert into tbl_looptest_1(bunho,name) values( i, '이혜리'||i  ) ;  -- 즉, 20000번 반복하는 것이다. 
        end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
    
    select count(*)
    from tbl_looptest_1; -- 20000
    
    rollback;
    
    declare 
        v_name   varchar2(20) := '강감찬'; -- 변수의 선언 및 초기화
    begin
        for i in 1..20000 loop -- 변수 i에 맨처음 1 이 들어가고 매번 1씩 증가된 값이 i에 들어가는데 20000 까지 i에 들어간다.        
            insert into tbl_looptest_1(bunho,name) values( i, v_name||i  ) ;  -- 즉, 20000번 반복하는 것이다. 
        end loop;
    end;
        
    select count(*)
    from tbl_looptest_1; -- 20000
    
    rollback;
    
    declare 
        v_name   varchar2(20) := '아이유'; -- 변수의 선언 및 초기화
    begin
        for i in reverse 1..100 loop -- 변수 i에 맨처음 100 이 들어가고 매번 1씩 감소된 값이 i에 들어가는데 1 까지 i에 들어간다.        
            insert into tbl_looptest_1(bunho,name) values( i, v_name||i  ) ;  -- 즉, 100번 반복하는 것이다. 
        end loop;
    end;
    -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
   
    select *
    from tbl_looptest_1
    
    select count(*)
    from tbl_looptest_1;
    
    ----- ====== ****  3. WHILE LOOP 문 **** ====== -----
  /*
     [문법]
     WHILE  조건  LOOP
         실행문장;   -- 조건이 참이라면 실행함. 조건이 거짓이 되어지면 반복문을 빠져나간다.
     END LOOP;
  */
  
  declare
        v_cnt  number := 1;  -- 변수의 선언 및 초기화
  begin
       while not( v_cnt > 20000 )  loop     -- not(탈출조건)    탈출조건이 참이라면 전체가 거짓이 되어지므로 반복문을 빠져나간다.
        insert into tbl_looptest_1(bunho, name) values(v_cnt, '홍길동'||v_cnt );
        v_cnt := v_cnt +1;
        end loop;
  end;
  -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
  
    select *
    from tbl_looptest_1
    order by bunho asc;
    
    select count(*)
    from tbl_looptest_1;
    
    rollback;
    
   
   
   
   
   select '9001192s34567', func_age_3('9001192s34567')
   from dual;
   
   create or replace function func_age_3
    (p_jubun  IN  varchar2)   
    return number           
   is
       v_genderNum     varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다.
        
       v_cnt   number(2) := 1; 
       v_chr   varchar2(3);
        
       v_year          number(4);
       error_jubun  Exception; -- error_jubun 은 사용자가 정의하는 예외절(Exception)임을 선언한다.  
       v_age           number(3);
       
   begin
        if    length(p_jubun) != 13 then RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        else 
             loop 
                v_chr := substr(P_jubun, V_cnt, 1); 
                if not(v_chr between '0' and '9') 
                   then RAISE error_jubun; -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
                end if; 
                v_cnt := v_cnt+1;
                exit when v_cnt > 13;
             end loop;
        end if;
        
        if       v_genderNum IN('1','2') then v_year := 1900;
        elsif    v_genderNum IN('3','4') then v_year := 2000;
        else     RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;

        v_age := extract(year from sysdate) - ( v_year + to_number(substr(P_jubun,1,2) ) ) + 1 ;
        return v_age;

        Exception 
            when error_jubun then 
                 raise_application_error(-20001, '>> 올바르지 않은 주민번호입니다. <<');
                 --     -20001은 오류번호로써, 사용자가 정의해주는 exception 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.  
   end func_age_3; 
   -- Function FUNC_AGE_3이(가) 컴파일되었습니다.
    
    
   select '9001192s34567', func_age_3('9001192s34567')
   from dual;
   -- 9001192s34567	33   33=> 잘못된 주민번호 이더라도 지금은 나이가 나온다. 
   --                         잘못된 주민번호 이므로 오류가 뜨게끔 반복문을 통해 고친다.
   --ORA-20001: >> 올바르지 않은 주민번호입니다. <<  
   
   -- for loop문으로 해보기 
   
   create or replace function func_age_3
    (p_jubun  IN  varchar2)   
    return number           
   is
       v_genderNum     varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다.
        
       v_cnt   number(2) := 1; 
       v_chr   varchar2(3);
        
       v_year          number(4);
       error_jubun  Exception; -- error_jubun 은 사용자가 정의하는 예외절(Exception)임을 선언한다.  
       v_age           number(3);
       
   begin
        if    length(p_jubun) != 13 then RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        else 
            /*
            loop 
                v_chr := substr(P_jubun, V_cnt, 1); 
                if not(v_chr between '0' and '9') 
                   then RAISE error_jubun; -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
                end if; 
                v_cnt := v_cnt+1;
                exit when v_cnt > 13;
             end loop;
             */ --또는 
             for i in  reverse  1..13  loop  --reverse는 생략가능 reverse의 경우 마지막값에서 시작값으로 자동 감소
                 v_chr := substr(P_jubun, i, 1);
                    if not(v_chr between '0' and '9') 
                       then RAISE error_jubun; -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
                    end if; 
             end loop;
        end if;
        
        if       v_genderNum IN('1','2') then v_year := 1900;
        elsif    v_genderNum IN('3','4') then v_year := 2000;
        else     RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;

        v_age := extract(year from sysdate) - ( v_year + to_number(substr(P_jubun,1,2) ) ) + 1 ;
        return v_age;

        Exception 
            when error_jubun then 
                 raise_application_error(-20001, '>> 올바르지 않은 주민번호입니다. <<');
                 --     -20001은 오류번호로써, 사용자가 정의해주는 exception 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.  
   end func_age_3;
    
   
   select '9001192s34567', func_age_3('9001192s34567')
   from dual;
    -- ORA-20001: >> 올바르지 않은 주민번호입니다. <<
    
    -- while loop 해보기
    
    create or replace function func_age_3
    (p_jubun  IN  varchar2)   
    return number           
   is
       v_genderNum     varchar2(1) := substr(p_jubun, 7, 1);
       -- v_genderNum 에는 '1' 또는 '2' 또는 '3' 또는 '4' 가 들어올 것이다.
        
       v_cnt   number(2) := 1; 
       v_chr   varchar2(3);
        
       v_year          number(4);
       error_jubun  Exception; -- error_jubun 은 사용자가 정의하는 예외절(Exception)임을 선언한다.  
       v_age           number(3);
       
   begin
        if    length(p_jubun) != 13 then RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        else 
            /*
                 [문법]
                 WHILE  조건  LOOP
                     실행문장;   -- 조건이 참이라면 실행함. 조건이 거짓이 되어지면 반복문을 빠져나간다.
                 END LOOP;
              */
                   
            while not( v_cnt > 13  ) loop 
                v_chr := substr(P_jubun, V_cnt, 1); 
                if not(v_chr between '0' and '9') 
                   then RAISE error_jubun; -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
                end if; 
                v_cnt := v_cnt+1;
                
             end loop;
        end if;
        
        if       v_genderNum IN('1','2') then v_year := 1900;
        elsif    v_genderNum IN('3','4') then v_year := 2000;
        else     RAISE error_jubun;  -- error_jubun 은 사용자가 정의하는 예외절(Exception)이다. 
        end if;

        v_age := extract(year from sysdate) - ( v_year + to_number(substr(P_jubun,1,2) ) ) + 1 ;
        return v_age;

        Exception 
            when error_jubun then 
                 raise_application_error(-20001, '>> 올바르지 않은 주민번호입니다. <<');
                 --     -20001은 오류번호로써, 사용자가 정의해주는 exception 에 대해서는 오류번호를 -20001 부터 -20999 까지만 사용하도록 오라클에서 비워두었다.  
   end func_age_3; 
    
   select '9001192s34567', func_age_3('9001192s34567')
   from dual;
    -- ORA-20001: >> 올바르지 않은 주민번호입니다. <<
    
    
    
    
    
    
    
    
    
  create table tbl_member_test1
  (userid      varchar2(20)
  ,passwd      varchar2(20) not null
  ,name        varchar2(30) not null
  ,constraint  PK_tbl_member_test1_userid  primary key(userid)
  );
  -- Table TBL_MEMBER_TEST1이(가) 생성되었습니다.
  
  -- [퀴즈] tbl_member_test1 테이블에 insert 해주는 pcd_tbl_member_test1_insert 라는 프로시저를 작성하세요.
  
  exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');  --> 정상적으로 insert 되어진다.
  
  exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');      --> 오류메시지 -20002 '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다. 그러므로 insert 가 안되어진다. 
  exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');  --> 오류메시지 -20002 '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' 이 뜬다. 그러므로 insert 가 안되어진다.
    
    
    create or replace procedure pcd_tbl_member_test1_insert
    (p_userid  IN  tbl_member_test1.userid%type 
   , p_passwd  IN  tbl_member_test1.passwd%type
   , P_name    IN  tbl_member_test1.name%type
     )
    is 
       v_length        number(20); 
       error_insert    EXCEPTION;
       v_ch            varchar2(1);
       v_flag_alphabet number(1) := 0;
       v_flag_number   number(1) := 0;
       v_flag_special  number(1) := 0;
    begin
        v_length := length(p_passwd);
        
         if ( v_length < 5 OR v_length > 20 ) then
             raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
        else 
            for i in 1..v_length loop
                v_ch := substr(p_passwd, i, 1);
                
                if(v_ch between 'a' and 'z' OR v_ch between 'A' and 'Z') then  -- 영문자 이라면 
                     v_flag_alphabet := 1; 
                elsif (v_ch between '0' and '9') then -- 숫자 이라면
                     v_flag_number := 1; 
                else -- 특수문자 이라면
                     v_flag_special := 1;
                end if;
            end loop;
            
            if(v_flag_alphabet*v_flag_number*v_flag_special = 1 ) then 
               insert into tbl_member_test1(userid, passwd, name) values( p_userid, p_passwd, P_name);
               --commit; -- 커밋을 적으면 오토 커밋
            else 
               raise error_insert;
            end if;
        end if;
        
        exception 
        when error_insert then
             raise_application_error( -20002, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.' );         
        
    end pcd_tbl_member_test1_insert;
 
 
    
  select *
  from tbl_member_test1;
  
  exec pcd_tbl_member_test1_insert('eomjh','a3$','유관순');
/*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
*/
  
  exec pcd_tbl_member_test1_insert('eomjh','abc1234','유관순');
/*
    오류 보고 -
    ORA-20002: 암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.
*/
  
  exec pcd_tbl_member_test1_insert('hongkd','qwer1234$','홍길동');
  -- PL/SQL 프로시저가 성공적으로 완료되었습니다.
  
  select *
  from tbl_member_test1;
  -- hongkd   qwer1234$   홍길동
  
  commit;
  -- 커밋 완료.
    
    
    ------------ ***** 사용자 정의 예외절(EXCEPTION) ***** ----------------
/*
     예외절 = 오류절
     
     ※ 형식
     
     exception
          when  익셉션이름1  [or 익셉션이름2]  then
                실행문장1;
                실행문장2;
                실행문장3;
                
          when  익셉션이름3  [or 익셉션이름4]  then
                실행문장4;
                실행문장5;
                실행문장6; 
                
          when  others  then  
                실행문장7;
                실행문장8;
                실행문장9; 
   */
   ------------------------------------------------------------------  
   
   
   /*
      === tbl_member_test1 테이블에 insert 할 수 있는 요일명과 시간을 제한해 두겠습니다. ===
        
          tbl_member_test1 테이블에 insert 할 수 있는 요일명은 월,화,수,목,금 만 가능하며
          또한 월,화,수,목,금 중에 오후 2시 부터 오후 5시 이전까지만(오후 5시 정각은 안돼요) insert 가 가능하도록 하고자 한다.
          만약에 insert 가 불가한 요일명(토,일)이거나 불가한 시간대에 insert 를 시도하면 
          '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!' 이라는 오류메시지가 뜨도록 한다. 
   */
    
  create or replace procedure pcd_tbl_member_test1_insert
  (p_userid   IN   tbl_member_test1.userid%type
  ,p_passwd   IN   tbl_member_test1.passwd%type
  ,p_name     IN   tbl_member_test1.name%type
  )
  is
      error_dayTime    exception;
      v_length         number(20);
      error_insert     exception;
      v_ch             varchar2(1);
      v_flag_alphabet  number(1) := 0;
      v_flag_number    number(1) := 0;
      v_flag_special   number(1) := 0;
  begin
        -- 입력(insert) 이 불가한 요일명과 입력이 불가한 시간대인지 알아봅니다. -- 
        if ( to_char(sysdate, 'd') in('1','7')  -- to_char(sysdate, 'd') ==> '1'(일), '2'(월), '3'(화), '4'(수), '5'(목), '6'(금), '7'(토)
          OR to_char(sysdate, 'hh24' ) < '14' or to_char(sysdate, 'hh24') > 16 )
          then raise error_dayTime;
        
        
        end if;
        
        v_length := length(p_passwd);
        
        if ( v_length < 5 OR v_length > 20 ) then
             raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
        else
            for i in 1..v_length loop
                v_ch := substr(p_passwd, i, 1);
                
                if (v_ch between 'a' and 'z' OR v_ch between 'A' and 'Z') then  -- 영문자 이라면 
                    v_flag_alphabet := 1;
                elsif (v_ch between '0' and '9') then  -- 숫자 이라면    
                    v_flag_number := 1;
                else  -- 특수문자이라면
                    v_flag_special := 1;
                end if;
            end loop;
            
            if(v_flag_alphabet * v_flag_number * v_flag_special = 1) then
               insert into tbl_member_test1(userid, passwd, name) values(p_userid, p_passwd, p_name);
            else
               raise error_insert;  -- 사용자가 정의하는 예외절(EXCEPTION)을 구동시켜라.
            end if;
            
        end if;
        
        exception 
             when error_dayTime then
                  raise_application_error(-20002, '영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!');
             
             when error_insert then     
                  raise_application_error(-20003, '암호는 최소 5글자 이상이면서 영문자 및 숫자 및 특수기호가 혼합되어져야 합니다.');
                  
  end pcd_tbl_member_test1_insert;  
  -- Procedure PCD_TBL_MEMBER_TEST1_INSERT이(가) 컴파일되었습니다.
  
  
   exec pcd_tbl_member_test1_insert('eomjh','qwer0070$','엄정화');
  -- PL/SQL 프로시저가 성공적으로 완료되었습니다. 
    
    commit;
    
  select *
  from tbl_member_test1;
    
    exec pcd_tbl_member_test1_insert('leess','qwer5678$','이순신');
  /*
    오류 보고 -
    ORA-20002: 영업시간(월~금 14:00 ~ 16:59:59 까지) 아니므로 입력불가함!!
    
    왜냐하면 현재 목요일 오후 5시가 지났기 때문에 입력불가함 
  */
 
    
    
    
    
    
    
    
    
    
    
    
    ----- ==== **** 오라클에서는 배열이 없습니다만 배열처럼 사용되어지는 table 타입 변수가 있습니다. **** ===== -----
  --              그래서 table 타입 변수를 사용하여 자바의 배열처럼 사용합니다. -- 
  
   create or replace procedure pcd_employees_info_deptid
   (p_department_id  IN  employees.department_id%type)
   is
      v_department_id      employees.department_id%type;
      v_department_name    departments.department_name%type;
      v_employee_id        employees.employee_id%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
   
   begin
        
        with E as
        (
          select department_id
               , employee_id
               , first_name || ' ' || last_name AS ENAME
               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
               , func_gender(jubun) AS GENDER
               , func_age(jubun) AS AGE
          from employees
          where department_id = p_department_id
        )
        select E.department_id, D.department_name, E.employee_id, E.ename, E.hiredate, E.gender, E.age
               into
               v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age 
        from departments D right join E
        on D.department_id = E.department_id;
        
        dbms_output.put_line( lpad('-',60,'-') );
        dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',60,'-') );
        
        dbms_output.put_line( v_department_id || ' ' || v_department_name || ' ' || 
                              v_employee_id || ' ' || v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age );
                              
        EXCEPTION 
           WHEN no_data_found THEN   -- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류임.
                dbms_output.put_line('>> 부서번호 ' || p_department_id || '은 존재하지 않습니다. <<');
        
   end pcd_employees_info_deptid;   
 
    -- Procedure PCD_EMPLOYEES_INFO_DEPTID이(가) 컴파일되었습니다.
    
    exec pcd_employees_info_deptid(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. <<
    
    exec pcd_employees_info_deptid(10);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 45
    */
    
    exec pcd_employees_info_deptid(30);
    /*
        오류 보고 -
        ORA-01422: exact fetch returns more than requested number of rows
        
        왜냐하면 30번 부서에 근무하는 직원은 6명이므로 select 되어진 결과는 6개 행이 나와야하는데 
        프로시저에서 select 되어진 컬럼의 값을 담을 변수 (v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age)는 
        데이터 값을 1개 밖에 담지 못하므로 위와 같은 오류가 발생한다. 
       
       
     자바를 예를 들면
     int jumsu = 0;
     
     변수 jumsu 에 90, 95, 88, 75, 91, 80 이라는 6개의 점수를 입력하고자 한다.
     돼요? 안돼요?  안됩니다.
 
     jumsu = 90;
     jumsu = 85;
     jumsu = 88;
     jumsu = 75;
     jumsu = 91;
     jumsu = 80;
     
     최종적으로 변수 jumsu 에 담긴 값은 80 이 된다.
     
     그래서 자바에서는 아래와 같이 배열로 만들어서 한다. 
     int[] jumsuArr = new int[6]; 
     
     jumsuArr[0] = 90;
     jumsuArr[1] = 85;
     jumsuArr[2] = 88;
     jumsuArr[3] = 75;
     jumsuArr[4] = 91;
     jumsuArr[5] = 80;
     
     -------------------------------
     | 90 | 85 | 88 | 75 | 91 | 80 | 
     -------------------------------
        
    */
    
    select employee_id
    from employees
    where department_id = 30
    
 /*
    아래의 모양은 자바에서 사용되던 배열의 모양을 90도 회전한 것과 같다.
    그래서 오라클에서는 자바의 배열처럼 컬럼을 1개만 가지는 table 타입 변수를 사용하여 쓴다.
    
    EMPLOYEE_ID 
     -------
     | 114 |
     -------
     | 115 |
     -------
     | 116 |
     -------
     | 117 |
     -------
     | 118 |
     -------
     | 119 |
     -------
 
 */
    
    
    
    
     ----- **** [위에서 만든 pcd_employees_info_deptid 을 올바르게 작동하도록 해결하기] **** -----
     
   create or replace procedure pcd_employees_info_deptid
   (p_department_id  IN  employees.department_id%type)
   is
      type department_id_type
      is table of employees.department_id%type index by binary_integer;
      
      type department_name_type
      is table of departments.department_name%type index by binary_integer;
      
      type employee_id_type
      is table of employees.employee_id%type index by binary_integer;
      
      type ename_type
      is table of varchar2(30) index by binary_integer;
      
      type hiredate_type
      is table of varchar2(10) index by binary_integer;
      
      type gender_type
      is table of varchar2(6) index by binary_integer;
      
      type age_type
      is table of number(3) index by binary_integer;
      
      v_department_id     department_id_type ;
      v_department_name   department_name_type;
      v_employee_id       employee_id_type ;
      v_ename             ename_type ;
      v_hiredate          hiredate_type ;
      v_gender            gender_type ;
      v_age               age_type ;
      
      i binary_integer := 0; -- i가 마치 배열의 방번호 용도처럼 쓰인다. 
                             -- 그런데 자바에서 배열의 시작은 0번 부터 시작하지만 
                             -- 오라클에서는 1번 부터 시작한다. 
   begin
   
      for v_rcd in ( 
                    select E.department_id
                         , D.department_name
                         , E.employee_id
                         , Ename
                         , HIREDATE
                         , GENDER
                         , AGE
                    from  departments D right JOIN
                    (     select department_id
                               , employee_id
                               , first_name || ' ' || last_name AS ENAME
                               , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
                               , func_gender(jubun) AS GENDER
                               , func_age(jubun) AS AGE
                          from employees 
                          where department_id = p_department_id  ) E
                    on D.department_id = E.department_id 
                    ) LOOP
            i := i+1;
        
            v_department_id(i) := v_rcd.department_id;
            v_department_name(i) := v_rcd.department_name;
            v_employee_id(i) := v_rcd.employee_id;
            v_ename(i) := v_rcd.ename;  
            v_hiredate(i) := v_rcd.hiredate;
            v_gender(i) := v_rcd.gender;
            v_age(i) := v_rcd.age; 
        
      end loop;
      
      --dbms_output.put_line('확인용 i =>' || i);
      if( i = 0 ) then
        raise no_data_found;
      else 
        dbms_output.put_line( lpad('-',60,'-') );
        dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
        dbms_output.put_line( lpad('-',60,'-') );
        
        for k IN 1..i loop
            dbms_output.put_line(  v_department_id(k) || ' ' || 
                                   v_department_name(k) || ' ' || 
                                   v_employee_id(k) || ' ' || 
                                   v_ename(k) || ' ' || 
                                   v_hiredate(k) || ' ' || 
                                   v_gender(k) || ' ' || 
                                   v_age(k) 
                                  );
        end loop;
            
      end if;  
      
      exception 
        when no_data_found then -- no_data_found 은 오라클에서 데이터가 존재하지 않을 경우 발생하는 오류이다. 
            dbms_output.put_line( '>> 부서번호' || P_department_id || '존재하지 않습니다.<<' );
        
   end pcd_employees_info_deptid;
    
    
    
    exec pcd_employees_info_deptid(10);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 45
    */
    exec pcd_employees_info_deptid(9999);
    -- >> 부서번호9999존재하지 않습니다.<<
    
    exec pcd_employees_info_deptid(30);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        30 Purchasing 114 Den Raphaely 2002-12-07 여 56
        30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
        30 Purchasing 116 Shelli Baida 2005-12-24 남 63
        30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
        30 Purchasing 118 Guy Himuro 2006-11-15 남 45
        30 Purchasing 119 Karen Colmenares 2007-08-10 남 44
    */
    
    
    
    --*******************************************************************************--
    
      -----------------------------------------------------------------------------
  
                    ---- ===== **** CURSOR **** ===== -----
              
  --  PL/SQL 에서 SELECT 되어져 나오는 행의 개수가 2개 이상인 경우에는 위에서 한 것처럼
  --  table 타입의 변수를 사용하여 나타낼 수 있고, 또는 CURSOR 를 사용하여 나타낼 수도 있다. 
  --  table 타입의 변수를 사용하는 것 보다 CURSOR 를 사용하는 것이 더 편하므로 
  --  대부분 CURSOR 를 많이 사용한다.
  
  
  ----- *** 명시적 CURSOR 만들기 *** -----
  ※ 형식

  1.단계 -- CURSOR 의 선언(정의)
     
    CURSOR 커서명
    IS
    SELECT 문;  

  2.단계 -- CURSOR 의 OPEN

    OPEN 커서명;

  3.단계 -- CURSOR 의 FETCH
           (FETCH 란? SELECT 되어진 결과물을 끄집어 내는 작업을 말한다)
    
    FETCH  커서명 INTO 변수;

  4.단계 -- CURSOR 의 CLOSE

    CLOSE 커서명;
      


 ※ ==== 커서의 속성변수 ==== ※

 1. 커서명%ISOPEN   ==> 커서가 OPEN 되어진 상태인가를 체크하는 것.
                       만약에 커서가 OPEN 되어진 상태이라면 TRUE.

 2. 커서명%FOUND    ==> FETCH 된 레코드(행)이 있는지 체크하는 것.
                       만약에 FETCH 된 레코드(행)이 있으면 TRUE.

 3. 커서명%NOTFOUND ==> FETCH 된 레코드(행)이 없는지 체크하는 것.
                       만약에 FETCH 된 레코드(행)이 없으면 TRUE.

 4. 커서명%ROWCOUNT ==> 현재까지 FETCH 된 레코드(행)의 갯수를 반환해줌.
    
   
   create or replace procedure pcd_employees_deptid_cursor
   (p_department_id  IN  employees.department_id%type)
   is 
    -- 1.단계 -- CURSOR 의 선언(정의)
    cursor cur_empinfo
    is
    select E.department_id
         , D.department_name
         , E.employee_id
         , Ename
         , HIREDATE
         , GENDER
         , AGE
    from  departments D right JOIN
    ( select department_id
           , employee_id
           , first_name || ' ' || last_name AS ENAME
           , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
           , func_gender(jubun) AS GENDER
           , func_age(jubun) AS AGE
      from employees 
      where department_id = p_department_id  ) E
    on D.department_id = E.department_id;
    
      v_department_id      employees.department_id%type;
      v_department_name    departments.department_name%type;
      v_employee_id        employees.employee_id%type;
      v_ename              varchar2(30);
      v_hiredate           varchar2(10);
      v_gender             varchar2(6);
      v_age                number(3);
      v_cnt                number := 0;
      
   begin
    --2.단계 -- CURSOR 의 OPEN
    OPEN cur_empinfo;
    --3.단계 -- CURSOR 의 FETCH
    --                  (FETCH 란? SELECT 되어진 결과물을 끄집어 내는 작업을 말한다)
    
    loop 
    
        FETCH cur_empinfo INTO v_department_id, v_department_name, v_employee_id, v_ename, v_hiredate, v_gender, v_age;

        v_cnt := cur_empinfo%ROWCOUNT;
    
     -- dbms_output.put_line('>> 확인용 fetch 되어진 행의 개수 => ' || cur_empinfo%ROWCOUNT ); 
        
        
        exit when cur_empinfo%NOTFOUND; -- 더 이상 select 되어진 행이 없다면 반복문을 빠져나간다.
        
        if (v_cnt = 1) then 
            dbms_output.put_line( lpad('-',60,'-') );
            dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
            dbms_output.put_line( lpad('-',60,'-') );
        end if;
        
        dbms_output.put_line(v_department_id || ' ' || v_department_name || ' ' || v_employee_id || ' ' || v_ename || ' ' || v_hiredate || ' ' || v_gender || ' ' || v_age);
        
    end loop;
    
    -- 4.단계 -- CURSOR 의 CLOSE

    CLOSE cur_empinfo;
    
    if(v_cnt = 0) then 
        dbms_output.put_line(' >> 부서번호 ' || p_department_id || '은 존재하지 않습니다. << ');
    else 
        dbms_output.put_line(' ');
        dbms_output.put_line('>> 조회된 행의 개수 : '|| v_cnt ||'개 <<');
    end if;
    
   end pcd_employees_deptid_cursor; 



    
    exec pcd_employees_deptid_cursor(10);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 45
 
        >> 조회된 행의 개수 : 1개 <<
    */
    exec pcd_employees_deptid_cursor(30);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        30 Purchasing 114 Den Raphaely 2002-12-07 여 56
        30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
        30 Purchasing 116 Shelli Baida 2005-12-24 남 63
        30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
        30 Purchasing 118 Guy Himuro 2006-11-15 남 45
        30 Purchasing 119 Karen Colmenares 2007-08-10 남 44
         
        >> 조회된 행의 개수 : 6개 <<
    */
    
    
    exec pcd_employees_deptid_cursor(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. << 
    
    
    
    
    
    
    
 --*******************************************************************--   
 -------------- *****  FOR LOOP CURSOR 만들기 ***** -----------------
 /*
     FOR LOOP CURSOR 문을 사용하면
     커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 가 자동적으로 발생되어지기 때문에
     우리는 커서의 OPEN, 커서의 FETCH, 커서의 CLOSE 문장을 기술할 필요가 없다.
 */
  
  ※ 형식
  FOR 변수명(=select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
      실행문장;
  END LOOP; 
  
    
    
    
   create or replace procedure pcd_employees_deptid_forcursor
   (p_department_id  IN  employees.department_id%type)
   is 
    -- 1.단계 -- CURSOR 의 선언(정의)
    cursor cur_empinfo
    is
    select E.department_id
         , D.department_name
         , E.employee_id
         , Ename
         , HIREDATE
         , GENDER
         , AGE
    from  departments D right JOIN
    ( select department_id
           , employee_id
           , first_name || ' ' || last_name AS ENAME
           , to_char(hire_date, 'yyyy-mm-dd') AS HIREDATE
           , func_gender(jubun) AS GENDER
           , func_age(jubun) AS AGE
      from employees 
      where department_id = p_department_id  ) E
    on D.department_id = E.department_id;
    
    v_cnt number := 0;
      
   begin  
    /*
        2단계 
        FOR 변수명(select 되어진 행의 정보가 담기는 변수) IN 커서명 LOOP
        실행문장;
        END LOOP; 
    */
     FOR v_rcd IN cur_empinfo LOOP
      v_cnt := cur_empinfo%ROWCOUNT;
   -- dbms_output.put_line('>> 확인용 fetch 되어진 행의 개수 => ' || v_cnt ); 
      
        if (v_cnt = 1) then 
            dbms_output.put_line( lpad('-',60,'-') );
            dbms_output.put_line( '부서번호    부서명     사원번호     사원명    입사일자   성별   나이' );
            dbms_output.put_line( lpad('-',60,'-') );
        end if; 
        
        dbms_output.put_line(v_rcd.department_id || ' ' || v_rcd.department_name || ' ' || v_rcd.employee_id || ' ' || v_rcd.ename || ' ' || v_rcd.hiredate || ' ' || v_rcd.gender || ' ' || v_rcd.age);
        
     END LOOP; 
     
     if(v_cnt = 0) then 
        dbms_output.put_line(' >> 부서번호 ' || p_department_id || '은 존재하지 않습니다. << ');
     else 
        dbms_output.put_line(' ');
        dbms_output.put_line('>> 조회된 행의 개수 : '|| v_cnt ||'개 <<');
     end if;
   
   end pcd_employees_deptid_forcursor; 
      
   
    exec pcd_employees_deptid_forcursor(10);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        10 Administration 200 Jennifer Whalen 2003-09-17 여 45
 
        >> 조회된 행의 개수 : 1개 <<
    */
    exec pcd_employees_deptid_forcursor(30);
    /*
        ------------------------------------------------------------
        부서번호    부서명     사원번호     사원명    입사일자   성별   나이
        ------------------------------------------------------------
        30 Purchasing 114 Den Raphaely 2002-12-07 여 56
        30 Purchasing 115 Alexander Khoo 2003-05-18 남 62
        30 Purchasing 116 Shelli Baida 2005-12-24 남 63
        30 Purchasing 117 Sigal Tobias 2005-07-24 여 62
        30 Purchasing 118 Guy Himuro 2006-11-15 남 45
        30 Purchasing 119 Karen Colmenares 2007-08-10 남 44
         
        >> 조회된 행의 개수 : 6개 <<
    */
    exec pcd_employees_deptid_forcursor(9999);
    -- >> 부서번호 9999은 존재하지 않습니다. << 
    
    
    -------------------- ****** PACKAGE(패키지) ****** ----------------------
   
   --->   PACKAGE(패키지)란?  여러개의 Procedure 와 여러개의 Function 들의 묶음
   
   --- 1. PACKAGE(패키지)의 선언하기
   create or replace package employee_pack
   is
    -- employee_pack에 들어올 프로시저 또는 함수를 선언해준다.
    procedure pcd_emp_info(p_deptno IN employees.department_id%type);
    procedure pcd_dept_info(p_deptno IN departments.department_id%type);
    function func_sex(p_jubun IN employees.jubun%type)return varchar2;
   
   end employee_pack;
   -- Package EMPLOYEE_PACK이(가) 컴파일되었습니다. 
    
   --- 2. PACKAGE(패키지)의 body(본문) 생성하기
   create or replace package body employee_pack
   is
    procedure pcd_emp_info(p_deptno IN employees.department_id%type) 
    is 
        cursor cur_empinfo
        is
        select D.department_id, D.department_name, 
               E.employee_id, E.first_name||' ' || E.last_name as ename 
        from departments D join employees E
        ON D.department_id = E.department_id
        where E.department_id = p_deptno;
        
        v_cnt number := 0;
    begin
        for v_rcd in cur_empinfo loop
            v_cnt := cur_empinfo%rowcount;
            if(v_cnt = 1) then
                dbms_output.put_line( lpad('-',60,'-') );            
                dbms_output.put_line( '부서번호   부서명            사원번호     사원명' );
                dbms_output.put_line( lpad('-',60,'-') );
            end if;
            
            dbms_output.put_line( v_rcd.department_id || ' ' || 
                                  v_rcd.department_name || ' ' ||  
                                  v_rcd.employee_id || ' ' ||
                                  v_rcd.ename
                                  );   
        end loop;
        
        if(v_cnt = 0) then 
            dbms_output.put_line('>> 부서번호' || p_deptno || ' 은 없습니다.<<' );
        else 
            dbms_output.put_line( ' ');
            dbms_output.put_line( '>> 조회건수 :  '|| v_cnt || ' 개');
        end if;    
    end pcd_emp_info;
    
    procedure pcd_dept_info(p_deptno IN departments.department_id%type)
    is
        v_department_id    departments.department_id%type; 
        v_department_name  departments.department_name%type;
    begin
        select department_id, department_name
               into 
               v_department_id, v_department_name
        from departments
        where department_id = p_deptno;
        
        dbms_output.put_line( lpad('-',40,'-') );            
        dbms_output.put_line( '부서번호   부서명' );
        dbms_output.put_line( lpad('-',40,'-') );
        
        dbms_output.put_line( v_department_id || ' ' || v_department_name );
        
        exception 
            when no_data_found then 
                dbms_output.put_line('>> 부서번호' || p_deptno || ' 은 없습니다.<<');
        
    end pcd_dept_info;
   
    function func_sex(p_jubun IN employees.jubun%type)
    return varchar2
    is
        v_result      varchar2(100);
        v_gender_num  varchar2(1);
    begin
        if(length(p_jubun) = 13) then
            v_gender_num := substr(p_jubun,7,1);
            
            if(v_gender_num in('1','3')) then
                v_result := '남';
            elsif(v_gender_num in('2','4')) then
                v_result := '여';
            else
                v_result := '주민번호가 올바르지 않습니다.';
            end if;
        else
          v_result := '주민번호의 길이가 13자리가 아닙니다.';
        end if;
        return v_result;
    end func_sex;
   end employee_pack;
   
   begin
     employee_pack.pcd_emp_info(30);
   end;
/*
    ------------------------------------------------------------
    부서번호  부서명         사원번호   사원명
    ------------------------------------------------------------
    30 Purchasing 114 Den Raphaely
    30 Purchasing 115 Alexander Khoo
    30 Purchasing 116 Shelli Baida
    30 Purchasing 117 Sigal Tobias
    30 Purchasing 118 Guy Himuro
    30 Purchasing 119 Karen Colmenares
     
    >> 조회건수 : 6개
*/
   
   begin
       employee_pack.pcd_emp_info(9999);
   end;
   --  >> 부서번호 9999은 없습니다. <<
   
   
   begin
       employee_pack.pcd_dept_info(30);
   end;
/*
    ----------------------------------------
    부서번호  부서명
    ----------------------------------------
    30 Purchasing
*/
   
   begin
       employee_pack.pcd_dept_info(9999);
   end;
   --  >> 부서번호 9999은 없습니다. <<
   
   select employee_pack.func_sex('9001201234567')
        , employee_pack.func_sex('9001202234567')
        , employee_pack.func_sex('0101203234567')
        , employee_pack.func_sex('0101204234567')
   from dual;
   --  남	여	남	여
   
   select employee_pack.func_sex('900120123456')
        , employee_pack.func_sex('9001209234567')
   from dual;
   -- 주민번호의 길이가 13자리가 아닙니다.	주민번호가 올바르지 않습니다.
   
   select employee_id, first_name, jubun, employee_pack.func_sex(jubun)
   from employees
   order by 1; 
    
    
  ---- **** 패지키 소스 보기 **** ----
   select line, text
   from user_source
   where type = 'PACKAGE' and name = 'EMPLOYEE_PACK';
   
   
   ---- **** 패지키 BODY(본문) 소스 보기 **** ----
   select line, text
   from user_source
   where type = 'PACKAGE BODY' and name = 'EMPLOYEE_PACK';
   
   
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
 
 
 
 
 
 
   -- [과제1 1번문제] --
   select department_id as 부서번호
        , first_name || ' ' || last_name as 사원명 
        , rpad(substr(jubun,1,6),13,'*')  as 주민번호
        , case when substr(jubun, 7,1) in(1,3) then '남' else '여' end  as 성별
   from employees
   where department_id in(30, 50);
   
   -- [과제1 2번문제] --
   select *
   from employees
   
   select first_name || ' ' || last_name as 사원명 
        , phone_number as 공개연락처
        ,substr(phone_number, 1,4) ||
        lpad(substr(phone_number, 8 ,5),8,'*') as 비공개연락처
   from employees
   where department_id = 90;
   
    -- [과제1 3번문제] --
    
    select first_name || ' ' || last_name as 사원명 
         , phone_number as 공개연락처
         , substr( phone_number, 1,(instr(phone_number, '.', 1,1)))|| '**' || 
           reverse(substr( reverse(phone_number), 7, 6))|| '******'  as 비공개연락처 
    from employees
    where department_id = 80
    order by 1;
    
    -- substr('문자열', 시작글자번호, 뽑아야할글자수)
    -- instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', 1, 2) -- 10
         --  '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육' 이 나온 위치를 찾는데
         --  출발점이 1 번째 부터 2 번째로 나오는 '교육'의 위치를 알려달라는 말이다.
   -- 1.7 lpad : 왼쪽부터 문자를 자리채움 **** ---
   -- 1.8  rpad : 오른쪽부터 문자를 자리채움 **** ---
    select lpad('교육센터',10,'*')   
        -- 10 byte를 확보해서 거기에 '교육센터' 를 넣습니다. 넣은 후 빈공간(2byte)이 있으면 왼쪽부터 '*' 로 채워라 
        -- lpad(<원래문자>, <맞출 자릿수>, <빈 자리에 사용한 물자>)

        ,  rpad('교육센터',10,'*')
        -- 10 byte를 확보해서 거기에 '교육센터' 를 넣습니다. 넣은 후 빈공간(2byte)이 있으면 오른쪽부터 '*' 로 채워라 
    from dual;
   ----------------------------------------------------------------------------------------
    
    select first_name || ' ' || last_name as 사원명 
         , phone_number as 공개연락처
         , rpad(substr(phone_number,1,instr(phone_number,'.',1)),6,'*') ||
           rpad(substr(phone_number,instr(phone_number,'.',2),6),12,'*')
           as 비공개연락처
    from employees
    where department_id = 80
    order by 1;
    --011.**.1344.******
   
    select substr(phone_number,7,instr(phone_number,'.',1,2))
    from employees
    where department_id = 80
    -- 862924.4431.44.110
    
    select phone_number
    , instr(phone_number, '.', 10)-5
    , lpad('*', instr(phone_number, '.', 1)-2, '*') 
    from employees
    
    -- [과제1 4번문제] --
    
    select department_id as 부서번호
         , first_name || ' ' || last_name as 사원명
         , phone_number as 공개연락처
         , case when length(phone_number)= 18  then substr( phone_number, 1,(instr(phone_number, '.', 1,1)))|| '**' || 
           reverse(substr( reverse(phone_number), 7, 6))|| '******' 
           else substr( phone_number, 1,(instr(phone_number, '.', 1,1)))|| '***.****' 
           end as 비공개연락처
    from employees
    where department_id in (80, 90)
    order by 1;
    
    select department_id as 부서번호
         , first_name || ' ' || last_name as 사원명
         , phone_number as 공개연락처
         , substr(phone_number,1,instr(phone_number, '.', 1)) || 
           lpad('*',instr(phone_number,'.',2)-2,'*') ||
           substr(phone_number,instr(phone_number, '.', 1)+3,instr(reverse(phone_number), '.', 1))
           
           
 
    from employees
    where department_id in (80, 90)
    order by department_id;
    
    
    
    
    select instr(phone_number, '.', 1)+2
    from employees
    where department_id in (80, 90)
    
    
    /*
    == SQL 과제2 ==

    --  아래와 같이 나오도록 하세요...
    
    /*
        ----------------------------------------------------------------------------------------------------------------------------------------------------
         부서번호    부서명    부서주소    부서장성명    사원번호   사원명    성별    나이    연봉    연봉소득세액    부서내연봉평균차액    부서내연봉등수     전체연봉등수 
        ----------------------------------------------------------------------------------------------------------------------------------------------------
    */
    
    select * from tab
     부서번호    부서명    부서주소    부서장성명    사원번호   사원명    성별    
     나이    연봉    연봉소득세액    부서내연봉평균차액    
     부서내연봉등수     전체연봉등수  
    
 
    
   with
    V1 AS
    (
    select E.department_id 
         , D.department_name 
         , L.city || ' ' || L.street_address AS dept_adress
         , E.employee_id 
         , E.first_name || ' ' || E.last_name AS Ename
         , case when substr(e.jubun, 7, 1) in(1,3) then '남' else '여' end  as GENDER
         , extract(year from sysdate) - ( substr(jubun,1,2) + case when substr(jubun, 7, 1) in('1','2') then 1900 else 2000 end ) + 1 as AGE
         , NVL(salary+(salary*commission_pct), salary)*12 as YEAR_SAL
         , (NVL(salary+(salary*commission_pct),salary)*12)*taxpercent as TAX_INDEX
        
    from regions R
    JOIN countries C
    on R.region_id = C.region_id
    JOIN LOCATIONS L
    on C.country_id = L.country_id
    JOIN DEPARTMENTS D
    on L.location_id = D.location_id
    right JOIN employees E
    on D.department_id = E.department_id
    join tbl_taxindex T 
    on nvl(salary+(salary*commission_pct), salary)*12 between Lowerincome and highincome
    ) 
    , 
    V2 AS
    (
       select first_name || ' ' || last_name as manager_name
            , D.department_id
       from departments D JOIN employees E
       on D.manager_id = E.employee_id
    )
    ,
    V3 AS
    ( 
      select department_id
           , trunc(avg(nvl(salary+(salary*commission_pct), salary)*12)) as dept_ys_avg
      from employees
      group by department_id
    )
    
    select v2.department_id as 부서번호
         , department_name as 부서명
         , dept_adress as 부서주소
         , manager_name as 부서장성명
         , employee_id as 사원번호
         , Ename as 사원명
         , gender as 성별
         , age as 나이
         , YEAR_SAL as 연봉
         , trunc(TAX_INDEX) as 연봉소득세액
         , YEAR_SAL - dept_ys_avg as 부서내연봉평균차액 
    from V1 left join V2
    on V1.department_id = V2.department_id
    left join V3
    on v2.department_id = V3.department_id
    order by 1, year_sal desc ;
 
    
    ----------------------------------------------
   
    -- 부서내연봉평균
   /*    (
       select department_id , trunc(avg(NVL(salary+(salary*commission_pct), salary)*12)) as dept_avg_ys
       from employees
       group by department_id
       order by 1
       ) V2
     join*/
    -- 부서장성명구하기
       
       select first_name || ' ' || last_name as manager_name
       from departments D JOIN employees E
       on D.manager_id = E.employee_id
       
       
       
       ----------------------------
       join tbl_taxindex T 
       on year_sal between Lowerincome and highincome
       order by 1;
    

    -------------------------------------
    select first_name || ' ' || last_name
    from departments D JOIN employees E
       on D.manager_id = E.employee_id
    
    select *
    from departments
    
    select *
    from employees
    
    select *
    from LOCATIONS
    
    select * 
    from tbl_taxindex;   
    
    
    
    
    