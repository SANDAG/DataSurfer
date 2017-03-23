DECLARE @datasource_id smallint = 24;

SELECT
  p.datasource_id
  ,m.geotype
  ,m.geozone
  ,p.yr_id
  ,h.long_name
  ,SUM(p.[population]) pop
FROM 
  fact.population p
  INNER JOIN dim.mgra m ON p.mgra_id = m.mgra_id
  INNER JOIN dim.housing_type h ON p.housing_type_id = h.housing_type_id
WHERE
  p.datasource_id = @datasource_id
  AND m.geozone is not null
GROUP BY
  p.datasource_id
  ,m.geotype
  ,m.geozone
  ,p.yr_id
  ,h.long_name
ORDER BY
  p.yr_id
  ,m.geotype
  ,m.geozone
  ,h.long_name