/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bacall_number_1 AS (
	SELECT DISTINCT a.actor_id 
	FROM actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
	JOIN film_actor bacall_fa ON fa.film_id = bacall_fa.film_id
	JOIN actor bacall ON bacall_fa.actor_id = bacall.actor_id
	WHERE bacall.first_name = 'RUSSELL'
	AND bacall.last_name = 'BACALL'
	AND a.actor_id != bacall.actor_id
),
bacall_actor_id AS (
	SELECT actor_id
	FROM actor
	WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
)

SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_actor bn1_fa ON fa.film_id = bn1_fa.film_id
JOIN bacall_number_1 bn1 ON bn1_fa.actor_id = bn1.actor_id
WHERE a.actor_id NOT IN (SELECT actor_id FROM bacall_number_1)
AND a.actor_id NOT IN (SELECT actor_id FROM bacall_actor_id)
ORDER BY "Actor Name";
