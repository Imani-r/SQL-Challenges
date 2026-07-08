/* Challenge: 
Data Source Bank has some quarterly targets for the value of transactions that are being performed in-person and online. 
It's our job to compare the transactions to these target figures.*/

-- For the transations file:
    -- Filter the transactions to just look at DSB (these will be transactions that contain DSB in the Transaction Code field)
    -- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
    -- Change the date to be the quarter
    -- Sum the transaction values for each quarter and for each type of transaction (online or in-person)

SELECT 
     split_part(transaction_code,'-',1) AS "Bank"
     ,IFF(trans.online_or_in_person=1,'Online','In-Person') AS "Online or In-Person"
     ,QUARTER(TO_DATE(transaction_date,'DD/MM/YYYY HH24:mi:ss')) AS "Quarter"
     ,SUM(VALUE) AS Value
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01 trans
WHERE "Bank" = 'DSB'
GROUP BY "Bank"
    ,"Online or In-Person"
    ,"Quarter"


-- For the targets file:
    -- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter
    -- Rename the fields
    -- Remove the 'Q' from the quarter field and make the data type numeric

SELECT 
    online_or_in_person
    ,RIGHT(Quarter,1) AS "Quarter"
    ,"Quarterly Target"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK03_TARGETS
    UNPIVOT("Quarterly Target" FOR Quarter IN (Q1, Q2, Q3, Q4))


-- Join the two datasets together to compare the transactions to the targets
    -- Calculate the Variance to Target for each row

SELECT 
    trans."Online or In-Person"
    ,trans."Quarter"
    ,trans.Value
    ,targets."Quarterly Target"
    ,trans.Value-targets."Quarterly Target" AS "Variance to Target"
FROM (
SELECT 
     split_part(transaction_code,'-',1) AS "Bank"
     ,IFF(online_or_in_person=1,'Online','In-Person') AS "Online or In-Person"
     ,QUARTER(TO_DATE(transaction_date,'DD/MM/YYYY HH24:mi:ss')) AS "Quarter"
     ,SUM(VALUE) AS Value
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01 
WHERE "Bank" = 'DSB'
GROUP BY "Bank"
    ,"Online or In-Person"
    ,"Quarter"
) AS trans

LEFT JOIN (
SELECT 
    online_or_in_person
    ,RIGHT(Quarter,1) AS "Quarter"
    ,"Quarterly Target"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK03_TARGETS
    UNPIVOT("Quarterly Target" FOR Quarter IN (Q1, Q2, Q3, Q4))
) AS targets

ON targets."Quarter" = trans."Quarter"
AND targets.Online_or_In_Person = trans."Online or In-Person"