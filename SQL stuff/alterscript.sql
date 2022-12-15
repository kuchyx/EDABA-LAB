alter table manager
    DISABLE constraint manager_club_fk;

alter table club
    DISABLE constraint club_manager_fk;
alter table club
    DISABLE constraint club_competition_fk;
    



alter table takes_part_in
    add id number;

where exists C
    select * from takes_part_in
    where club_id = match_id and club_id 

alter table takes_part_in
    drop column id




alter table manager
    ENABLE constraint manager_club_fk;

alter table club
    ENABLE constraint club_manager_fk;
alter table club
    ENABLE constraint club_competition_fk;