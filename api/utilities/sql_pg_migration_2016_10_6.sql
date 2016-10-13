--Add the new datasources
INSERT INTO dim.datasource (datasource_id, datasource_type_id, name, yr, description, is_active, series, vintage)
VALUES (22, 2, '2014 Estimates', 0, 'Series 13 2014 Estimates', false, 13, 2014);

INSERT INTO dim.datasource (datasource_id, datasource_type_id, name, yr, description, is_active, series, vintage)
VALUES (23, 2, '2015 Estimates', 0, 'Series 13 2015 Estimates', false, 13, 2015);

INSERT INTO dim.datasource (datasource_id, datasource_type_id, name, yr, description, is_active, series, vintage)
VALUES (24, 2, '2016 Estimates', 0, 'Series 13 2016 Estimates', false, 13, 2016);

-- 3,4,10,14 -> 22
CREATE TABLE fact.age_sex_ethnicity_ds22
(
  CONSTRAINT pk_age_sex_ethnicity_ds22 PRIMARY KEY (age_sex_ethnicity_id),
  CONSTRAINT chk_ase_ds22 CHECK (datasource_id = 22)
) INHERITS (fact.age_sex_ethnicity);

ALTER TABLE fact.age_sex_ethnicity_ds22 OWNER TO datasurfer_admin;

INSERT INTO fact.age_sex_ethnicity_ds22 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 22, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds3;
INSERT INTO fact.age_sex_ethnicity_ds22 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 22, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds4;
INSERT INTO fact.age_sex_ethnicity_ds22 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 22, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds10;
INSERT INTO fact.age_sex_ethnicity_ds22 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 22, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds14;

CREATE INDEX ix_age_ds22_mgra
  ON fact.age_sex_ethnicity_ds22
  USING btree
  (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds22
  ON fact.age_sex_ethnicity_ds22
  USING btree
  (age_group_id);

CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds22
  ON fact.age_sex_ethnicity_ds22
  USING btree
  (datasource_id);

CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds22
  ON fact.age_sex_ethnicity_ds22
  USING btree
  (datasource_id, mgra_id, age_group_id);

CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds22
  ON fact.age_sex_ethnicity_ds22
  USING btree
  (mgra_id);


-- 15,16,17,18,19 -> 23
CREATE TABLE fact.age_sex_ethnicity_ds23
(
  CONSTRAINT pk_age_sex_ethnicity_ds23 PRIMARY KEY (age_sex_ethnicity_id),
  CONSTRAINT chk_ase_ds23 CHECK (datasource_id = 23)
) INHERITS (fact.age_sex_ethnicity);

ALTER TABLE fact.age_sex_ethnicity_ds23 OWNER TO datasurfer_admin;

INSERT INTO fact.age_sex_ethnicity_ds23 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 23, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds15;
INSERT INTO fact.age_sex_ethnicity_ds23 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 23, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds16;
INSERT INTO fact.age_sex_ethnicity_ds23 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 23, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds17;
INSERT INTO fact.age_sex_ethnicity_ds23 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 23, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds18;
INSERT INTO fact.age_sex_ethnicity_ds23 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 23, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity_ds19;

CREATE INDEX ix_age_ds23_mgra
  ON fact.age_sex_ethnicity_ds23
  USING btree
  (mgra_id);

CREATE INDEX ix_age_sex_ethnicity_age_group_id_ds23
  ON fact.age_sex_ethnicity_ds23
  USING btree
  (age_group_id);

CREATE INDEX ix_age_sex_ethnicity_datasource_id_ds23
  ON fact.age_sex_ethnicity_ds23
  USING btree
  (datasource_id);

CREATE INDEX ix_age_sex_ethnicity_datasource_mgra_age_group_ds23
  ON fact.age_sex_ethnicity_ds23
  USING btree
  (datasource_id, mgra_id, age_group_id);

CREATE INDEX ix_age_sex_ethnicity_mgra_id_ds23
  ON fact.age_sex_ethnicity_ds23
  USING btree
  (mgra_id);


UPDATE fact.household_income SET datasource_id = 22 WHERE datasource_id IN (3,4,10,14);
UPDATE fact.household_income SET datasource_id = 23 WHERE datasource_id IN (15,16,17,18,19);

UPDATE fact.housing SET datasource_id = 22 WHERE datasource_id IN (3,4,10,14);
UPDATE fact.housing SET datasource_id = 23 WHERE datasource_id IN (15,16,17,18,19);

UPDATE fact.population SET datasource_id = 22 WHERE datasource_id IN (3,4,10,14);
UPDATE fact.population SET datasource_id = 23 WHERE datasource_id IN (15,16,17,18,19);

DROP TABLE fact.age_sex_ethnicity_ds3;
DROP TABLE fact.age_sex_ethnicity_ds4;
DROP TABLE fact.age_sex_ethnicity_ds10;
DROP TABLE fact.age_sex_ethnicity_ds14;
DROP TABLE fact.age_sex_ethnicity_ds15;
DROP TABLE fact.age_sex_ethnicity_ds16;
DROP TABLE fact.age_sex_ethnicity_ds17;
DROP TABLE fact.age_sex_ethnicity_ds18;
DROP TABLE fact.age_sex_ethnicity_ds19;

ALTER TABLE fact.age_sex_ethnicity ADD CONSTRAINT fk_datasource_id FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds12 ADD CONSTRAINT fk_datasource_id_ds12 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds13 ADD CONSTRAINT fk_datasource_id_ds13 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds2 ADD CONSTRAINT fk_datasource_id_ds2 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds22 ADD CONSTRAINT fk_datasource_id_ds22 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds23 ADD CONSTRAINT fk_datasource_id_ds23 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds5 ADD CONSTRAINT fk_datasource_id_ds5 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.age_sex_ethnicity_ds6 ADD CONSTRAINT fk_datasource_id_ds6 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE fact.household_income ADD CONSTRAINT fk_household_income_datasource_id FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.housing ADD CONSTRAINT fk_housing_datasource_id FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.jobs ADD CONSTRAINT fk_jobs_datasource_id FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.jobs_ds13 ADD CONSTRAINT fk_jobs_datasource_id_ds13 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.jobs_ds6 ADD CONSTRAINT fk_jobs_datasource_id_ds6 FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE fact.population ADD CONSTRAINT fk_population_datasource_id FOREIGN KEY (datasource_id) REFERENCES dim.datasource (datasource_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

DELETE FROM dim.datasource WHERE datasource_id IN (3,4,10,14,15,16,17,18,19);

ALTER TABLE dim.datasource DROP COLUMN yr;
ALTER TABLE dim.datasource DROP COLUMN displayed_name;

CREATE TABLE fact.summary_age_ds22(CONSTRAINT chk_summary_age_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_age);
CREATE TABLE fact.summary_age_ds23(CONSTRAINT chk_summary_age_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_age);
CREATE TABLE fact.summary_age_ds24(CONSTRAINT chk_summary_age_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_age);

ALTER TABLE fact.summary_age_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_age_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_age_ds24 OWNER TO datasurfer_admin;

CREATE INDEX ix_summary_age_ds22_geotype_geoname ON fact.summary_age_ds22 USING btree (geotype COLLATE pg_catalog."default", lower(geozone::text) COLLATE pg_catalog."default");
CREATE INDEX ix_summary_age_ds23_geotype_geoname ON fact.summary_age_ds23 USING btree (geotype COLLATE pg_catalog."default", lower(geozone::text) COLLATE pg_catalog."default");
CREATE INDEX ix_summary_age_ds24_geotype_geoname ON fact.summary_age_ds24 USING btree (geotype COLLATE pg_catalog."default", lower(geozone::text) COLLATE pg_catalog."default");

CREATE TABLE fact.summary_ethnicity_ds22(CONSTRAINT chk_summary_ethnicity_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_ethnicity);
CREATE TABLE fact.summary_ethnicity_ds23(CONSTRAINT chk_summary_ethnicity_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_ethnicity);
CREATE TABLE fact.summary_ethnicity_ds24(CONSTRAINT chk_summary_ethnicity_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_ethnicity);

ALTER TABLE fact.summary_ethnicity_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_ethnicity_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_ethnicity_ds24 OWNER TO datasurfer_admin;

CREATE TABLE fact.summary_housing_ds22(CONSTRAINT chk_summary_housing_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_housing);
CREATE TABLE fact.summary_housing_ds23(CONSTRAINT chk_summary_housing_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_housing);
CREATE TABLE fact.summary_housing_ds24(CONSTRAINT chk_summary_housing_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_housing);

ALTER TABLE fact.summary_housing_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_housing_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_housing_ds24 OWNER TO datasurfer_admin;

CREATE TABLE fact.summary_income_ds22(CONSTRAINT chk_summary_income_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_income);
CREATE TABLE fact.summary_income_ds23(CONSTRAINT chk_summary_income_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_income);
CREATE TABLE fact.summary_income_ds24(CONSTRAINT chk_summary_income_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_income);

ALTER TABLE fact.summary_income_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_income_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_income_ds24 OWNER TO datasurfer_admin;


CREATE TABLE fact.summary_income_median_ds22(CONSTRAINT chk_summary_income_median_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_income_median);
CREATE TABLE fact.summary_income_median_ds23(CONSTRAINT chk_summary_income_median_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_income_median);
CREATE TABLE fact.summary_income_median_ds24(CONSTRAINT chk_summary_income_median_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_income_median);

ALTER TABLE fact.summary_income_median_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_income_median_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_income_median_ds24 OWNER TO datasurfer_admin;


CREATE TABLE fact.summary_population_ds22(CONSTRAINT chk_summary_population_ds22 CHECK (datasource_id = 22)) INHERITS (fact.summary_population);
CREATE TABLE fact.summary_population_ds23(CONSTRAINT chk_summary_population_ds23 CHECK (datasource_id = 23)) INHERITS (fact.summary_population);
CREATE TABLE fact.summary_population_ds24(CONSTRAINT chk_summary_population_ds24 CHECK (datasource_id = 24)) INHERITS (fact.summary_population);

ALTER TABLE fact.summary_population_ds22 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_population_ds23 OWNER TO datasurfer_admin;
ALTER TABLE fact.summary_population_ds24 OWNER TO datasurfer_admin;

INSERT INTO fact.summary_age_ds22 SELECT * FROM app.fn_summarize_age(22); COMMIT;
INSERT INTO fact.summary_age_ds23 SELECT * FROM app.fn_summarize_age(23); COMMIT;
INSERT INTO fact.summary_age_ds22 SELECT 22, geotype, geozone, yr, sex, age_group, population FROM fact.summary_age_ds2;
INSERT INTO fact.summary_age_ds23 SELECT 23, geotype, geozone, yr, sex, age_group, population FROM fact.summary_age_ds2;

INSERT INTO fact.summary_ethnicity_ds22 SELECT * FROM app.fn_summarize_ethnicity(22); COMMIT;
INSERT INTO fact.summary_ethnicity_ds23 SELECT * FROM app.fn_summarize_ethnicity(23); COMMIT;
INSERT INTO fact.summary_ethnicity_ds22 SELECT 22, geotype, geozone, yr, ethnic, population FROM fact.summary_ethnicity_ds2;
INSERT INTO fact.summary_ethnicity_ds23 SELECT 23, geotype, geozone, yr, ethnic, population FROM fact.summary_ethnicity_ds2;


INSERT INTO fact.summary_housing_ds22 SELECT * FROM app.fn_summarize_housing(22); COMMIT;
INSERT INTO fact.summary_housing_ds23 SELECT * FROM app.fn_summarize_housing(23); COMMIT;
INSERT INTO fact.summary_housing_ds22 SELECT 22, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM fact.summary_housing_ds2;
INSERT INTO fact.summary_housing_ds23 SELECT 23, geotype, geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM fact.summary_housing_ds2;

INSERT INTO fact.summary_income_ds22 SELECT * FROM app.fn_summarize_income(22); COMMIT;
INSERT INTO fact.summary_income_ds23 SELECT * FROM app.fn_summarize_income(23); COMMIT;
INSERT INTO fact.summary_income_ds22 SELECT 22, geotype, geozone, yr, ordinal, income_group, households FROM fact.summary_income_ds2;
INSERT INTO fact.summary_income_ds23 SELECT 23, geotype, geozone, yr, ordinal, income_group, households FROM fact.summary_income_ds2;

INSERT INTO fact.summary_income_median_ds22 SELECT * FROM app.fn_summarize_median_income(22); COMMIT;
INSERT INTO fact.summary_income_median_ds23 SELECT * FROM app.fn_summarize_median_income(23); COMMIT;
INSERT INTO fact.summary_income_median_ds22 SELECT 22, geotype, geozone, yr, median_inc FROM fact.summary_income_median_ds2;
INSERT INTO fact.summary_income_median_ds23 SELECT 23, geotype, geozone, yr, median_inc FROM fact.summary_income_median_ds2;

INSERT INTO fact.summary_population_ds22 SELECT * FROM app.fn_summarize_population(22); COMMIT;
INSERT INTO fact.summary_population_ds23 SELECT * FROM app.fn_summarize_population(23); COMMIT;
INSERT INTO fact.summary_population_ds22 SELECT 22, geotype, geozone, yr, housing_type, population FROM fact.summary_population_ds2;
INSERT INTO fact.summary_population_ds23 SELECT 23, geotype, geozone, yr, housing_type, population FROM fact.summary_population_ds2;

CREATE INDEX ix_summary_age_ds22_geotype_geoname ON fact.summary_age_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_age_ds23_geotype_geoname ON fact.summary_age_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_ethnicity_ds22_geotype_geozone ON fact.summary_ethnicity_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_ethnicity_ds23_geotype_geozone ON fact.summary_ethnicity_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_sex_ds22_geotype_geozone ON fact.summary_sex_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_sex_ds23_geotype_geozone ON fact.summary_sex_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_housing_ds22_geotype_geozone ON fact.summary_housing_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_housing_ds23_geotype_geozone ON fact.summary_housing_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_income_ds22_geotype_geozone ON fact.summary_income_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_income_ds23_geotype_geozone ON fact.summary_income_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_income_median_ds22 ON fact.summary_income_median_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_income_median_ds23 ON fact.summary_income_median_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;

CREATE INDEX ix_summary_population_ds22 ON fact.summary_population_ds22 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;
CREATE INDEX ix_summary_population_ds23 ON fact.summary_population_ds23 (geotype, lower(geozone)) TABLESPACE datasurfer_tablespace;