-- first get the id of the movie
-- then get all the ids of the actors in that movie
-- finally select the first and last name of those id's, and concatentate
	-- them together with a space in between
-- select concat(first," ", last) as fullname
-- from Actor
-- where id in 
-- (
-- 	select aid
-- 	from MovieActor
-- 	where mid =	
-- 	(
-- 		select id
-- 		from Movie
-- 		where title = "Die Another Day"
-- 	)
-- );

-- select concat(first," ", last) as fullname
-- from Actor
-- where id in 
-- (
-- 	select aid from 	
-- 	(
-- 		select aid 
-- 		from MovieActor
-- 		where mid = 	
-- 		(
-- 			select id
-- 			from Movie
-- 			where title = "Die Another Day"
-- 		)
-- 	) 
-- 	as subquery
-- );

select concat (Actor.first," ",Actor.last) 
from Actor, MovieActor
where (Actor.id = MovieActor.aid) and (MovieActor.mid = 
(
	select id 
	from Movie
	where title = "Die Another Day"
));

-- count of all actors who acted in multiple movies
-- subquery finds all the actor id's who are in multiple movies
-- then count all the id's from the Actor tables that are in the result of the subquery
-- select count(*)
-- from Actor 
-- where id in (select aid
-- 			from MovieActor
-- 			group by aid
-- 			having count(*)>1)

select count(*) from
(
	select aid
	from MovieActor
	group by aid
	having count(*)>1
) as s;
-- movie titles whose directors also acted in the movie
-- first join the MovieDirector table and MovieActor table
-- select Movie.title 
-- from Movie, MovieActor,MovieDirector
-- where MovieDirector.did = MovieActor.aid;

select Movie.title
from Movie, (select distinct MovieDirector.mid from MovieDirector,MovieActor where MovieDirector.did = MovieActor.aid)as x
where Movie.id = x.mid;



-- select title
-- from Movie
-- where id in	(select MovieDirector.mid
-- 			from MovieDirector,MovieActor
-- 			where MovieDirector.did = MovieActor.aid)

