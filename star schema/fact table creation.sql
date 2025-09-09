CREATE TABLE FACTSales (
interactionID INT IDENTITY(1,1) PRIMARY KEY,
customerID INT,
prodectID INT,
paymentID INT,
promoID INT,
ratingID INT,
shippingID INT,
purchase_amount_usd INT,
previous_purchases INT
)

INSERT INTO FACTSales (
    customerID,
    paymentID,
    prodectID,
    promoID,
    ratingID,
    shippingID,
    purchase_amount_usd,
    previous_purchases
)
SELECT
   c.customerID ,
   p.paymentID,
   r.prodectID,
   o.promoID,
   a.ratingID,
   sh.shippingID,
   s.[Purchase Amount (USD)],
   s.[Previous Purchases]
FROM [dbo].[customer_behavior] s
JOIN [dbo].[DimCustomer1] c 
    ON s.[Customer ID] = c.[customerID]
JOIN [dbo].[DiMPayment1] p 
    ON s.[Payment Method] = p.[payment_method]
JOIN [dbo].[DiMProducts1] r 
    ON s.[Category] = r.[Category]
   AND s.[Size] = r.[Size] 
   AND s.[Color] = r.[Color] 
   AND s.[Season] = r.[Season] 
JOIN [dbo].[DiMPromo1] o 
    ON s.[Discount Applied] = o.[discount_applied]
   AND s.[Promo Code Used] = o.[promo_code_used]
JOIN [dbo].[DiMRating1] a 
    ON s.[Review Rating] = a.[review_rating]
JOIN [dbo].[DimShipping1] sh 
    ON s.[Shipping Type] = sh.[shipping_type]
