-- ER

-- we only need to put the child attributes and the primary key of the parent in the child table

create table P (
    id integer primary key,
    a integer
);

create table R (
    id integer primary key,
    b integer,
    foreign key (id) references P(id)
);

create table S (
    id integer primary key,
    c integer,
    foreign key (id) references P(id)
);

create table T(
    id integer primary key,
    d integer,
    foreign key (id) references P(id)
);

-- OO

-- every child table contains not just the primary of the parent, but ALL the attributes of the parent

create table P (
    id integer primary key,
    a integer
);

create table R (
    id integer primary key,
    a integer,
    b integer,
    foreign key (id) references P(id)
);

create table S (
    id integer primary key,
    a integer,
    c integer,
    foreign key (id) references P(id)
);

create table T (
    id integer primary key,
    a integer,
    d integer,
    foreign key (id) references P(id)
);


-- Single Table

-- the union of ALL the attributes of the parent and all children

-- also need to check the disjoint
-- an object can only be either R or S or T but not both

-- instance for R, (id, a null/not null, b null/not null, c null, d null, subclass = 'R')

create table P (
    id integer primary key,
    a integer,
    b integer,
    c integer,
    d integer,
    subclass varchar(1) check ((subclass = 'R' and (c is null) and (d is null))
                        or (subclass = 'S' and (b is null) and (d is null))
                        ...)    
);
