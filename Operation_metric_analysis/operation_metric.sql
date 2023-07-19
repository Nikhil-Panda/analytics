use operation_metric;

select * from job_data;


## Case Study 1 (Job Data)

-- A) Number of jobs reviewed: Amount of jobs reviewed over time.
select ds as Date, 
round((count(distinct job_id)/sum(time_spent))*3600) as `Time spent`
from job_data 
where ds between '2020-11-01' and '2020-11-30'
group by ds
order by `Time spent` desc;


-- B)Throughput: It is the no. of events happening per second.
select ds as date,
round(count(event)/sum(time_spent),2) as Daily_Throughput
from job_data
group by ds
order by ds;

#7-day-throughput
select round(count(event)/sum(time_spent),2) as Weekly_throughput
from job_data;


-- C) Percentage share of each language: Share of each language for different events.
select language,
round(100*((count(*)/(select count(*) from job_data))) ,2) as `Percentage Share`
from job_data
group by language
order by `Percentage Share` desc;


-- D) Duplicate rows: Rows that have the same value present in them.
select job_id, actor_id, count(*) as Count
from job_data
group by job_id, actor_id
having Count>1;


##Case Study 2 (Investigating metric spike)

-- 1)User Engagement
SELECT week(occurred_at) as Week,
count(DISTINCT user_id)as Weekly_User_engagement
FROM events
GROUP BY week(occurred_at)
ORDER BY week(occurred_at);


#2
SET @g := 0;
SELECT a.no_of_users, a.date,
( @g := @g + a.no_of_users ) as user_growth
FROM
( SELECT count(user_id) as no_of_users,
date(created_at) as date
FROM users WHERE state = "active"
GROUP BY date(created_at) ) a;


#3
SELECT first AS "Week Numbers" ,
SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS "Week 0",
SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS "Week 1",
SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS "Week 2",
SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS "Week 3",
SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS "Week 4",
SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS "Week 5",
SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS "Week 6",
SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS "Week 7",
SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS "Week 8",
SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS "Week 9",
SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS "Week 10",
SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS "Week 11",
SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS "Week 12",
SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS "Week 13",
SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS "Week 14",
SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS "Week 15",
SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS "Week 16",
SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS "Week 17",
SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS "Week 18"
FROM
( 
SELECT m.user_id, m.login_week, n.first, (m.login_week - first) AS week_number
from
(SELECT user id,EXTRACT(WEEK FROM occurred_at) AS login_week FROM events
GROUP BY 1, 2) m,
(SELECT user id,EXTRACT(WEEK FROM occurred_at) AS `first` FROM events
GROUP BY 1)n
WHERE m.user_id = n.user_id)sub
group by first
order by first;



#4
SELECT week(occurred_at) as Weeks,
device, count(distinct user_id)as User_engagement
FROM events
GROUP BY device,week(occurred_at)
ORDER BY week(occurred_at);

#5
SELECT week(occurred_at) as Week,
count( DISTINCT ( CASE WHEN action = "sent_weekly_digest" THEN user_id end )) as weekly_digest,
count( distinct ( CASE WHEN action = "sent_reengagement_email" THEN user_id end )) as reengagement_mail,
count( distinct ( CASE WHEN action = "email_open" THEN user_id end )) as opened_email,
count( distinct ( CASE WHEN action = "email_clickthrough" THEN user_id end )) as email_clickthrough
FROM emails
GROUP BY week(occurred_at)
ORDER BY week(occurred_at);











number =
number —
number —









-9 THEN 1 ELSE O END) AS
"Week 9",



