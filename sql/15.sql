/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
SELECT 
f.title,
string_agg(
initcap(split_part(trim(actor), ' ', 1)) || initcap(split_part(trim(actor), ' ', 2)),
', '
) AS actors 
FROM film f
JOIN film_list fi ON f.film_id = fi.fid,
unnest(string_to_array(fi.actors, ',')) AS actor
WHERE fi.category = 'Documentary' AND fi.rating = 'G'
GROUP BY f.title
ORDER BY title;

