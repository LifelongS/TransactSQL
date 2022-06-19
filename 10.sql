--Для всех клиентов с именем, в котором есть Tailspin Toys, 
--вывести все адреса, которые есть в таблице, в одной колонке.

SELECT DISTINCT 
	 c.[CustomerName]
	,[Address]
FROM 
	[Sales].[Customers] c
	CROSS APPLY
	(
		SELECT [DeliveryAddressLine1] AS [Address]
		FROM [Sales].[Customers] c1
		WHERE c.[CustomerID] = c1.[CustomerID]

		UNION

		SELECT [DeliveryAddressLine2] AS [Address]
		FROM [Sales].[Customers] c1
		WHERE c.[CustomerID] = c1.[CustomerID]

		UNION

		SELECT [PostalAddressLine1] AS [Address]
		FROM [Sales].[Customers] c1
		WHERE c.[CustomerID] = c1.[CustomerID]

		UNION

		SELECT [PostalAddressLine2] AS [Address]
		FROM [Sales].[Customers] c1
		WHERE c.[CustomerID] = c1.[CustomerID]
	) adr
WHERE
	c.[CustomerName] LIKE 'Tailspin Toys%'
ORDER BY [Address] ASC;


-- Вариант с UNPIVOT:
SELECT 
	 CustomerName
	,cunpvt.[Address]
FROM
(
	SELECT
		 [CustomerName]
		,[DeliveryAddressLine1]
		,[DeliveryAddressLine2]
		,[PostalAddressLine1]
		,[PostalAddressLine2]
	FROM [Sales].[Customers] c
	WHERE c.[CustomerName] LIKE 'Tailspin Toys%'
) c
UNPIVOT
(
	[Address] 
	FOR [AddressType] 
	IN ([DeliveryAddressLine1], [DeliveryAddressLine2], [PostalAddressLine1], [PostalAddressLine2])
) cunpvt