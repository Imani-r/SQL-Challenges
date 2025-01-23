/* Challenge:
Data Source Bank acquires new customers every month. They are stored in separate tabs of an Excel workbook so it's "easy" to see which customers joined in which month. 
However, it's not so easy to do any comparisons between months. Therefore, we'd like to consolidate all the months into one dataset. 

There's an extra twist as well. The customer demographics are stored as rows rather than columns, which doesn't make for very easy reading. So we'd also like to restructure the data.
*/

-- We want to stack the tables on top of one another, since they have the same fields in each sheet.
-- Some of the fields (i.e. 'Demographiic' in AUgust) aren't matching up as we'd expect, due to differences in spelling. We'll need to account for that.
-- Make a Joining Date field based on the Joining Day, Table Names and the year 2023
-- Now we want to reshape our data so we have a field for each demographic, for each new customer (help)
-- Make sure all the data types are correct for each field
-- Remove duplicates: If a customer appears multiple times take their earliest joining date

SELECT 
    ID
    ,DATE_FROM_PARTS(2023, "Month", Joining_Day) AS Joining_Date
    ,"'Account Type'"
    ,"'Date of Birth'"
    ,"'Ethnicity'"
FROM (
SELECT *
    ,'01' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_JANUARY
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'02' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_FEBRUARY
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'03' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_MARCH
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'04' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_APRIL
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'05' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_MAY
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'06' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_JUNE
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'07' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_JULY
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'08' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_AUGUST
    PIVOT(MAX(value) FOR DEMOGRAPHIIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'09' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_SEPTEMBER
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'10' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_OCTOBER
    PIVOT(MAX(value) FOR DEMAGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'11' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_NOVEMBER
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
UNION all
SELECT *
    ,'12' AS "Month"
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK04_DECEMBER
    PIVOT(MAX(value) FOR DEMOGRAPHIC IN ('Ethnicity', 'Date of Birth', 'Account Type'))
)