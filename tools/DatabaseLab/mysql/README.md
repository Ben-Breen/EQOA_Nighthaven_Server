# MySQL account/character storage experiment

User-authorized test scaffold; **not the production Nighthaven schema or a final backend decision**. MySQL/MariaDB and PostgreSQL remain candidates for production persistence. No adapter, account handler, listener or gameplay is implemented here. No historical schema/content or proprietary assets are imported.

## Run in MySQL Workbench

1. Open the **Nighthaven** connection. Open a new SQL tab and run only this identity query first:

   ```sql
   SELECT VERSION(), @@hostname, @@port, CURRENT_USER();
   SHOW DATABASES LIKE 'nighthaven_test';
   ```

2. Confirm it is the intended test server and MySQL 8.0 or later. If the schema already exists, inspect it rather than running the creation script over it. Keep Workbench's **stop on SQL errors** enabled.
3. Open `create_nighthaven_test.sql` using File → Open SQL Script, select the intended connection and execute. It creates a new `nighthaven_test` database and three tables. It contains no DROP/TRUNCATE/ALTER statements, user/grant changes or data inserts. MySQL DDL commits independently; a failed setup can leave a partial schema. Inspect errors before retrying.
4. Refresh the Schemas pane and expand `nighthaven_test` → Tables. Optionally set it as the default schema.
5. Run `verify_nighthaven_test.sql`. Expect accounts, account_credentials and characters, with zero rows each. Preserve the successful output/version for test provenance. **These scripts have not been executed against a live server by Codex.**

The repository contains no connection string or database password. Root can perform initial DDL; a future application connection should use its own narrowly scoped database account. Do not put the root password or another secret in these scripts or Git.

## Tables and provisional choices

- `accounts`: internal account identity, unique test username, enabled flag (default false), UTC timestamps.
- `account_credentials`: one encoded application-generated password verifier per account. No plaintext, reversible password encoding or wire credential bytes. No verifier is seeded and no authentication algorithm is implemented by the DDL.
- `characters`: account ownership, name, independently supplied race/class labels, timestamps and a revision counter. It begins empty. The revision counter only supports concurrency if future updates compare/increment it transactionally; the database does not do that automatically.

All tables use InnoDB and explicit account foreign keys with restricted deletion. Character creation/refresh/selection must eventually be implemented through the real client flow; these empty tables alone do not make that flow work. A later application should insert the account credential and related records within appropriate transactions. Race/class labels must eventually be mapped and validated using verified client evidence. No race/class combinations, equipment or game content are seeded.

For this test only, string comparison is binary/case-sensitive and storage lengths are 64 characters. These are storage choices, **not confirmed client constraints**. Character-name indexes are nonunique because name scope/normalization/reservation rules are not established. Appearance, starting locations, progression, inventory and session recovery remain intentionally undesigned here. The database timestamp defaults assume each writing connection sets its session timezone to UTC; application-written timestamps must also be UTC. No client-supplied field is trustworthy simply because it fits a column.

## Scope and validation

This establishes minimal relational relationships for independent storage tests. It does not resolve the post-update black screen or make TCP/9735 speak an account protocol. Architecture/evidence gates are unchanged, and no database has been modified by authoring these files. Actual acceptance requires the identity query, successful DDL, table definitions and empty-row verification from the intended server.

Syntax/behavior reference: [CREATE DATABASE](https://dev.mysql.com/doc/refman/8.4/en/create-database.html), [CREATE TABLE](https://dev.mysql.com/doc/refman/8.4/en/create-table.html). Review the target version before running; no claim of tested MariaDB compatibility is made.
