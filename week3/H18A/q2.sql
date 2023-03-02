-- 1) 

-- good answer: maps teachers to teaching a subject, where each teacher teaches 0/1 subjects, and a subject have 0+ teachers

-- create 1 table per entity

-- if the relationship is 1:n or 1:1, the "relationship" would be a foreign key in one of the table

-- where should we put (teaches, semester)


create table subject (
    subjcode integer primary key,

);

create table teacher (
    staff_id integer primary key,
    teaches integer,
    semester text,
    foreign key (teaches) references subject(subjcode)
);



-- 2)

-- good answer: maps teachers to teaching a subject, where each teacher teaches 0+ subjects, and a subject have 0+ teachers

create table subject (
    subjcode integer primary key
);

create table teacher (
    staff_id integer primary key
);

create table teaches (
    subjcode integer,
    staff_id integer,
    semester text,
    primary key (staff_id, subjcode),
    foreign key (subjcode) references subject(subjcode),
    foreign key (staff_id) references teacher(staff_id)
);

-- 3) 

-- good answer: maps teachers to teaching a subject, where each teacher teaches 0~1 subjects, and a subject have 1 teachers


create table teacher (
    staff_id integer primary key
);


create table subject (
    subjcode integer primary key
    teaches integer not null unique, -- unique for the 1:1
    semester text,
    foreign key (teaches) references teacher(staff_id)
);
