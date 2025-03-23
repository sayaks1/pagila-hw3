/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
WITH american_circus_info AS (
    SELECT film_id
    FROM film
    WHERE title = 'AMERICAN CIRCUS'
),

actor_matches AS (
    SELECT DISTINCT f.film_id, f.title
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN film_actor ac_fa ON fa.actor_id = ac_fa.actor_id
    JOIN american_circus_info ac ON ac_fa.film_id = ac.film_id
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fa.actor_id) = 1 OR f.title = 'AMERICAN CIRCUS'
),

category_matches AS (
    SELECT f.film_id, f.title
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN film_category ac_fc ON fc.category_id = ac_fc.category_id
    JOIN american_circus_info ac ON ac_fc.film_id = ac.film_id
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fc.category_id) = 2 OR f.title = 'AMERICAN CIRCUS'
)

SELECT cm.title
FROM category_matches cm
JOIN actor_matches am ON cm.film_id = am.film_id
ORDER BY cm.title;
