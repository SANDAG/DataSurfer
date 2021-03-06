DELETE FROM demographic_warehouse.dim.mgra WHERE series = 13

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Community College District' as geotype_pretty,
	app.fn_capitalize_first(LOWER(LEFT(p_zone.name, CHARINDEX(' COMMUNITY COLLEGE',p_zone.name) - 1))) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 132

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Elementary School District' as geotype_pretty,
	app.fn_capitalize_first(LOWER(SUBSTRING(LEFT(p_zone.name, IIF(CHARINDEX('UNION',p_zone.name) > 0, CHARINDEX('UNION',p_zone.name) - 2, len(p_zone.name))), 10, 100))) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 135

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Jurisdiction' as geotype_pretty,
	app.fn_capitalize_first(LOWER(p_zone.name)) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 136

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'High School District' as geotype_pretty,
	app.fn_capitalize_first(LOWER(SUBSTRING(LEFT(p_zone.name, IIF(CHARINDEX('UNION',p_zone.name) > 0, CHARINDEX('UNION',p_zone.name) - 2, len(p_zone.name))), 6, 100))) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 137

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Unified School District' as geotype_pretty,
	app.fn_capitalize_first(LOWER(SUBSTRING(LEFT(p_zone.name, IIF(CHARINDEX('UNION',p_zone.name) > 0, CHARINDEX('UNION',p_zone.name) - 2, len(p_zone.name))), 9, 100))) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 138

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'U.S. Postal ZIP Code' as geotype_pretty,
	cast(p_zone.zone as varchar) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 139

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Major Statistical Area' as geotype_pretty,
	app.fn_capitalize_first(LOWER(p_zone.name)) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 30

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Region' as geotype_pretty,
	'San Diego' as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 4

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Statistical Reference Area' as geotype_pretty,
	app.fn_capitalize_first(LOWER(p_zone.name)) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 53

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Transit Provider' as geotype_pretty,
	p_zone.name as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 66

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'City of San Diego Council District' as geotype_pretty,
	cast(p_zone.zone as varchar) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 42

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'San Diego County Supervisorial District' as geotype_pretty,
	cast(p_zone.zone as varchar) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 56

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	p_type.geography_type as geotype,
	'Census Tract (2010)' as geotype_pretty,
	cast(p_zone.zone / 100 as varchar) + IIF(p_zone.zone % 100 = 0, '', IIF(p_zone.zone % 100 < 10, '.0' + cast(p_zone.zone % 100 as varchar), '.' + cast(p_zone.zone % 100 as varchar))) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id = 59

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	'cpa' as geotype,
	'Community Planning Area' as geotype_pretty,
	p_zone.name as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id in (15,20)

INSERT INTO demographic_warehouse.dim.mgra(mgra_id,mgra,series,geotype,geotype_pretty,geozone) 
SELECT
    1300000 + c_zone.zone as mgra_id,
	c_zone.zone as mgra,
	13 as series,
	'cpa' as geotype,
	'Community Planning Area' as geotype_pretty,
	app.fn_capitalize_first(p_zone.name) as geozone
FROM
    data_cafe.ref.geography_xref x
	  INNER JOIN data_cafe.ref.geography_zone c_zone ON x.child_geography_zone_id = c_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_zone p_zone ON x.parent_geography_zone_id = p_zone.geography_zone_id
	  INNER JOIN data_cafe.ref.geography_type p_type ON p_zone.geography_type_id = p_type.geography_type_id
WHERE
  c_zone.geography_type_id = 90
  and p_zone.geography_type_id IN (133,134)

/*
SELECT
 geotype_pretty
 ,geozone
FROM
  dim.mgra
WHERE
	geotype = 'cpa'
group by geotype_pretty, geozone
*/