alter table manager
DISABLE constraint manager_club_fk;

alter table club
DISABLE constraint club_manager_fk;

truncate table stadium cascade;--
truncate table manager cascade;--
truncate table club cascade;--
truncate table competition cascade;--competition is last since it has no foreign keys (but club holds a foreign key to competition)

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
connect by level <=10
;

insert into club
--(id, budget, training_ground_quality, reputation, country_of_origin, competition_id, manager_id)
    select
   level +(select nvl(max(id),0) from club) as id,
    DBMS_RANDOM.value(0,1000000) as budget,
    DBMS_RANDOM.value(1,5)as training_ground_quality,
    DBMS_RANDOM.value(1,5) as reputation,
    dbms_random.string('A', 6) as country_of_origin,
    (SELECT id FROM competition SAMPLE(1) WHERE rownum = 1) as competition_id, --https://stackoverflow.com/questions/27879874/how-to-get-random-foreign-key-in-sql-developer
    level as manager_id
from dual
connect by level <=10
;

--insert all
--into manager
--(id, skill, reputation, age, wage, club_id)
--            values 
--           (1 +(select nvl(max(id),0) from manager),
--            DBMS_RANDOM.value(1,5),
--            DBMS_RANDOM.value(1,5),
--            DBMS_RANDOM.value(18,80),
--            DBMS_RANDOM.value(0,1000000),
--            s_club_id)
--into club
--(id, budget, training_ground_quality, reputation, country_of_origin, competition_id, manager_id)
--    values 
--   (1 +(select nvl(max(id),0) from club),
--    DBMS_RANDOM.value(0,1000000),
--    DBMS_RANDOM.value(1,5),
--    DBMS_RANDOM.value(1,5),
--    dbms_random.string('A', 6),
--    (SELECT id FROM competition SAMPLE(1) WHERE rownum = 1), --https://stackoverflow.com/questions/27879874/how-to-get-random-foreign-key-in-sql-developer
--    s_manager_id)
--select s_club_id, s_manager_id
--from
--(
--    select
--        (1 +(select nvl(max(id),0) from club)) s_club_id,
--        (1 +(select nvl(max(id),0) from manager)) s_manager_id
--    from dual
--)
----connect by level <=10
--;

--insert into stadium
--    select 
--   level +(select nvl(max(id),0) from stadium) as id,
--    DBMS_RANDOM.value(0,40000) as capacity,
--    DBMS_RANDOM.value(1,5) as reputation,
--    dbms_random.string('A', 6) as location,
--    DBMS_RANDOM.value(1900,2100) as build_year,
--    DBMS_RANDOM.value(0,1000000) as value,
--    DBMS_RANDOM.value(0,200) as ticket_price,
--    level +(select nvl(max(id),0) from stadium) as club_id
--from dual
--connect by level <=10
--;

--insert into match
--    select 
--        level +(select nvl(max(id),0) from match) as id,
--        DBMS_RANDOM.value(0,100) as score,
--        DBMS_RANDOM.value(1,5) as rating,
--        DBMS_RANDOM.value(0, 40000) as attendance,
--        dbms_random.string('A', 6) as weather,
--        DBMS_RANDOM.value(0,120) as duration,
--        dbms_random.string('A', 6) as referee_name,
--        (SELECT id FROM competition SAMPLE(1) WHERE rownum = 1) as competition_id
--    from dual
--connect by level <=10
--;


--insert into player 
--    select 
--        level +(select nvl(max(id),0) from player) as id,
--        DBMS_RANDOM.value(1, 5) as skill,
--        dbms_random.string('A', 6) as position,
--        DBMS_RANDOM.value(1, 5) as reputation,
--        dbms_random.string('A', 6) as contract_status,
--        DBMS_RANDOM.value(0, 700) as injuries,
--        DBMS_RANDOM.value(15, 50) as age,
--        DBMS_RANDOM.value(15, 50) as wages,
--        DBMS_RANDOM.value(0, 1000000000) as transfer_value,
--        (SELECT id FROM CLUB SAMPLE(1) WHERE rownum = 1) as club_id
--    from dual 
--connect by level <=10

alter table manager
ENABLE constraint manager_club_fk;

alter table club
ENABLE constraint club_manager_fk;