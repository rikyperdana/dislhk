# Copy your geojson files to ./public/maps
# Run this shell with ./update.sh

sed --in-place '/peta/d' ./view.jade
sed --in-place '/onRendered/d' ./client.coffee
sed --in-place '/push/d' ./array.coffee

for i in $(ls ./public/maps); do
    echo 'template(name="'"${i%.*}"'"): #peta' >> view.jade
    echo '    Template.'${i%.*}'.onRendered -> makeMap "'"${i%.*}"'", "F_Prbhn"' >> client.coffee
    echo 'petas.push "'"${i%.*}"'"' >> array.coffee
done
