# Before copying new geojson file, do these first
# 1. Remove all template(name=): #peta in view.jade
# 2. Remove all Template.bla.onRendered in client.coffee
# 3. Remove all petas.push bla in array.coffee
# 4. Copy the geojson file to ./public/maps
# 5. Run this sh with ./input.sh
# 6. Customize the labeling category in view.jade


for i in $(ls ./public/maps); do
    echo 'template(name="'"${i%.*}"'"): #peta' >> view.jade
    echo '    Template.'${i%.*}'.onRendered -> makeMap "'"${i%.*}"'", "F_Prbhn"' >> client.coffee
    echo 'petas.push "'"${i%.*}"'"' >> array.coffee
done
