/*
Find the titles of the movies that have only 1 and 10 as ratings, and order them by average rating
(decreasing).
*/

SELECT movie.title
FROM (SELECT DISTINCT movie_rating.movie_id AS id
			FROM movie_rating, info_type
			WHERE info_type.info='votes distribution' AND info_type.id=movie_rating.info_type_id AND movie_rating.info LIKE '_........_'
			) AS good_movies,
			( SELECT movie_rating.movie_id, movie_rating.info_type_id, CAST(movie_rating.info AS FLOAT) _info
				FROM movie_rating			
			) AS decimal_movie_rating, movie, info_type
WHERE good_movies.id=decimal_movie_rating.movie_id AND decimal_movie_rating.movie_id=movie.id AND info_type.info='rating' AND info_type.id=decimal_movie_rating.info_type_id
ORDER BY decimal_movie_rating._info DESC