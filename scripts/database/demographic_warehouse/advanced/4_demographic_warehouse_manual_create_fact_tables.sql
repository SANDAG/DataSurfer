
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Create dimension schema
CREATE SCHEMA [fact]
GO

-- 2. Create fact tables
CREATE TABLE [fact].[age](
	[age_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[age_group_id] [smallint] NULL,
	[population] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[age_sex_ethnicity](
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[age_group_id] [smallint] NOT NULL,
	[sex_id] [smallint] NOT NULL,
	[ethnicity_id] [smallint] NOT NULL,
	[population] [int] NOT NULL,
	[age_sex_ethnicity_id] [bigint] IDENTITY(1,1) NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[ethnicity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[ethnicity_id] [smallint] NULL,
	[population] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[household_income](
	[household_income_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NULL,
	[mgra_id] [int] NOT NULL,
	[income_group_id] [int] NOT NULL,
	[households] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[housing](
	[housing_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[structure_type_id] [smallint] NOT NULL,
	[units] [int] NOT NULL,
	[unoccupiable] [int] NULL,
	[occupied] [int] NOT NULL,
	[vacancy] [float] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[jobs](
	[jobs_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[employment_type_id] [smallint] NOT NULL,
	[jobs] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[land_use](
	[land_use_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[land_use_type_id] [smallint] NOT NULL,
	[development_type_id] [smallint] NOT NULL,
	[acres] [float] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[population](
	[population_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[housing_type_id] [smallint] NOT NULL,
	[population] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[price_index_sd](
	[estimates_year] [int] NOT NULL,
	[cpisd] [float] NULL,
	[CPIyear] [int] NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[sex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr_id] [smallint] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[sex_id] [smallint] NULL,
	[population] [int] NOT NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[syn_households](
	[syn_hh_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr] [smallint] NOT NULL,
	[hh_id] [int] NOT NULL,
	[mgra_id] [int] NOT NULL,
	[income_group_id] [smallint] NOT NULL,
	[hh_income] [int] NOT NULL,
	[workers] [tinyint] NOT NULL,
	[persons] [tinyint] NOT NULL,
	[household_type_id] [tinyint] NOT NULL,
	[building_size_id] [tinyint] NOT NULL,
	[unit_type_id] [tinyint] NOT NULL,
	[poverty] [decimal](5, 3) NULL) ON [PRIMARY]
GO

CREATE TABLE [fact].[syn_persons](
	[syn_person_id] [int] IDENTITY(1,1) NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr] [smallint] NOT NULL,
	[hh_id] [int] NOT NULL,
	[person_id] [int] NOT NULL,
	[person_number] [smallint] NOT NULL,
	[age] [smallint] NOT NULL,
	[sex_id] [tinyint] NOT NULL,
	[military] [smallint] NOT NULL,
	[employment_status] [smallint] NOT NULL,
	[student_type] [smallint] NOT NULL,
	[person_type_id] [smallint] NOT NULL,
	[education] [smallint] NOT NULL,
	[grade] [smallint] NULL,
	[occen5] [smallint] NULL,
	[occsoc5] [nvarchar](7) NULL,
	[indcen] [smallint] NULL,
	[weeks] [smallint] NULL,
	[hrs] [smallint] NULL,
	[rac1p] [smallint] NULL,
	[hisp] [smallint] NULL) ON [PRIMARY]
GO