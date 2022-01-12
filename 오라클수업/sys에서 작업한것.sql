show user;
-- USER이(가) "SYS"입니다.

-- 1줄 주석문


/*
    여러줄
    주석문
*/

-- ** 현재 오라클 서버에서 사용중인 오라클 사용자 계정 정보를 조회하는 것 ** --
select * from dba_users;

-- ** 샘플 오라클 사용자 계정인 HR(Human Resource 인사관리)은 기본적으로 사용불능(EXPIRED & LOCKED)으로 되어있는데
--    이것을 사용가능(OPEN)으로 만들겠다. ** 

alter user hr account unlock; -- LOCKED 되어진 hr 계정을 풀어주는 것(unlock)이다.
-- User HR이(가) 변경되었습니다.

alter user hr account lock; -- 풀린(UNLOCKED) hr 계정을 잠그는 것(lock)이다.
-- User HR이(가) 변경되었습니다.

alter user hr account unlock;

select * from dba_users; -- hr 은 계정상태가 EXPIRED로 변경되어진다.
                         -- EXPIRED 은 hr의 암호 사용기간이 끝났다는 말이다.
                         -- 그러므로 새로운 암호를 부여해야 한다.
                         
alter user hr identified by cclass; -- hr 사용자 계정의 암호를 cclass로 하겠다는 말이다.
-- User HR이(가) 변경되었습니다.

select * from dba_users; -- hr은 계정상태가 OPEN(사용가능)로 변경되어진다. 

----------------------------------------------------------------------------------
