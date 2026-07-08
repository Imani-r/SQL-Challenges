/* Challenge: 
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

SELECT *
FROM read_csv_auto('/Users/faithrotich/Desktop/SQL-Challenges/preppin_data/2023_week_02/data/transactions.csv');
