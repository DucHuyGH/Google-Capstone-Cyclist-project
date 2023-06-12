-- Compare number of trips between customer and subscriber user
select
	usertype,
	count(*) as num_of_trips
from
	all_2019
group by
	usertype

-- Compare total trip duration between customer and subscriber user
select
	usertype,
	sum(tripduration) as total_duration
from
	all_2019
group by
	usertype

-- Compare average trip duration between customer and subscriber user
select
	usertype,
	round(avg(tripduration),2) as avg_duration
from
	all_2019
group by
	usertype

-- Compare total trips taken by month between customer and subscriber user -------------------------------------------------
select
	usertype,
	start_month,
	start_season,
	count(*) as num_of_trips
from
	all_2019
group by
	usertype,
	start_month,
	start_season
order by
	start_month,
	usertype

-- Compare average trip duration by month between customer and subscriber user
select
	usertype,
	start_month,
	round(avg(tripduration),2) as avg_duration
from
	all_2019
group by
	start_month,
	usertype
order by
	start_month,
	usertype

-- Compare total trips by day in week between customer and subscriber user ------------------------------------------------------
select
	usertype,
	day_in_week,
	count(*) as num_of_trips
from
	all_2019
group by
	usertype,
	day_in_week
order by
	CASE 
    WHEN day_in_week = 'Monday' THEN 1
    WHEN day_in_week = 'Tuesday' THEN 2
    WHEN day_in_week = 'Wednesday' THEN 3
    WHEN day_in_week = 'Thursday' THEN 4
    WHEN day_in_week = 'Friday' THEN 5
    WHEN day_in_week = 'Saturday' THEN 6
    WHEN day_in_week = 'Sunday' THEN 7
END,
	usertype

-- Compare average duration by day in week between customer and subscriber user
select
	usertype,
	day_in_week,
	round(avg(tripduration),2) as avg_duration
from
	all_2019
group by
	usertype,
	day_in_week
order by
	CASE 
    WHEN day_in_week = 'Monday' THEN 1
    WHEN day_in_week = 'Tuesday' THEN 2
    WHEN day_in_week = 'Wednesday' THEN 3
    WHEN day_in_week = 'Thursday' THEN 4
    WHEN day_in_week = 'Friday' THEN 5
    WHEN day_in_week = 'Saturday' THEN 6
    WHEN day_in_week = 'Sunday' THEN 7
END,
	usertype

-- Compare total trips by time of day between customer and subscriber user --------------------------------------------------------------
select
	usertype,
	start_hour_of_day,
	count(*) as num_of_trips
from
	all_2019
group by
	usertype,
	start_hour_of_day
order by
	start_hour_of_day,
	usertype

-- Compare averaga duration by time of day between casual and subscriber user
select
	usertype,
	start_hour_of_day,
	round(avg(tripduration),2) as avg_duration
from
	all_2019
group by
	usertype,
	start_hour_of_day
order by
	start_hour_of_day,
	usertype

-- Top 10 most used starting station by customer user
select
	top 10
	a.usertype,
	a.from_station_name,
	b.latitude,
	b.longtitude,
	count(*) as num_of_trips
from
	all_2019 a
	join address b
	on a.from_station_name=b.from_station_name
where
	usertype='Customer'
group by
	a.usertype,
	a.from_station_name,
	b.latitude,
	b.latitude
order by
	5 desc
	
-- Top 10 most used starting station by subscriber user
select
	top 10
	a.usertype,
	a.from_station_name,
	b.latitude,
	b.longtitude,
	count(*) as num_of_trips
from
	all_2019 a
	join address b
	on a.from_station_name=b.from_station_name
where
	usertype='Subscriber'
group by
	a.usertype,
	a.from_station_name,
	b.latitude,
	b.longtitude
order by
	5 desc
	
