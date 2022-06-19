--В таблице стран есть поля с кодом страны - цифровым и буквенным; 
--сделайте выборку ИД страны, название, код - чтобы в поле был либо цифровой, либо буквенный код.
SELECT
	 [CountryID]
	,[CountryName]
	,ac.[CountryCode]
FROM 
	[Application].[Countries] c
	OUTER APPLY
	(
		SELECT [IsoAlpha3Code] AS [CountryCode]
		FROM [Application].[Countries] c1
		WHERE c.[CountryID] = c1.[CountryID]

		UNION

		SELECT CAST([IsoNumericCode] AS nvarchar(3)) AS [CountryCode]
		FROM [Application].[Countries] c1
		WHERE c.[CountryID] = c1.[CountryID]
	) ac