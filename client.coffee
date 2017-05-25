if Meteor.isClient

    Template.menu.helpers
        menus: -> petas

    makeMap = (i, labeling) ->
        map = L.map 'peta', zoomControl: false
        map.setView [0.5, 101.44], 8
        tile = L.tileLayer.provider 'OpenStreetMap.DE'
        tile.addTo map
        props = []
        getColor = (prop) ->
            colorGen = '#'+Math.random().toString(16).substr(-6)
            colorExist = _.findWhere props, label: prop
            if colorExist
                colorExist.color
            else
                props.push
                    label: prop
                    color: colorGen
                colorGen
        style = (feature) ->
            fillColor: getColor feature.properties[labeling]
            weight: 2
            opacity: 1
            color: 'white'
            dashArray: '3'
            fillOpacity: 0.7
        data = L.geoJson.ajax 'maps/'+i+'.geojson', style: style
        data.addTo map

    Template.hutan_desa.onRendered -> makeMap 'hutan_desa', 'SK'
    Template.iuphhk_re.onRendered -> makeMap 'iuphhk_re'
    Template.iuphhk_ha.onRendered -> makeMap 'iuphhk_ha'
    Template.iuphhk_ht.onRendered -> makeMap 'iuphhk_ht'
