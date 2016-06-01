DROP TABLE staging.mgra;

CREATE TABLE staging.mgra (
  mgra_id int not null
  ,mgra int not null
  ,series smallint not null
  ,geotype varchar(50) not null
  ,geotype_pretty varchar(100)
  ,geozone varchar(50) not null
);

COPY staging.mgra FROM '/tmp/mgra.csv' DELIMITER ',' CSV HEADER;

DELETE FROM dim.mgra WHERE series = 13 and geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM dim.mgra WHERE series = 13 and geotype = 'cpa' and geozone = 'Nestor';

INSERT INTO dim.mgra (mgra_id, mgra, series, geotype, geotype_pretty, geozone)
  SELECT mgra_id, mgra, series, geotype, geotype_pretty, geozone FROM staging.mgra WHERE series = 13 and geotype = 'cpa' and geozone in ('Otay Mesa','Nestor');

DELETE FROM fact.summary_age_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_age_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_age_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_age_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_age_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_ethnicity_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_ethnicity_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_ethnicity_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_ethnicity_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_ethnicity_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_housing_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_housing_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_housing_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_housing_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_housing_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_income_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_income_median_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_median_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_median_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_median_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_income_median_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_population_ds15 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_population_ds16 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_population_ds17 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_population_ds18 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';
DELETE FROM fact.summary_population_ds19 WHERE geotype = 'cpa' and geozone = 'Otay Mesa';

DELETE FROM fact.summary_age_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_age_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_age_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_age_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_age_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';

DELETE FROM fact.summary_ethnicity_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_ethnicity_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_ethnicity_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_ethnicity_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_ethnicity_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';

DELETE FROM fact.summary_housing_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_housing_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_housing_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_housing_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_housing_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';

DELETE FROM fact.summary_income_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';

DELETE FROM fact.summary_income_median_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_median_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_median_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_median_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_income_median_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';

DELETE FROM fact.summary_population_ds15 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_population_ds16 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_population_ds17 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_population_ds18 WHERE geotype = 'cpa' and geozone = 'Nestor';
DELETE FROM fact.summary_population_ds19 WHERE geotype = 'cpa' and geozone = 'Nestor';


DO $$
DECLARE v_datasource_id smallint;
BEGIN
v_datasource_id := 15;
--AGE
INSERT INTO fact.summary_age_ds15
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) age;

INSERT INTO fact.summary_age_ds15
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Nestor')) age;

--ETHNICITY
INSERT INTO fact.summary_ethnicity_ds15
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) e;

INSERT INTO fact.summary_ethnicity_ds15
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Nestor')) e;

--HOUSING
INSERT INTO fact.summary_housing_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_housing_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

--INCOME
INSERT INTO fact.summary_income_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--INCOME MEDIAN
INSERT INTO fact.summary_income_median_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_median_ds15
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--POPULATION
INSERT INTO fact.summary_population_ds15
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_population_ds15
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

END $$;

-----------------------DS 16---------------------------------------------------------------------------
DO $$
DECLARE v_datasource_id smallint;
BEGIN
v_datasource_id := 16;
--AGE
INSERT INTO fact.summary_age_ds16
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) age;

INSERT INTO fact.summary_age_ds16
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Nestor')) age;

--ETHNICITY
INSERT INTO fact.summary_ethnicity_ds16
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) e;

INSERT INTO fact.summary_ethnicity_ds16
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Nestor')) e;

--HOUSING
INSERT INTO fact.summary_housing_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_housing_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

--INCOME
INSERT INTO fact.summary_income_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--INCOME MEDIAN
INSERT INTO fact.summary_income_median_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_median_ds16
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--POPULATION
INSERT INTO fact.summary_population_ds16
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_population_ds16
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

END $$;


----------------------------------DS 17------------------------------
DO $$
DECLARE v_datasource_id smallint;
BEGIN
v_datasource_id := 17;
--AGE
INSERT INTO fact.summary_age_ds17
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) age;

INSERT INTO fact.summary_age_ds17
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Nestor')) age;

--ETHNICITY
INSERT INTO fact.summary_ethnicity_ds17
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) e;

INSERT INTO fact.summary_ethnicity_ds17
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Nestor')) e;

--HOUSING
INSERT INTO fact.summary_housing_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_housing_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

--INCOME
INSERT INTO fact.summary_income_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--INCOME MEDIAN
INSERT INTO fact.summary_income_median_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_median_ds17
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--POPULATION
INSERT INTO fact.summary_population_ds17
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_population_ds17
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

END $$;


------------------------------------DS 18----------------------------------------------------------
DO $$
DECLARE v_datasource_id smallint;
BEGIN
v_datasource_id := 18;
--AGE
INSERT INTO fact.summary_age_ds18
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) age;

INSERT INTO fact.summary_age_ds18
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Nestor')) age;

--ETHNICITY
INSERT INTO fact.summary_ethnicity_ds18
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) e;

INSERT INTO fact.summary_ethnicity_ds18
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Nestor')) e;

--HOUSING
INSERT INTO fact.summary_housing_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_housing_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

--INCOME
INSERT INTO fact.summary_income_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--INCOME MEDIAN
INSERT INTO fact.summary_income_median_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_median_ds18
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--POPULATION
INSERT INTO fact.summary_population_ds18
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_population_ds18
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

END $$;



-------------------------------------DS 19-------------------------------------------------------
DO $$
DECLARE v_datasource_id smallint;
BEGIN
v_datasource_id := 19;
--AGE
INSERT INTO fact.summary_age_ds19
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) age;

INSERT INTO fact.summary_age_ds19
SELECT 
  v_datasource_id as datasource_id, 'cpa' as geotype, age.geography_zone as geozone
  ,age.yr as yr, age.sex as sex, age.group_10yr as age_group, age.population as population
FROM
  app.fn_age_profile(v_datasource_id, lower('cpa'), lower('Nestor')) age;

--ETHNICITY
INSERT INTO fact.summary_ethnicity_ds19
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) e;

INSERT INTO fact.summary_ethnicity_ds19
SELECT
  v_datasource_id as datasource_id, 'cpa' as geotype, e.geography_zone as geozone
  ,e.yr as yr, e.ethnicity as ethnic, e.population as population
FROM
  app.fn_ethnicity_profile(v_datasource_id, lower('cpa'), lower('Nestor')) e;

--HOUSING
INSERT INTO fact.summary_housing_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_housing_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,h.geography_zone as geozone
  ,h.yr as yr,h.unit_type,h.units,h.occupied,h.unoccupied,h.vacancy_rate
FROM
  app.fn_housing_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

--INCOME
INSERT INTO fact.summary_income_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.ordinal,i.income_group,i.households
FROM
  app.fn_income_profile(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--INCOME MEDIAN
INSERT INTO fact.summary_income_median_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Otay Mesa')) i;

INSERT INTO fact.summary_income_median_ds19
SELECT
  v_datasource_id as datasource_id,cast('cpa' as varchar) as geotype,i.geography_zone as geozone
  ,i.yr as yr,i.median_inc
FROM
  app.fn_median_income(v_datasource_id, lower('cpa'), lower('Nestor')) i;

--POPULATION
INSERT INTO fact.summary_population_ds19
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Otay Mesa')) h;

INSERT INTO fact.summary_population_ds19
SELECT
   v_datasource_id as datasource_id, cast('cpa' as varchar) as geotype,h.geography_zone as geozone
   ,h.yr as yr,h.housing_type,h.population
FROM
  app.fn_population_profile(v_datasource_id, lower('cpa'), lower('Nestor')) h;

END $$;