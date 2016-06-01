UPDATE dim.mgra SET geozone = CAST(FLOOR(geozone::numeric) as varchar(50))
  WHERE
    geotype = 'tract'
    AND (ROUND(geozone::numeric,2) - FLOOR(geozone::numeric)) = 0


TRUNCATE TABLE fact.summary_age_ds2;
TRUNCATE TABLE fact.summary_age_ds3;
TRUNCATE TABLE fact.summary_age_ds4;
TRUNCATE TABLE fact.summary_age_ds5;
TRUNCATE TABLE fact.summary_age_ds6;
TRUNCATE TABLE fact.summary_age_ds10;
TRUNCATE TABLE fact.summary_age_ds12;
TRUNCATE TABLE fact.summary_age_ds13;
TRUNCATE TABLE fact.summary_age_ds14;

INSERT INTO fact.summary_age_ds2 SELECT * FROM app.fn_summarize_age(2); COMMIT; 
INSERT INTO fact.summary_age_ds3 SELECT * FROM app.fn_summarize_age(3); COMMIT;
INSERT INTO fact.summary_age_ds4 SELECT * FROM app.fn_summarize_age(4); COMMIT;
INSERT INTO fact.summary_age_ds5 SELECT * FROM app.fn_summarize_age(5); COMMIT;
INSERT INTO fact.summary_age_ds6 SELECT * FROM app.fn_summarize_age(6); COMMIT;
INSERT INTO fact.summary_age_ds10 SELECT * FROM app.fn_summarize_age(10); COMMIT;
INSERT INTO fact.summary_age_ds12 SELECT * FROM app.fn_summarize_age(12); COMMIT;
INSERT INTO fact.summary_age_ds13 SELECT * FROM app.fn_summarize_age(13); COMMIT;
INSERT INTO fact.summary_age_ds14 SELECT * FROM app.fn_summarize_age(14); COMMIT;

TRUNCATE TABLE fact.summary_ethnicty_ds2;
TRUNCATE TABLE fact.summary_ethnicty_ds3;
TRUNCATE TABLE fact.summary_ethnicty_ds4;
TRUNCATE TABLE fact.summary_ethnicty_ds5;
TRUNCATE TABLE fact.summary_ethnicty_ds6;
TRUNCATE TABLE fact.summary_ethnicty_ds10;
TRUNCATE TABLE fact.summary_ethnicty_ds12;
TRUNCATE TABLE fact.summary_ethnicty_ds13;
TRUNCATE TABLE fact.summary_ethnicty_ds14;

INSERT INTO fact.summary_ethnicity_ds2 SELECT * FROM app.fn_summarize_ethnicity(2); COMMIT;
INSERT INTO fact.summary_ethnicity_ds3 SELECT * FROM app.fn_summarize_ethnicity(3); COMMIT;
INSERT INTO fact.summary_ethnicity_ds4 SELECT * FROM app.fn_summarize_ethnicity(4); COMMIT;
INSERT INTO fact.summary_ethnicity_ds5 SELECT * FROM app.fn_summarize_ethnicity(5); COMMIT;
INSERT INTO fact.summary_ethnicity_ds6 SELECT * FROM app.fn_summarize_ethnicity(6); COMMIT;
INSERT INTO fact.summary_ethnicity_ds10 SELECT * FROM app.fn_summarize_ethnicity(10); COMMIT;
INSERT INTO fact.summary_ethnicity_ds12 SELECT * FROM app.fn_summarize_ethnicity(12); COMMIT;
INSERT INTO fact.summary_ethnicity_ds13 SELECT * FROM app.fn_summarize_ethnicity(13); COMMIT;
INSERT INTO fact.summary_ethnicity_ds14 SELECT * FROM app.fn_summarize_ethnicity(14); COMMIT;

TRUNCATE TABLE fact.summary_ethnicity_change_ds2;
TRUNCATE TABLE fact.summary_ethnicity_change_ds3;
TRUNCATE TABLE fact.summary_ethnicity_change_ds4;
TRUNCATE TABLE fact.summary_ethnicity_change_ds5;
TRUNCATE TABLE fact.summary_ethnicity_change_ds6;
TRUNCATE TABLE fact.summary_ethnicity_change_ds10;
TRUNCATE TABLE fact.summary_ethnicity_change_ds12;
TRUNCATE TABLE fact.summary_ethnicity_change_ds13;
TRUNCATE TABLE fact.summary_ethnicity_change_ds14;

INSERT INTO fact.summary_ethnicity_change_ds6 SELECT * FROM app.fn_summarize_ethnicity_change(6); COMMIT;
INSERT INTO fact.summary_ethnicity_change_ds13 SELECT * FROM app.fn_summarize_ethnicity_change(13); COMMIT;

TRUNCATE TABLE fact.summary_housing_ds2;
TRUNCATE TABLE fact.summary_housing_ds3;
TRUNCATE TABLE fact.summary_housing_ds4;
TRUNCATE TABLE fact.summary_housing_ds5;
TRUNCATE TABLE fact.summary_housing_ds6;
TRUNCATE TABLE fact.summary_housing_ds10;
TRUNCATE TABLE fact.summary_housing_ds12;
TRUNCATE TABLE fact.summary_housing_ds13;
TRUNCATE TABLE fact.summary_housing_ds14;

INSERT INTO fact.summary_housing_ds2 SELECT * FROM app.fn_summarize_housing(2); COMMIT;
INSERT INTO fact.summary_housing_ds3 SELECT * FROM app.fn_summarize_housing(3); COMMIT;
INSERT INTO fact.summary_housing_ds4 SELECT * FROM app.fn_summarize_housing(4); COMMIT;
INSERT INTO fact.summary_housing_ds5 SELECT * FROM app.fn_summarize_housing(5); COMMIT;
INSERT INTO fact.summary_housing_ds6 SELECT * FROM app.fn_summarize_housing(6); COMMIT;
INSERT INTO fact.summary_housing_ds10 SELECT * FROM app.fn_summarize_housing(10); COMMIT;
INSERT INTO fact.summary_housing_ds12 SELECT * FROM app.fn_summarize_housing(12); COMMIT;
INSERT INTO fact.summary_housing_ds13 SELECT * FROM app.fn_summarize_housing(13); COMMIT;
INSERT INTO fact.summary_housing_ds14 SELECT * FROM app.fn_summarize_housing(14); COMMIT;

TRUNCATE TABLE fact.summary_income_ds2;
TRUNCATE TABLE fact.summary_income_ds3;
TRUNCATE TABLE fact.summary_income_ds4;
TRUNCATE TABLE fact.summary_income_ds5;
TRUNCATE TABLE fact.summary_income_ds6;
TRUNCATE TABLE fact.summary_income_ds10;
TRUNCATE TABLE fact.summary_income_ds12;
TRUNCATE TABLE fact.summary_income_ds13;
TRUNCATE TABLE fact.summary_income_ds14;

INSERT INTO fact.summary_income_ds2 SELECT * FROM app.fn_summarize_income(2); COMMIT;
INSERT INTO fact.summary_income_ds3 SELECT * FROM app.fn_summarize_income(3); COMMIT;
INSERT INTO fact.summary_income_ds4 SELECT * FROM app.fn_summarize_income(4); COMMIT;
INSERT INTO fact.summary_income_ds5 SELECT * FROM app.fn_summarize_income(5); COMMIT;
INSERT INTO fact.summary_income_ds6 SELECT * FROM app.fn_summarize_income(6); COMMIT;
INSERT INTO fact.summary_income_ds10 SELECT * FROM app.fn_summarize_income(10); COMMIT;
INSERT INTO fact.summary_income_ds12 SELECT * FROM app.fn_summarize_income(12); COMMIT;
INSERT INTO fact.summary_income_ds13 SELECT * FROM app.fn_summarize_income(13); COMMIT;
INSERT INTO fact.summary_income_ds14 SELECT * FROM app.fn_summarize_income(14); COMMIT;

TRUNCATE TABLE fact.summary_income_median_ds2;
TRUNCATE TABLE fact.summary_income_median_ds3;
TRUNCATE TABLE fact.summary_income_median_ds4;
TRUNCATE TABLE fact.summary_income_median_ds5;
TRUNCATE TABLE fact.summary_income_median_ds6;
TRUNCATE TABLE fact.summary_income_median_ds10;
TRUNCATE TABLE fact.summary_income_median_ds12;
TRUNCATE TABLE fact.summary_income_median_ds13;
TRUNCATE TABLE fact.summary_income_median_ds14;

INSERT INTO fact.summary_income_median_ds2 SELECT * FROM app.fn_summarize_median_income(2); COMMIT;
INSERT INTO fact.summary_income_median_ds3 SELECT * FROM app.fn_summarize_median_income(3); COMMIT;
INSERT INTO fact.summary_income_median_ds4 SELECT * FROM app.fn_summarize_median_income(4); COMMIT;
INSERT INTO fact.summary_income_median_ds5 SELECT * FROM app.fn_summarize_median_income(5); COMMIT;
INSERT INTO fact.summary_income_median_ds6 SELECT * FROM app.fn_summarize_median_income(6); COMMIT;
INSERT INTO fact.summary_income_median_ds10 SELECT * FROM app.fn_summarize_median_income(10); COMMIT;
INSERT INTO fact.summary_income_median_ds12 SELECT * FROM app.fn_summarize_median_income(12); COMMIT;
INSERT INTO fact.summary_income_median_ds13 SELECT * FROM app.fn_summarize_median_income(13); COMMIT;
INSERT INTO fact.summary_income_median_ds14 SELECT * FROM app.fn_summarize_median_income(14); COMMIT;

TRUNCATE TABLE fact.summary_jobs_ds6;
TRUNCATE TABLE fact.summary_jobs_ds13;

INSERT INTO fact.summary_jobs_ds6 SELECT * FROM app.fn_summarize_jobs(6); COMMIT;
INSERT INTO fact.summary_jobs_ds13 SELECT * FROM app.fn_summarize_jobs(13); COMMIT;

TRUNCATE TABLE fact.summary_population_ds2;
TRUNCATE TABLE fact.summary_population_ds3;
TRUNCATE TABLE fact.summary_population_ds4;
TRUNCATE TABLE fact.summary_population_ds5;
TRUNCATE TABLE fact.summary_population_ds6;
TRUNCATE TABLE fact.summary_population_ds10;
TRUNCATE TABLE fact.summary_population_ds12;
TRUNCATE TABLE fact.summary_population_ds13;
TRUNCATE TABLE fact.summary_population_ds14;

INSERT INTO fact.summary_population_ds2 SELECT * FROM app.fn_summarize_population(2); COMMIT;
INSERT INTO fact.summary_population_ds3 SELECT * FROM app.fn_summarize_population(3); COMMIT;
INSERT INTO fact.summary_population_ds4 SELECT * FROM app.fn_summarize_population(4); COMMIT;
INSERT INTO fact.summary_population_ds5 SELECT * FROM app.fn_summarize_population(5); COMMIT;
INSERT INTO fact.summary_population_ds6 SELECT * FROM app.fn_summarize_population(6); COMMIT;
INSERT INTO fact.summary_population_ds10 SELECT * FROM app.fn_summarize_population(10); COMMIT;
INSERT INTO fact.summary_population_ds12 SELECT * FROM app.fn_summarize_population(12); COMMIT;
INSERT INTO fact.summary_population_ds13 SELECT * FROM app.fn_summarize_population(13); COMMIT;
INSERT INTO fact.summary_population_ds14 SELECT * FROM app.fn_summarize_population(14); COMMIT;