
create table Employee (
    ssn integer primary key,
    birthdate date,
    name text,
    workfor text not null,
    -- foreign key (workfor) references Department(name)
);

create table Department (
    name text primary key,
    phone text,
    location text,
    manager integer not null unique,
    mdate date,
    foreign key (manager) references Employee(ssn)
);

alter table Employee add constraint e_fk foreign key (workfor) references Department(name);

create table Project (
    pnum integer primary key,
    title text
);

create table Dependent (
    ssn integer,
    name text,
    birthdate date,
    relation text,
    primary key (ssn, name),
    foreign key (ssn) references Employee(ssn)
);

-- map the n:m, the total participation of project cannot be represented 
create table Participation (
    employee_id integer,
    project_id integer,
    "time" integer, 
    primary key(employee_id, project_id),
    foreign key (employee_id) references Employee(ssn),
    foreign key (project_id) references Project(pnum)
);



