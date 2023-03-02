

-- ER

create table P (
    id integer primary key,
    a integer
);


-- ER mapping, each child's table we need to put in the child attribute + the primary key of the parent's attribute
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

create table T (
    id integer primary key,
    d integer,
    foreign key (id) references P(id)
);


-- OO

create table P (
    id integer primary key,
    a integer
);

-- OO style mapping, we need to put in ALL the attributes of the child as well as all the attributes of the parent in the child table

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


-- Single Table with NULL

-- if we want to insert a tuple of type R
-- (id: not null, a: can be null,b: cannot be null, c: must be null, d: must be null) subclass = 'R'

create table P (
    id integer primary key,
    a integer,
    b integer,
    c integer,
    d integer,
    subclass varchar(1) check (((b is not null) and (c is null) and (d is null) and (subclass = 'R'))
                        or ((b is null) and (c is not null) and (d is null) and (subclass = 'S'))
                        or ((b is null) and (c is null) and (d is not null) and (subclass = 'T'))
                        or ((b is null) and (c is null) and (d is  null) and (subclass is null))
);