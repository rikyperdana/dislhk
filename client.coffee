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
        geojson = L.geoJson.ajax 'maps/'+i+'.geojson', style: style
        geojson.addTo map
        legend = L.control position: 'bottomright'
        legend.onAdd = ->
            div = L.DomUtil.create 'div', 'info legend'
            labelAdd = -> div.innerHTML += i.label + '<br/>' for i in props
            setTimeout labelAdd, 3000
            div
        legend.addTo map

    Template.hutan_desa.onRendered -> makeMap 'hutan_desa', 'SK'
    Template.iuphhk_re.onRendered -> makeMap 'iuphhk_re'
    Template.iuphhk_ha.onRendered -> makeMap 'iuphhk_ha'
    Template.iuphhk_ht.onRendered -> makeMap 'iuphhk_ht'
