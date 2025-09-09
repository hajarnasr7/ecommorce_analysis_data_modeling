DROP TABLE DiMRating1

CREATE TABLE DiMRating1 (
ratingID INT IDENTITY(1,1) PRIMARY KEY,
review_rating FLOAT
)

INSERT INTO DiMRating1 (review_rating)
SELECT DISTINCT [Review Rating]
FROM customer_behavior
WHERE [Review Rating] IS NOT NULL;