WITH Duplicated_Record AS (
    SELECT 
        [JourneyID],                              -- Unique identifier for the journey
        [CustomerID],                             -- Unique identifier for the customer
        [ProductID],                              -- Associated product
        [VisitDate],                              -- Visit date
        [Stage],                                  -- Customer journey stage
        [Action],                                 -- Action performed by the customer
        [Duration],                               -- Duration of the action
        ROW_NUMBER() OVER (
            PARTITION BY [CustomerID], [ProductID], [VisitDate], [Stage], [Action] -- Grouping to identify duplicates
            ORDER BY [JourneyID] -- Ordering within each group
        ) AS row_num                              -- Row number to identify duplicates
    FROM 
        [PortfolioProject_MarketingAnalytics].[dbo].[customer_journey] -- Source table
)
SELECT *
FROM Duplicated_Record
WHERE row_num > 1 -- Filter duplicate records
ORDER BY [JourneyID]; -- Order results by JourneyID

-- Second query: Cleaning and processing data
SELECT 
    [JourneyID],  -- Unique identifier for the journey to ensure data traceability
    [CustomerID],  -- Unique identifier for the customer to link journeys to specific customers
    [ProductID],  -- Unique identifier for the product to analyze customer interactions with different products
    [VisitDate],  -- Visit date to understand the chronology of customer interactions
    [Stage],  -- Uses the uppercase stage value from the subquery for consistency in analysis
    [Action],  -- Action performed by the customer (e.g., View, Click, Purchase)
    COALESCE([Duration], [avg_duration]) AS [Duration]  -- Replaces missing durations with the average for the corresponding date
FROM 
    (
        -- Subquery to process and clean data
        SELECT 
            [JourneyID],  -- Unique identifier for the journey to ensure data traceability
            [CustomerID],  -- Unique identifier for the customer to link journeys to specific customers
            [ProductID],  -- Unique identifier for the product to analyze customer interactions with different products
            [VisitDate],  -- Visit date to understand the chronology of customer interactions
            UPPER([Stage]) AS [Stage],  -- Converts stage values to uppercase for consistency in analysis
            [Action],  -- Action performed by the customer (e.g., View, Click, Purchase)
            [Duration],  -- Uses the duration directly, assuming it is already a numeric type
            AVG([Duration]) OVER (PARTITION BY [VisitDate]) AS [avg_duration],  -- Calculates the average duration for each visit date
            ROW_NUMBER() OVER (
                PARTITION BY [CustomerID], [ProductID], [VisitDate], UPPER([Stage]), [Action]  -- Groups by these columns to identify duplicates
                ORDER BY [JourneyID]  -- Orders by JourneyID to keep the first occurrence of each duplicate
            ) AS [row_num]  -- Assigns a row number to each record within the partition to identify duplicates
        FROM 
            [PortfolioProject_MarketingAnalytics].[dbo].[customer_journey]  -- Specifies the source table to select data
    ) AS [subquery]  -- Names the subquery for reference in the outer query
WHERE 
    [row_num] = 1;  -- Retains only the first occurrence of each duplicate group identified in the subquery
