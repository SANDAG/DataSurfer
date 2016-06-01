DROP TABLE IF EXISTS staging.age_sex_ethnicity;
DROP TABLE IF EXISTS staging.household_income;
DROP TABLE IF EXISTS staging.housing;
DROP TABLE IF EXISTS staging.mgra;
DROP TABLE IF EXISTS staging.population;

CREATE TABLE staging.age_sex_ethnicity
(
  age_sex_ethnicity_id integer NOT NULL,
  datasource_id smallint NOT NULL,
  yr smallint NOT NULL,
  mgra_id integer NOT NULL,
  age_group_id smallint NOT NULL,
  sex_id smallint NOT NULL,
  ethnicity_id smallint NOT NULL,
  population integer NOT NULL
);


CREATE TABLE staging.household_income
(
  household_income_id integer NOT NULL,
  datasource_id smallint NOT NULL,
  yr integer NOT NULL,
  mgra_id integer NOT NULL,
  income_group_id integer NOT NULL,
  households integer NOT NULL
);

CREATE TABLE staging.housing
(
  housing_id integer NOT NULL,
  datasource_id smallint NOT NULL,
  yr smallint NOT NULL,
  mgra_id integer NOT NULL,
  structure_type_id smallint NOT NULL,
  units integer NOT NULL,
  occupied integer NOT NULL,
  vacancy double precision NOT NULL
);

CREATE TABLE staging.population
(
  population_id integer NOT NULL,
  datasource_id smallint NOT NULL,
  yr smallint NOT NULL,
  mgra_id integer NOT NULL,
  housing_type_id smallint NOT NULL,
  population integer NOT NULL
);

CREATE TABLE staging.mgra
(
  mgra_id integer NOT NULL,
  mgra integer NOT NULL,
  series smallint NOT NULL,
  geotype character varying(50) NOT NULL,
  geotype_pretty character varying(100) NOT NULL,
  geozone character varying(50) NOT NULL
);

COPY staging.age_sex_ethnicity FROM '/tmp/age_sex_ethnicity.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.household_income FROM '/tmp/household_income.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.housing FROM '/tmp/housing.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.mgra FROM '/tmp/mgra.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.population FROM '/tmp/population.csv' WITH CSV DELIMITER ',' HEADER;


TRUNCATE TABLE dim.mgra;
INSERT INTO dim.mgra (mgra_id, mgra, series, geotype, geotype_pretty, geozone) SELECT mgra_id, mgra, series, geotype, geotype_pretty, geozone FROM staging.mgra;


TRUNCATE TABLE fact.age_sex_ethnicity_ds15;
TRUNCATE TABLE fact.age_sex_ethnicity_ds16;
TRUNCATE TABLE fact.age_sex_ethnicity_ds17;
TRUNCATE TABLE fact.age_sex_ethnicity_ds18;
TRUNCATE TABLE fact.age_sex_ethnicity_ds19;

INSERT INTO fact.age_sex_ethnicity_ds15 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 15;
INSERT INTO fact.age_sex_ethnicity_ds16 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 16;
INSERT INTO fact.age_sex_ethnicity_ds17 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 17;
INSERT INTO fact.age_sex_ethnicity_ds18 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 18;
INSERT INTO fact.age_sex_ethnicity_ds19 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 19;

DELETE FROM fact.household_income WHERE datasource_id IN (15,16,17,18,19);
INSERT INTO fact.household_income (datasource_id, yr, mgra_id, income_group_id, households) SELECT datasource_id, yr, mgra_id, income_group_id, households FROM staging.household_income;

DELETE FROM fact.housing WHERE datasource_id IN (15,16,17,18,19);
INSERT INTO fact.housing (datasource_id, yr, mgra_id, structure_type_id, units, occupied, vacancy) SELECT datasource_id, yr, mgra_id, structure_type_id, units, occupied, vacancy FROM staging.housing;

DELETE FROM fact.population WHERE datasource_id IN (15,16,17,18,19);
INSERT INTO fact.population (datasource_id, yr, mgra_id, housing_type_id, population) SELECT datasource_id, yr, mgra_id, housing_type_id, population FROM staging.population;

ALTER TABLE fact.age_sex_ethnicity_ds2 ADD CONSTRAINT pk_age_sex_ethnicity_ds2 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds3 ADD CONSTRAINT pk_age_sex_ethnicity_ds3 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds4 ADD CONSTRAINT pk_age_sex_ethnicity_ds4 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds5 ADD CONSTRAINT pk_age_sex_ethnicity_ds5 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds6 ADD CONSTRAINT pk_age_sex_ethnicity_ds6 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds10 ADD CONSTRAINT pk_age_sex_ethnicity_ds10 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds12 ADD CONSTRAINT pk_age_sex_ethnicity_ds12 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds13 ADD CONSTRAINT pk_age_sex_ethnicity_ds13 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds14 ADD CONSTRAINT pk_age_sex_ethnicity_ds14 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds15 ADD CONSTRAINT pk_age_sex_ethnicity_ds15 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds16 ADD CONSTRAINT pk_age_sex_ethnicity_ds16 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds17 ADD CONSTRAINT pk_age_sex_ethnicity_ds17 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds18 ADD CONSTRAINT pk_age_sex_ethnicity_ds18 PRIMARY KEY(age_sex_ethnicity_id);
ALTER TABLE fact.age_sex_ethnicity_ds19 ADD CONSTRAINT pk_age_sex_ethnicity_ds19 PRIMARY KEY(age_sex_ethnicity_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds2 ON fact.age_sex_ethnicity_ds2 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds2 ON fact.age_sex_ethnicity_ds2 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds2 ON fact.age_sex_ethnicity_ds2 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds2 ON fact.age_sex_ethnicity_ds2 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds3 ON fact.age_sex_ethnicity_ds3 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds3 ON fact.age_sex_ethnicity_ds3 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds3 ON fact.age_sex_ethnicity_ds3 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds3 ON fact.age_sex_ethnicity_ds3 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds4 ON fact.age_sex_ethnicity_ds4 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds4 ON fact.age_sex_ethnicity_ds4 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds4 ON fact.age_sex_ethnicity_ds4 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds4 ON fact.age_sex_ethnicity_ds4 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds5 ON fact.age_sex_ethnicity_ds5 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds5 ON fact.age_sex_ethnicity_ds5 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds5 ON fact.age_sex_ethnicity_ds5 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds5 ON fact.age_sex_ethnicity_ds5 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds6 ON fact.age_sex_ethnicity_ds6 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds6 ON fact.age_sex_ethnicity_ds6 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds6 ON fact.age_sex_ethnicity_ds6 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds6 ON fact.age_sex_ethnicity_ds6 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds10 ON fact.age_sex_ethnicity_ds10 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds10 ON fact.age_sex_ethnicity_ds10 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds10 ON fact.age_sex_ethnicity_ds10 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds10 ON fact.age_sex_ethnicity_ds10 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds12 ON fact.age_sex_ethnicity_ds12 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds12 ON fact.age_sex_ethnicity_ds12 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds12 ON fact.age_sex_ethnicity_ds12 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds12 ON fact.age_sex_ethnicity_ds12 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds13 ON fact.age_sex_ethnicity_ds13 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds13 ON fact.age_sex_ethnicity_ds13 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds13 ON fact.age_sex_ethnicity_ds13 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds13 ON fact.age_sex_ethnicity_ds13 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds14 ON fact.age_sex_ethnicity_ds14 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds14 ON fact.age_sex_ethnicity_ds14 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds14 ON fact.age_sex_ethnicity_ds14 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds14 ON fact.age_sex_ethnicity_ds14 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds15 ON fact.age_sex_ethnicity_ds15 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds15 ON fact.age_sex_ethnicity_ds15 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds15 ON fact.age_sex_ethnicity_ds15 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds15 ON fact.age_sex_ethnicity_ds15 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds16 ON fact.age_sex_ethnicity_ds16 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds16 ON fact.age_sex_ethnicity_ds16 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds16 ON fact.age_sex_ethnicity_ds16 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds16 ON fact.age_sex_ethnicity_ds16 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds17 ON fact.age_sex_ethnicity_ds17 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds17 ON fact.age_sex_ethnicity_ds17 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds17 ON fact.age_sex_ethnicity_ds17 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds17 ON fact.age_sex_ethnicity_ds17 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds18 ON fact.age_sex_ethnicity_ds18 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds18 ON fact.age_sex_ethnicity_ds18 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds18 ON fact.age_sex_ethnicity_ds18 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds18 ON fact.age_sex_ethnicity_ds18 USING btree (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds19 ON fact.age_sex_ethnicity_ds19 USING btree (age_group_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds19 ON fact.age_sex_ethnicity_ds19 USING btree (datasource_id);
CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds19 ON fact.age_sex_ethnicity_ds19 USING btree (datasource_id, mgra_id, age_group_id);
CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds19 ON fact.age_sex_ethnicity_ds19 USING btree (mgra_id);

TRUNCATE TABLE fact.summary_age_ds15;
TRUNCATE TABLE fact.summary_age_ds16;
TRUNCATE TABLE fact.summary_age_ds17;
TRUNCATE TABLE fact.summary_age_ds18;
TRUNCATE TABLE fact.summary_age_ds19;

INSERT INTO fact.summary_age_ds15 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(15); COMMIT;
INSERT INTO fact.summary_age_ds16 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(16); COMMIT;
INSERT INTO fact.summary_age_ds17 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(17); COMMIT;
INSERT INTO fact.summary_age_ds18 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(18); COMMIT;
INSERT INTO fact.summary_age_ds19 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(19); COMMIT;


TRUNCATE TABLE fact.summary_ethnicity_ds15;
TRUNCATE TABLE fact.summary_ethnicity_ds16;
TRUNCATE TABLE fact.summary_ethnicity_ds17;
TRUNCATE TABLE fact.summary_ethnicity_ds18;
TRUNCATE TABLE fact.summary_ethnicity_ds19;

INSERT INTO fact.summary_ethnicity_ds15 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(15); COMMIT;
INSERT INTO fact.summary_ethnicity_ds16 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(16); COMMIT;
INSERT INTO fact.summary_ethnicity_ds17 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(17); COMMIT;
INSERT INTO fact.summary_ethnicity_ds18 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(18); COMMIT;
INSERT INTO fact.summary_ethnicity_ds19 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(19); COMMIT;

TRUNCATE TABLE fact.summary_housing_ds15;
TRUNCATE TABLE fact.summary_housing_ds16;
TRUNCATE TABLE fact.summary_housing_ds17;
TRUNCATE TABLE fact.summary_housing_ds18;
TRUNCATE TABLE fact.summary_housing_ds19;

INSERT INTO fact.summary_housing_ds15 (datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate) SELECT datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM app.fn_summarize_housing(15); COMMIT;
INSERT INTO fact.summary_housing_ds16 (datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate) SELECT datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM app.fn_summarize_housing(16); COMMIT;
INSERT INTO fact.summary_housing_ds17 (datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate) SELECT datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM app.fn_summarize_housing(17); COMMIT;
INSERT INTO fact.summary_housing_ds18 (datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate) SELECT datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM app.fn_summarize_housing(18); COMMIT;
INSERT INTO fact.summary_housing_ds19 (datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate) SELECT datasource_id, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM app.fn_summarize_housing(19); COMMIT;


TRUNCATE TABLE fact.summary_income_ds15;
TRUNCATE TABLE fact.summary_income_ds16;
TRUNCATE TABLE fact.summary_income_ds17;
TRUNCATE TABLE fact.summary_income_ds18;
TRUNCATE TABLE fact.summary_income_ds19;

INSERT INTO fact.summary_income_ds15 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(15); COMMIT;
INSERT INTO fact.summary_income_ds16 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(16); COMMIT;
INSERT INTO fact.summary_income_ds17 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(17); COMMIT;
INSERT INTO fact.summary_income_ds18 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(18); COMMIT;
INSERT INTO fact.summary_income_ds19 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(19); COMMIT;


TRUNCATE TABLE fact.summary_income_median_ds15;
TRUNCATE TABLE fact.summary_income_median_ds16;
TRUNCATE TABLE fact.summary_income_median_ds17;
TRUNCATE TABLE fact.summary_income_median_ds18;
TRUNCATE TABLE fact.summary_income_median_ds19;

INSERT INTO fact.summary_income_median_ds15 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(15); COMMIT;
INSERT INTO fact.summary_income_median_ds16 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(16); COMMIT;
INSERT INTO fact.summary_income_median_ds17 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(17); COMMIT;
INSERT INTO fact.summary_income_median_ds18 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(18); COMMIT;
INSERT INTO fact.summary_income_median_ds19 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(19); COMMIT;

TRUNCATE TABLE fact.summary_population_ds15;
TRUNCATE TABLE fact.summary_population_ds16;
TRUNCATE TABLE fact.summary_population_ds17;
TRUNCATE TABLE fact.summary_population_ds18;
TRUNCATE TABLE fact.summary_population_ds19;

INSERT INTO fact.summary_population_ds15 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(15); COMMIT;
INSERT INTO fact.summary_population_ds16 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(16); COMMIT;
INSERT INTO fact.summary_population_ds17 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(17); COMMIT;
INSERT INTO fact.summary_population_ds18 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(18); COMMIT;
INSERT INTO fact.summary_population_ds19 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(19); COMMIT;