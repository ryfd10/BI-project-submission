WITH ItemAvg AS (
  SELECT SH.SalesPersonCode,SL.ItemCode,AVG(SL.Qty) AS AvgQty
  FROM SalesHeader SH
  JOIN SalesLine SL ON SH.DocNum = SL.DocNum
  GROUP BY SH.SalesPersonCode, SL.ItemCode
)
SELECT 
SP.SalesPersonName,SL.ItemCode,IA.AvgQty,SL.Qty,SL.LineSum
FROM SalesLine SL
JOIN SalesHeader SH ON SH.DocNum = SL.DocNum
JOIN SalesPerson SP ON SH.SalesPersonCode = SP.SalesPersonCode
JOIN ItemAvg IA ON 
     IA.SalesPersonCode = SH.SalesPersonCode
 AND IA.ItemCode = SL.ItemCode
WHERE SL.Qty < IA.AvgQty
