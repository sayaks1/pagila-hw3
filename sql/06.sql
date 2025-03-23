/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_actor bacall_fa ON fa.film_id = bacall_fa.film_id
JOIN actor bacall ON bacall_fa.actor_id = bacall.actor_id
WHERE bacall.first_name = 'RUSSELL'
AND bacall.last_name = 'BACALL'
AND a.actor_id != bacall.actor_id
ORDER BY "Actor Name"; 
