/* Challenge: 
This week we have had a report with a number of transactions that have not just our transactions but other banks' too. 
Can you help clean up the data?*/

SELECT 
-- Split the Transaction Code to extract the letters at the start of the transaction code
    -- Rename the new filed with the Bank code 'Bank'
    split_part(transaction_code,'-',1) AS "Bank"
--Total Values of Transactions by each bank
    ,SUM(value) AS "Value"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
 GROUP BY "Bank"


SELECT 
-- Split the Transaction Code to extract the letters at the start of the transaction code
    split_part(transaction_code,'-',1) AS "Bank"
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values.
    ,IFF(online_or_in_person=1,'Online','In-Person') AS "Online or In-Person"
-- Alternative for above: 
    --CASE online_or_in_person 
        --WHEN 1 THEN 'Online'
        --ELSE 'In-Person'
        --END
        --AS "Online or In-Person"
-- Change the date to be the day of the week
    ,DAYNAME(TO_DATE(transaction_date,'DD/MM/YYYY HH24:mi:ss')) AS "Day of Week"
--Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
    ,SUM(value) AS "Value"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
 GROUP BY "Bank", "Day of Week", "Online or In-Person"


SELECT 
-- Split the Transaction Code to extract the letters at the start of the transaction code
    split_part(transaction_code,'-',1) AS "Bank"
    ,customer_code
-- Total Values by Bank and Customer Code
    ,SUM(value) AS "Value"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY "Bank", customer_code
