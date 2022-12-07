truncate table stadium;--
truncate table competition;--
truncate table manager;--
truncate table club;--

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



insert all
into manager
(id, skill, reputation, age, wage, club_id)
            values 
           (1 +(select nvl(max(id),0) from manager),
            DBMS_RANDOM.value(1,5),
            DBMS_RANDOM.value(1,5),
            DBMS_RANDOM.value(18,80),
            DBMS_RANDOM.value(0,1000000),
            s_club_id)
into club
(id, budget, training_ground_quality, reputation, country_of_origin, competition_id, manager_id)
    values 
   (1 +(select nvl(max(id),0) from club),
    DBMS_RANDOM.value(0,1000000),
    DBMS_RANDOM.value(1,5),
    DBMS_RANDOM.value(1,5),
    dbms_random.string('A', 6),
    (SELECT id FROM competition SAMPLE(1) WHERE rownum = 1), --https://stackoverflow.com/questions/27879874/how-to-get-random-foreign-key-in-sql-developer
    s_manager_id)
select s_club_id, s_manager_id
from
(
    select
        (1 +(select nvl(max(id),0) from club)) s_club_id,
        (1 +(select nvl(max(id),0) from manager)) s_manager_id
    from dual
)
--connect by level <=10
;

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