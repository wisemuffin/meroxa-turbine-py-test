-- Use a role that can create databases
USE ROLE accountadmin;
-- Create new database 
CREATE DATABASE meroxa_db;
USE meroxa_db;
CREATE SCHEMA stream_data;
-- Create a Snowflake role with the privileges to work with the connector.
CREATE ROLE meroxa_platform_role;
-- Grant privileges on the database.
GRANT USAGE ON DATABASE meroxa_db TO ROLE meroxa_platform_role;
GRANT USAGE ON SCHEMA stream_data TO ROLE meroxa_platform_role;
GRANT CREATE TABLE ON SCHEMA stream_data TO ROLE meroxa_platform_role;
-- Grant access to stage data
GRANT CREATE STAGE ON SCHEMA stream_data TO ROLE meroxa_platform_role;
GRANT CREATE PIPE ON SCHEMA stream_data TO ROLE meroxa_platform_role;
-- Grant the custom role to an existing user.
GRANT ROLE meroxa_platform_role TO USER meroxa_user;
ALTER USER meroxa_user SET DEFAULT_ROLE = meroxa_platform_role;
GRANT ROLE meroxa_platform_role TO ROLE sysadmin;