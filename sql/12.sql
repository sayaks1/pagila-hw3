/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH recent_rentals AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        r.rental_id,
        cat.name AS category_name
    FROM customer c
    JOIN LATERAL (
        SELECT r.rental_id, r.rental_date, i.film_id
        FROM rental r
        JOIN inventory i USING(inventory_id)
        WHERE r.customer_id = c.customer_id
        ORDER BY r.rental_date DESC
        LIMIT 5
    ) r ON true
    JOIN film_category fc ON r.film_id = fc.film_id
    JOIN category cat USING(category_id)
)

SELECT
    customer_id,
    first_name,
    last_name
FROM recent_rentals
GROUP BY customer_id, first_name, last_name 
HAVING COUNT(*) FILTER (WHERE category_name = 'Action') >= 4 
ORDER BY customer_id;
