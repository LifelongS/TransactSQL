--Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида: 
--клиент, месяц, год, количество покупок
SELECT selpvt.*
FROM
(
	SELECT 
		 [OrderDate]
		,[CustomerName] = replace(replace([CustomerName], left([CustomerName], charindex('(', [CustomerName], 0)), ''), ')', '')
		,[OrderID]
	FROM 
		[Sales].[Customers] c
		CROSS APPLY
		(
			SELECT 
				 [OrderDate] = FORMAT(o.[OrderDate], 'd', 'de-de')
				,o.[OrderID]
			FROM 
				[Sales].[Orders] o
				INNER JOIN [Sales].[Invoices] i ON o.[OrderID] = i.[OrderID]
			WHERE
				EXISTS
				(
					SELECT ct.[CustomerTransactionID]
					FROM [Sales].[CustomerTransactions] ct
					WHERE 
					ct.[InvoiceID] = i.[InvoiceID]
				)
				AND c.[CustomerID] = o.[CustomerID]
		) oc
	WHERE
		c.[CustomerID] BETWEEN 2 AND 6
) AS sel
PIVOT
(
	count([OrderID])
	FOR [CustomerName] 
	IN 
	(
		 [Sylvanite, MT]
		,[Peeples Valley, AZ]
		,[Medicine Lodge, KS]
		,[Gasport, NY]
		,[Jessie, ND]
	)
) AS selpvt