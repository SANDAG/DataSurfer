<?php
require 'Config.php';

class Query {
	
	private static $instance;
	
	private $db_server = null;
	private $database = null;
	private $uid = null;
	private $pwd = null;
	private $connectionInfo = array();
	
	private function __construct()
	{
		$config = new Config("configuration.ini");
		
		$this->db_server = $config->get('db_server');
		$this->uid = $config->get('user');
		$this->pwd = $config->get('password');
		$this->database = $config->get('database');
	}
	
	public static function getInstance()
	{
		if (is_null(self::$instance))
		{
			self::$instance = new self();
		}
		
		return self::$instance;
	}
    
    public function getDatasourceId($datasource, $year)
    {
        $columns = ["forecast" => "ds.series", "census"=>"yr.yr", "estimate"=>"yr.yr"];
		
		
		
        $sql = "SELECT ds.datasource_id FROM dim.datasource ds INNER JOIN dim.datasource_type ds_type ON ds.datasource_type_id = ds_type.datasource_type_id"
                .($datasource !== "forecast" ? " INNER JOIN dim.forecast_year yr ON ds.datasource_id = yr.datasource_id" : "")
                ." WHERE lower(ds_type.datasource_type) = lower($1) and {$columns[$datasource]} = $2 AND ds.is_active ORDER BY 1";
        
        $db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");
        $result = pg_query_params($db, $sql, array($datasource, $year));
        
        if($datasource_id = pg_fetch_result($result, 'datasource_id'))
        
        pg_free_result($result);
	    pg_close($db);
        
        return $datasource_id;
    }
	
	public function getZonesAsJson($series_id, $geotype)
	{
		$json = array ();
	
		$db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");
		$sql = "select lower(geozone) as {$geotype} from dim.mgra where series = $1 and geotype = $2 group by geozone order by geozone;";
        
		$result = pg_query_params($db, $sql, array($series_id, $geotype));
		$result_array = pg_fetch_all($result);
		
        $json = json_encode($result_array);
	 
        pg_free_result($result);
	    pg_close($db);
	 
        return $json;
	}
    
    public function getZoneAsGeoJson($datasource, $year, $geotype, $geozone)
    {
        
        $datasource_id = [
          "census" => [
            2000 => [
                "college"=>[22],
                "cpa"=>[12,17],
                "elementary"=>[44],
                "jurisdiction"=>[38],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[145],
                "secondary"=>[47],
                "sra"=>[53],
                "supervisorial"=>[55],
                "tract"=>[58],
                "transit"=>[66],
                "unified"=>[61],
                "zip"=>[72]
            ],
            2010 => [
                "college"=>[23],
                "cpa"=>[14,19],
                "elementary"=>[45],
                "jurisdiction"=>[39],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[48],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[62],
                "zip"=>[73]
            ]
        ],
        "estimate" => [
            2010 => [
                "college"=>[23],
                "cpa"=>[14,19],
                "elementary"=>[45],
                "jurisdiction"=>[39],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[48],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[62],
                "zip"=>[73]
            ],
            2011 => [
                "college"=>[132],
                "cpa"=>[133,134],
                "elementary"=>[135],
                "jurisdiction"=>[136],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[137],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[138],
                "zip"=>[139]
            ],
            2012 => [
                "college"=>[132],
                "cpa"=>[133,134],
                "elementary"=>[135],
                "jurisdiction"=>[136],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[137],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[138],
                "zip"=>[139]
            ],
            2013 => [
                "college"=>[132],
                "cpa"=>[133,134],
                "elementary"=>[135],
                "jurisdiction"=>[136],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[137],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[138],
                "zip"=>[139]
            ],
            2014 => [
                "college"=>[132],
                "cpa"=>[133,134],
                "elementary"=>[135],
                "jurisdiction"=>[136],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[137],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[138],
                "zip"=>[139]
            ],
            2015 => [
                "college"=>[132],
                "cpa"=>[133,134],
                "elementary"=>[135],
                "jurisdiction"=>[136],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[137],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[138],
                "zip"=>[139]
            ]
        ],
        "forecast" => [
            12=> [
                "college"=>[22],
                "cpa"=>[14,19],
                "elementary"=>[44],
                "jurisdiction"=>[38],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[145],
                "secondary"=>[47],
                "sra"=>[53],
                "supervisorial"=>[55],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[61],
                "zip"=>[73]
            ],
            13 => [
                "college"=>[23],
                "cpa"=>[15,20],
                "elementary"=>[45],
                "jurisdiction"=>[39],
                "msa"=>[30],
                "region"=>[4],
                "sdcouncil"=>[42],
                "secondary"=>[48],
                "sra"=>[53],
                "supervisorial"=>[56],
                "tract"=>[59],
                "transit"=>[66],
                "unified"=>[62],
                "zip"=>[73]
            ]
          ]
        ];
        
        $ds_id = $datasource_id[$datasource][$year][$geotype];
        
        $db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");
        $sql = "SELECT z.geojson FROM dim.geography_zone z ".
               "WHERE geography_type_id = ANY($1) AND ".
                ((is_numeric($geozone) and $geotype != 'tract') ? "z.zone = $2 " : "lower(z.name) = $2 ");
        
        $result = pg_query_params($db, $sql, array('{' . implode(', ', $ds_id) . '}', $geozone));
		$result_array = pg_fetch_all($result);
        
        $json = $result_array[0]["geojson"];

        pg_free_result($result);
	    pg_close($db);
	 
        return $json;
    }
	
    public function getYearsAsJson($sql, $datasource)
    {
        $json = array ();
        
        $php_to_pg = array(
        	"int2" => "int",
        	"int4" => "int",
        	"int8" => "int",
        	"float4" => "float",
        	"float8" => "float",
        	"numeric" => "float"
        );
        
        $db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");
        
        $result = pg_query_params($db, $sql, array($datasource));
	    $result_array = pg_fetch_all($result);
	    $mod_array = array();
	    
	    foreach($result_array as $row)
	    {
	    	for($j=0;$j<count($row);$j++)
	    	{
	    		if (array_key_exists(pg_field_type($result, $j), $php_to_pg))
	    		{
	    			$field_type = pg_field_type($result, $j);
	    			$field_name = pg_field_name($result, $j);
	    			eval("\$row[\$field_name] = (".$php_to_pg[$field_type].") \$row[\$field_name];");
	    		}
	    	}
	    	
	    	array_push($mod_array, $row);
	    }
	    
	    $json = json_encode($mod_array);
        
        pg_free_result($result);
	    pg_close($db);
	    
	    return $json;
    }
    
	public function getResultAsJson($sql, $datasource_id, $geotype, $geozone) 
	{
		$json = array ();
		
        $php_to_pg = array(
        	"int2" => "int",
        	"int4" => "int",
        	"int8" => "int",
        	"float4" => "float",
        	"float8" => "float",
        	"numeric" => "float"
        );
		
		$db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");

	    $result = pg_query_params($db, $sql, array($datasource_id, $geotype, $geozone));
	    $result_array = pg_fetch_all($result);
	    $mod_array = array();
	    
	    foreach($result_array as $row)
	    {
	    	for($j=0;$j<count($row);$j++)
	    	{
                if (is_null($row[pg_field_name($result, $j)]))
                {
                    $row[pg_field_name($result, $j)] = null;
                } else if (array_key_exists(pg_field_type($result, $j), $php_to_pg))
	    		{
	    			$field_type = pg_field_type($result, $j);
	    			$field_name = pg_field_name($result, $j);
	    			eval("\$row[\$field_name] = (".$php_to_pg[$field_type].") \$row[\$field_name];");
	    		}
	    	}
	    	
	    	array_push($mod_array, $row);
	    }
	    
	    $json = json_encode($mod_array);
	    
	    pg_free_result($result);
	    pg_close($db);
	    
	    return $json;
	}
	
	public function getResultAsArray($sql, $datasource_id, $geotype, $zonelist) 
	{
		$db = new PDO("pgsql:dbname={$this->database};host={$this->db_server};user={$this->uid};password={$this->pwd}");
		$stmt = $db->prepare($sql);
			
		$stmt->bindParam(':datasource_id', $datasource_id);
		$stmt->bindParam(':geotype', $geotype);
        if ($zonelist)
            $stmt->bindParam(':zonelist', $zonelist);
		
		$records = array();
		if ($stmt->execute()) {
			while ($row = $stmt->fetch(PDO::FETCH_NUM)) {
				$records[] = $row;
			}
		}
		
		return $records;
	}
    
    public function getGeoTypeAsArray($datasource_id)
    {
        $json = array ();
	
		$db = pg_connect("dbname={$this->database} host={$this->db_server} user={$this->uid} password={$this->pwd}");
		 
        $sql = "SELECT geotype as zone FROM dim.mgra mgra INNER JOIN dim.datasource ds ON mgra.series = ds.series WHERE ds.datasource_id = $1 and ds.is_active GROUP BY geotype ORDER BY 1";
         
		$result = pg_query_params($db, $sql, array($datasource_id));
		$result_array = pg_fetch_all($result);
		
        $json = json_encode($result_array);
	 
        pg_free_result($result);
	    pg_close($db);
	 
        return $json;
    }
}
?>