SELECT SalesPersonName 
FROM SalesPerson AS SP
JOIN SalesHeader AS SH
  ON SP.SalesPersonCode = SH.SalesPersonCode
JOIN SalesLine AS SL
  ON SH.DocNum = SL.DocNum
JOIN Items AS I
  ON SL.ItemCode = I.ItemCode
GROUP BY SP.SalesPersonName
HAVING COUNT(DISTINCT SL.ItemCode) = (
    SELECT COUNT(DISTINCT ItemCode) 
    FROM Items
)
