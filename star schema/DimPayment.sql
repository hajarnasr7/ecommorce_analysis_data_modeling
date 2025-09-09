DROP TABLE DiMPayment1


CREATE TABLE DiMPayment1 (
paymentID INT IDENTITY(1,1) PRIMARY KEY,
payment_method VARCHAR(50)
)


INSERT INTO DiMPayment1 (payment_method)
SELECT DISTINCT [Payment Method]
FROM customer_behavior
WHERE [Payment Method] IS NOT NULL ;

