SELECT Season, COUNT([interactionID]) as num_of_purchases
FROM [dbo].[DiMProducts1] p
JOIN [dbo].[FACTSales] s
ON p.prodectID = s.prodectID
GROUP BY Season
ORDER BY COUNT([interactionID]) ASC

-- spring and fall are the most

SELECT TOP 4
Season,Category, COUNT([interactionID]) as num_of_purchases
FROM [dbo].[DiMProducts1] p
JOIN [dbo].[FACTSales] s
ON p.prodectID = s.prodectID
GROUP BY Season,[Category]
ORDER BY COUNT([interactionID]) DESC
-- CLOTHING

SELECT ROUND(AVG([review_rating]),2)
FROM [dbo].[DiMRating1] r
JOIN [dbo].[FACTSales] s 
ON r.[ratingID] = s.[ratingID]
-- 3,75

-- مقارنه المبيعات الحاليه بالسابقه حسب السيزون
SELECT [Season],SUM([purchase_amount_usd]) as curr_purchase,SUM([previous_purchases]) as prev_purchase
FROM [dbo].[FACTSales] s
join [dbo].[DiMProducts1] P
on s.[prodectID] = P.[prodectID]
GROUP BY [Season]
ORDER BY SUM([purchase_amount_usd]),SUM([previous_purchases]) DESC

-- frequency_of_purchases by customars
SELECT [frequency_of_purchases],count(s.[customerID]) as customar_num
FROM [dbo].[DimCustomer1] c
JOIN [dbo].[FACTSales] s
ON c.[customerID] = s.[customerID]
group by [frequency_of_purchases]
order by count(s.[customerID]) ASC

-- orders per location
SELECT [location],count(s.[customerID]) as customar_num
FROM [dbo].[DimCustomer1] c
JOIN [dbo].[FACTSales] s
ON c.[customerID] = s.[customerID]
group by [location]
order by count(s.[customerID]) DESC

-- orders per gender
SELECT gender,count(s.[customerID]) as customar_num
FROM [dbo].[DimCustomer1] c
JOIN [dbo].[FACTSales] s
ON c.[customerID] = s.[customerID]
group by gender
order by count(s.[customerID]) DESC


UPDATE [dbo].[DimCustomer1]
SET [frequency_of_purchases] = REPLACE([frequency_of_purchases], 'Bi-Weekly', 'Weekly')
WHERE [frequency_of_purchases] LIKE '%Bi-Weekly%';

-- frquency and discount
SELECT frequency_of_purchases ,discount_applied, count(discount_applied) as discount_count
FROM [dbo].[FACTSales] s
JOIN [dbo].[DimCustomer1] c
ON c.[customerID] = s.[customerID]
JOIN [dbo].[DiMPromo1] p
ON p.[promoID] = s.[promoID]
group by [frequency_of_purchases],discount_applied
order by count(discount_applied) DESC
-- اللي مش بيستخدمو الخصم اكتر من اللي بيستخدمو


-- frquency and subscription_status
SELECT frequency_of_purchases, subscription_status, count(subscription_status) as discount_count
FROM [dbo].[FACTSales] s
JOIN [dbo].[DimCustomer1] c
ON c.[customerID] = s.[customerID]
group by [frequency_of_purchases],subscription_status
order by count(subscription_status) DESC
-- نفس الحوار بتاع الديسكاونت هنا كمان

-- VIP per
SELECT CAST(
        100.0 * 
        SUM(CASE WHEN([purchase_amount_usd] + [previous_purchases]) > 120 THEN 1 END) /COUNT(*) AS DECIMAL(5,2))
AS vip_count_per       
FROM [dbo].[FACTSales]

-- مقارنه بين الكميه المشتراه بين اللي استخدومو العروض واللي مستخدموش 
SELECT discount_applied, SUM([purchase_amount_usd]+[previous_purchases]) as amount_purchased
FROM [dbo].[FACTSales] s
JOIN [dbo].[DiMPromo1] p
ON p.[promoID] = s.[promoID]
group by discount_applied
order by SUM([purchase_amount_usd]+[previous_purchases]) DESC

-- reviews by customars
SELECT [review_rating] , SUM([purchase_amount_usd]+[previous_purchases]) as amount_purchased
FROM [dbo].[FACTSales] s
JOIN [dbo].[DiMRating1] r
ON s.[ratingID] = r.[ratingID]
group by [review_rating]
order by SUM([purchase_amount_usd]+[previous_purchases]) DESC

-- shipping type 
SELECT [shipping_type],count(*) as orders_num
FROM [dbo].[FACTSales] s
JOIN [dbo].[DimShipping1] sh
ON s.shippingID = sh.shippingID
group by [shipping_type]
order by count(*)  DESC

-- payment
SELECT [payment_method],count(*) as orders_num
FROM [dbo].[FACTSales] s
JOIN [dbo].[DiMPayment1] p
ON s.[paymentID] = p.[paymentID]
group by [payment_method]
order by count(*)  DESC