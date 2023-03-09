
create table if not exists Suppliers (
      sid     integer primary key,
      sname   text,
      address text
);

create table if not exists Parts (
      pid     integer primary key,
      pname   text,
      colour  text
);

create table if not exists Catalog (
      sid     integer references Suppliers(sid),
      pid     integer references Parts(pid),
      cost    real,
      primary key (sid,pid)
);

delete from catalog where true;
delete from parts where true;
delete from suppliers where true;

insert into Suppliers values (1, 'supplier-1', '221 Packer Street');
insert into Suppliers values (2, 'Yosemite Sham', '222 Packer Street');
insert into Suppliers values (3, 'supplier-3', '223 Packer Street');
insert into Suppliers values (4, null, '221 Packer Street');
insert into Suppliers values (5, 'supplier-5', null);
insert into Suppliers values (6, null, null);
insert into Suppliers values (7, null, '221 Packer Street');

insert into Parts values (1, 'part-1', 'red');
insert into Parts values (2, 'part-2', 'green');
insert into Parts values (3, 'part-3', 'blue');
insert into Parts values (4, 'part-4', 'yellow');
insert into Parts values (5, null, 'red');

-- all suppliers supply part 1 with price lower than 200
insert into Catalog values (1, 3, 199);
insert into Catalog values (2, 3, 198);
insert into Catalog values (3, 3, 197);
insert into Catalog values (4, 3, 199);
insert into Catalog values (5, 3, 199);
insert into Catalog values (6, 3, 199);
insert into Catalog values (7, 3, 199);
-- all suppliers except one supply part 2 with price lower than 200
insert into Catalog values (1, 2, 199);
insert into Catalog values (2, 2, 198);
insert into Catalog values (3, 2, 197);
insert into Catalog values (4, 2, 199);
insert into Catalog values (5, 2, 199);
insert into Catalog values (6, 2, 202);

-- all suppliers supply part 3 with price lower than 200 but supplier 6 does not supply part 3
insert into Catalog values (1, 1, 199);
insert into Catalog values (2, 1, 198);


insert into Catalog values (5, 5, 300);
insert into Catalog values (1, 4, 300);
insert into Catalog values (2, 4, 300);
insert into Catalog values (1, 5, 300);
insert into Catalog values (2, 5, 300);
