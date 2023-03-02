create table S (
	sid integer primary key,
	r integer
);
    
create table R (
	rid integer primary key,
	s integer
);

alter table S add constraint s_fk foreign key (r) references R(rid) deferrable;
alter table R add constraint r_fk foreign key (s) references S(sid) deferrable;

-- I want to insert in S(1, 2) and R(2, 1)
-- what should we do?

-- (1, 2) and (2, 1), you want it to check the fk constraints after both tuples are inserted

begin;
	set constraints all deferred;
	insert into S values (1, 2);
	insert into R values (2, 1);
commit;

-- bad

begin;
	set constraints all deferred;
	insert into S values (3, 4);
	insert into R values (4, 3);
	insert into R values (9, 8);
commit;