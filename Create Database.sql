-- CREATE DATABASE

-- Check if database exists. If it does, delete the database
IF DB_ID('SQL_Basic_Project') IS NOT NULL	
	DROP DATABASE SQL_Basic_Project
GO

-- Create new database if database does not exist
IF DB_ID('SQL_Basic_Project') IS NULL
	CREATE DATABASE SQL_Basic_Project
GO
