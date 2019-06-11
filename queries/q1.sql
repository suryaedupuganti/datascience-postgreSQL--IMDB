/*
Find the title and the year of production of each movie in which Nicholas Cage played. 
Order the results by year in descending order, then by title in ascending order.
*/

SELECT movie.title, movie.production_year
FROM movie, (SELECT DISTINCT cast_info.movie_id
                     FROM cast_info
                     WHERE cast_info.person_id IN ((SELECT aka_name.person_id FROM aka_name
                                                   WHERE (aka_name.name = 'Cage, Nicholas' OR aka_name.name='Cage, Nicolas'))
													UNION
													(SELECT person.id FROM person
														WHERE (person.name = 'Cage, Nicholas' OR person.name = 'Cage, Nicolas')
													)
                                                   )
                     ) AS ids
WHERE movie.id = ids.movie_id
ORDER BY movie.production_year DESC, movie.title ASC;