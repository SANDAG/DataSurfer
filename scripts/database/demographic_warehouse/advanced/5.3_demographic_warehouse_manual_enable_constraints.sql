
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
