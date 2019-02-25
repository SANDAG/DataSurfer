
USE [demographic_warehouse_advanced]
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
GO