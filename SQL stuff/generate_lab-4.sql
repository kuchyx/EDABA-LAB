--variable loops number
--loops := 10;





truncate table takes_part_in cascade;--
truncate table takes_place_in cascade;--
truncate table player cascade;--
truncate table match cascade;--
truncate table stadium cascade;--
truncate table manager cascade;--
truncate table club cascade;--
truncate table competition cascade;--competition is last since it has no foreign keys (but club holds a foreign key to competition)

declare loops number := 20;
begin

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
connect by level <=loops
;

insert into manager
    select
    level +(select nvl(max(id),0) from manager) as id,
        DBMS_RANDOM.value(1,5) as skill,
        DBMS_RANDOM.value(1,5) as reputation,
        DBMS_RANDOM.value(18,80) as age,
        DBMS_RANDOM.value(0,1000000) as wage,
        level as club_id
from dual
connect by level <=loops
;

insert into club
--(id, budget, training_ground_quality, reputation, country_of_origin, competition_id, manager_id)
    select
   level +(select nvl(max(id),0) from club) as id,
    DBMS_RANDOM.value(0,1000000) as budget,
    DBMS_RANDOM.value(1,5)as training_ground_quality,
    DBMS_RANDOM.value(1,5) as reputation,
    dbms_random.string('A', 6) as country_of_origin,
    dbms_random.value(1,loops) as competition_id, --https://stackoverflow.com/questions/27879874/how-to-get-random-foreign-key-in-sql-developer
    level as manager_id
from dual
connect by level <=loops
;

-- attempt at getting random id from competition: (SELECT id FROM competition SAMPLE(1) WHERE rownum = 1)

insert into stadium
    select 
   level +(select nvl(max(id),0) from stadium) as id,
    DBMS_RANDOM.value(0,40000) as capacity,
    DBMS_RANDOM.value(1,5) as reputation,
    dbms_random.string('A', 6) as location,
    DBMS_RANDOM.value(1900,2100) as build_year,
    DBMS_RANDOM.value(0,1000000) as value,
    DBMS_RANDOM.value(0,200) as ticket_price,
    level as club_id
from dual
connect by level <=loops
;

insert into match
    select 
        level +(select nvl(max(id),0) from match) as id,
        DBMS_RANDOM.value(0,100) as score,
        DBMS_RANDOM.value(1,5) as rating,
        DBMS_RANDOM.value(0, 40000) as attendance,
        dbms_random.string('A', 6) as weather,
        DBMS_RANDOM.value(0,120) as duration,
        To_date(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '1950-01-01','J') ,TO_CHAR(DATE '2001-12-31','J'))), 'J') as date2,
        dbms_random.string('A', 6) as referee_name,
        level as competition_id
    from dual
connect by level <=loops
;


insert into player 
    select 
        level +(select nvl(max(id),0) from player) as id,
        DBMS_RANDOM.value(1, 5) as skill,
        dbms_random.string('A', 6) as position,
        DBMS_RANDOM.value(1, 5) as reputation,
        dbms_random.string('A', 6) as contract_status,
        DBMS_RANDOM.value(0, 700) as injuries,
        DBMS_RANDOM.value(15, 50) as age,
        DBMS_RANDOM.value(15, 50) as wages,
        DBMS_RANDOM.value(0, 1000000000) as transfer_value,
        dbms_random.value(1,loops) as club_id
    from dual 
connect by level <=loops
;

insert into takes_part_in 
    select 
        dbms_random.value(1,loops) as club_id,
        dbms_random.value(1,loops) as match_id
    from dual 
connect by level <=loops
;

insert into takes_place_in 
    select 
        dbms_random.value(1,loops) as stadium_id,
        dbms_random.value(1,loops) as competition_id
    from dual 
connect by level <=loops
;

end;