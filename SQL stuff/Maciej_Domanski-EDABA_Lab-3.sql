--Maciej Domañski 303853 - EDABA Lab 3


-- Show data before triggers
select * from competition where id < 10
select * from club where competition_id = 1

-- insert trigger creation

-- update trigger creation
CREATE OR REPLACE trigger update_trigger after update on competition
for each row
begin
    update club
    set budget = 2000
    where 20 < :NEW.prize AND :NEW.id = competition_id;
end;

-- delete trigger creation

-- Show data that triggers trigger

-- trigger triggers
update competition
set prize = 1000
where id = 1;

-- Show data after trigger
select * from competition where id < 10
select * from club where competition_id = 1




-- NEW - valid only for insert/update
-- OLD - delete/upate 
--CREATE OR REPLACE trigger update_nb_emp after insert or update or delete on emp
--for each row
--begin
--    -- increase number of employes in given department
--    update dept
--    set nb_emp = nb_emp +1 
--    where deptno = :NEW.deptno;
--
--    -- decrease number of employes in given department
--    -- here we do not decrease number of employees if there are no data in department because of OLD  
--    update dept
--    set nb_emp = nb_emp -1 
--    where deptno = :OLD.deptno;
--end;
--
--
--select * from dept;
--select * from emp;
--insert into emp
--values(800, 'John', 'Rambo', 7788,'2022-01-20',7000, 0,40);
--
--update emp
--set deptno = 30
--where empno = 800
--
--delete from emp
--where empno = 800
--
--select * from emp
--
--update dept
--set nb_emp = (select count(*) from emp where emp.deptno = dept.deptno)
--

