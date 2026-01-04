WITH SalesData AS (
  SELECT 
    SH.SalesPersonCode,SL.DocNum,SH.DocDate,SUM(SL.Qty) AS Qty
  FROM SalesHeader SH
  JOIN SalesLine SL ON SH.DocNum = SL.DocNum
  GROUP BY SH.SalesPersonCode, SL.DocNum, SH.DocDate
),
SalesTotal AS (
  SELECT SalesPersonCode, SUM(Qty) AS TotalQty
  FROM SalesData
  GROUP BY SalesPersonCode
),
Ranked AS (
  SELECT 
    ST.SalesPersonCode,SP.SalesPersonName,SD.DocNum,SD.DocDate,SD.Qty,ST.TotalQty,
    SUM(ST.TotalQty) OVER (ORDER BY ST.TotalQty DESC 
                           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
                           * 1.0 / SUM(ST.TotalQty) OVER () AS CumulativePercent
  FROM SalesTotal ST
  JOIN SalesData SD ON ST.SalesPersonCode = SD.SalesPersonCode
  JOIN SalesPerson SP ON ST.SalesPersonCode = SP.SalesPersonCode
)
SELECT 
  SalesPersonName,DocNum,DocDate,Qty
FROM Ranked
WHERE CumulativePercent <= 0.88
ORDER BY TotalQty DESC, SalesPersonCode, DocDate
