DROP TABLE DiMProducts1 

CREATE TABLE DiMProducts1 (
prodectID INT IDENTITY(1,1) PRIMARY KEY,
Category VARCHAR(50),
Size  VARCHAR(50),
Color  VARCHAR(50),
Season VARCHAR(50)
)

INSERT INTO DiMProducts1 (Category , Size , Color, Season)
SELECT DISTINCT Category, Size ,  Color, Season
FROM customer_behavior
WHERE Category IS NOT NULL OR
 Size IS NOT NULL OR
 Color IS NOT NULL OR
 Season IS NOT NULL;
 


