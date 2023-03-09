-- Week 4 tutorial SQL
-- 1. assignment 1 is out, due next Friday
-- 2. Quiz 3 is out, due this Friday

-- ignore this command: 
-- sudo -u postgres psql mydb
-- \cd /home/z5173587/z5173587/Tutoring/COMP3311-23T1-Tutoring/week4/


-- Find the names of suppliers who supply some red part.
-- name of supplier -> suppliers
-- red part -> parts
drop view if exists Q12 cascade;
create or replace view Q12(name) as
select distinct s.sname 
from suppliers as s, parts as p, catalog as c 
where s.sid = c.sid and p.pid = c.pid and p.colour = 'red';

-- Find the sids of suppliers who supply some red or green part.
-- we only need catalog and parts tables
drop view if exists Q13 cascade;
create or replace view Q13(sid) as
select distinct c.sid
from parts as p, catalog as c 
where p.pid = c.pid and (p.colour = 'red' or p.colour = 'green');  


-- Find the sids of suppliers who supply some red part or whose address is 221 Packer Street.
-- <supplier, red part>
-- or supplier with address 221 parker street
drop view if exists Q14 cascade;
create or replace view Q14(sid) as
(
    select distinct c.sid
    from parts as p, catalog as c 
    where p.pid = c.pid and p.colour = 'red'
)
union 
(
    select distinct sid 
    from suppliers 
    where address = '221 Packer Street'
);


-- Find the sids of suppliers who supply some red part and some green part.
-- Find the sids of suppliers who supply some red part
-- Find the sids of suppliers who supply some green part
-- intersection of these 2 sets
drop view if exists Q15 cascade;
create or replace view Q15(sid) as 
(
    select distinct c.sid
    from parts as p, catalog as c 
    where p.pid = c.pid and p.colour = 'red'
)  
-- take away is this intersect keyword
intersect 

(
    select distinct c.sid
    from parts as p, catalog as c 
    where p.pid = c.pid and p.colour = 'green'
);

-- Find the sids of suppliers who supply every part.
-- Find the id of entity A that is associated with every B with some properties
-- Find the sids of suppliers that does not have a part is does not supply
-- {all parts} - {the parts the supplier supplies} = {}
drop view if exists Q16 cascade;
create or replace view Q16(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts)
    except -- we use this to model the difference between 2 sets
    (select c.pid
    from catalog as c 
    where c.sid = s.sid)
);

-- Find the sids of suppliers who supply every red part.
-- Find the sids of suppliers that does not have a red part is does not supply
-- {all red parts} - {the parts the supplier supplies} = {}
-- {all red parts} - {the red parts the supplier supplies} = {} definitely correct
drop view if exists Q17 cascade;
create or replace view Q17(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts where colour = 'red')
    except 
    (select c.pid 
    from catalog as c 
    where s.sid = c.sid)
);


-- Find the sids of suppliers who supply every red or green part.
-- {all red or green parts} - {the parts the supplier supplies} = {}
drop view if exists Q18 cascade;
create or replace view Q18(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts where (colour = 'red' or colour = 'green'))
    except 
    (select c.pid 
    from catalog as c 
    where s.sid = c.sid)
);

-- Find the sids of suppliers who supply every red part 
-- or
-- the sids of suppliers who supply every green part.
drop view if exists Q19 cascade;
create or replace view Q19(sid) as 
(
    select s.sid 
    from suppliers as s 
    where not exists (
        (select pid from parts where colour = 'red')
        except 
        (select c.pid 
        from catalog as c 
        where s.sid = c.sid)
    )
)
union
(
    select s.sid 
    from suppliers as s 
    where not exists (
        (select pid from parts where colour = 'green')
        except 
        (select c.pid 
        from catalog as c 
        where s.sid = c.sid)
    )
);




-- Find pairs of sids such that the supplier with the first sid charges more 
-- for some part than the supplier with the second sid.
-- catalog 
drop view if exists Q20 cascade;
create or replace view Q20(sid1, sid2) as
select c1.sid, c2.sid 
from catalog as c1, catalog as c2 
where c1.cost > c2.cost and c1.pid = c2.pid
group by c1.sid, c2.sid
order by c1.sid, c2.sid;
-- question: why can we remove c1.sid <> c2.sid
-- answer: observe the schema, (sid, pid) forms a composite primary key, if pid is the same, cost is different, sid cannot be the same


-- Find the pids of parts that are supplied by at least two different suppliers.
-- 1. create 2 views: 1) helper view that give us (parts, the number of suppliers that supply this part)
-- 2. answer view: query on the helper view
drop view if exists q21_helper cascade;
drop view if exists Q21 cascade;

-- if a part is not supplied by any supplier, it should also be included in the result with count=0
create or replace view q21_helper(parts, count) as 
select p.pid, count(distinct c.sid)
from parts as p 
left outer join catalog as c on p.pid = c.pid
group by p.pid;

-- question: what's the difference between inner join and left outer join
-- answer: inner join <p.pid, c.pid>, the result table contains tuples that appears in both tables
-- left outer join, we must include p.pid at least once in the final result, and we put <p.pid, null> as the result tuple if there's no c associated with p in table catalog 


create or replace view Q21(pid) as 
select parts 
from q21_helper 
where count >= 2;

-- Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
-- 1. find the pid of all parts supplied by "Yosemite Sham"
-- 2. check if the price is the most expensive
drop view if exists Q22 cascade;
create or replace view Q22(pid) as
select distinct c.pid 
from catalog as c 
join  suppliers as s on c.sid = s.sid 
where s.sname = 'Yosemite Sham' and c.cost = (
    select max(cc.cost)
    from catalog as cc 
    where cc.sid = s.sid
);

-- Find the pids of parts supplied by every supplier at a price less than 200 dollars
drop view if exists Q23 cascade;
create or replace view Q23(pid) as
select c.pid
from catalog as c 
where c.cost < 200
-- filter all the pid with cost < 200
group by c.pid
-- group by pid, a pid is going to appear multiple times because it can associated with multiple sid

-- check if count(*) = (select count(*) from suppliers)?
having count(*) = (select count(*) from suppliers);

-- count if the number of suppliers supply this part is equal to the total number of suppliers
-- <pid, sid>
