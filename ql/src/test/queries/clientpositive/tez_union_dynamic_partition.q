SET hive.vectorized.execution.enabled=false;
set hive.mapred.mode=nonstrict;
set hive.explain.user=false;
create table dummy_n2(i int);
insert into table dummy_n2 values (1);
select * from dummy_n2;

create table partunion1(id1 int) partitioned by (part1 string);

set hive.exec.dynamic.partition.mode=nonstrict;

explain insert into table partunion1 partition(part1)
select temps.* from (
select 1 as id1, '2014' as part1 from dummy_n2 
union all 
select 2 as id1, '2014' as part1 from dummy_n2 ) temps;

insert into table partunion1 partition(part1)
select temps.* from (
select 1 as id1, '2014' as part1 from dummy_n2 
union all 
select 2 as id1, '2014' as part1 from dummy_n2 ) temps;

select * from partunion1;
