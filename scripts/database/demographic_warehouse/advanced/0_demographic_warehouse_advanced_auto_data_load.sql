USE [msdb]
GO

/* SQL Server Instance Prerequisites

	1. Database named demographic_warehouse should not exist on the destination instance for this script.
	2. Directory F:\SQLDATA\ needs to exist on the server with at least 300GB of free space
	3. Source data from demographic_warehouse database will need to be restored as demographic_warehouse_origin 
		on the destination instance for data pull.
	4. SQL Agent needs to be up and running for the automated scripts to run.

*/

/****** Object:  Job [Load Demographic Datawarehouse]    Script Date: 1/17/2019 13:35:43 ******/
EXEC msdb.dbo.sp_delete_job @job_name=N'Load Demographic Datawarehouse', @delete_unused_schedule=1
GO

/****** Object:  Job [Load Demographic Datawarehouse]    Script Date: 1/17/2019 13:35:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 1/17/2019 13:35:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Load Demographic Datawarehouse', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'https://github.com/SANDAG/ABM', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create Database]    Script Date: 1/17/2019 13:35:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Database', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
-- Clustered versus Non-Clustered: https://blogs.msdn.microsoft.com/sqlserverstorageengine/2016/07/18/columnstore-index-differences-between-clusterednonclustered-columnstore-index/
-- Combining nonclustered and columnstore indexes: https://docs.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-data-warehouse?view=sql-server-2017#example-use-a-nonclustered-index-to-enforce-a-primary-key-constraint-on-a-columnstore-table

CREATE DATABASE [demographic_warehouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N''demographic_warehouse_data'', FILENAME = N''F:\SQLDATA\demographic_warehouse_data.mdf'' , SIZE = 10240MB , FILEGROWTH = 512MB )
 LOG ON 
( NAME = N''demographic_warehouse_log'', FILENAME = N''F:\SQLDATA\demographic_warehouse_log.ldf'' , SIZE = 10240MB , FILEGROWTH = 512MB )
GO
ALTER DATABASE [demographic_warehouse] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [demographic_warehouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [demographic_warehouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [demographic_warehouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [demographic_warehouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [demographic_warehouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [demographic_warehouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [demographic_warehouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [demographic_warehouse] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [demographic_warehouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [demographic_warehouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [demographic_warehouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [demographic_warehouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [demographic_warehouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [demographic_warehouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [demographic_warehouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [demographic_warehouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [demographic_warehouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [demographic_warehouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [demographic_warehouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [demographic_warehouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [demographic_warehouse] SET  READ_WRITE 
GO
ALTER DATABASE [demographic_warehouse] SET RECOVERY BULK_LOGGED 
GO
ALTER DATABASE [demographic_warehouse] SET  MULTI_USER 
GO
ALTER DATABASE [demographic_warehouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [demographic_warehouse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [demographic_warehouse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [master]
GO
USE [demographic_warehouse]
GO
ALTER AUTHORIZATION ON DATABASE::[demographic_warehouse] TO [sa]
GO
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Clean Up Database]    Script Date: 1/17/2019 13:35:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Clean Up Database', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1. Drop Constraints
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''dim'' AND CONSTRAINT_NAME = N''fk_datasource_datasource_type'')
BEGIN
	ALTER TABLE [dim].[datasource] DROP CONSTRAINT [fk_datasource_datasource_type];
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_age_%'')
BEGIN
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_age_group]
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_datasource];
	ALTER TABLE [fact].[age] DROP CONSTRAINT [fk_age_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_ethnicity_%'')
BEGIN
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_datasource];
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_ethnicity];
	ALTER TABLE [fact].[ethnicity] DROP CONSTRAINT [fk_ethnicity_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_household_%'')
BEGIN
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_yr];
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_datasource];
	ALTER TABLE [fact].[household_income] DROP CONSTRAINT [fk_household_income_income_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_housing_%'')
BEGIN
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_datasource];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_structure_type];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [fk_housing_yr];
	ALTER TABLE [fact].[housing] DROP CONSTRAINT [ck_housing_occupied_unit];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_jobs_%'')
BEGIN
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_datasource];
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_employment_type];
	ALTER TABLE [fact].[jobs] DROP CONSTRAINT [fk_jobs_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_land_use_%'')
BEGIN
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_datasource];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_development_type];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_land_use_type];
	ALTER TABLE [fact].[land_use] DROP CONSTRAINT [fk_land_use_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_population_%'')
BEGIN
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_datasource];
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_housing_type];
	ALTER TABLE [fact].[population] DROP CONSTRAINT [fk_population_yr];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = N''fact'' AND CONSTRAINT_NAME LIKE N''fk_sex_%'')
BEGIN
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_datasource];
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_sex];
	ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_yr];
END

-- 2. Drop Tables
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''age'')
BEGIN
	DROP TABLE [fact].[age];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''age_sex_ethnicity'')
BEGIN
	DROP TABLE [fact].[age_sex_ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''ethnicity'')
BEGIN
	DROP TABLE [fact].[ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''household_income'')
BEGIN
	DROP TABLE [fact].[household_income];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''housing'')
BEGIN
	DROP TABLE [fact].[housing];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''jobs'')
BEGIN
	DROP TABLE [fact].[jobs];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''land_use'')
BEGIN
	DROP TABLE [fact].[land_use];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''population'')
BEGIN
	DROP TABLE [fact].[population];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''price_index_sd'')
BEGIN
	DROP TABLE [fact].[price_index_sd];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''sex'')
BEGIN
	DROP TABLE [fact].[sex];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''syn_households'')
BEGIN
	DROP TABLE [fact].[syn_households];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''fact'' AND TABLE_NAME = N''syn_persons'')
BEGIN
	DROP TABLE [fact].[syn_persons];
END

-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''age_group'')
BEGIN
	DROP TABLE [dim].[age_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''building_size'')
BEGIN
	DROP TABLE [dim].[building_size];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''datasource'')
BEGIN
	DROP TABLE [dim].[datasource];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''datasource_type'')
BEGIN
	DROP TABLE [dim].[datasource_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''development_type'')
BEGIN
	DROP TABLE [dim].[development_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''employment_type'')
BEGIN
	DROP TABLE [dim].[employment_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''ethnicity'')
BEGIN
	DROP TABLE [dim].[ethnicity];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''forecast_year'')
BEGIN
	DROP TABLE [dim].[forecast_year];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''household_type'')
BEGIN
	DROP TABLE [dim].[household_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''housing_type'')
BEGIN
	DROP TABLE [dim].[housing_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''income_group'')
BEGIN
	DROP TABLE [dim].[income_group];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''land_use_type'')
BEGIN
	DROP TABLE [dim].[land_use_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''mgra'')
BEGIN
	DROP TABLE [dim].[mgra];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''mgra_denormalize'')
BEGIN
	DROP TABLE [dim].[mgra_denormalize];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''sex'')
BEGIN
	DROP TABLE [dim].[sex];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''structure_type'')
BEGIN
	DROP TABLE [dim].[structure_type];
END

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = N''dim'' AND TABLE_NAME = N''yr'')
BEGIN
	DROP TABLE [dim].[yr];
END
GO

-- 3. Drop Schemas 
-- ********************************************************************************************************************
IF EXISTS (SELECT * FROM sys.schemas WHERE name = N''dim'')
BEGIN
	DROP SCHEMA [dim];
END
GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N''fact'')
BEGIN
	DROP SCHEMA [fact];
END
GO
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create Dimension Tables]    Script Date: 1/17/2019 13:35:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Dimension Tables', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
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
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Create Fact Tables]    Script Date: 1/17/2019 13:35:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Fact Tables', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
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
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Load Data]    Script Date: 1/17/2019 13:35:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Load Data', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT INTO [dim].[age_group]
SELECT * FROM [demographic_warehouse_origin].[dim].[age_group];
GO

INSERT INTO [dim].[building_size]
SELECT * FROM [demographic_warehouse_origin].[dim].[building_size];
GO

INSERT INTO [dim].[datasource] (datasource_id, datasource_type_id, [name], [description], series, publish_year)
SELECT datasource_id, datasource_type_id, [name], [description], series, publish_year
FROM [demographic_warehouse_origin].[dim].[datasource];
GO

INSERT INTO [dim].[datasource_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[datasource_type];
GO

INSERT INTO [dim].[development_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[development_type];
GO

INSERT INTO [dim].[employment_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[employment_type];
GO

INSERT INTO [dim].[ethnicity]
SELECT * FROM [demographic_warehouse_origin].[dim].[ethnicity];
GO

INSERT INTO [dim].[forecast_year]
SELECT * FROM [demographic_warehouse_origin].[dim].[forecast_year];
GO

INSERT INTO [dim].[household_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[household_type];
GO

INSERT INTO [dim].[housing_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[housing_type];
GO

INSERT INTO [dim].[income_group]
SELECT * FROM [demographic_warehouse_origin].[dim].[income_group];
GO

INSERT INTO [dim].[land_use_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[land_use_type];
GO

INSERT INTO [dim].[mgra]
SELECT * FROM [demographic_warehouse_origin].[dim].[mgra];
GO

INSERT INTO [dim].[mgra_denormalize]
SELECT * FROM [demographic_warehouse_origin].[dim].[mgra_denormalize];
GO

INSERT INTO [dim].[sex]
SELECT * FROM [demographic_warehouse_origin].[dim].[sex];
GO

INSERT INTO [dim].[structure_type]
SELECT * FROM [demographic_warehouse_origin].[dim].[structure_type];
GO

INSERT INTO [dim].[yr]
SELECT * FROM [demographic_warehouse_origin].[dim].[yr];
GO

SET IDENTITY_INSERT [fact].[age] ON;
INSERT INTO [fact].[age] ([age_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[age_group_id]
      ,[population])
SELECT [age_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[age_group_id]
      ,[population]
FROM [demographic_warehouse_origin].[fact].[age]
SET IDENTITY_INSERT [fact].[age] OFF;
GO

SET IDENTITY_INSERT [fact].[age_sex_ethnicity] ON;
INSERT INTO [fact].[age_sex_ethnicity] ([datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[age_group_id]
      ,[sex_id]
      ,[ethnicity_id]
      ,[population]
      ,[age_sex_ethnicity_id])
SELECT [datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[age_group_id]
      ,[sex_id]
      ,[ethnicity_id]
      ,[population]
      ,[age_sex_ethnicity_id]
FROM [demographic_warehouse_origin].[fact].[age_sex_ethnicity];
SET IDENTITY_INSERT [fact].[age_sex_ethnicity] OFF;
GO

SET IDENTITY_INSERT [fact].[ethnicity] ON;
INSERT INTO [fact].[ethnicity] ([id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[ethnicity_id]
      ,[population])
SELECT [id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[ethnicity_id]
      ,[population]
FROM [demographic_warehouse_origin].[fact].[ethnicity];
SET IDENTITY_INSERT [fact].[ethnicity] OFF;
GO

SET IDENTITY_INSERT [fact].[household_income] ON;
INSERT INTO [fact].[household_income] ([household_income_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[income_group_id]
      ,[households])
SELECT [household_income_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[income_group_id]
      ,[households]
FROM [demographic_warehouse_origin].[fact].[household_income];
SET IDENTITY_INSERT [fact].[household_income] OFF;
GO

SET IDENTITY_INSERT [fact].[housing] ON;
INSERT INTO [fact].[housing] ([housing_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[structure_type_id]
      ,[units]
      ,[unoccupiable]
      ,[occupied]
      ,[vacancy])
SELECT [housing_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[structure_type_id]
      ,[units]
      ,[unoccupiable]
      ,[occupied]
      ,[vacancy]
FROM [demographic_warehouse_origin].[fact].[housing];
SET IDENTITY_INSERT [fact].[housing] OFF;
GO

SET IDENTITY_INSERT [fact].[jobs] ON;
INSERT INTO [fact].[jobs] ([jobs_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[employment_type_id]
      ,[jobs])
SELECT [jobs_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[employment_type_id]
      ,[jobs]
FROM [demographic_warehouse_origin].[fact].[jobs];
SET IDENTITY_INSERT [fact].[jobs] OFF;
GO

SET IDENTITY_INSERT [fact].[land_use] ON;
INSERT INTO [fact].[land_use] ([land_use_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[land_use_type_id]
      ,[development_type_id]
      ,[acres])
SELECT [land_use_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[land_use_type_id]
      ,[development_type_id]
      ,[acres]
FROM [demographic_warehouse_origin].[fact].[land_use];
SET IDENTITY_INSERT [fact].[land_use] OFF;
GO

SET IDENTITY_INSERT [fact].[population] ON;
INSERT INTO [fact].[population] ([population_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[housing_type_id]
      ,[population])
SELECT [population_id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[housing_type_id]
      ,[population]
FROM [demographic_warehouse_origin].[fact].[population];
SET IDENTITY_INSERT [fact].[population] OFF;
GO

INSERT INTO [fact].[price_index_sd]
SELECT * FROM [demographic_warehouse_origin].[fact].[price_index_sd];
GO

SET IDENTITY_INSERT [fact].[sex] ON;
INSERT INTO [fact].[sex] ([id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[sex_id]
      ,[population])
SELECT [id]
      ,[datasource_id]
      ,[yr_id]
      ,[mgra_id]
      ,[sex_id]
      ,[population]
FROM [demographic_warehouse_origin].[fact].[sex];
SET IDENTITY_INSERT [fact].[sex] OFF;
GO

SET IDENTITY_INSERT [fact].[syn_households] ON;
INSERT INTO [fact].[syn_households] ([syn_hh_id]
      ,[datasource_id]
      ,[yr]
      ,[hh_id]
      ,[mgra_id]
      ,[income_group_id]
      ,[hh_income]
      ,[workers]
      ,[persons]
      ,[household_type_id]
      ,[building_size_id]
      ,[unit_type_id]
      ,[poverty])
SELECT [syn_hh_id]
      ,[datasource_id]
      ,[yr]
      ,[hh_id]
      ,[mgra_id]
      ,[income_group_id]
      ,[hh_income]
      ,[workers]
      ,[persons]
      ,[household_type_id]
      ,[building_size_id]
      ,[unit_type_id]
      ,[poverty]
FROM [demographic_warehouse_origin].[fact].[syn_households];
SET IDENTITY_INSERT [fact].[syn_households] OFF;
GO

SET IDENTITY_INSERT [fact].[syn_persons] ON;
INSERT INTO [fact].[syn_persons] ([syn_person_id]
      ,[datasource_id]
      ,[yr]
      ,[hh_id]
      ,[person_id]
      ,[person_number]
      ,[age]
      ,[sex_id]
      ,[military]
      ,[employment_status]
      ,[student_type]
      ,[person_type_id]
      ,[education]
      ,[grade]
      ,[occen5]
      ,[occsoc5]
      ,[indcen]
      ,[weeks]
      ,[hrs]
      ,[rac1p]
      ,[hisp])
SELECT [syn_person_id]
      ,[datasource_id]
      ,[yr]
      ,[hh_id]
      ,[person_id]
      ,[person_number]
      ,[age]
      ,[sex_id]
      ,[military]
      ,[employment_status]
      ,[student_type]
      ,[person_type_id]
      ,[education]
      ,[grade]
      ,[occen5]
      ,[occsoc5]
      ,[indcen]
      ,[weeks]
      ,[hrs]
      ,[rac1p]
      ,[hisp]
FROM [demographic_warehouse_origin].[fact].[syn_persons];
SET IDENTITY_INSERT [fact].[syn_persons] OFF;
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Apply Clustered Columnstore Indexes]    Script Date: 1/17/2019 13:35:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apply Clustered Columnstore Indexes', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE CLUSTERED COLUMNSTORE INDEX [ccix_age_group] ON [dim].[age_group] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_building_size] ON [dim].[building_size] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_datasource_type] ON [dim].[datasource_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_datasource] ON [dim].[datasource] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_development_type] ON [dim].[development_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_employment_type] ON [dim].[employment_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_ethnicity] ON [dim].[ethnicity] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_forecast_year] ON [dim].[forecast_year] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_household_type] ON [dim].[household_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_housing_type] ON [dim].[housing_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_income_group] ON [dim].[income_group] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_land_use_type] ON [dim].[land_use_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_mgra] ON [dim].[mgra] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_mgra_denormalize] ON [dim].[mgra_denormalize] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_sex] ON [dim].[sex] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_structure_type] ON [dim].[structure_type] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_yr] ON [dim].[yr] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
GO

CREATE CLUSTERED COLUMNSTORE INDEX [ccix_age] ON [fact].[age] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_age_sex_ethnicity] ON [fact].[age_sex_ethnicity] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_ethnicity] ON [fact].[ethnicity] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_household_income] ON [fact].[household_income] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_housing] ON [fact].[housing] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_jobs] ON [fact].[jobs] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_land_use] ON [fact].[land_use] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_population] ON [fact].[population] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_price_index_sd] ON [fact].[price_index_sd] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_sex] ON [fact].[sex] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_syn_households] ON [fact].[syn_households] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
CREATE CLUSTERED COLUMNSTORE INDEX [ccix_syn_persons] ON [fact].[syn_persons] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY];
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Apply Database Constraints]    Script Date: 1/17/2019 13:35:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Apply Database Constraints', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dim].[datasource] WITH CHECK ADD CONSTRAINT [fk_datasource_datasource_type] FOREIGN KEY([datasource_type_id]) REFERENCES [dim].[datasource_type] ([datasource_type_id])
GO
ALTER TABLE [dim].[datasource] CHECK CONSTRAINT [fk_datasource_datasource_type]
GO
ALTER TABLE [dim].[employment_type] ADD  CONSTRAINT [df_employment_type_employment_type_id]  DEFAULT ((1)) FOR [employment_type_id]
GO

ALTER TABLE [fact].[age] WITH CHECK ADD CONSTRAINT [fk_age_age_group] FOREIGN KEY([age_group_id]) REFERENCES [dim].[age_group] ([age_group_id])
GO
ALTER TABLE [fact].[age] CHECK CONSTRAINT [fk_age_age_group]
GO
ALTER TABLE [fact].[age] WITH CHECK ADD CONSTRAINT [fk_age_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[age] CHECK CONSTRAINT [fk_age_datasource]
GO
ALTER TABLE [fact].[age] WITH CHECK ADD CONSTRAINT [fk_age_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[age] CHECK CONSTRAINT [fk_age_yr]
GO
ALTER TABLE [fact].[ethnicity] WITH CHECK ADD CONSTRAINT [fk_ethnicity_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[ethnicity] CHECK CONSTRAINT [fk_ethnicity_datasource]
GO
ALTER TABLE [fact].[ethnicity] WITH CHECK ADD CONSTRAINT [fk_ethnicity_ethnicity] FOREIGN KEY([ethnicity_id]) REFERENCES [dim].[ethnicity] ([ethnicity_id])
GO
ALTER TABLE [fact].[ethnicity] CHECK CONSTRAINT [fk_ethnicity_ethnicity]
GO
ALTER TABLE [fact].[ethnicity] WITH CHECK ADD CONSTRAINT [fk_ethnicity_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[ethnicity] CHECK CONSTRAINT [fk_ethnicity_yr]
GO
ALTER TABLE [fact].[household_income] WITH NOCHECK ADD CONSTRAINT [fk_household_income_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[household_income] NOCHECK CONSTRAINT [fk_household_income_yr]
GO
ALTER TABLE [fact].[household_income] WITH NOCHECK ADD CONSTRAINT [fk_household_income_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[household_income] NOCHECK CONSTRAINT [fk_household_income_datasource]
GO
ALTER TABLE [fact].[household_income] WITH NOCHECK ADD CONSTRAINT [fk_household_income_income_group] FOREIGN KEY([income_group_id]) REFERENCES [dim].[income_group] ([income_group_id])
GO
ALTER TABLE [fact].[household_income] NOCHECK CONSTRAINT [fk_household_income_income_group]
GO
ALTER TABLE [fact].[housing] WITH NOCHECK ADD CONSTRAINT [fk_housing_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[housing] NOCHECK CONSTRAINT [fk_housing_datasource]
GO
ALTER TABLE [fact].[housing] WITH NOCHECK ADD CONSTRAINT [fk_housing_structure_type] FOREIGN KEY([structure_type_id]) REFERENCES [dim].[structure_type] ([structure_type_id])
GO
ALTER TABLE [fact].[housing] NOCHECK CONSTRAINT [fk_housing_structure_type]
GO
ALTER TABLE [fact].[housing] WITH NOCHECK ADD CONSTRAINT [fk_housing_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[housing] NOCHECK CONSTRAINT [fk_housing_yr]
GO
ALTER TABLE [fact].[housing] WITH CHECK ADD CONSTRAINT [ck_housing_occupied_unit] CHECK (([datasource_id]=(13) OR [occupied]<=[units]))
GO
ALTER TABLE [fact].[housing] CHECK CONSTRAINT [ck_housing_occupied_unit]
GO
ALTER TABLE [fact].[jobs] WITH NOCHECK ADD CONSTRAINT [fk_jobs_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[jobs] NOCHECK CONSTRAINT [fk_jobs_datasource]
GO
ALTER TABLE [fact].[jobs] WITH NOCHECK ADD CONSTRAINT [fk_jobs_employment_type] FOREIGN KEY([employment_type_id]) REFERENCES [dim].[employment_type] ([employment_type_id])
GO
ALTER TABLE [fact].[jobs] NOCHECK CONSTRAINT [fk_jobs_employment_type]
GO
ALTER TABLE [fact].[jobs] WITH NOCHECK ADD CONSTRAINT [fk_jobs_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[jobs] NOCHECK CONSTRAINT [fk_jobs_yr]
GO
ALTER TABLE [fact].[land_use] WITH NOCHECK ADD CONSTRAINT [fk_land_use_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[land_use] NOCHECK CONSTRAINT [fk_land_use_datasource]
GO
ALTER TABLE [fact].[land_use] WITH NOCHECK ADD CONSTRAINT [fk_land_use_development_type] FOREIGN KEY([development_type_id]) REFERENCES [dim].[development_type] ([development_type_id])
GO
ALTER TABLE [fact].[land_use] NOCHECK CONSTRAINT [fk_land_use_development_type]
GO
ALTER TABLE [fact].[land_use] WITH NOCHECK ADD CONSTRAINT [fk_land_use_land_use_type] FOREIGN KEY([land_use_type_id]) REFERENCES [dim].[land_use_type] ([land_use_type_id])
GO
ALTER TABLE [fact].[land_use] NOCHECK CONSTRAINT [fk_land_use_land_use_type]
GO
ALTER TABLE [fact].[land_use] WITH NOCHECK ADD CONSTRAINT [fk_land_use_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[land_use] NOCHECK CONSTRAINT [fk_land_use_yr]
GO
ALTER TABLE [fact].[population] WITH NOCHECK ADD CONSTRAINT [fk_population_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[population] NOCHECK CONSTRAINT [fk_population_datasource]
GO
ALTER TABLE [fact].[population] WITH NOCHECK ADD CONSTRAINT [fk_population_housing_type] FOREIGN KEY([housing_type_id]) REFERENCES [dim].[housing_type] ([housing_type_id])
GO
ALTER TABLE [fact].[population] NOCHECK CONSTRAINT [fk_population_housing_type]
GO
ALTER TABLE [fact].[population] WITH NOCHECK ADD CONSTRAINT [fk_population_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[population] NOCHECK CONSTRAINT [fk_population_yr]
GO
ALTER TABLE [fact].[sex] WITH CHECK ADD CONSTRAINT [fk_sex_datasource] FOREIGN KEY([datasource_id]) REFERENCES [dim].[datasource] ([datasource_id])
GO
ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_datasource]
GO
ALTER TABLE [fact].[sex] WITH CHECK ADD CONSTRAINT [fk_sex_sex] FOREIGN KEY([sex_id]) REFERENCES [dim].[sex] ([sex_id])
GO
ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_sex]
GO
ALTER TABLE [fact].[sex] WITH CHECK ADD CONSTRAINT [fk_sex_yr] FOREIGN KEY([yr_id]) REFERENCES [dim].[yr] ([yr_id])
GO
ALTER TABLE [fact].[sex] CHECK CONSTRAINT [fk_sex_yr]
GO
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Reclaim Storage Space]    Script Date: 1/17/2019 13:35:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Reclaim Storage Space', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
USE [demographic_warehouse]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DBCC SHRINKFILE (N''demographic_warehouse_data'' , 10240)
GO
DBCC SHRINKFILE (N''demographic_warehouse_log'' , 0)
GO

USE [master]
GO
ALTER DATABASE [demographic_warehouse] SET RECOVERY SIMPLE WITH NO_WAIT
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

USE msdb ;  
GO  
EXEC dbo.sp_start_job N'Load Demographic Datawarehouse';  
GO  