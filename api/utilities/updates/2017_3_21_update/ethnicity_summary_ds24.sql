DECLARE @datasource_id smallint = 24;

SELECT
   ase.datasource_id
   ,m.geotype
   ,m.geozone
   ,ase.yr_id
   ,e.short_name as ethnic
   ,sum(ase.population) pop
FROM
  fact.age_sex_ethnicity ase
  INNER JOIN dim.mgra m ON ase.mgra_id = m.mgra_id
  INNER JOIN dim.ethnicity e ON ase.ethnicity_id = e.ethnicity_id
WHERE
  ase.datasource_id = @datasource_id
  AND m.geozone is not null
GROUP BY
   ase.datasource_id
   ,m.geotype
   ,m.geozone
   ,ase.yr_id
   ,e.short_name
UNION ALL
SELECT
   ase.datasource_id
   ,m.geotype
   ,m.geozone
   ,ase.yr_id
   ,'Total Population' as ethnic
   ,sum(ase.population) pop
FROM
  fact.ethnicity ase
  INNER JOIN dim.mgra m ON ase.mgra_id = m.mgra_id
WHERE
  ase.datasource_id = @datasource_id
  AND m.geozone is not null
GROUP BY
   ase.datasource_id
   ,m.geotype
   ,m.geozone
   ,ase.yr_id