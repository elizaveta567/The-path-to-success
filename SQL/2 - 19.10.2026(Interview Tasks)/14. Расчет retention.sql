#Задание 1
Дата первого события пользователя считается датой его привлечения.
Посчитайте общий D1 retention: долю пользователей, 
у которых было хотя бы одно событие ровно на следующий календарный день.
Несколько событий одного пользователя нужно считать один раз.

events
user_id	event_dt
1	    2026-04-01
1	    2026-04-02
1	    2026-04-02
2	    2026-04-01
2	    2026-04-03
3	    2026-04-05
3	    2026-04-06


with distinct_events as (
    select distinct user_id, event_dt
    from events
),
first_event as (
    select user_id, min(event_dt) as first_dt
    from distinct_events
    group by user_id
),
user_activity as (
    select f.user_id, f.first_dt, e.event_dt 
    from first_event f inner join distinct_events e on f.user_id=e.user_id
),
cohort_lifetime as(
    select user_id, first_dt, event_dt, event_dt-first_dt as diff
    from user_activity
),
grouped as (select diff, count(user_id) as cnt
from cohort_lifetime
group by diff
),
pivot_raw as (
    select max(case when diff=0 then cnt else 0 end) as all, max(case when diff=1 then cnt else 0 end) as one_event_next_day
    from grouped
)
select round(one_event_next_day*100/nullif(all,0),3)
from pivot_raw



Эталонное решение:

first_event as (
    select user_id, min(event_dt) as first_dt
    from distinct_events
    group by user_id
)
select count(distinct f.user_id),
count(distinct e.user_id), round(count(distinct e.user_id)*100/NULLIF(count(distinct f.user_id),0),4) as d1_retentiom
from first_event f left join distinct_events e on f.user_id = e.user_id and first_dt + 1= event_dt



#Задание 2
Для каждой даты регистрации посчитайте размер когорты и exact retention на D1, D7 и D30.
Данные полны по 2026-04-30 включительно, поэтому в расчет возьмите только когорты, 
для которых уже успел наступить D30.

users
user_id	registration_dt
1	    2026-03-01
2	    2026-03-01
3	    2026-03-02
4	    2026-03-02

events
user_id	event_dt
1	    2026-03-02
1	    2026-03-08
1	    2026-03-31
2	    2026-03-08
3	    2026-03-03
3	    2026-04-01



with t as(
    select registration_dt, count(user_id) as size
    from users
    where registration_dt <= DATE '2026-04-30' - INTERVAL '30 days'
    group by registration_dt
),
q as (
    select u.user_id, u.registration_dt, e.event_dt, e.event_dt-u.registration_dt as cohort_day
    from users u join events e on u.user_id=e.user_id
    join t on t.registration_dt=u.registration_dt - отсекаем ненужные когорты
),
w as (
    select registration_dt, cohort_day, count(distinct user_id) as cnt
    from q
    group by registration_dt, cohort_day 
)
select t.registration_dt, cohort_day,size, round(cnt*100.0/nullif(size,0),3) as retention_pct
from w join t on t.registration_dt=w.registration_dt
where cohort_day in (1,7,30)



Эталонное решение:
with cohorts as (
    select user_id, registration_dt as cohort_dt
    from users
    where registration_dt <= DATE '2026-04-30'-INTERVAL '30 days'
)
select c.cohort_dt,count(distinct(c.user_id)) as size,
100.0*count(distinct case when e.event_dt+1=c.cohort_dt then user_id end)/nullif(count(distinct(c.user_id)),0) as d1_retention,
100.0*count(distinct case when e.event_dt+7=c.cohort_dt then user_id end)/nullif(count(distinct(c.user_id)),0) as d7_retention,
100.0*count(distinct case when e.event_dt+30=c.cohort_dt then user_id end)/nullif(count(distinct(c.user_id)),0) as d30_retention
from cohorts c left join events e on c.user_id = e.user_id and e.event_dt between
c.cohort_dt + 30 and c.cohort_dt + 1
group by c.cohort_dt



#Задание 3
По состоянию на 2026-04-30 посчитайте две метрики:
exact D7 retention — активность ровно на седьмой день после регистрации;
rolling D7 retention — активность на седьмой день или в любой более поздний день.
Исключите пользователей, для которых D7 еще не наступил.

users
user_id	registration_dt
1	2026-04-01
2	2026-04-10
3	2026-04-24

events
user_id	event_dt
1	2026-04-08
1	2026-04-20
2	2026-04-18
3	2026-04-30


with cohorts as(
    select user_id, registration_dt as cohort_dt
    from users
    where registration_dt + INTERVAL '7 days' <= DATE '2026-04-30'
)
select c.cohort_dt,
100.0*count(distinct case when e.event_dt-c.cohort_dt=7 then c.user_id end)/NULLIF(count(distinct c.user_id),0),
100.0*count(distinct case when e.event_dt-c.cohort_dt>=7 then c.user_id end)/NULLIF(count(distinct c.user_id),0)
from cohorts c left join events e on c.user_id=e.user_id and e.event_dt<= date '2026-04-30'
group by c.cohort_dt



#Задание 4
Соберите retention по недельным когортам в длинном формате за недели W0–W4.
Когорта определяется неделей регистрации, а активность — календарной неделей события. 
Для каждой пары cohort_week и week_number выведите размер когорты, 
число активных пользователей и retention.

users
user_id	registration_dt
1	    2026-01-05
2	    2026-01-07
3	    2026-01-12
4	    2026-01-13

events
user_id	event_dt
1	    2026-01-06
1	    2026-01-14
1	    2026-01-27
2	    2026-01-08
3	    2026-01-20
4	    2026-02-03


with cohort as (
    select user_id, date_trunc('week',registration_dt)::date as cohort_dt
    from users
)
select c.cohort_dt, count(distinct u.user_id),
100.0*count(distinct case when (date_trunc('week',e.event_dt)::date-c.cohort_dt)/7=0 then u.user_id end)/NULLIF(count(distinct u.user_id),0),
100.0*count(distinct case when (date_trunc('week',e.event_dt)::date-c.cohort_dt)/7=1 then u.user_id end)/NULLIF(count(distinct u.user_id),0),
100.0*count(distinct case when (date_trunc('week',e.event_dt)::date-c.cohort_dt)/7=2 then u.user_id end)/NULLIF(count(distinct u.user_id),0),
100.0*count(distinct case when (date_trunc('week',e.event_dt)::date-c.cohort_dt)/7=3 then u.user_id end)/NULLIF(count(distinct u.user_id),0),
100.0*count(distinct case when (date_trunc('week',e.event_dt)::date-c.cohort_dt)/7=4 then u.user_id end)/NULLIF(count(distinct u.user_id),0)
from cohort c left join events e on c.user_id=e.user_id
group by c.cohort_dt



#Задание 5
Постройте когортную матрицу M0–M3. Когорта — календарный месяц регистрации;
M0 — активность в месяце регистрации, M1 — в следующем месяце и так далее. 
В строке должны быть месяц когорты, ее размер и четыре значения retention в процентах.

users 
user_id	registration_dt
1	2026-01-10
2	2026-01-20
3	2026-02-05
4	2026-02-18

events
user_id	event_dt
1	2026-01-11
1	2026-02-03
1	2026-04-01
2	2026-01-25
2	2026-03-10
3	2026-02-06
3	2026-03-01


with cohort as (
    select user_id, date_trunc('month',registration_dt)::date as cohort_dt
    from users
)
select c.cohort_dt, count(distinct c.user_id),
100.0*count(distinct case when date_trunc('month',e.event_dt)::date=c.cohort_dt then user_id end)/NULLIF(count(distinct c.user_id),0) as M0,
100.0*count(distinct case when date_trunc('month',e.event_dt)::date=c.cohort_dt+INTERVAL '1 month' then user_id end)/NULLIF(count(distinct c.user_id),0) as M1,
100.0*count(distinct case when date_trunc('month',e.event_dt)::date=c.cohort_dt+INTERVAL '2 month' then user_id end)/NULLIF(count(distinct c.user_id),0) as M2,
100.0*count(distinct case when date_trunc('month',e.event_dt)::date=c.cohort_dt+INTERVAL '3 month' then user_id end)/NULLIF(count(distinct c.user_id),0) as M3
from cohort c left join events e on c.user_id = e.user_id
group by c.cohort_dt