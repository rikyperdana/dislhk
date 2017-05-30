# Copy your geojson files to ./public/maps
# Run this shell with ./update.sh

sed --in-place '/peta/d' ./generated/view.jade
sed --in-place '/onRendered/d' ./generated/client.coffee
sed --in-place '/push/d' ./generated/array.coffee

for i in $(ls ./public/maps); do
    echo 'template(name="'"${i%.*}"'"): #peta' >> ./generated/view.jade
    echo '    Template.'${i%.*}'.onRendered -> makeMap "'"${i%.*}"'", "F_Prbhn"' >> ./generated/client.coffee
    echo 'petas.push "'"${i%.*}"'"' >> ./generated/array.coffee
done
