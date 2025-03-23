/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT f1.title
FROM film f1
JOIN film_actor a1 USING(film_id)
WHERE a1.actor_id in (
		SELECT a2.actor_id
		FROM film_actor a2
		JOIN film f2 USING(film_id)
		WHERE f2.title = 'AMERICAN CIRCUS'
	)
GROUP BY f1.title
HAVING count(DISTINCT a1.actor_id) >= 2
ORDER BY f1.title;
