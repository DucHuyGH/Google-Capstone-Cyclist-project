select
	*
from
	all_2019

-- Counting rows that have null cells in 'gender' column
select
	usertype,
	count(*) as num_of_trip,
	count(case when gender is null then 1 else null end) as num_of_null,
	cast(count(case when gender is null then 1 else null end) as float)/cast(count(*) as float)*100 as null_percent
from
	all_2019
group by
	usertype

-- Counting rows that have null in 'birthyear' column
select
	usertype,
	count(*) as num_of_trip,
	count(case when birthyear is null then 1 else null end) as num_of_null,
	cast(count(case when birthyear is null then 1 else null end) as float)/cast(count(*) as float)*100 as null_percent
from
	all_2019
group by
	usertype

select
	count(trip_id)-count(distinct trip_id) as num_of_duplicates
from
	all_2019

-------------------------- Check for duplicate ---------------------------------------------------------------------------------
select  -- Create contemporary table dupCTE
	*,
	row_number() over (
	partition by start_time,
		     end_time,
		     bikeid,
		     tripduration,
		     from_station_id,
		     to_station_id,
		     usertype
	order by trip_id
		           ) row_num
into dupCTE
from all_2019

select -- Check row_num > 1
	*
from
	dupCTE
where
	row_num > 1

delete -- Delete rows that have row_num > 1 (116 rows removed)
from
	dupCTE
where
	row_num > 1

select -- Recheck rows that have row_num > 1 (no row left)
	*
from
	dupCTE
where
	row_num > 1

truncate table all_2019 -- Erase all date in table all_2019

alter table all_2019 -- Add row_num row to table all_2019
add row_num int

insert into all_2019 -- Insert new data from table dupCTE to all_2019
select * from dupCTE

select
	*
from
	all_2019

-- Checking for trip_id length
select
	distinct(len(trip_id)) as tripid_len
from
	all_2019

-- Checking earliest date and latest date
select
	max(start_time) as max_start,
	min(start_time) as min_start
from
	all_2019

-- Checking if there is any negative trip duration
select
	count(*) as num_of_trips
from
	all_2019
where
	tripduration < 0







