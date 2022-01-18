show user;

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