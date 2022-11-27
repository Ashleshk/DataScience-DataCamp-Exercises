SELECT COUNT(id) AS films_over_100k_votes
FROM reviews
WHERE num_votes >= 100000;