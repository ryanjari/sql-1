-- value comparison
select * from movie where mov_year = 1977;
select * from movie where mov_time > 120;
select * from movie where mov_time < 120;

select * from movie where mov_year > 2001;
select * from movie where mov_year >= 2001;

select mov_title, mov_year from movie where mov_year >= 2001;

select mov_title, mov_year from movie where mov_lang='Japanese';


-- string pattern
select * from actor where act_fname LIKE 'J%'; -- start with J
select * from actor where act_fname LIKE '%n'; -- end with n
select * from actor where act_fname LIKE '%a%'; -- anywhere
select * from actor where act_fname LIKE '_a%'; -- second is a
select * from actor where act_fname LIKE 'J___%'; -- start with J and at least have 4 characters



-- between
select * from movie where mov_year between 2001 and 2005;
select * from rating where rev_stars between 7 and 10;

-- IN / NOT IN
select * from movie where mov_year in (2001,1977,2004);
select * from actor where act_fname not in ('James','Kevin');

-- IS NULL / IS NOT NULL
select * from movie where mov_dt_rel is null;
select * from movie where mov_dt_rel is not null;

-- DISTINCT
select distinct mov_year from movie;
select distinct mov_lang from movie where mov_time < 120;

-- AND OR
select * from movie where mov_dt_rel is null and mov_year < 2000;
select * from movie where mov_time = 122 or mov_year = 1999;
select * from movie where mov_time = 122 and mov_year = 1999;


-- aggregate
select max(rev_stars) from rating;
select min(rev_stars) from rating;
select avg(rev_stars) from rating;
select sum(num_o_ratings) from rating;
select count(*) from rating where rev_stars > 8;

-- group by
select mov_lang, count(mov_id) from movie group by mov_lang;
select mov_year, count(mov_id) from movie group by mov_year;

-- having
select mov_year, count(mov_id) from movie group by mov_year;
select mov_lang, count(mov_id) from movie group by mov_lang having count(mov_id) > 1;

-- conditional
select mov_id, rev_stars,
    case 
        when rev_stars between 0 and 5 then 'film jelek'
        when rev_stars between 6 and 7 then 'film lumayan'
        when rev_stars between 8 and 10 then 'film bagus'
    else 'blm ada rating'
    end as status_rating
from rating;


-- inner join
select * 
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id;

select * 
from movie m
left  join movie_cast mc on mc.mov_id = m.mov_id;

insert into movie_cast values (222, null, 'kucing lucu');

select * 
from movie m
right join movie_cast mc on mc.mov_id = m.mov_id;


-- union
select act_id id, act_fname fname, act_lname lname from actor
union all
select dir_id id, dir_fname fname, dir_lname lname from director;

insert into actor values (999, 'kucing', 'lucu');
insert into director values (999, 'kucing', 'lucu');

select act_id id, act_fname fname, act_lname lname from actor
union
select dir_id id, dir_fname fname, dir_lname lname from director;


-- subquery
select mov_id, mov_title from movie where mov_year > 2000;

select *
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join rating r on r.mov_id = f2000an.mov_id;

select f2000an.mov_title, rev_stars
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join rating r on r.mov_id = f2000an.mov_id;

select mov_id, rev_stars,
    case 
        when rev_stars between 0 and 5 then 'film jelek'
        when rev_stars between 6 and 7 then 'film lumayan'
        when rev_stars between 8 and 10 then 'film bagus'
    else 'blm ada rating'
    end as status_rating
from rating;


select f2000an.mov_title, rs.status_rating
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join 
    (
        select mov_id, rev_stars,
        case 
            when rev_stars between 0 and 5 then 'film jelek'
            when rev_stars between 6 and 7 then 'film lumayan'
            when rev_stars between 8 and 10 then 'film bagus'
        else 'blm ada rating'
        end as status_rating
    from rating
    ) as rs on rs.mov_id = f2000an.mov_id;


-- order by
select * from movie order by mov_year;
select * from movie order by mov_year desc;
select * from movie order by mov_title;

-- limit
select * from movie limit 5;