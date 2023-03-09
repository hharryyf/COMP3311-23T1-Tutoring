-- Week 4 tutorial SQL
-- 1. assignment 1 is out, due next Friday
-- 2. Quiz 3 is out, due this Friday

-- ignore this command: 
-- sudo -u postgres psql mydb
-- \cd /home/z5173587/z5173587/Tutoring/COMP3311-23T1-Tutoring/week4/


-- Find the names of suppliers who supply some red part.
-- name
-- supplier
-- red part
-- we recongnize all the 3 tables are useful
drop view if exists Q12 cascade;
create or replace view Q12(name) as
select distinct s.sname 
from suppliers as s, parts as p, catalog as c
where s.sid = c.sid and p.pid = c.pid and p.colour = 'red';


-- Find the sids of suppliers who supply some red or green part.
-- 
drop view if exists Q13 cascade;
create or replace view Q13(sid) as
select distinct c.sid 
from parts as p, catalog as c
where p.pid = c.pid and (p.colour = 'red' or p.colour = 'green');


-- Find the sids of suppliers who supply some red part or whose address is 221 Packer Street.
drop view if exists Q14 cascade;
create or replace view Q14(sid) as
select distinct s.sid  
from suppliers as s, catalog as c, parts as p  
where (s.sid = c.sid and p.pid = c.pid and p.colour = 'red') or s.address = '221 Packer Street';

-- Find the sids of suppliers who supply some red part and some green part.
drop view if exists Q15 cascade;
create or replace view Q15(sid) as 
(
    select c.sid 
    from catalog as c, parts as p 
    where c.pid = p.pid and p.colour = 'red'
)

intersect 

(
    select c.sid 
    from catalog as c, parts as p 
    where c.pid = p.pid and p.colour = 'green'
);



-- Find the sids of suppliers who supply every part.
-- a supplier does not have a part that it does not supply
-- {all parts} - {the parts supplier supplies} --> {}
drop view if exists Q16 cascade;
create or replace view Q16(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts)
    except 
    (select c.pid 
    from catalog as c, parts as p 
    where c.pid = p.pid and s.sid = c.sid)
);



-- Find the sids of suppliers who supply every red part.
-- a supplier does not have a red part that it does not supply
-- {all red parts} - {the parts supplier supplies} --> {}
-- {all red parts} - {the red parts supplier supplies} --> {}
drop view if exists Q17 cascade;
create or replace view Q17(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts where colour = 'red')
    except 
    (select p.pid 
    from catalog as c, parts as p 
    where p.colour = 'red' and c.pid = p.pid and c.sid = s.sid)
);


-- Find the sids of suppliers who supply every red or green part.
-- a supplier does not have a red or green part that it does not supply
-- {all red or green parts} - {the parts supplier supplies} --> {}
drop view if exists Q18 cascade;
create or replace view Q18(sid) as 
select s.sid 
from suppliers as s 
where not exists (
    (select pid from parts where colour = 'red' or colour = 'green')
    except 
    (select p.pid 
    from catalog as c, parts as p 
    where c.pid = p.pid and c.sid = s.sid)
);

-- Find the sids of suppliers who supply every red part or supply every green part.
drop view if exists Q19 cascade;
create or replace view Q19(sid) as 
(
    select s.sid 
    from suppliers as s 
    where not exists (
        (select pid from parts where colour = 'red')
        except 
        (select p.pid 
        from catalog as c, parts as p 
        where p.colour = 'red' and c.pid = p.pid and c.sid = s.sid)
    )
)

union 

(
    select s.sid 
    from suppliers as s 
    where not exists (
        (select pid from parts where colour = 'green')
        except 
        (select p.pid 
        from catalog as c, parts as p 
        where p.colour = 'green' and c.pid = p.pid and c.sid = s.sid)
    )
);


-- Find pairs of sids such that the supplier with the first sid charges more 
-- for some part than the supplier with the second sid.
-- sid1 supplies some parts with greater cost than supplier sid2
drop view if exists Q20 cascade;
create or replace view Q20(sid1, sid2) as
select c1.sid, c2.sid 
from catalog as c1, catalog as c2
where c1.pid = c2.pid and c1.cost > c2.cost
group by c1.sid, c2.sid;

-- Find the pids of parts that are supplied by at least two different suppliers.
-- 1. create a helper view q21_helper that is going to give us (part, number of suppliers supply this part)
-- 2. q21_helper -> get the parts that has number of suppliers greater than or equal to 2
drop view if exists Q21_helper cascade;
create or replace view q21_helper(parts, count) as 
select p.pid, count(distinct c.sid)
from parts as p 
left outer join catalog as c on p.pid = c.pid 
group by p.pid;


drop view if exists Q21 cascade;
create or replace view Q21(pid) as 
select parts
from q21_helper
where count >= 2; 

-- Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
-- 1. find all parts supplied by the supplier "Yosemite Sham"
-- 2. check if the price is equal to the most expensive (maximum) price of parts supplied by "Y... S.."

-- comment: for this question it is always tempting to order the result based on price and limit 1, WRONG!
drop view if exists Q22 cascade;
create or replace view Q22(pid) as
select c.pid 
from catalog as c, suppliers as s 
where c.sid = s.sid and s.sname = 'Yosemite Sham' and c.cost = (
    select max(cc.cost)
    from catalog as cc 
    where cc.sid = s.sid
);



-- Find the pids of parts supplied by every supplier at a price less than 200 dollars
-- if we get the pid of parts the supplier supplies at a price less than $200
-- it should equal to the total number of suppliers 
drop view if exists Q23 cascade;
create or replace view Q23(pid, number) as
select c.pid, count(*) 
from catalog as c 
where c.cost < 200 
group by c.pid 
-- we want to check the count is equal to the total number of suppliers
having count(*) = (select count(*) from suppliers);
