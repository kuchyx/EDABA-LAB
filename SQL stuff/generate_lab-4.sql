--truncate table competition;--

insert into competition
    select 
   level +(select max(id) from competition) as id,
    DBMS_RANDOM.value(10,100) as prize,
    dbms_random.string('A', 6) as country,
    DBMS_RANDOM.value(1,5) as reputation
--into competionTemp 
from dual
connect by level <=10
--generate 10 records