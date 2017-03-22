import json
import os
from shapely.geometry import shape
import sys
import time
import urllib2

base_url = 'http://datasurfer-dev.sandag.org/api'

def ordered(obj):
    if isinstance(obj, dict):
        return sorted((k, ordered(v)) for k, v in obj.items())
    if isinstance(obj, list):
        return sorted(ordered(x) for x in obj)
    else:
        return obj

with open('e:/apps/datasurfer/api/utilities/geojson.log', 'w') as f:

  for datasource in ['forecast','estimate', 'census']:
    response = urllib2.urlopen('%s/%s' % (base_url, datasource))
    series_api = json.load(response)

    for record in series_api:
        if datasource == 'forecast':
          series_id = record['series']
        else:
          series_id = record['year']
     
      #if series_id == 12:  
     
        response = urllib2.urlopen('%s/%s/%s' % (base_url, datasource, series_id))
        geo_api = json.load(response)

        for geo in geo_api:
            geo_id = geo['zone']

            response = urllib2.urlopen('%s/%s/%s/%s' % (base_url, datasource, series_id, geo_id))
            zone_api = json.load(response)
    
            for zone in zone_api:
                zone_id = zone[geo_id]
            
                for type in ['map/geojson']:
                    burl = '%s/%s/%s/%s/%s/%s' % (base_url, datasource, series_id, geo_id, zone_id, type)
                    burl = burl.replace(' ', '%20')
                    
                    try:
                      bresponse = urllib2.urlopen(burl)
                    
                      bjson = json.loads(bresponse.read())
                      geom = bjson['geometry']
                      s = shape(geom)

                      if s.area > .000001:
                        print "GOOD: " + burl
                      else:
                        print "BAD: " + burl
                        f.write("BAD (" + str(s.area) + "): " + burl + "\n")
                      
                    except:
                      print "Error: " + burl
                    #  print sys.exc_info()[0]
                      f.write("Error: " + burl + "\n")

                    f.flush()
                    os.fsync(f.fileno())