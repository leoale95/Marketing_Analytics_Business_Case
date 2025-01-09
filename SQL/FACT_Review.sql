SELECT 
    [ReviewID],            -- Unique identifier for each review
    [CustomerID],          -- Unique identifier for the customer who submitted the review
    [ProductID],           -- Unique identifier for the product being reviewed
    [ReviewDate],          -- Date when the review was submitted
    [Rating],              -- Customer's rating for the product (e.g., 1-5 stars)
    REPLACE([ReviewText], '  ', ' ') AS [ReviewText] -- Cleans up extra spaces in the review text by replacing double spaces with a single space
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[customer_reviews]; -- Table containing customer reviews data

