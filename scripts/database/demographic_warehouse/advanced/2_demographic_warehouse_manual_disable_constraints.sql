
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Drop Constraints
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'dim' AND CONSTRAINT_NAME = N'fk_datasource_datasource_type')
BEGIN
	ALTER TABLE [dim].[datasource] DROP CONSTRAINT [fk_datasource_datasource_type];
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_age_%')
BEGIN
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_age_group]
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_datasource];
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_ethnicity_%')
BEGIN
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_datasource];
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_ethnicity];
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_household_%')
BEGIN
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_yr];
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_datasource];
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_income_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_housing_%')
BEGIN
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_datasource];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_structure_type];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_yr];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [ck_housing_occupied_unit];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_jobs_%')
BEGIN
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_datasource];
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_employment_type];
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_land_use_%')
BEGIN
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_datasource];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_development_type];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_land_use_type];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_population_%')
BEGIN
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_datasource];
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_housing_type];
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N'fact' AND CONSTRAINT_NAME LIKE N'fk_sex_%')
BEGIN
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_datasource];
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_sex];
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_yr];
END

-- 2. Drop Tables
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'age')
BEGIN
	DROP TABLE [fact].[age];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'age_sex_ethnicity')
BEGIN
	DROP TABLE [fact].[age_sex_ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'ethnicity')
BEGIN
	DROP TABLE [fact].[ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'household_income')
BEGIN
	DROP TABLE [fact].[household_income];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'housing')
BEGIN
	DROP TABLE [fact].[housing];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'jobs')
BEGIN
	DROP TABLE [fact].[jobs];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'land_use')
BEGIN
	DROP TABLE [fact].[land_use];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'population')
BEGIN
	DROP TABLE [fact].[population];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'price_index_sd')
BEGIN
	DROP TABLE [fact].[price_index_sd];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'sex')
BEGIN
	DROP TABLE [fact].[sex];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'syn_households')
BEGIN
	DROP TABLE [fact].[syn_households];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'fact' AND TABLE_NAME = N'syn_persons')
BEGIN
	DROP TABLE [fact].[syn_persons];
END

-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'age_group')
BEGIN
	DROP TABLE [dim].[age_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'building_size')
BEGIN
	DROP TABLE [dim].[building_size];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'datasource')
BEGIN
	DROP TABLE [dim].[datasource];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'datasource_type')
BEGIN
	DROP TABLE [dim].[datasource_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'development_type')
BEGIN
	DROP TABLE [dim].[development_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'employment_type')
BEGIN
	DROP TABLE [dim].[employment_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'ethnicity')
BEGIN
	DROP TABLE [dim].[ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'forecast_year')
BEGIN
	DROP TABLE [dim].[forecast_year];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'household_type')
BEGIN
	DROP TABLE [dim].[household_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'housing_type')
BEGIN
	DROP TABLE [dim].[housing_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'income_group')
BEGIN
	DROP TABLE [dim].[income_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'land_use_type')
BEGIN
	DROP TABLE [dim].[land_use_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'mgra')
BEGIN
	DROP TABLE [dim].[mgra];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'mgra_denormalize')
BEGIN
	DROP TABLE [dim].[mgra_denormalize];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'sex')
BEGIN
	DROP TABLE [dim].[sex];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'structure_type')
BEGIN
	DROP TABLE [dim].[structure_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N'dim' AND TABLE_NAME = N'yr')
BEGIN
	DROP TABLE [dim].[yr];
END
GO

-- 3. Drop Schemas 
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'dim')
BEGIN
	DROP SCHEMA [dim];
END
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'fact')
BEGIN
	DROP SCHEMA [fact];
END
GO
