/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
WITH film_rentals AS (
  SELECT
    c.category_id,
    c.name AS category_name,
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS rental_count
  FROM
    category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY
    c.category_id, c.name, f.film_id, f.title
),
ranked_films AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY category_id
      ORDER BY rental_count DESC, title DESC
    ) AS row_num
  FROM film_rentals
)
SELECT
  category_name AS "name",
  title,
  rental_count AS "total rentals"
FROM
  ranked_films
WHERE
  row_num <= 5
ORDER BY
  category_name, rental_count DESC, title;
