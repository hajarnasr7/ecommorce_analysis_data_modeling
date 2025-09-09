DROP TABLE DiMPromo1

CREATE TABLE DiMPromo1(
promoID INT IDENTITY(1,1) PRIMARY KEY,
discount_applied VARCHAR(50),
promo_code_used VARCHAR(50),
)

INSERT INTO DiMPromo1 (discount_applied, promo_code_used)
SELECT DISTINCT [Discount Applied], [Promo Code Used]
FROM customer_behavior
WHERE [Discount Applied] IS NOT NULL OR
 [Promo Code Used] IS NOT NULL;