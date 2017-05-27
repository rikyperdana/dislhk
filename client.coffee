if Meteor.isClient

    Template.menu.helpers
        menus: -> petas

    makeMap = (i, labeling) ->
        map = L.map 'peta', zoomControl: false
        map.setView [0.5, 101.44], 8
        tile = L.tileLayer.provider 'OpenStreetMap.DE'
        tile.addTo map

        highlightFeature = (e) ->
            e.target.setStyle
                weight: 5
                color: '#666'
                dashArray: ''
                fillOpacity: 0.7
            e.target.bringToFront()
        resetHighlight = (e) ->
            geojson.resetStyle e.target
        zoomToFeature = (e) ->
            map.fitBounds e.target.getBounds()
        onEachFeature = (feature, layer) ->
            layer.on
                mouseover: highlightFeature
                mouseout: resetHighlight
                click: zoomToFeature
            layer.bindPopup ->
                content = ''
                for key, val of feature.properties
                    console.log key, val
                    content += '<b>Data ' + key + '</b>' + ': ' + val + '<br/>'
                content

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

        geojson = L.geoJson.ajax 'maps/' + i + '.geojson',
            style: style
            onEachFeature: onEachFeature
        geojson.addTo map

        legend = L.control position: 'bottomright'
        legend.onAdd = ->
            div = L.DomUtil.create 'div', 'info legend'
            labelAdd = ->
                div.innerHTML +=
                    '<i style="background:'+i.color+'"></i>' +
                    i.label + '<br/>' for i in props
            setTimeout labelAdd, 3000
            div
        legend.addTo map

    Template.hutan_desa.onRendered -> makeMap 'hutan_desa', 'SK'
    Template.iuphhk_re.onRendered -> makeMap 'iuphhk_re', 'Pemilik'
    Template.iuphhk_ha.onRendered -> makeMap 'iuphhk_ha', 'NAMA_PERUS'
    Template.iuphhk_ht.onRendered -> makeMap 'iuphhk_ht', 'PERUSAHAAN'
