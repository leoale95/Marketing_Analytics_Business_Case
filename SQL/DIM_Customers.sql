-- Select customer details from the customers table
SELECT 
    [CustomerID],        -- Unique identifier for the customer
    [CustomerName],      -- Name of the customer
    [Email],             -- Email address of the customer
    [Gender],            -- Gender of the customer
    [Age],               -- Age of the customer
    [GeographyID]        -- Identifier linking the customer to geographic information
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[customers];

-- Select geographic details from the geography table
SELECT 
    [GeographyID],       -- Unique identifier for the geography record
    [Country],           -- Country of the geographic location
    [City]               -- City of the geographic location
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[geography];

-- Combine customer details with geographic information using a LEFT JOIN
SELECT 
    c.CustomerID,        -- Unique identifier for the customer
    c.CustomerName,      -- Name of the customer
    c.Email,             -- Email address of the customer
    c.Gender,            -- Gender of the customer
    g.Country,           -- Country linked to the customer's location
    g.City               -- City linked to the customer's location
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[customers] AS c -- Alias for the customers table
LEFT JOIN 
    [PortfolioProject_MarketingAnalytics].[dbo].[geography] AS g -- Alias for the geography table
ON 
    c.GeographyID = g.GeographyID; -- Join condition linking customer and geography tables
