<?php
/**
 * Step 1: Require the Slim Framework
 *
 * If you are not using Composer, you need to require the
 * Slim Framework and register its PSR-0 autoloader.
 *
 * If you are using Composer, you can skip this step.
 */
ini_set('display_errors', 1);
require 'Slim/Slim.php';
require 'Query.php';
require 'xlsxwriter.class.php';

\Slim\Slim::registerAutoloader();

//define column mappings
$geotypes = [
		"jurisdiction" => "city_name",
		"region" => "region_name",
		"zip" => "zip",
		"msa" => "msa_name",
		"sra" => "sra_name",
		"tract" => "tract_name",
		"elementary" => "elementary_name",
		"secondary" => "high_school_name",
		"unified" => "unified_name",
		"college" => "community_college_name",
		"sdcouncil" => "council",
		"supervisorial" => "supervisorial",
		"cpa" => "cpa_name"
];

$app = new \Slim\Slim();

$app->notFound(function() use ($app)
{
	$app->halt(400, "Bad Request");
});
$app->setName('datasurferapi');
$app->response->headers->set('Content-Type', 'application/json');

$app->hook('slim.after.router', function() use ($app) {
    $env = $app->environment();
    if ($env['pdf.zip.file'])
    {
        header('Content-Type: application/zip');
        header('Content-disposition: attachment; filename='.$env['pdf.zip.file']);
        header('Content-Length: ' . filesize($env['pdf.zip.path']));
        header('Content-Description: ZIP File Transfer');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        
        set_time_limit(0);
        $file = @fopen($env['pdf.zip.path'], 'rb');
        while (!feof($file))
        {
            print @fread($file, 1024*8);
            ob_flush();
            flush();
        }
        
        unlink($env['pdf.zip.path']);
    }
});

$app->get('/', function () use ($app)
{
    $app->response->headers->set('Content-Type', 'text/html');
    $app->render('home.php');
});

$app->get('/map', function () use ($app)
{
    $app->response->headers->set('Content-Type', 'text/html');
    $app->render('map.htm');
});

$app->get('/:datasource', function ($datasource) use ($app)
{
    $datasource_type_id = ["census"=>"1","estimate"=>"2","forecast"=>"3"];
    
    $labels = ["forecast" => "series", "census"=>"year", "estimate"=>"year"];
    $columns = ["forecast" => "ds.series", "census"=>"yr.yr", "estimate"=>"yr.yr"];

    $sql = "SELECT {$columns[$datasource]} as {$labels[$datasource]} FROM dim.datasource ds" 
        .($datasource !== 'forecast' ? " INNER JOIN dim.forecast_year yr ON ds.datasource_id = yr.datasource_id" : "")
        ." INNER JOIN dim.datasource_type dsType ON ds.datasource_type_id = dsType.datasource_type_id WHERE lower(datasource_type) = lower($1) AND is_active ORDER BY 1";
	
	echo Query::getInstance()->getYearsAsJson($sql, $datasource);
    
})->conditions(array('datasource' => 'census|forecast|estimate'));

$app->get('/:datasource/:year', function ($datasource, $year) use ($app)
{
    $datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);

	if(!$datasource_id)
	{
		$app->halt(400, 'Invalid year or series id');
	}

    echo Query::getInstance()->getGeoTypeAsArray($datasource_id);

})->conditions(array('datasource' => 'census|forecast|estimate', 'year' => '(\d){2,4}'));

//Get Information - Zone Names for Geotype
$app->get('/:datasource/:year/:geotype', function ($datasource, $series, $geotype) use ($app)
{
	$series_id = 13;
	
	if ($datasource == 'forecast') 
	{
		$series_id = $series;	
	} elseif ($datasource == 'census')
	{
		if($series == 2000)
		{
			$series_id = 10;
		}
	}
    
    $response = Query::getInstance()->getZonesAsJson($series_id, $geotype);
    $json = json_decode($response, true);
    if ($response == 'false') $app->halt(400, 'Invalid request parameters');
    
    if ($geotype == 'unified' and ($series == 13 or $series == 2010))
    {
        $unset_queue = array();

        foreach ( $json as $i=>$item )
        {

            if ($item == "bonsall")
            {

                $unset_queue[] = $i;
            }
        }

        foreach ( $unset_queue as $index )
        {
            echo $index;
            unset($json[$index]);
        }
    }
    
    echo json_encode($json);
	
})->conditions(array('datasource' => 'census|forecast|estimate', 'year' => '(\d){2,4}'));

 //Census / Estimate - Housing
$app->get('/:datasource/:year/:geotype/:zone/housing', function ($datasource, $year, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');
    
    $sql = "SELECT geozone as {$geotype}, yr as year, unit_type, cast(units as int), occupied, unoccupied, round(cast(vacancy_rate as numeric),5) as vacancy_rate FROM fact.summary_housing 
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
     
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

//Census / Estimate - Housing
$app->get('/:datasource/:year/:geotype/:zone/population', function ($datasource, $year, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, housing_type, population FROM fact.summary_population 
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
	 
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

//Census / Estimate - Ethnicity
$app->get('/:datasource/:year/:geotype/:zone/ethnicity', function ($datasource, $year, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, ethnic as ethnicity, population FROM fact.summary_ethnicity
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

//Census / Estimate - Age
$app->get('/:datasource/:year/:geotype/:zone/age', function ($datasource, $year, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, sex, age_group as group_10yr, population FROM fact.summary_age
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

//Census / Estimate - Income
$app->get('/:datasource/:year/:geotype/:zone/income', function ($datasource, $year, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, ordinal, income_group, households FROM fact.summary_income 
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

$app->get('/:datasource/:year/:geotype/:zone/income/median', function ($datasource, $year, $geotype, $zone) use ($app)
{
    $datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, median_inc FROM fact.summary_income_median 
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3)"
            .($datasource == 'estimate' ? " AND yr = {$year}" : "");	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

$app->get('/:datasource/:year/:geotype/all/export/pdf', function($datasource, $year, $geoType) use ($app)
{
	$ts = round(microtime(true) * 1000);
	$base_file_name = strtolower(join("_", array('sandag',$datasource, $year, $geoType)).".zip");
	$sys_file_name = './zip/'.$ts."_".$base_file_name;
        
    $zip = new ZipArchive();
	$zip->open($sys_file_name, ZIPARCHIVE::CREATE);
        
    $pdf_dir = join(DIRECTORY_SEPARATOR, array(".","pdf", $datasource, $year, $geoType));
		
    if($handle = opendir($pdf_dir)) {
        while ($entry = readdir($handle)) {
            if (strstr($entry, '.pdf')) {
                $zip->addFile(join(DIRECTORY_SEPARATOR, array($pdf_dir,$entry)),$entry);
            }
        }
        closedir($handle);
    }
        
    $zip->close();
    
    $env = $app->environment();
    $env["pdf.zip.path"] = $sys_file_name;
    $env["pdf.zip.file"] = $base_file_name;
    
})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

$app->map('/:datasource/:year/:geotype/:zones+/export/pdf', function($datasource, $year, $geoType, $zones) use ($app)
{
	if (1 == count($zones))
	{
		$zone = $zones[0];
		$file_name = strtolower(join("_", array('sandag', $datasource, $year, $geoType, $zone)).".pdf");
		$file_path = join(DIRECTORY_SEPARATOR, array(".","pdf", $datasource, $year, $geoType, $file_name));
		
		if (file_exists($file_path))
		{
			$res = $app->response();
			$res['Content-Description'] = 'File Transfer';
			$res['Content-Type'] = 'application/pdf';
			$res['Content-Disposition'] ='attachment; filename='.$file_name;
			$res['Content-Transfer-Encoding'] = 'binary';
			$res['Expires'] = '0';
			$res['Cache-Control'] = 'must-revalidate';
			$res['Pragma'] = 'public';
		
			$res['Content-Length'] = filesize($file_path);
			readfile($file_path);
		} else
		{
			$app->halt(400, 'Invalid PDF Export Request');
		}
	} else 
	{
		natcasesort($zones);
		
		$zip = new ZipArchive();
		$ts = round(microtime(true) * 1000);
		$base_file_name = strtolower(join("_", array('sandag',$datasource, $year, $geoType))."_".$ts.".zip");
		
		$sys_file_name = './zip/'.$ts."_".$base_file_name;
		
		$zip->open($sys_file_name, ZIPARCHIVE::CREATE);
		
		foreach ($zones as $zone)
		{
			$file_name = strtolower(join("_", array('sandag', $datasource, $year, $geoType, $zone)).".pdf");
			$file_path = join(DIRECTORY_SEPARATOR, array(".","pdf", $datasource, $year, $geoType, $file_name));
			if (file_exists($file_path))
			{
				$zip->addFile($file_path, $file_name);
			} else
			{
				$app->halt(400, 'Invalid PDF Export Request');
			}
		}
		
		$zip->close();
		
		$res = $app->response();
		$res['Content-Description'] = 'File Transfer';
		$res['Content-Type'] = 'application/zip';
		$res['Content-Disposition'] ='attachment; filename='.$base_file_name;
		$res['Content-Transfer-Encoding'] = 'binary';
		$res['Expires'] = '0';
		$res['Cache-Control'] = 'must-revalidate';
		$res['Pragma'] = 'public';
		$res['Content-Length'] = filesize($sys_file_name);
		
		readfile($sys_file_name);
		
		unlink($sys_file_name);
	}
})->via('GET', 'POST')->conditions(array('datasource' => 'census|forecast|estimate', 'year' => '(\d){2,4}'));

$app->get('/:datasource/:year/:geotype/all/export/xlsx', function ($datasource, $year, $geotype) use ($app)
{
    $datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');
    
 	$ts = round(microtime(true) * 1000);
	$file_name = strtolower(join("_", array($datasource, $year, $geotype))."_{$ts}.xlsx");
    
    $res = $app->response();
    $res['Content-Description'] = 'File Transfer';
    $res['Content-Type'] = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    $res['Content-Disposition'] ='attachment; filename='.$file_name;
    $res['Content-Transfer-Encoding'] = 'binary';
    $res['Expires'] = '0';
    $res['Cache-Control'] = 'must-revalidate';
    $res['Pragma'] = 'public';
    
    $writer = new XLSXWriter();
    $writer->setAuthor("San Diego Association of Governments");

    //*******AGE*************
    $ageSql = "SELECT geozone as {$geotype}, yr as year, sex, age_group as group_10yr, population FROM fact.summary_age
                WHERE datasource_id = :datasource_id AND geotype = :geotype AND age_group <> 'Total Population'
                ORDER BY yr, sex, age_group";
    $writer->writeSheet(
                Query::getInstance()->getResultAsArray($ageSql, $datasource_id, $geotype, null),
                'Age'
                ,array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'SEX' => 'string',
                    'Group - 10 Year' => 'string',
                    'POPULATION' => 'integer'
                )
    );

    //*******ETHNICITY*************
    $ethnicitySql = "SELECT geozone as {$geotype}, yr as year, ethnic as ethnicity, population FROM fact.summary_ethnicity 
                        WHERE datasource_id = :datasource_id AND geotype = :geotype AND ethnic <> 'Total Population' order by geozone, yr, ethnic;";
    
    $writer->writeSheet(
                Query::getInstance()->getResultAsArray($ethnicitySql, $datasource_id, $geotype, null),
                'Ethnicity',
                array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'ETHNICITY' => 'string',
                    'POPULATION' => 'integer'
                )
    );
    
    //*******HOUSING*************
    $housingSql = "SELECT geozone as {$geotype}, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM fact.summary_housing 
        WHERE datasource_id = :datasource_id AND geotype = :geotype and unit_type <> 'Total Units' order by geozone, yr, unit_type;";

    $writer->writeSheet(
                Query::getInstance()->getResultAsArray($housingSql, $datasource_id, $geotype, null),
                'Housing',
                array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'UNIT TYPE' => 'string',
                    'UNITS' => 'integer',
                    'OCCUPIED' => 'integer',
                    'UNOCCUPIED' => 'integer',
                    'VACANCY RATE' => 'double'
                )
    );

    //*******POPULATION*************
    $populationSql = "SELECT geozone as {$geotype}, yr, housing_type, population FROM fact.summary_population 
    		WHERE datasource_id = :datasource_id AND geotype = :geotype order by geozone, yr, housing_type;";
    
    $writer->writeSheet(
                Query::getInstance()->getResultAsArray($populationSql, $datasource_id, $geotype, null),
                'Population',
                array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'HOUSING TYPE' => 'string',
                    'POPULATION' => 'integer',
                )
    );

    //*******INCOME*************
    $incomeSql = "SELECT geozone as {$geotype}, yr, ordinal, income_group, households FROM fact.summary_income 
    		WHERE datasource_id = :datasource_id AND geotype = :geotype order by geozone, yr, ordinal;";
   
    $writer->writeSheet(
                Query::getInstance()->getResultAsArray($incomeSql, $datasource_id, $geotype, null),
                'Income',
                array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'ORDINAL' => 'integer',
                    'INCOME GROUP' => 'string',
                    'HOUSEHOLDS' => 'integer'
                )
    );
   
    if("forecast"==$datasource)
    {
        $jobsSql = "SELECT geozone as {$geotype}, yr, employment_type, jobs FROM fact.summary_jobs 
                        WHERE datasource_id = :datasource_id AND geotype = :geotype and employment_type <> 'Total Jobs' order by geozone, yr, employment_type;";
        $writer->writeSheet(
                Query::getInstance()->getResultAsArray($jobsSql, $datasource_id, $geotype, null),
                'Civilian Jobs',
                array(
                    strtoupper($geotype) => 'string',
                    'YEAR' => 'string',
                    'EMPLOYMENT TYPE (Civilian)' => 'string',
                    'JOBS' => 'integer'
                )
        );
    }
    
    $writer->writeToStdOut();

})->conditions(array('datasource' => 'forecast|census|estimate', 'year' => '(\d){2,4}'));

$app->get('/:datasource/:year/:geotype/:zones+/export/xlsx', function ($datasource, $year, $geotype, $zones) use ($app)
{
	if (count($zones) > 20)
	{
		$app->halt(400, 'Max Zone Request Exceeded (Limit: 20)');
	}
	natcasesort($zones);
	
	$zonelist = '{'.strtolower(implode(',', $zones)).'}';
	 
	$datasource_id = Query::getInstance()->getDatasourceId($datasource, $year);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');
	
	$ts = round(microtime(true) * 1000);
	$file_name = strtolower(join("_", array($datasource, $year, $geotype))."_{$ts}.xlsx");
	
    $res = $app->response();
    $res['Content-Description'] = 'File Transfer';
    $res['Content-Type'] = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    $res['Content-Disposition'] ='attachment; filename='.$file_name;
    $res['Content-Transfer-Encoding'] = 'binary';
    $res['Expires'] = '0';
    $res['Cache-Control'] = 'must-revalidate';
    $res['Pragma'] = 'public';

    $writer = new XLSXWriter();
    $writer->setAuthor("San Diego Association of Governments");

    $ageHeader = array(
    		strtoupper($geotype) => 'string',
    		'YEAR' => 'string',
    		'SEX' => 'string',
    		'Group - 10 Year' => 'string',
    		'POPULATION' => 'integer'
    );
    $ageSql = "SELECT geozone as {$geotype}, yr as year, sex, age_group as group_10yr, population FROM fact.summary_age
    WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) AND age_group <> 'Total Population'
    ORDER BY yr, sex, age_group";
    $ageArray = Query::getInstance()->getResultAsArray($ageSql, $datasource_id, $geotype, $zonelist);
    
    //*******ETHNICITY*************
    $ethnicityHeader = array(
        strtoupper($geotype) => 'string',
        'YEAR' => 'string',
    	'ETHNICITY' => 'string',
    	'POPULATION' => 'integer'
    );
    $ethnicitySql = "SELECT geozone as {$geotype}, yr as year, ethnic as ethnicity, population FROM fact.summary_ethnicity 
    		WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) AND ethnic <> 'Total Population' order by geozone, yr, ethnic;";
    $ethnicityArray = Query::getInstance()->getResultAsArray($ethnicitySql, $datasource_id, $geotype, $zonelist);
    
    //*******HOUSING*************
    $housingHeader = array(
        strtoupper($geotype) => 'string',
    	'YEAR' => 'string',
    	'UNIT TYPE' => 'string',
    	'UNITS' => 'integer',
    	'OCCUPIED' => 'integer',
    	'UNOCCUPIED' => 'integer',
    	'VACANCY RATE' => 'double'
    );
    $housingSql = "SELECT geozone, yr, unit_type, units, occupied, unoccupied, vacancy_rate FROM fact.summary_housing 
        WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) and unit_type <> 'Total Units' order by geozone, yr, unit_type;";
    $housingArray = Query::getInstance()->getResultAsArray($housingSql, $datasource_id, $geotype, $zonelist);
    
    //*******POPULATION*************
    $populationHeader = array(
        strtoupper($geotype) => 'string',
    	'YEAR' => 'string',
    	'HOUSING TYPE' => 'string',
    	'POPULATION' => 'integer',
    );
    $populationSql = "SELECT geozone, yr, housing_type, population FROM fact.summary_population 
    		WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) order by geozone, yr, housing_type;";
    $populationArray = Query::getInstance()->getResultAsArray($populationSql, $datasource_id, $geotype, $zonelist);
    
    //*******INCOME*************
    $incomeHeader = array(
        strtoupper($geotype) => 'string',
    	'YEAR' => 'string',
    	'ORDINAL' => 'integer',
    	'INCOME GROUP' => 'string',
    	'HOUSEHOLDS' => 'integer'
    );
    $incomeSql = "SELECT geozone, yr, ordinal, income_group, households FROM fact.summary_income 
    		WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) order by geozone, yr, ordinal;";
    $incomeArray = Query::getInstance()->getResultAsArray($incomeSql, $datasource_id, $geotype, $zonelist);
    
    $writer->writeSheet($ageArray, 'Age', $ageHeader);
    $writer->writeSheet($ethnicityArray, 'Ethnicity', $ethnicityHeader);
    $writer->writeSheet($housingArray, 'Housing', $housingHeader);
    $writer->writeSheet($populationArray, 'Population', $populationHeader);
    $writer->writeSheet($incomeArray, 'Income', $incomeHeader);
   
    if("forecast"==$datasource)
    {
      $jobsHeader = array(
      		strtoupper($geotype) => 'string',
      		'YEAR' => 'string',
      		'EMPLOYMENT TYPE (Civilian)' => 'string',
      		'JOBS' => 'integer'
      );
      $jobsSql = "SELECT geozone, yr, employment_type, jobs FROM fact.summary_jobs 
      		WHERE datasource_id = :datasource_id AND geotype = :geotype AND lower(geozone) = ANY(:zonelist) and employment_type <> 'Total Jobs' order by geozone, yr, employment_type;";
      $jobsArray = Query::getInstance()->getResultAsArray($jobsSql, $datasource_id, $geotype, $zonelist);
      $writer->writeSheet($jobsArray, 'Civilian Jobs', $jobsHeader);
    }
    
    $writer->writeToStdOut();
});

//Forecast - Ethnicity Change
$app->get('/forecast/:series/:geotype/:zone/ethnicity/change', function ($series, $geotype, $zone) use ($app)
{
	$datasource_id = Query::getInstance()->getDatasourceId('forecast', $series);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');
	
    $sql = "SELECT geozone as ${geotype}, ethnicity, pct_chg_byear_to_2020, pct_chg_2020_to_2025, pct_chg_2025_to_2030, 
    		pct_chg_2030_to_2035, pct_chg_2035_to_2040, pct_chg_2040_to_2045, pct_chg_2045_to_2050, 
    		pct_chg_base_to_horizon FROM fact.summary_ethnicity_change
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3);";

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;

})->conditions(array('series' => '(\d){2}'));

$app->get('/forecast/:series/:geotype/:zone/jobs', function ($series, $geotype, $zone) use ($app)
{
    $datasource_id = Query::getInstance()->getDatasourceId('forecast', $series);
    
    if (!$datasource_id)
        $app->halt(400, 'Invalid year or series id');

    $sql = "SELECT geozone as {$geotype}, yr as year, employment_type as category, jobs FROM fact.summary_jobs 
            WHERE datasource_id = $1 AND geotype = $2 AND lower(geozone) = lower($3);";	

    $json = Query::getInstance()->getResultAsJson($sql, $datasource_id, $geotype, $zone); 

    echo $json;
	
})->conditions(array('series' => '(\d){2}'));

$app->get('/:program/:series/:geotype/:zone/map', function ($datasource, $series, $geoType, $zone) use ($app)
{
	$res = $app->response();
	$res['Content-Type'] = 'image/jpeg';
	$res['Expires'] = '0';
	$res['Cache-Control'] = 'must-revalidate';
	$res['Pragma'] = 'public';
	
	$series_id = '13';
	
	if ($datasource == 'forecast') 
	{
		$series_id = $series;	
	} elseif ($datasource == 'census')
	{
		if($series == 2000)
		{
			$series_id = 10;
		}
	}
	
	$file_name = strtolower(join("_", array('sandag', 'series'.$series_id, $geoType, $zone)).".jpg");
	$file_path = join(DIRECTORY_SEPARATOR, array(".","map", 'series'.$series_id,$geoType, $file_name));
	
	if (file_exists($file_path))
	{
		$image = imagecreatefromjpeg($file_path);
		echo imagepng($image);
		imagedestroy($image);
	} else {
		$app->halt(400, 'Invalid PDF Export Request');
	}
	
})->conditions(array('datasource' => 'census|forecast|estimate', 'series' => '(\d){2,4}'));

$app->get('/:datasource/:series/:geotype/:zone/map/geojson', function ($datasource, $series, $geotype, $zone) use ($app)
{
    echo Query::getInstance()->getZoneAsGeoJson($datasource, $series, $geotype, $zone);
})->conditions(array('datasource' => 'census|forecast|estimate', 'series' => '(\d){2,4}'));

/**
 * Step 4: Run the Slim application
 *
 * This method should be called last. This executes the Slim application
 * and returns the HTTP response to the HTTP client.
 */
$app->run();
