SELECT 
  SH.SalesPersonCode,
  SUM(SL.LineSum) AS TotalSales,
  (
    SELECT AVG(InvoiceTotal)
    FROM (
      SELECT SUM(SL2.LineSum) AS InvoiceTotal
      FROM SalesHeader SH2
      JOIN SalesLine SL2 ON SH2.DocNum = SL2.DocNum
      WHERE SH2.SalesPersonCode = SH.SalesPersonCode
      GROUP BY SH2.DocNum
    ) AS Invoices
  ) AS AvgInvoiceAmount
FROM SalesHeader SH
JOIN SalesLine SL ON SH.DocNum = SL.DocNum
GROUP BY SH.SalesPersonCode
