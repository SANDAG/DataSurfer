/*
DROP TABLE IF EXISTS staging.age_sex_ethnicity;
DROP TABLE IF EXISTS staging.household_income;
DROP TABLE IF EXISTS staging.housing;
--DROP TABLE IF EXISTS staging.mgra;
DROP TABLE IF EXISTS staging.population;

CREATE TABLE staging.age_sex_ethnicity
(
  age_sex_ethnicity_id integer,
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
  household_income_id integer,
  datasource_id smallint NOT NULL,
  yr integer NOT NULL,
  mgra_id integer NOT NULL,
  income_group_id integer NOT NULL,
  households integer NOT NULL
);

CREATE TABLE staging.housing
(
  housing_id integer,
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
  population_id integer,
  datasource_id smallint NOT NULL,
  yr smallint NOT NULL,
  mgra_id integer NOT NULL,
  housing_type_id smallint NOT NULL,
  population integer NOT NULL
);


--CREATE TABLE staging.mgra
--(
--  mgra_id integer NOT NULL,
--  mgra integer NOT NULL,
--  series smallint NOT NULL,
--  geotype character varying(50) NOT NULL,
--  geotype_pretty character varying(100) NOT NULL,
--  geozone character varying(50) NOT NULL
--);

COPY staging.age_sex_ethnicity (datasource_id, mgra_id, yr, age_group_id, sex_id, ethnicity_id, population) FROM '/tmp/fact_age_sex_ethnicity_ds24.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.household_income (datasource_id, mgra_id, yr, income_group_id, households) FROM '/tmp/fact_houeshold_income_ds24.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.housing (datasource_id, mgra_id, yr, structure_type_id, units, occupied, vacancy) FROM '/tmp/fact_housing_ds24.csv' WITH CSV DELIMITER ',' HEADER;
--COPY staging.mgra (mgra_id, mgra, series, geotype, geotype_pretty, geozone) FROM '/tmp/dim_mgra_ds24.csv' WITH CSV DELIMITER ',' HEADER;
COPY staging.population (datasource_id, mgra_id, yr, housing_type_id, population) FROM '/tmp/fact_population_ds24.csv' WITH CSV DELIMITER ',' HEADER;

--LOAD DATASOURCE 24 (2016 ESTIMATES INTO FACT SCHEMA)
DROP TABLE IF EXISTS fact.age_sex_ethnicity_ds24;
DELETE FROM fact.age_sex_ethnicity WHERE datasource_id = 24;

CREATE TABLE fact.age_sex_ethnicity_ds24
(
  CONSTRAINT pk_age_sex_ethnicity_ds24 PRIMARY KEY (age_sex_ethnicity_id),
  CONSTRAINT fk_datasource_id_ds24 FOREIGN KEY (datasource_id)
      REFERENCES dim.datasource (datasource_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT chk_ase_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.age_sex_ethnicity)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.age_sex_ethnicity_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.age_sex_ethnicity_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.age_sex_ethnicity_ds24 TO ds_app_user;

INSERT INTO fact.age_sex_ethnicity_ds24 (datasource_id, mgra_id, yr, age_group_id, sex_id, ethnicity_id, population) SELECT datasource_id, mgra_id, yr, age_group_id, sex_id, ethnicity_id, population FROM staging.age_sex_ethnicity WHERE datasource_id = 24 AND yr >= 2011;

DELETE FROM fact.household_income WHERE datasource_id = 24;
INSERT INTO fact.household_income (datasource_id, mgra_id, yr, income_group_id, households) SELECT datasource_id, mgra_id, yr, income_group_id, households FROM staging.household_income WHERE datasource_id = 24 and yr >= 2011;

DELETE FROM fact.housing WHERE datasource_id = 24;
INSERT INTO fact.housing (datasource_id, mgra_id, yr, structure_type_id, units, occupied, vacancy) SELECT datasource_id, mgra_id, yr, structure_type_id, units, occupied, vacancy FROM staging.housing WHERE datasource_id = 24 and yr >= 2011;

DELETE FROM fact.population WHERE datasource_id = 24;
INSERT INTO fact.population (datasource_id, mgra_id, yr, housing_type_id, population) SELECT datasource_id, mgra_id, yr, housing_type_id, population FROM staging.population WHERE datasource_id = 24 and yr >= 2011;

INSERT INTO dim.forecast_year VALUES (242010, 24, 2010);
INSERT INTO dim.forecast_year VALUES (242011, 24, 2011);
INSERT INTO dim.forecast_year VALUES (242012, 24, 2012);
INSERT INTO dim.forecast_year VALUES (242013, 24, 2013);
INSERT INTO dim.forecast_year VALUES (242014, 24, 2014);
INSERT INTO dim.forecast_year VALUES (242015, 24, 2015);
INSERT INTO dim.forecast_year VALUES (242016, 24, 2016);

INSERT INTO fact.age_sex_ethnicity_ds24 (datasource_id, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population) SELECT 24, yr, mgra_id, age_group_id, sex_id, ethnicity_id, population FROM fact.age_sex_ethnicity WHERE datasource_id = 23 and yr = 2010;
INSERT INTO fact.housing (datasource_id, yr, mgra_id, structure_type_id, units, occupied, vacancy) SELECT 24, yr, mgra_id, structure_type_id, units, occupied, vacancy FROM fact.housing WHERE datasource_id = 23 and yr = 2010;
INSERT INTO fact.household_income (datasource_id, yr, mgra_id, income_group_id, households) SELECT 24, yr, mgra_id, income_group_id, households FROM fact.household_income WHERE datasource_id = 23 and yr = 2010;
INSERT INTO fact.population (datasource_id, yr, mgra_id, housing_type_id, population) SELECT 24, yr, mgra_id, housing_type_id, population FROM fact.population WHERE datasource_id = 23 and yr = 2010;

*/
/*
UPDATE fact.age_sex_ethnicity ase
  SET mgra_id = x.new_mgra_id
 FROM
   (SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction') x 
WHERE 
  ase.mgra_id = x.old_mgra;

UPDATE fact.household_income hi
  SET mgra_id = x.new_mgra_id
 FROM
   (SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction') x 
WHERE 
  hi.mgra_id = x.old_mgra;

UPDATE fact.housing h
  SET mgra_id = x.new_mgra_id
 FROM
   (SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction') x 
WHERE 
  h.mgra_id = x.old_mgra;

UPDATE fact.jobs j
  SET mgra_id = x.new_mgra_id
 FROM
   (SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction') x 
WHERE 
  j.mgra_id = x.old_mgra;

UPDATE  fact.population as p
  SET mgra_id = x.new_mgra_id
 FROM
   (SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction') as x 
WHERE 
  p.mgra_id / 100000 = 13 AND p.mgra_id = x.old_mgra;


SELECT o.mgra_id old_mgra, n.mgra_id new_mgra_id FROM dim.mgra o LEFT JOIN staging.mgra n ON o.mgra = n.MGRA and o.geotype = n.geotype and o.geozone = n.geozone WHERE o.series = 13 AND o.geotype = 'jurisdiction' ORDER BY o.mgra_id

SELECT * FROM staging.mgra WHERE mgra = 15307

 AND o.mgra_id = 1315306

SELECT *,mgra_id / 100000 FROM fact.population WHERE population_id = 484268


DELETE FROM dim.mgra WHERE series = 13;
INSERT INTO dim.mgra (mgra_id, mgra, series, geotype, geotype_pretty, geozone) SELECT mgra_id, mgra, series, geotype, geotype_pretty, geozone FROM staging.mgra;


DROP TABLE IF EXISTS fact.summary_age_ds24;
CREATE TABLE fact.summary_age_ds24
(
  CONSTRAINT chk_summary_age_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_age)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_age_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_age_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_age_ds24 TO ds_app_user;

INSERT INTO fact.summary_age_ds24 (datasource_id, geotype, geozone, yr, sex, age_group, population) SELECT datasource_id, geotype, geozone, yr, sex, age_group, population FROM app.fn_summarize_age(24) WHERE yr > 2010; COMMIT;


DROP TABLE IF EXISTS fact.summary_ethnicity_ds24;
CREATE TABLE fact.summary_ethnicity_ds24
(
  CONSTRAINT chk_summary_ethnicity_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_ethnicity)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_ethnicity_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_ethnicity_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_ethnicity_ds24 TO ds_app_user;

INSERT INTO fact.summary_ethnicity_ds24 (datasource_id, geotype, geozone, yr, ethnic, population) SELECT datasource_id, geotype, geozone, yr, ethnicity, population FROM app.fn_summarize_ethnicity(24) WHERE yr > 2010; COMMIT;

--HOUSING
DROP TABLE IF EXISTS fact.summary_housing_ds24;

CREATE TABLE fact.summary_housing_ds24
(
  CONSTRAINT chk_summary_housing_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_housing)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_housing_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_housing_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_housing_ds24 TO ds_app_user;

INSERT INTO fact.summary_housing_ds24 (datasource_id, yr, geotype, geozone, unit_type, units, occupied, unoccupied, vacancy_rate)
SELECT
  24 as datasource_id
  ,h.yr
  ,m.geotype
  ,m.geozone
  ,s.long_name as unit_type
  ,SUM(h.units) as units
  ,SUM(h.occupied) as occupied
  ,SUM(h.units - h.occupied) as unoccupied
  ,CASE
    WHEN SUM(h.units) = 0 THEN NULL 
    ELSE SUM(h.units - h.occupied) / CAST(SUM(h.units) as float) 
  END as vacancy_rate
FROM
  fact.housing h
  JOIN dim.mgra m ON h.mgra_id = m.mgra_id
  JOIN dim.structure_type s ON h.structure_type_id = s.structure_type_id
WHERE 
  h.datasource_id = 24 and yr > 2010
GROUP BY 
  h.yr, m.geotype, m.geozone, s.structure_type_id, s.long_name
UNION ALL
SELECT
  24 as datasource_id
  ,h.yr
  ,m.geotype
  ,m.geozone
  ,'Total Units' as unit_type
  ,SUM(h.units) as units
  ,SUM(h.occupied) as occupied
  ,SUM(h.units - h.occupied) as unoccupied
  ,CASE
    WHEN SUM(h.units) = 0 THEN NULL 
    ELSE SUM(h.units - h.occupied) / CAST(SUM(h.units) as float) 
  END as vacancy_rate
FROM
  fact.housing h
  JOIN dim.mgra m ON h.mgra_id = m.mgra_id
  JOIN dim.structure_type s ON h.structure_type_id = s.structure_type_id
WHERE 
  h.datasource_id = 24 and yr > 2010
GROUP BY 
  h.yr, m.geotype, m.geozone;

DROP TABLE IF EXISTS fact.summary_income_ds24;
CREATE TABLE fact.summary_income_ds24
(
  CONSTRAINT chk_summary_income_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_income)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_income_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_income_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_income_ds24 TO ds_app_user;

INSERT INTO fact.summary_income_ds24 (datasource_id, geotype, geozone, yr, ordinal, income_group, households) SELECT datasource_id, geotype, geozone, yr, ordinal, income_group, households FROM app.fn_summarize_income(24) WHERE yr > 2010; COMMIT;

DROP TABLE IF EXISTS fact.summary_income_median_ds24;
CREATE TABLE fact.summary_income_median_ds24
(
  CONSTRAINT chk_unique_datasource_geotype_geozone_yr_ds24 UNIQUE (datasource_id, geotype, geozone, yr),
  CONSTRAINT chk_summary_income_median_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_income_median)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_income_median_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_income_median_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_income_median_ds24 TO ds_app_user;

INSERT INTO fact.summary_income_median_ds24 (datasource_id, geotype, geozone, yr, median_inc) SELECT datasource_id, geotype, geozone, yr, median_inc FROM app.fn_summarize_median_income(24) WHERE yr > 2010; COMMIT;

DROP TABLE IF EXISTS fact.summary_population_ds24;
CREATE TABLE fact.summary_population_ds24
(
  CONSTRAINT chk_summary_population_ds24 CHECK (datasource_id = 24)
)
INHERITS (fact.summary_population)
WITH (
  OIDS=FALSE
);
ALTER TABLE fact.summary_population_ds24
  OWNER TO datasurfer_admin;
GRANT ALL ON TABLE fact.summary_population_ds24 TO datasurfer_admin;
GRANT SELECT ON TABLE fact.summary_population_ds24 TO ds_app_user;

INSERT INTO fact.summary_population_ds24 (datasource_id, geotype, geozone, yr, housing_type, population) SELECT datasource_id, geotype, geozone, yr, housing_type, population FROM app.fn_summarize_population(24) WHERE yr > 2010; COMMIT;
*/