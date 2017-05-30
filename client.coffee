if Meteor.isClient

    Template.menu.helpers
        menus: -> petas

    makeMap = (peta, labeling) ->
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

        highlightFeature = (event) ->
            event.target.setStyle
                weight: 5
                color: '#666'
                dashArray: ''
                fillOpacity: 0.7
            event.target.bringToFront()
        resetHighlight = (event) ->
            geojson.resetStyle event.target
        zoomToFeature = (event) ->
            map.fitBounds event.target.getBounds()
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

        geojson = L.geoJson.ajax 'maps/' + peta + '.geojson',
            style: style
            onEachFeature: onEachFeature

        tile = L.tileLayer.provider 'OpenStreetMap.DE'

        map = L.map 'peta',
            center: [0.5, 101.44]
            zoom: 8
            zoomControl: false
            layers: [tile, geojson]

        legend = L.control position: 'bottomright'
        legend.onAdd = ->
            div = L.DomUtil.create 'div', 'info legend'
            labelAdd = ->
                div.innerHTML +=
                    '<i style="background:' + i.color + '"></i>' +
                    i.label + '<br/>' for i in props
            setTimeout labelAdd, 3000
            div
        legend.addTo map

        locate = L.control.locate position: 'topright'
        locate.addTo map

        baseMaps =
            'Jalan': L.tileLayer.provider 'OpenStreetMap.DE'
            'Topografi': L.tileLayer.provider 'OpenTopoMap'
        overlayMaps = 
            'Data': geojson
        options =
            collapsed: false
        layers = L.control.layers baseMaps, overlayMaps, options
        layers.addTo map

    Template.hutan_desa.onRendered -> makeMap 'hutan_desa', 'SK'
    Template.iuphhk_re.onRendered -> makeMap 'iuphhk_re', 'Pemilik'
    Template.iuphhk_ha.onRendered -> makeMap 'iuphhk_ha', 'NAMA_PERUS'
    Template.iuphhk_ht.onRendered -> makeMap 'iuphhk_ht', 'PERUSAHAAN'
