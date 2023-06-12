-- Standardize date format in start_time column
select
	*
from
	all_2019

alter table all_2019 -- Add column for starting day
add start_day date

update all_2019
set start_day = convert(date,start_time)

alter table all_2019 -- Add column for starting time in day
add start_hour_of_day int

update all_2019
set start_hour_of_day = datepart(hour,start_time)

alter table all_2019 -- Add column for starting month
add start_month int

update all_2019
set start_month = month(start_time)

alter table all_2019 -- Add column for starting season
add start_season nvarchar(50)

update all_2019
set start_season = case when start_month in (1, 2, 3) then 'Spring'
						when start_month in (4, 5, 6) then 'Summer'
						when start_month in (7, 8, 9) then 'Fall'
						else 'Winter'
						end

alter table all_2019
add day_in_week nvarchar(50)

update all_2019
set day_in_week = datename(weekday, start_time)