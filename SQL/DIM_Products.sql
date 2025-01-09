    [ProductID],           -- Unique identifier for the product
    [ProductName],         -- Name of the product
    -- [Category],         -- Product category (commented out in this case)
    [Price],               -- Price of the product
    CASE 
        WHEN Price < 50 THEN 'Low'          -- Classification: low price (less than 50)
        WHEN Price BETWEEN 50 AND 100 THEN 'Medium' -- Classification: medium price (between 50 and 100)
        ELSE 'High'                         -- Classification: high price (greater than 100)
    END AS Price_Category                  -- Name of the newly calculated column
FROM 
    [PortfolioProject_MarketingAnalytics].[dbo].[products] -- Source table in the database
ORDER BY Price ASC; -- Sort the results in ascending order by price
