--Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года 
--(в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки).
SELECT
 i.InvoiceID AS [InvoiceId]
 , c.CustomerName AS [CustomerName]
 , i.InvoiceDate AS [InvoiceDate]
 , SUM(il.Quantity * il.UnitPrice) OVER (PARTITION BY i.InvoiceID) [OrderSum]
 , SUM(il.Quantity * il.UnitPrice) OVER (ORDER BY DATEPART(YEAR, i.InvoiceDate), DATEPART(MONTH, i.InvoiceDate)) [CumulativeTotal]
FROM Sales.Invoices i
INNER JOIN Sales.Customers c ON c.CustomerID = i.CustomerID
INNER JOIN Sales.InvoiceLines il ON il.InvoiceID = i.InvoiceID
WHERE i.InvoiceDate >= '20150101' AND i.InvoiceDate < '20160101'
ORDER BY i.InvoiceDate, i.CustomerID;