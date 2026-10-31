-- Read-only inspection. Run after create_nighthaven_test.sql.
USE nighthaven_test;
SELECT VERSION() AS server_version, @@hostname AS server_host,
       @@port AS server_port, CURRENT_USER() AS database_account;
SHOW CREATE TABLE accounts;
SHOW CREATE TABLE account_credentials;
SHOW CREATE TABLE characters;
SELECT 'accounts' AS table_name, COUNT(*) AS row_count FROM accounts
UNION ALL SELECT 'account_credentials', COUNT(*) FROM account_credentials
UNION ALL SELECT 'characters', COUNT(*) FROM characters;
-- Fresh setup expectation: three InnoDB tables, all three row counts zero.
