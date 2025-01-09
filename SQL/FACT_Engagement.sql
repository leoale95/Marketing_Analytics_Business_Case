SELECT 
    [EngagementID],                                       -- Unique identifier for the engagement
    [ContentID],                                          -- Unique identifier for the content
    [CampaignID],                                         -- Unique identifier for the campaign
    [ProductID],                                          -- Unique identifier for the product
    UPPER(REPLACE([ContentType], 'Socialmedia', 'Social Media')) AS [ContentType], -- Formats the content type by replacing 'Socialmedia' with 'Social Media' and converting to uppercase
    [Likes],                                             -- Number of likes
    LEFT([ViewsClicksCombined], CHARINDEX('-', [ViewsClicksCombined]) - 1) AS [Views], -- Extracts the number of views from the combined field
    RIGHT([ViewsClicksCombined], LEN([ViewsClicksCombined]) - CHARINDEX('-', [ViewsClicksCombined])) AS [Clicks], -- Extracts the number of clicks from the combined field
    FORMAT(CONVERT(DATE, [EngagementDate]), 'dd.MM.yyyy') AS [EngagementDate] -- Formats the engagement date in the 'dd.MM.yyyy' format
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[engagement_data];
