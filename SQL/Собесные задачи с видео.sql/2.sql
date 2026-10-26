#Задание 1
CREATE TABLE tickets (
    itinerary VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round VARCHAR(1),
    ticket_count INT
);

INSERT INTO tickets VALUES
('QR829', 'BKK', 'DOH', 'R', 254),
('QR832', 'BKK', 'DOH', 'R', 300),
('TN887', 'BKK', 'SIN', 'O', 187),
('VJ814', 'SGN', 'BKK', 'O', 172),
('VJ808', 'SGN', 'DPS', 'O', 182),
('VJ818', 'DOH', 'BKK', 'R', 185),
('TA331', 'DOH', 'BKK', 'O', 104),
('TA460', 'BKK', 'HKT', 'R', 187),
('VJ837', 'BKK', 'SIN', 'O', 106),
('VJ801', 'DPS', 'SGN', 'O', 245),
('QR123', 'DOH', 'BKK', 'O', 150),
('QR456', 'BKK', 'DOH', 'O', 175),
('TH789', 'BKK', 'IST', 'R', 110);


-- Найти самый загруженный маршрут по кол-ву билетов
-- itinerary
-- origin
-- destination
-- oneway_round
-- ticket_count


with df_1 as (
    select origin, destination, sum(ticket_count) as total
    from tickets
    group by origin, destination
),
df_2 as (
    select destination as origin,origin as destination, sum(ticket_count) as total
    from tickets
    where oneway_round='R'
    group by origin, destination
),
df_t as (select origin, destination, total
from df_1
union all
select origin, destination, total
from df_2)
select origin, destination, sum(total)
from df_t
group by origin, destination




#Задание 2
CREATE TABLE tickets (
    Id_Ticket int,
    TicketDate date,
    TicketType text CHECK (TicketType IN ('Standard', 'AllInclusive', 'Dual')), -- Dual на двоих (?)
    Person text,
    PRIMARY KEY (Id_Ticket, Person),
    UNIQUE (TicketDate, Person, TicketType)
);

INSERT INTO tickets VALUES
(1, '2023-01-01', 'Standard', 'Иванов Иван Иванович'),
(2, '2023-01-01', 'AllInclusive', 'Петров Петр Петрович'),
(3, '2023-01-01', 'Dual', 'Сидоров Сидор Сидорович'),
(4, '2023-01-01', 'Standard', 'Кузнецова Анна Сергеевна'),
(5, '2023-01-01', 'AllInclusive', 'Смирнова Елена Владимировна'),

(6, '2023-01-15', 'AllInclusive', 'Иванов Иван Иванович'),
(7, '2023-01-15', 'Standard', 'Петров Петр Петрович'),
(8, '2023-01-15', 'AllInclusive', 'Сидоров Сидор Сидорович'),
(9, '2023-01-15', 'Dual', 'Кузнецова Анна Сергеевна'),

(10, '2023-02-01', 'Standard', 'Иванов Иван Иванович'),
(11, '2023-02-01', 'AllInclusive', 'Иванов Иван Иванович'),
(12, '2023-02-01', 'Dual', 'Петров Петр Петрович'),
(13, '2023-02-01', 'Standard', 'Петров Петр Петрович'),

(14, '2023-02-10', 'Standard', 'Козлов Дмитрий Алексеевич'),
(15, '2023-02-10', 'AllInclusive', 'Новикова Ольга Игоревна'),
(16, '2023-02-10', 'Dual', 'Федоров Михаил Сергеевич');


-- Компания «СНЕЖИНКА» (SNOWFLAKE) проводит ежегодную конференцию. Участие в конференции платное.
-- Есть три уровня билетов:
-- Standard стоимостью 2000 р за одного участника;
-- AllInclusive стоимостью 4000 р за одного участника;
-- Dual стоимостью 6000 р за двух участников.

-- Разработчик сделал таблицу tickets для сохранения информации о приобретении билетов участниками.
-- Часть участников сразу не смогли определиться, какой билет приобрести, поэтому в дальнейшем меняли свое решение.
-- В таблице продажи билетов факт возврата билета никак не отражается, но появляется новая запись о приобретении билета другого уровня.
-- При этом участник мог изменять уровень билета несколько раз в день.
-- Считается, что среди участников конференции нет полных тезок, то есть ФИО каждого участника уникально.

-- Перед конференцией бухгалтерия решила провести сверку. Для этого ей необходимо определить:
-- - количество проданных билетов, количество участников и сумму билетов отдельно по каждому уровню;
-- - общее количество проданных билетов, общее количество участников и общую сумму денег.

-- Уровень участника определяется по следующим правилам:
-- 1) Уровень билета определяется по последней дате приобретения билета;
-- 2) Если в одну дату одним участником были приобретены несколько билетов,
-- то выбирается билет максимального уровня (уровни в порядке убывания: Dual, AllInclusive, Standard);


with replace_value as(
    select Id_Ticket, TicketDate, 
    case when TicketType='Dual' then 1
    when TicketType='AllInclusive' then 2
    else 3 end as TicketType,
    Person
    from tickets
),
score as (
    select Id_Ticket, TicketDate, TicketType, Person,
    row_number() over(partition by Person order by TicketDate desc, TicketType) as rn
    from replace_value
),
result as (
    select Id_Ticket, TicketDate, TicketType, Person
    from score
    where rn = 1
)
select count(*), count(distinct Person),
sum(case when TicketType=1 then 6000 else 0) as 'Dual',
sum(case when TicketType=2 then 4000 else 0) as 'AllInclusive',
sum(case when TicketType=3 then 2000 else 0) as 'Standart'
from result