use ig_clone;

-- A.1) rewarding most loyal users

select username, created_at
from users
order by created_at asc
limit 5;

-- A.2) remind inactive users to start posting
select username, photos.id as posts
from users
left join photos on users.id = photos.user_id
where photos.id is null;

-- A.3) declaring contest winner
select username as `Contest Winner`, photos.id as ID,count(*) as Total_Likes
from photos
inner join likes on likes.photo_id = photos.id 
inner join users on photos.user_id = users.id
group by photos.id 
order by Total_Likes desc
limit 1;

-- A.4) hashtag researching
select tags.tag_name, count(*) as Total_tags
from photo_tags
join tags on tags.id = photo_tags.tag_id
group by tags.id
order by Total_tags desc
limit 5;

-- A.5) Launch AD Campaign
select dayname(created_at) as day, count(*) as Total_reg
from users 
group by day
order by Total_reg desc
limit 1;

-- B.1) User Engagement
select round(
(select count(*) from photos) / 
(select count(*) from users)) 
as `Average Posts per User`;

-- B.2) Bots & Fake accounts
select id, username, count(*) as total_likes
from users
join likes on likes.user_id = users.id
group by users.id
having total_likes = (select count(*) from photos);


