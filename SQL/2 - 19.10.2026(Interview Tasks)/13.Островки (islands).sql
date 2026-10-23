#Задание 1
Для каждого пользователя найдите все периоды непрерывной ежедневной активности. 
Если пользователь был активен несколько раз за один день, этот день нужно учитывать один раз.
Выведите начало, конец и длину каждого островка.

user_activity
user_id	activity_dt
1	    2026-01-01
1	    2026-01-02
1	    2026-01-04
1	    2026-01-05
1	    2026-01-06
2	    2026-01-03
2	    2026-01-05

Способ 1
with unique_dt as (
    select distinct user_id, activity_dt
    from user_activity
), 
grouped as (
    select user_id, activity_dt,
    activity_dt - (row_number() over(partition by user_id order by activity_dt))::int as grp
    from unique_dt
)
select user_id, min(activity_dt) as start_dt ,max(activity_dt) as end_dt, count(*) as len
from grouped
group by user_id, grp



Способ 2
with unique_dt as (
    select distinct user_id, activity_dt
    from user_activity
),
df_diff as (
    select user_id, activity_dt, activity_dt - lag(activity_dt) over(partition by user_id order by activity_dt) as diff
    from unique_dt
),
df_flag as (
    select user_id, activity_dt, case when diff=1 then 0 else 1 end as flag
    from df_diff
),
df_sum as (
    select user_id, activity_dt, sum(flag) over(partition by user_id order by activity_dt) as npsum
    from df_flag
)
select user_id, min(activity_dt), max(activity_dt), count(*) as len
from df_sum
group by user_id, npsum



#Задание 2
История заказа содержит последовательность смен статуса.
Объедините соседние записи с одинаковым статусом в отдельные периоды.
Один и тот же статус может встречаться повторно после другого статуса — это уже новый островок.

order_status_history
order_id	changed_at	        status
10	        2026-02-01 10:00	new
10	        2026-02-01 10:05	new
10	        2026-02-01 10:20	processing
10	        2026-02-01 11:00	new
10	        2026-02-01 11:10	new
20	        2026-02-01 09:00	processing


Способ 1
with grouped as (
    select order_id, changed_at, status,
    row_number() over(partition by order_id, status order by changed_at) as rnp,
    row_number() over(partition by order_id order by changed_at) as rn
    from order_status_history
)
select order_id, status, min(changed_at) as start, max(changed_at) as end, count(*) as cnt 
from grouped
group by order_id, status, rn-rnp
order by order_id, start


Способ 2
with t as(
    select order_id, changed_at, status,
    lag(status) over(partition by order_id order by changed_at) as shift
    from order_status_history
),
df_flag as (
    select order_id, changed_at, status, case when status=shift then 0 else 1 end as flag
    from t 
),
np_sum as (
    select order_id, changed_at,status, sum(flag) over(partition by order_id order by changed_at) as q_sum
    from df_flag
)
select order_id, status, min(changed_at) as start, max(changed_at) as end, count(*) as cnt
from np_sum
group by order_id, status, q_sum
order by order_id, start



#Задание 3
Для каждого рейса найдите блоки минимум из трех свободных мест с последовательными номерами.
Выведите первое и последнее место в блоке и количество мест.

free_seats
route_id	seat_no
100	        1
100	        2
100	        3
100	        5
100	        6
200	        10
200	        11
200	        12
200	        13



Способ 1
with t as(
    select route_id, seat_no, lag(seat_no) over(partition by route_id order by seat_no) as shift
    from free_seats
),
q as (
    select route_id, seat_no, case when seat_no-shift=1 then 0 else 1 end as flag
    from t
)
w as (
    select route_id, seat_no, sum(flag) over(partition by route_id order by seat_no) as np_sum
    from q
)
select route_id,min(seat_no) ,max(seat_no), count(*) as cnt
from w
group by route_id, np_sum
having count(*)>=3



Способ 2
with t as(
    select route_id, seat_no,
    seat_no-(row_number() over(partition by route_id order by seat_no))::int as diff
    from free_seats
)
select route_id, min(seat_no) as mn, max(seat_no) as mx, count(*) as cnt
from t
group by route_id, diff
having count(*)>=3



#Задание 4
Разбейте события каждого пользователя на сессии. Новая сессия начинается,
если от предыдущего события прошло больше 30 минут.
Выведите границы сессии и количество событий в ней.

events
user_id	event_ts
1	    2026-03-01 10:00
1	    2026-03-01 10:20
1	    2026-03-01 11:05
1	    2026-03-01 11:25
2	    2026-03-01 09:00
2	    2026-03-01 09:30


with t as(select user_id, event_ts, lag(event_ts) over(partition by user_id order by event_ts) as shift
from events),
d as(
    select user_id, event_ts, case when event_ts-shift <= INTERVAL '30 minutes' then 0 else 1 end as flag
    from t
)
b as (
    select user_id, event_ts, sum(flag) over(partition by user_id order by event_ts) as np_sum
    from d
)
select user_id, min(event_ts), max(event_ts), count(*)
from b
group by user_id, np_sum



#Задание 5
Для каждого пользователя объедините периоды подписки,
которые пересекаются или идут вплотную друг за другом.
Решение должно корректно работать и для вложенных интервалов.

subscriptions
user_id	start_dt	end_dt
1	    2026-01-01	2026-01-05
1	    2026-01-04	2026-01-10
1	    2026-01-11	2026-01-12
1	    2026-01-15	2026-01-18
2	    2026-02-01	2026-02-03


'''Тяжелая задача, сама не догадалась(('''

with ordered as (
    select user_id, start_dt, end_dt,
    max(end_dt) over(partition by user_id order by start_dt, end_dt
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) as max_previous_end
    from subscriprions
),
marked as (
    select user_id, start_dt, end_dt,
    case when max_previous_end is null or start_dt > max_previous_end + 1 then 1 else 0 end as flag
    from ordered
)
grouped as (
    select user_id, start_dt, end_dt, sum(flag) over(partition by user_id order by start_dt,end_dt) as np_sum
    from marked
)
select min(start_dt),max(end_dt)
from grouped
group by user_id, np_sum



