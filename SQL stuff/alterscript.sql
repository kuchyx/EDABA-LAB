alter table manager
    DISABLE constraint manager_club_fk;

alter table club
    DISABLE constraint club_manager_fk;
alter table club
    DISABLE constraint club_competition_fk;




alter table manager
    ENABLE constraint manager_club_fk;

alter table club
    ENABLE constraint club_manager_fk;
alter table club
    ENABLE constraint club_competition_fk;