import json
import os
import time
import urllib2

base_url = 'http://datasurfer.sandag.org/api'
#comp_url = 'http://localhost/api'
comp_url = 'http://datasurfer-dev.sandag.org/api'

def ordered(obj):
    if isinstance(obj, dict):
        return sorted((k, ordered(v)) for k, v in obj.items())
    if isinstance(obj, list):
        return sorted(ordered(x) for x in obj)
    else:
        return obj

with open('e:/apps/datasurfer/api/utilities/console.log', 'w') as f:

  for datasource in ['estimate', 'census', 'forecast']:
    response = urllib2.urlopen('%s/%s' % (base_url, datasource))
    series_api = json.load(response)

    for record in series_api:
        if datasource == 'forecast':
          series_id = record['series']
        else:
          series_id = record['year']
        
        if series_id == 2000:
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
                    burl = '%s/%s/%s/%s/%s/%s' % (base_url, datasource, series_id, geo_id, zone_id, type)
                    burl = burl.replace(' ', '%20')
                    
                    try:
                      bresponse = urllib2.urlopen(burl)
                      bjson = json.load(bresponse)
                    except:
                      print "Error: " + burl
                      f.write("Error: " + burl + "\n")
                    
                    try:
                      curl = '%s/%s/%s/%s/%s/%s' % (comp_url, datasource, series_id, geo_id, zone_id, type)
                      curl = curl.replace(' ', '%20')
                      cresponse = urllib2.urlopen(curl)
                      
                      cjson = json.loads(cresponse.read().replace('null', '0'))
                    except:
                      print "Error: " + curl
                      f.write("Error: " + curl + "\n")
                    
                    #for bitem in bjson:
                    #  for citem in cjson:
                    #    if bitem['unit_type'] == citem['unit_type']:
                    #      if bitem['unit_type'] == 'Total Units':
                              
                    #          f.write(burl + '\n')
                    #          if bitem['vacancy_rate'] != citem['vacancy_rate']: f.write('ERROR\n')
                    #          f.write('{0} vacancy: {1}, {2} \n'.format(bitem['unit_type'], bitem['vacancy_rate'], citem['vacancy_rate']))
                    #          if bitem['occupied'] != citem['occupied']: f.write('ERROR\n')
                    #          f.write('{0} occupied: {1}, {2} \n'.format(bitem['unit_type'], bitem['occupied'], citem['occupied']))
                    #          if bitem['unoccupied'] != citem['unoccupied']: f.write('ERROR\n')
                    #          f.write('{0} unoccupied: {1}, {2} \n'.format(bitem['unit_type'], bitem['unoccupied'], citem['unoccupied'])) 
                    
                    if not (ordered(bjson) == ordered(cjson)):
                        print "Equal: FALSE: " + burl
                        f.write("Equal: FALSE: " + burl + "\n")
                        #if type != 'housing':
                        f.write("---------------------------------------------------\n")
                        f.write("BASE JSON: " + str(bjson) + "\n")
                        f.write("COMP JSON: " + str(cjson) + "\n")
                        f.write("---------------------------------------------------\n\n")
                    
                    f.flush()
                    os.fsync(f.fileno())
                
                if datasource == 'forecast':
                    url = '%s/%s/%s/%s/%s/jobs' % (base_url, datasource, series_id, geo_id, zone_id)
                    url = url.replace(' ', '%20')
                    response = urllib2.urlopen(url)
                    url = '%s/%s/%s/%s/%s/ethnicity/change' % (base_url, datasource, series_id, geo_id, zone_id)
                    url = url.replace(' ', '%20')
                    response = urllib2.urlopen(url)
