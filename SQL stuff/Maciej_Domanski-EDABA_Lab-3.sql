--Maciej Domañski 303853 - EDABA Lab 3
----------------------- INSERT TRIGGER -----------------------

-- show club which budget was affected by inserting or deleting new/old player
select * from club where id = 1
-- show player who is inserted and by that affects club budget
select * from player where id = 1000000

-- insert trigger creation
-- after inserting a player increase club budget by player value
CREATE OR REPLACE trigger insert_player_trigger after insert on player
for each row
begin
    update club
    set budget = budget + :NEW.transfer_value
    where :NEW.club_id = id;
end;

-- insert
insert into player
values(1000000, 5, 'striker', 3, 'valid', 5, 35, 1000, 20000000, 1)

----------------------- UPDATE TRIGGER -----------------------

-- Show data that is affected by triggers
-- show competition where prize was updated which later changes club reputation
select * from competition where id = 1
-- show club affected by update trigger when competition prize is high enough
select * from club where competition_id = 1

-- update trigger creation
-- updates club reputation if the competition the club is taking part in has high enough prize value
CREATE OR REPLACE trigger update_trigger after update on competition
for each row
begin
    update club
    set reputation = 5
    where 200000 < :NEW.prize AND :NEW.id = competition_id;
end;

-- update
update competition
set prize = 1234567
where id = 1;


----------------------- DELETE TRIGGER -----------------------

-- Show data that is affected by triggers
-- show club which budget was affected by inserting or deleting new/old player
select * from club where id = 1
-- select player who is inserted and by that affects club budget
select * from player where id = 1000000

-- delete trigger creation
-- after deleting a player decrease club budget by player value
CREATE OR REPLACE trigger delete_player_trigger after delete on player
for each row
begin
    update club
    set budget = budget - :OLD.transfer_value
    where :OLD.club_id = id;
end;


-- delete
delete from player
where id = 1000000

