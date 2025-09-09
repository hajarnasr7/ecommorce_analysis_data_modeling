CREATE TABLE DimCustomer1 (
customerID INT PRIMARY KEY,
age INT,
gender VARCHAR(50),
location VARCHAR(50),
preferred_payment_method VARCHAR(50),
frequency_of_purchases VARCHAR(50),
subscription_status	 VARCHAR(50)
)

INSERT INTO DimCustomer1 (customerID , age , gender, location, preferred_payment_method, frequency_of_purchases, subscription_status)
SELECT DISTINCT [Customer ID], Age , Gender, Location, [Preferred Payment Method], [Frequency of Purchases], [Subscription Status]
FROM customer_behavior
WHERE Age IS NOT NULL OR
 Gender IS NOT NULL OR
 Location IS NOT NULL OR
 [Preferred Payment Method] IS NOT NULL OR
[Frequency of Purchases] IS NOT NULL OR
 [Subscription Status] IS NOT NULL;

