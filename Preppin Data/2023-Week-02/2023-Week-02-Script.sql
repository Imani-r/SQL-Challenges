SELECT 
    transaction_id AS "Transaction ID"
    ,CONCAT('GB',check_digits,swifts.swift_code,REPLACE(sort_code,'-',''),account_number) AS IBAN
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_TRANSACTIONS trans
INNER JOIN TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_SWIFT_CODES swifts
    ON trans.bank = swifts.bank