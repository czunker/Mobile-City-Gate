cd /usr/local/
mkdir osm

cd planet/
wget http://download.geofabrik.de/osm/europe/germany.osm.bz2
cd ../bin/mapnik/
wget http://tile.openstreetmap.org/shoreline_300.tar.bz2
tar xjf shoreline_300.tar.bz2 -C world_boundaries
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/10m-populated-places.zip
unzip 10m-populated-places.zip -d world_boundaries
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m-admin-0-boundary-lines.zip
unzip 110m-admin-0-boundary-lines.zip -d world_boundaries
cd /usr/local/osm/bin
svn co http://svn.openstreetmap.org/applications/utils/export/osm2pgsql/
cd osm2pgsql
sudo apt-get install -y postgresql-8.4-postgis postgresql-contrib-8.4 postgresql-server-dev-8.4 libgeos-dev libpq-dev libbz2-dev proj libxml2-dev libltdl3-dev libpng12-dev libtiff4-dev libicu-dev libboost-python1.40-dev python-cairo-dev python-nose libboost1.40-dev libboost-filesystem1.40-dev libboost-iostreams1.40-dev libboost-regex1.40-dev libboost-thread1.40-dev libboost-program-options1.40-dev libboost-python1.40-dev libfreetype6-dev libcairo2-dev libcairomm-1.0-dev libgeotiff-dev libtiff4 libtiff4-dev libtiffxx0c2 libsigc++-dev libsigc++0c2 libsigx-2.0-2 libsigx-2.0-dev libgdal1-dev python-gdal imagemagick ttf-dejavu
sudo apt-get install -y openjdk-6-jre-headless
./autogen.sh
./ configure && make

sudo -u postgres -i
createuser xyz
createdb -E UTF8 -O xyz gis
createlang plpgsql gis
exit

psql -f /usr/share/postgresql/8.4/contrib/postgis.sql -d gis
echo "ALTER TABLE geometry_columns OWNER TO xyz; ALTER TABLE spatial_ref_sys OWNER TO xyz;" | psql -d gis
psql -f /mnt/bin/osm2pgsql/900913.sql -d gis
psql -f /usr/local/osm/bin/osm2pgsql/900913.sql -d gis
cd ../../src/
svn co http://svn.mapnik.org/tags/release-0.7.1/ mapnik
cd mapnik/
python scons/scons.py configure INPUT_PLUGINS=all OPTIMIZATION=3 SYSTEM_FONTS=/usr/share/fonts/truetype/
python scons/scons.py
sudo python scons/scons.py install
sudo ldconfig
cd ../../bin/
svn co http://svn.openstreetmap.org/applications/rendering/mapnik
cd mapnik/
mkdir world_boundaries
wget http://tile.openstreetmap.org/world_boundaries-spherical.tgz
tar xvzf world_boundaries-spherical.tgz
wget http://tile.openstreetmap.org/processed_p.tar.bz2
tar xvjf processed_p.tar.bz2 -C world_boundaries
cd ../../src/
wget http://dev.openstreetmap.org/~bretth/osmosis-build/osmosis-latest.tgz
tar zxvf /mnt/src/osmosis-latest.tgz -C /usr/local/osm/bin/
tar zxvf osmosis-latest.tgz -C /usr/local/osm/bin/
cd ../bin/osm2pgsql/



