DECLARE @datasource_id smallint = 24;

SELECT
  h.datasource_id
  ,m.geotype
  ,m.geozone
  ,h.yr_id yr
  ,s.long_name unit_type
  ,SUM(h.units) units
  ,SUM(h.occupied) occupied
  ,SUM(h.units)  - SUM(h.occupied) unoccupied
  ,CASE
      WHEN SUM(h.units) > 0 THEN 1 - ((1.0 * SUM(h.occupied)) / SUM(h.units))
	  ELSE 0
  END vacancy
FROM
  fact.housing h
  INNER JOIN dim.mgra m ON h.mgra_id = m.mgra_id
  INNER JOIN dim.structure_type s on h.structure_type_id = s.structure_type_id
WHERE
  h.datasource_id = @datasouce_id
  AND m.geozone is not null
GROUP BY
  h.datasource_id
  ,m.geotype
  ,m.geozone
  ,h.yr_id 
  ,s.long_name
UNION ALL
SELECT
  h.datasource_id
  ,m.geotype
  ,m.geozone
  ,h.yr_id yr
  ,'Total Units' unit_type
  ,SUM(h.units) units
  ,SUM(h.occupied) occupied
  ,SUM(h.units)  - SUM(h.occupied) unoccupied
  ,CASE
      WHEN SUM(h.units) > 0 THEN 1 - ((1.0 * SUM(h.occupied)) / SUM(h.units))
	  ELSE 0
  END vacancy
FROM
  fact.housing h
  INNER JOIN dim.mgra m ON h.mgra_id = m.mgra_id
WHERE
  h.datasource_id = @datasource_id
  AND m.geozone is not null
GROUP BY
  h.datasource_id
  ,m.geotype
  ,m.geozone
  ,h.yr_id 