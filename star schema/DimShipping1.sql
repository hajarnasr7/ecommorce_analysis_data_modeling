DROP TABLE DimShipping1

CREATE TABLE DimShipping1 (
shippingID INT IDENTITY(1,1) PRIMARY KEY,
shipping_type VARCHAR(50)
)

INSERT INTO DimShipping1 (shipping_type)
SELECT DISTINCT [Shipping Type]
FROM customer_behavior
WHERE [Shipping Type] IS NOT NULL;