/*
Find the name of all the people that have played in a movie they directed, and order them by their
names (increasing alphabetical order).
*/

SELECT person.name
FROM person, (
	SELECT DISTINCT CI1.person_id
	FROM role_type RT1, role_type RT2, cast_info CI1, cast_info CI2
	WHERE (RT1.role='actor' OR RT1.role='actress') AND RT2.role='director' AND CI1.movie_id=CI2.movie_id AND CI1.person_id=CI2.person_id AND CI1.role_id=RT1.id AND CI2.role_id=RT2.id 
) AS ids
WHERE person.id=ids.person_id
ORDER BY person.name ASC;