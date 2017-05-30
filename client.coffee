if Meteor.isClient

    @makeMap = (peta, labeling) ->
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
                    content += '<b>Data ' + key + '</b>' + ': ' + val + '<br/>'
                content

        geojson = L.geoJson.ajax 'maps/' + peta + '.geojson',
            style: style
            onEachFeature: onEachFeature

        jalan = L.tileLayer.provider 'OpenStreetMap.DE'
        topo = L.tileLayer.provider 'OpenTopoMap'

        map = L.map 'peta',
            center: [0.5, 101.44]
            zoom: 8
            zoomControl: false
            layers: [jalan, geojson]

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
            'Jalan': jalan
            'Topografi': topo
        overlayMaps = 
            'Data': geojson
        options =
            collapsed: false
        control = L.control.layers baseMaps, overlayMaps, options
        control.addTo map

    Template.menu.helpers
        menus: -> _.map petas, (menu) -> menu.toUpperCase()
        
        bengkalis: -> _.filter petas, (peta) -> peta.includes 'bengkalis'
        dumai: -> _.filter petas, (peta) -> peta.includes 'dumai'
        inhil: -> _.filter petas, (peta) -> peta.includes 'inhil'
        inhu: -> _.filter petas, (peta) -> peta.includes 'inhu'
        kampar: -> _.filter petas, (peta) -> peta.includes 'kampar'
        kuansing: -> _.filter petas, (peta) -> peta.includes 'kuansing'
        meranti: -> _.filter petas, (peta) -> peta.includes 'meranti'
        pekanbaru: -> _.filter petas, (peta) -> peta.includes 'pekanbaru'
        pelalawan: -> _.filter petas, (peta) -> peta.includes 'pelalawan'
        rohil: -> _.filter petas, (peta) -> peta.includes 'rohil'
        rohul: -> _.filter petas, (peta) -> peta.includes 'rohul'
        siak: -> _.filter petas, (peta) -> peta.includes 'siak'
        
        apl: -> _.filter petas, (peta) -> peta.includes 'apl'
        hl: -> _.filter petas, (peta) -> peta.includes 'hl'
        hp: -> _.filter petas, (peta) -> peta.includes 'hp'
        hpt: -> _.filter petas, (peta) -> peta.includes 'hpt'
        ksa: -> _.filter petas, (peta) -> peta.includes 'ksa'


