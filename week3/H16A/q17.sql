create table Employee (
    ssn integer,
    birthdate date,
    name text,
    workfor text not null,
    primary key (ssn),
    -- foreign key (workfor) references Department(name) cannot do this, because of circular dependency
);

create table Department (
    name text,
    phone text,
    location text,
    manager integer not null unique, -- to indicate each manager can appears in the department table once
    mdate date,
    primary key (name)
    foreign key (manager) references Employee(ssn)
);

alter table Employee add constraint employee_fk foreign key (workfor) references Department(name);

create table Project (
    pnum integer primary key,
    title text
);


-- weak entity
create table Dependent (
    ssn integer,
    name text,
    relation text,
    birthdate date,
    primary key (ssn, name),
    foreign key (ssn) references Employee(ssn)
);

create table Participation (
    project_id integer,
    employee_id integer,
    "time" integer,
    primary key (project_id, employee_id),
    foreign key (project_id) references Project(pnum),
    foreign key (employee_id) references Employee(ssn)
);
