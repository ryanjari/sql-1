-- nomor 1
select * from movie
where mov_title like 'The%';

--nomor 2
(select concat(director.dir_fname, ' ',director.dir_lname) as director_name, movie.mov_title from movie_direction
inner join director on  movie_direction.dir_id =director.dir_id 
inner join movie on movie_direction.mov_id = movie.mov_id
where  concat(director.dir_fname, ' ',director.dir_lname) = 'James Cameron');

--nomor 3
SELECT act_fname
FROM actor
UNION
SELECT dir_fname
FROM director
order by act_fname;


--nomor 4
select count(gen_title) from genres
where gen_title in('Mystery', 'Drama',  'Adventure');

select count(genres.gen_title) as number_of_movie, genres.gen_title from movie_genres
inner join genres on  movie_genres.gen_id = genres.gen_id 
inner join movie on movie_genres.mov_id = movie.mov_id
where genres.gen_title in('Mystery', 'Drama',  'Adventure')
group by 2;

--nomor 5
SELECT 
    CASE 
        WHEN mov_time < 100 THEN 'short movie'
        WHEN mov_time between 100 and 130 then 'normal movie'
        ELSE 'long movie'
    END AS label_duration,
    COUNT(*) AS number_of_movies
FROM movie
GROUP BY label_duration;

