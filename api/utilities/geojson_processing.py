import json
import psycopg2

server = 'postydev.sandag.org'
db = 'data_surfer'
user = 'postgres'
password = '48RedSlideq7VbK'

with psycopg2.connect(database=db, user=user, password=password, host=server) as conn:
    with conn.cursor() as cur:
        with open('e:/data/data_surfer/cities_cpa.geojson') as  j:
            data = json.load(j)
            features = data["features"]
            for feature in features:
                cur.execute('INSERT INTO staging.geography_zone (geography_zone_id, geography_type_id, zone, name, geojson) VALUES (%s, %s, %s, %s, %s)', (
                    feature['properties']['geography_zone_id'],
                    feature['properties']['geography_type_id'],
                    feature['properties']['zone'],
                    feature['properties']['name'],
                    json.dumps(feature)
                ))
