UPDATE fact.summary_housing SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 23 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_ethnicity SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 23 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_income SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 23 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_income_median SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 23 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_population SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 23 and geotype = 'tract' and geozone like '%.00' and yr = 2010;

UPDATE fact.summary_housing SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 12 and geotype = 'tract' and geozone like '%.00' and yr = 2000;
UPDATE fact.summary_ethnicity SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 12 and geotype = 'tract' and geozone like '%.00' and yr = 2000;
UPDATE fact.summary_income SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 12 and geotype = 'tract' and geozone like '%.00' and yr = 2000;
UPDATE fact.summary_income_median SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 12 and geotype = 'tract' and geozone like '%.00' and yr = 2000;
UPDATE fact.summary_population SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 12 and geotype = 'tract' and geozone like '%.00' and yr = 2000;

UPDATE fact.summary_housing SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 5 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_ethnicity SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 5 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_income SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 5 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_income_median SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 5 and geotype = 'tract' and geozone like '%.00' and yr = 2010;
UPDATE fact.summary_population SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 5 and geotype = 'tract' and geozone like '%.00' and yr = 2010;

UPDATE fact.summary_housing SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 6 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_ethnicity SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 6 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_income SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 6 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_income_median SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 6 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_population SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 6 and geotype = 'tract' and geozone like '%.00';

UPDATE fact.summary_housing SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 13 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_ethnicity SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 13 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_income SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 13 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_income_median SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 13 and geotype = 'tract' and geozone like '%.00';
UPDATE fact.summary_population SET geozone = left(geozone, position('.' in geozone) - 1) WHERE datasource_id = 13 and geotype = 'tract' and geozone like '%.00';


INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2011, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '38', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2011, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2011, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2011, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2012, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '38', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2012, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2012, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2013, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '38', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2013, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2013, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2013, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2014, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '38', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2014, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2014, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2014, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92096', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92136', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92161', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92182', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'zip', '92259', 2015, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '38', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'tract', '99.02', 2015, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', '32nd Street Naval Station', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'East Elliott', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Flower Hill', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Harbor', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Los Penasquitos Canyon Preserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (23, 'cpa', 'Scripps Reserve', 2015, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'zip', '92134', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'zip', '92136', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'zip', '92259', 2000, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'cpa', '32nd Street Naval Station', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'cpa', 'East Elliott', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'cpa', 'Flower Hill', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'cpa', 'Los Penasquitos Canyon Preserve', 2000, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (12, 'cpa', 'Scripps Reserve', 2000, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'zip', '92096', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'zip', '92136', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'zip', '92161', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'zip', '92182', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'zip', '92259', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'tract', '38', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'tract', '99.02', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', '32nd Street Naval Station', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', 'East Elliott', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', 'Flower Hill', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', 'Harbor', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', 'Los Penasquitos Canyon Preserve', 2010, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (5, 'cpa', 'Scripps Reserve', 2010, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92096', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92134', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92136', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92140', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92161', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92182', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'zip', '92259', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '38', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'tract', '99.02', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', '32nd Street Naval Station', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Flower Hill', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Harbor', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Lindbergh Field', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Los Penasquitos Canyon Preserve', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'NCFUA Reserve', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2008, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (6, 'cpa', 'Scripps Reserve', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92096', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92136', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92161', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92182', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'zip', '92259', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '38', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'tract', '99.02', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', '32nd Street Naval Station', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'East Elliott', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Flower Hill', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Harbor', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Los Penasquitos Canyon Preserve', 2050, null);

INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2012, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2015, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2020, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2025, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2030, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2035, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2040, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2045, null);
INSERT INTO fact.summary_income_median (datasource_id, geotype, geozone, yr, median_inc) VALUES (13, 'cpa', 'Scripps Reserve', 2050, null);
