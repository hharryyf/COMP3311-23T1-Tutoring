-- Week 4 tutorial SQL
-- 1. assignment 1 is out, due next Friday
-- 2. Quiz 3 is out, due this Friday

-- ignore this command: 
-- sudo -u postgres psql mydb
-- \cd /home/z5173587/z5173587/Tutoring/COMP3311-23T1-Tutoring/week4/


-- Find the names of suppliers who supply some red part.
drop view if exists Q12 cascade;
-- create or replace view Q12(name) as


-- Find the sids of suppliers who supply some red or green part.
drop view if exists Q13 cascade;
-- create or replace view Q13(sid) as


-- Find the sids of suppliers who supply some red part or whose address is 221 Packer Street.
drop view if exists Q14 cascade;
-- create or replace view Q14(sid) as


-- Find the sids of suppliers who supply some red part and some green part.
drop view if exists Q15 cascade;
-- create or replace view Q15(sid) as 


-- Find the sids of suppliers who supply every part.
drop view if exists Q16 cascade;
-- create or replace view Q16(sid) as 


-- Find the sids of suppliers who supply every red part.
drop view if exists Q17 cascade;
-- create or replace view Q17(sid) as 


-- Find the sids of suppliers who supply every red or green part.
drop view if exists Q18 cascade;
-- create or replace view Q18(sid) as 

-- Find the sids of suppliers who supply every red part or supply every green part.
drop view if exists Q19 cascade;
-- create or replace view Q19(sid) as 

-- Find pairs of sids such that the supplier with the first sid charges more 
-- for some part than the supplier with the second sid.
drop view if exists Q20 cascade;
-- create or replace view Q20(sid1, sid2) as

-- Find the pids of parts that are supplied by at least two different suppliers.

drop view if exists Q21 cascade;
-- create or replace view Q21(pid) as 

-- Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
drop view if exists Q22 cascade;
-- create or replace view Q22(pid) as

-- Find the pids of parts supplied by every supplier at a price less than 200 dollars
drop view if exists Q23 cascade;
-- create or replace view Q23(pid, number) as

