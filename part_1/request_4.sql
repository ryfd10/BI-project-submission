WITH MaxQty AS (
    SELECT TOP 1 SalesPersonCode
    FROM SalesHeader SH
    JOIN SalesLine SL ON SH.DocNum = SL.DocNum
    GROUP BY SH.SalesPersonCode
    ORDER BY SUM(SL.Qty) DESC
),
MaxVariety AS (
    SELECT TOP 1 SalesPersonCode
    FROM SalesHeader SH
    JOIN SalesLine SL ON SH.DocNum = SL.DocNum
    GROUP BY SH.SalesPersonCode
    ORDER BY COUNT(DISTINCT SL.ItemCode) DESC
),
MinVariety AS (
    SELECT TOP 1 SalesPersonCode
    FROM SalesHeader SH
    JOIN SalesLine SL ON SH.DocNum = SL.DocNum
    GROUP BY SH.SalesPersonCode
    ORDER BY COUNT(DISTINCT SL.ItemCode) ASC
)
SELECT ItemCode 
FROM SalesLine SL
JOIN SalesHeader AS SH ON SH.DocNum = SL.DocNum
WHERE SH.SalesPersonCode IN (SELECT SalesPersonCode FROM MaxQty)
INTERSECT
SELECT ItemCode 
FROM SalesLine SL
JOIN SalesHeader AS SH ON SH.DocNum = SL.DocNum
WHERE SH.SalesPersonCode IN (SELECT SalesPersonCode FROM MaxVariety)
EXCEPT
SELECT ItemCode 
FROM SalesLine SL
JOIN SalesHeader AS SH ON SH.DocNum = SL.DocNum
WHERE SH.SalesPersonCode IN (SELECT SalesPersonCode FROM MinVariety);
