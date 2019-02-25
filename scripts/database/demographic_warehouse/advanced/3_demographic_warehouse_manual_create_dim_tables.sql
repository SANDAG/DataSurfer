
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Create dimension schema
CREATE SCHEMA [dim]
GO

-- 2. Create dimension tables
CREATE TABLE [dim].[age_group](
	[age_group_id] [smallint] NOT NULL,
	[name] [nvarchar](15) NOT NULL,
	[group_10yr] [nvarchar](10) NOT NULL,
	[lower_bound] [smallint] NOT NULL,
	[upper_bound] [smallint] NOT NULL,
	[group_10yr_lower_bound] [smallint] NOT NULL,
	[group_10yr_upper_bound] [smallint] NOT NULL,
	[group_5yr_lower_bound] [smallint] NOT NULL,
	[group_5yr_upper_bound] [smallint] NOT NULL,
	[group_5yr] [nvarchar](10) NULL,
	CONSTRAINT ncix_age_group_id UNIQUE (age_group_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[building_size](
	[building_size_id] [tinyint] NOT NULL,
	[name] [nvarchar](75) NOT NULL,
	CONSTRAINT ncix_building_size_id UNIQUE (building_size_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[datasource_type](
	[datasource_type_id] [tinyint] NOT NULL,
	[datasource_type] [nvarchar](25) NOT NULL,
	CONSTRAINT ncix_datasource_type_id UNIQUE (datasource_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[datasource](
	[datasource_id] [smallint] NOT NULL,
	[datasource_type_id] [tinyint] NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[series] [smallint] NOT NULL,
	[publish_year] [smallint] NULL,
	CONSTRAINT ncix_datasource_id UNIQUE (datasource_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[development_type](
	[development_type_id] [smallint] NOT NULL,
	[development_type] [nvarchar](15) NOT NULL,
	CONSTRAINT ncix_development_type_id UNIQUE (development_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[employment_type](
	[employment_type_id] [smallint] NOT NULL,
	[short_name] [nvarchar](15) NOT NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[civilian] [bit] NOT NULL,
	CONSTRAINT ncix_employment_type_id UNIQUE (employment_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[ethnicity](
	[ethnicity_id] [smallint] NOT NULL,
	[code] [nvarchar](5) NOT NULL,
	[hispanic] [bit] NOT NULL,
	[short_name] [nvarchar](35) NOT NULL,
	[long_name] [nvarchar](50) NOT NULL,
	CONSTRAINT ncix_ethnicity_id UNIQUE (ethnicity_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[forecast_year](
	[forecast_year_id] [int] NOT NULL,
	[datasource_id] [smallint] NOT NULL,
	[yr] [smallint] NOT NULL,
	CONSTRAINT ncix_forecast_year_id UNIQUE (forecast_year_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[household_type](
	[household_type_id] [tinyint] NOT NULL,
	[name] [nvarchar](75) NOT NULL,
	CONSTRAINT ncix_household_type_id UNIQUE (household_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[housing_type](
	[housing_type_id] [smallint] NOT NULL,
	[short_name] [varchar](10) NOT NULL,
	[long_name] [varchar](25) NOT NULL,
	CONSTRAINT ncix_housing_type_id UNIQUE (housing_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[income_group](
	[income_group_id] [int] NOT NULL,
	[income_group] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[constant_dollars_year] [int] NOT NULL,
	[lower_bound] [int] NOT NULL,
	[upper_bound] [int] NOT NULL,
	[categorization] [tinyint] NULL,
	CONSTRAINT ncix_income_group_id UNIQUE (income_group_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[land_use_type](
	[land_use_type_id] [smallint] NOT NULL,
	[short_name] [nvarchar](25) NOT NULL,
	[long_name] [nvarchar](50) NOT NULL,
	CONSTRAINT ncix_land_use_type_id UNIQUE (land_use_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[mgra](
	[mgra_id] [int] NOT NULL,
	[mgra] [int] NOT NULL,
	[series] [smallint] NOT NULL,
	[geotype] [nvarchar](150) NULL,
	[geotype_pretty] [nvarchar](150) NULL,
	[geozone] [nvarchar](150) NULL,
	[standard_geography] [bit] NULL) ON [PRIMARY]
GO

CREATE TABLE [dim].[mgra_denormalize](
	[mgra_id] [int] NOT NULL,
	[mgra] [int] NOT NULL,
	[series] [smallint] NOT NULL,
	[region] [nvarchar](150) NULL,
	[sra] [nvarchar](150) NULL,
	[tract] [nvarchar](150) NULL,
	[supervisorial] [nvarchar](150) NULL,
	[college] [nvarchar](150) NULL,
	[cpa] [nvarchar](150) NULL,
	[jurisdiction] [nvarchar](150) NULL,
	[zip] [nvarchar](150) NULL,
	[secondary] [nvarchar](150) NULL,
	[elementary] [nvarchar](150) NULL,
	[msa] [nvarchar](150) NULL,
	[sdcouncil] [nvarchar](150) NULL,
	[transit] [nvarchar](150) NULL,
	[unified] [nvarchar](150) NULL,
	[jurisdiction_id] [smallint] NULL,
	[cpa_id] [int] NULL,
	CONSTRAINT ncix_mgra_denormalize_mgra_id UNIQUE (mgra_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[sex](
	[sex_id] [smallint] NOT NULL,
	[sex] [nvarchar](6) NOT NULL,
	[abbreviation] [nchar](1) NOT NULL,
	CONSTRAINT ncix_sex_id UNIQUE (sex_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[structure_type](
	[structure_type_id] [smallint] NOT NULL,
	[short_name] [nvarchar](15) NOT NULL,
	[long_name] [nvarchar](35) NOT NULL,
	CONSTRAINT ncix_structure_type_id UNIQUE (structure_type_id)) ON [PRIMARY]
GO

CREATE TABLE [dim].[yr](
	[yr_id] [smallint] NOT NULL,
	CONSTRAINT ncix_yr_id UNIQUE (yr_id)) ON [PRIMARY]
GO