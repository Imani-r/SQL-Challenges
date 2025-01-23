/* Challenge:
This week's challenge looks at two analytical calculations that can make the use of the data source much easier for end users:
    - Ranking
    - Level of Detail (LOD) calculations */

-- Create the bank code by splitting out off the letters from the Transaction code, call this field 'Bank'
-- Change transaction date to the just be the month of the transaction
-- Total up the transaction values so you have one row for each bank and month combination
-- Rank each bank for their value of transactions each month against the other banks. 1st is the highest value of transactions, 3rd the lowest. 
-- Without losing all of the other data fields, find:
    -- The average rank a bank has across all of the months, call this field 'Avg Rank per Bank'
    -- The average transaction value per rank, call this field 'Avg Transaction Value per Rank'

WITH t1 AS
    (SELECT
    split_part(transaction_code,'-',1) AS "Bank"
    ,monthname(TO_DATE(transaction_date,'DD/MM/YYYY HH24:mi:ss')) AS "Month"
    ,SUM(value) AS "Value"
    ,RANK() OVER (PARTITION BY "Month" ORDER BY "Value" DESC) AS "Bank Rank per Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01 input
GROUP BY "Bank"
    ,"Month")

,t2 AS
    (SELECT 
    "Bank"
    ,AVG("Bank Rank per Month") AS "Avg Rank per Bank"
    FROM t1
    GROUP BY "Bank"
    )

,t3 AS
    (SELECT
    "Bank Rank per Month"
    ,AVG("Value") AS "Avg Transaction Value per Rank"
    FROM t1
    GROUP BY "Bank Rank per Month"
    )

SELECT 
    t1."Month"
    ,t1."Bank"
    ,t1."Value"
    ,t1."Bank Rank per Month"
    ,t3."Avg Transaction Value per Rank"
    ,t2."Avg Rank per Bank"
FROM t1
INNER JOIN t2
    ON t1."Bank" = t2."Bank"
INNER JOIN t3
    ON t1."Bank Rank per Month" = t3."Bank Rank per Month"
    