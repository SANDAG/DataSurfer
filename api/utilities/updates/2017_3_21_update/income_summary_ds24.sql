DECLARE @datasource_id smallint = 24;

SELECT
  i.datasource_id
  ,m.geotype
  ,m.geozone
  ,i.yr_id yr
  ,ig.income_group
  ,ig.name
  ,SUM(i.households) households
FROM
  fact.household_income i
  INNER JOIN dim.mgra m ON i.mgra_id = m.mgra_id
  INNER JOIN dim.income_group ig ON i.income_group_id = ig.income_group_id
WHERE
  i.datasource_id = @datasource_id
  AND m.geozone is not null
GROUP BY
  i.datasource_id
  ,m.geotype
  ,m.geozone
  ,i.yr_id
  ,ig.income_group
  ,ig.name
ORDER BY
  i.yr_id
  ,m.geotype
  ,m.geozone
  ,ig.income_group