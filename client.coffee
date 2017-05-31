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



    mapFilter = (category) ->
        list = _.filter petas, (peta) -> peta.includes category
        _.map list, (item) -> item.toUpperCase()

    Template.menu.helpers
        menus: -> _.map petas, (menu) -> menu.toUpperCase().replace '_', ' '
        
        bengkalis: -> mapFilter 'bengkalis'
        dumai: -> mapFilter 'dumai'
        inhil: -> mapFilter 'inhil'
        inhu: -> mapFilter 'inhu'
        kampar: -> mapFilter 'kampar'
        kuansing: -> mapFilter 'kuansing'
        meranti: -> mapfilter 'meranti'
        pekanbaru: -> mapFilter 'pekanbaru'
        pelalawan: -> mapFilter 'pelalawan'
        rohil: -> mapFilter 'rohil'
        rohul: -> mapFilter 'rohul'
        siak: -> mapFilter 'siak'
        
        apl: -> mapFilter 'apl'
        hl: -> mapFilter 'hl'
        hp: -> mapFilter 'hp'
        hpt: -> mapFilter 'hpt'
        ksa: -> mapFilter 'ksa'

    Template.menu.events
        'click #update': ->
            Meteor.call 'updatePetas'
