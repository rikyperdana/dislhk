if Meteor.isClient

    Template.menu.helpers
        menus: -> petas

    makeMap = (i) ->
        map = L.map 'peta', zoomControl: false
        map.setView [0.5, 101.44], 8
        tile = L.tileLayer.provider 'OpenStreetMap.DE'
        tile.addTo map
        data = L.geoJson.ajax 'maps/'+i+'.geojson'
        data.addTo map

    Template.hutan_desa.onRendered -> makeMap 'hutan_desa'
    Template.iuphhk_re.onRendered -> makeMap 'iuphhk_re'
    Template.iuphhk_ha.onRendered -> makeMap 'iuphhk_ha'
    Template.iuphhk_ht.onRendered -> makeMap 'iuphhk_ht'
