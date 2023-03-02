create table S (
	sid integer primary key,
	r integer
);
    
create table R (
	rid integer primary key,
	s integer
);

alter table S add constraint s_fk foreign key(r) references R(rid) on delete cascade deferrable;

alter table R add constraint r_fk foreign key(s) references S(sid) on delete cascade deferrable;

-- insert into S values (1, 2); create an error

-- insert into S values (1, 2);
-- insert into R values (2, 1);

-- what we want?
-- we want the foreign key constraints to be checked after we insert a group of data

begin;
set constraints all deferred;
insert into S values (1, 2);
insert into R values (2, 1);
commit;

-- bad: nothing going to be inserted in
begin;
set constraints all deferred;
insert into S values (3, 4);
insert into R values (4, 3);
insert into R values (11, 10);
commit;


