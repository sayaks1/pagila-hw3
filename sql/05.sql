/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT title
FROM film
JOIN film_actor a1 USING(film_id)
WHERE a1.actor_id IN (
	SELECT actor_id
	FROM film_actor a2
	WHERE a2.film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
)
ORDER BY title;
