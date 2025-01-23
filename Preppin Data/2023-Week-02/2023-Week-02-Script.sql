/* Challenge 
Data Source Bank has a requirement to construct International Bank Account Numbers (IBANs), 
even for Transactions taking place in the UK. We have all the information in separate fields, 
we just need to put it altogether in the following order:
    Country Code + Check Digits + Bank Code + Sort Code + Account Number
*/

-- In the Transactions table, there is a Sort Code field which contains dashes. 
    -- We need to remove these so just have a 6 digit string
-- Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account
-- Add a field for the Country Code (GB)
-- Concatenate the fields together in the correct order to create the IBAN
SELECT 
    transaction_id AS "Transaction ID"
    ,CONCAT('GB',check_digits,swifts.swift_code,REPLACE(sort_code,'-',''),account_number) AS IBAN
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_TRANSACTIONS trans
INNER JOIN TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_SWIFT_CODES swifts
    ON trans.bank = swifts.bank