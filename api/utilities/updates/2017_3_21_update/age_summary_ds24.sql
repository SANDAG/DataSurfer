DECLARE @datasource_id smallint = 24;

--SUMMARY AGE
SELECT
  ase.datasource_id
  ,m.geotype
  ,m.geozone
  ,ase.yr_id as yr
  ,s.sex
  ,a.group_10yr as age_group
  ,SUM(ase.population) as pop
FROM
  fact.age_sex_ethnicity ase
  INNER JOIN dim.sex s ON ase.sex_id = s.sex_id
  INNER JOIN dim.age_group a on ase.age_group_id = a.age_group_id
  INNER JOIN dim.mgra m ON ase.mgra_id = m.mgra_id
WHERE
  datasource_id = @datasource_id
  AND geozone is not null
GROUP BY
  ase.datasource_id
  ,ase.yr_id
  ,m.geotype
  ,m.geozone
  ,s.sex
  ,a.group_10yr
  ,a.group_10yr_lower_bound
UNION ALL
SELECT
  ase.datasource_id
  ,m.geotype
  ,m.geozone
  ,ase.yr_id as yr
  ,s.sex
  ,'Total Population' as age_group
  ,SUM(ase.population) as pop
FROM
  fact.age_sex_ethnicity ase
  INNER JOIN dim.sex s ON ase.sex_id = s.sex_id
  INNER JOIN dim.age_group a on ase.age_group_id = a.age_group_id
  INNER JOIN dim.mgra m ON ase.mgra_id = m.mgra_id
WHERE
  datasource_id = @datasource_id
  AND geozone is not null
GROUP BY
  ase.datasource_id
  ,ase.yr_id
  ,m.geotype
  ,m.geozone
  ,s.sex

UNION ALL
SELECT
  ase.datasource_id
  ,m.geotype
  ,m.geozone
  ,ase.yr_id as yr
  ,'Total' as sex
  ,'Total Population' as age_group
  ,SUM(ase.population) as pop
FROM
  fact.age_sex_ethnicity ase
  INNER JOIN dim.sex s ON ase.sex_id = s.sex_id
  INNER JOIN dim.age_group a on ase.age_group_id = a.age_group_id
  INNER JOIN dim.mgra m ON ase.mgra_id = m.mgra_id
WHERE
  datasource_id = @datasource_id
  AND geozone is not null
GROUP BY
  ase.datasource_id
  ,ase.yr_id
  ,m.geotype
  ,m.geozone