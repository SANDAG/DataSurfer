import json
import os
import time
import urllib2

def get_status_code(host, path):
    """ This function retreives the status code of a website by requesting
        HEAD data from the host. This means that it only requests the headers.
        If the host cannot be reached or something else goes wrong, it returns
        None instead.
    """
    try:
        print host
        print path
        conn = httplib.HTTPConnection('http://datasurfer-dev.sandag.org')
        conn.request("GET", path)
        r = conn.getresponse()
        return r.status
    except StandardError:
        return None

base_url = 'http://datasurfer-dev.sandag.org/api'
#comp_url = 'http://localhost/api'
#comp_url = 'http://datasurfer-dev.sandag.org/api'

def ordered(obj):
    if isinstance(obj, dict):
        return sorted((k, ordered(v)) for k, v in obj.items())
    if isinstance(obj, list):
        return sorted(ordered(x) for x in obj)
    else:
        return obj

with open('e:/apps/datasurfer/api/utilities/console.log', 'w') as f:

  for datasource in ['estimate']:#['estimate', 'census', 'forecast']:
    response = urllib2.urlopen('%s/%s' % (base_url, datasource))
    series_api = json.load(response)

    for record in series_api:
        if datasource == 'forecast':
          series_id = record['series']
        else:
          series_id = record['year']
        
        response = urllib2.urlopen('%s/%s/%s' % (base_url, datasource, series_id))
        geo_api = json.load(response)

        for geo in geo_api:
            geo_id = geo['zone']

            response = urllib2.urlopen('%s/%s/%s/%s' % (base_url, datasource, series_id, geo_id))
            zone_api = json.load(response)
    
            for zone in zone_api:
                print zone
                f.write(str(zone) + "\n")
                zone_id = zone[geo_id]
            
                for type in ['housing','age','ethnicity','income','income/median','population']:
                    burl = '/api/%s/%s/%s/%s/%s' % (datasource, series_id, geo_id, zone_id, type)
                    burl = burl.replace(' ', '%20')
                    
                    status = get_status_code(base_url[7:-4], burl)
                    if 200 == status:
                        print "200: " + base_url[7:-4] + burl
                    else:
                        print "ERROR - " + str(status) + ": " + base_url[7:-4] + burl
                        f.write("ERROR - " + str(status) + ": " + base_url[7:-4] + burl + "\n")
                    
                    f.flush()
                    os.fsync(f.fileno())
                
#                if datasource == 'forecast':
#                    url = '%s/%s/%s/%s/%s/jobs' % (base_url, datasource, series_id, geo_id, zone_id)
#                    url = url.replace(' ', '%20')
#                    response = urllib2.urlopen(url)
#                    url = '%s/%s/%s/%s/%s/ethnicity/change' % (base_url, datasource, series_id, geo_id, zone_id)
#                    url = url.replace(' ', '%20')
#                    response = urllib2.urlopen(url)
