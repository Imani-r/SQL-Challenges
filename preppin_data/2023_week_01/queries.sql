CREATE OR REPLACE TEMP VIEW cleaned_base AS

SELECT
    Value,
    "Customer Code",
-- Split the Transaction Code to extract the letters at the start of the transaction code.
    -- These identify the bank who processes the transaction
    split_part("Transaction Code", '-', 1) AS Bank,

-- Rename the values in the Online or In-person field,
    -- Online of the 1 values and In-Person for the 2 values. */
    CASE
        WHEN "Online or In-Person" = 1 THEN 'Online'
        WHEN "Online or In-Person" = 2 THEN 'In-Person'
    END AS "Online or In-Person",

-- Change the date to be the day of the week
    dayname("Transaction Date") AS "Transaction Date"
FROM read_csv_auto('/Users/faithrotich/Desktop/SQL-Challenges/preppin_data/2023_week_01/data/pd_2023_wk_1_input.csv');

-- 1. Total Values of Transactions by each bank
SELECT 
    Bank,
    SUM(Value) AS "Value"

FROM cleaned_base
GROUP BY Bank;

-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
SELECT
    Bank,
    "Transaction Date",
    SUM(Value) AS "Value"
FROM cleaned_base
GROUP BY 1, 2;
