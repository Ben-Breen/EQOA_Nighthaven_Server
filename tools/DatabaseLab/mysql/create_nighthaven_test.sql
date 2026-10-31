-- Nighthaven-owned disposable persistence scaffold. MySQL 8.0+.
-- Inspect the intended Workbench connection before executing this file.
-- Use a fresh schema: stop on errors; do not continue if this database exists.
-- No users/grants, credentials, imported content or character seeds are supplied.

SELECT VERSION() AS server_version, @@hostname AS server_host,
       @@port AS server_port, CURRENT_USER() AS database_account;

CREATE DATABASE nighthaven_test
    CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
USE nighthaven_test;
SET SESSION time_zone = '+00:00';

CREATE TABLE accounts (
    account_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    created_at_utc DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at_utc DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (account_id),
    UNIQUE KEY uq_accounts_username (username)
) ENGINE = InnoDB;

-- Application-generated, self-describing encoded password verifiers only.
-- Never insert plaintext, packet credential bytes or the MySQL root password.
-- No hash algorithm/authentication protocol is selected by this table.
CREATE TABLE account_credentials (
    account_id BIGINT UNSIGNED NOT NULL,
    password_hash VARCHAR(512) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    changed_at_utc DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (account_id),
    CONSTRAINT fk_credentials_account FOREIGN KEY (account_id)
        REFERENCES accounts (account_id) ON DELETE RESTRICT
) ENGINE = InnoDB;

-- Domain labels are application test inputs, not original-client wire IDs.
-- No valid race/class catalogue or pairing rules are asserted here.
CREATE TABLE characters (
    character_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    account_id BIGINT UNSIGNED NOT NULL,
    character_name VARCHAR(64) NOT NULL,
    race_key VARCHAR(64) NOT NULL,
    class_key VARCHAR(64) NOT NULL,
    revision BIGINT UNSIGNED NOT NULL DEFAULT 1,
    created_at_utc DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at_utc DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
        ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (character_id),
    KEY ix_characters_account (account_id),
    KEY ix_characters_name (character_name),
    CONSTRAINT fk_characters_account FOREIGN KEY (account_id)
        REFERENCES accounts (account_id) ON DELETE RESTRICT
) ENGINE = InnoDB;

SELECT table_name, engine
FROM information_schema.tables
WHERE table_schema = 'nighthaven_test'
ORDER BY table_name;
