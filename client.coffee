if Meteor.isClient

    Template.peta.onRendered ->
        map = L.map 'peta', zoomControl: false
        map.setView [0.5, 101.44], 8
        tile = L.tileLayer.provider 'OpenStreetMap.DE'
        tile.addTo map
        data = L.geoJson.ajax 'maps/iuphhk_ht.geojson'
        data.addTo map
