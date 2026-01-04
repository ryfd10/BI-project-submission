SELECT
L.ItemCode,
COUNT(DISTINCT L.DocNum) AS InvoiceCount,
SUM(L.Qty) AS TotalQty,
SUM(L.LineSum) AS TotalSales
FROM SalesLine L
GROUP BY L.ItemCode;
