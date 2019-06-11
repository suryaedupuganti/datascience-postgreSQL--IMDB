/*
Find all the pairs of titles of movies m1 and m2 such that m1 directly or indirectly references m2,
ordered first by the title of m1, then by the title of m2. We say there is an indirect reference from
m1 to m2, if either (i) m1 references m2, or (ii) m1 references m3, and m3 indirectly references
m2.
*/

WITH RECURSIVE unique_movie_link AS (SELECT DISTINCT movie_link.movie_id, movie_link.linked_movie_id FROM movie_link),
search_graph(first_id, last_id, path_string) AS (
				SELECT unique_movie_link.movie_id AS first_id, unique_movie_link.linked_movie_id AS last_id,
					unique_movie_link.movie_id || '.' || unique_movie_link.linked_movie_id || '.' AS path_string
				FROM unique_movie_link
			UNION ALL
				SELECT sg.first_id AS first_id, unique_movie_link.linked_movie_id AS last_id,
					sg.path_string || unique_movie_link.linked_movie_id || '.' AS path_string
				FROM search_graph sg
					JOIN unique_movie_link
						ON sg.last_id=unique_movie_link.movie_id
				WHERE sg.path_string NOT LIKE '%' || unique_movie_link.linked_movie_id || '.%'
)
SELECT M1.title as title_1, M2.title as title_2
FROM movie M1, movie M2, (SELECT first_id, last_id FROM search_graph LIMIT 50000000) AS all_links
WHERE M1.id=all_links.first_id AND M2.id=all_links.last_id
ORDER BY M1.title ASC, M2.title ASC