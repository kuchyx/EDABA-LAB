truncate table stadium;--
truncate table competition;--

--create table countryTable (Cname varchar(20))
--
--insert into table countryTable values('Poland')
--insert into table countryTable values('England')
--insert into table countryTable values('USA')
--insert into table countryTable values('Brazil')
--insert into table countryTable values('France')

insert into competition
    select 
   level +(select nvl(max(id),0) from competition) as id,
    DBMS_RANDOM.value(0,1000000) as prize,
    dbms_random.string('A', 6) as country,
--    (select Cname from countryTable order by random() limit 1) as country,
    DBMS_RANDOM.value(1,5) as reputation
--into competionTemp 
from dual
connect by level <=10
--generate 10 records
;

inster into club
    select 
   level +(select nvl(max(id),0) from competition) as id,
    DBMS_RANDOM.value(0,1000000) as prize,
    dbms_random.string('A', 6) as country,
--    (select Cname from countryTable order by random() limit 1) as country,
    DBMS_RANDOM.value(1,5) as reputation
--into competionTemp 
from dual
connect by level <=10
--generate 10 records
;

insert into stadium
    select 
   level +(select nvl(max(id),0) from stadium) as id,
    DBMS_RANDOM.value(0,40000) as capacity,
    DBMS_RANDOM.value(1,5) as reputation,
    dbms_random.string('A', 6) as location,
    DBMS_RANDOM.value(1900,2100) as build_year,
    DBMS_RANDOM.value(0,1000000) as value,
    DBMS_RANDOM.value(0,200) as ticket_price,
    level +(select nvl(max(id),0) from stadium) as club_id
from dual
connect by level <=10
--generate 10 records
;