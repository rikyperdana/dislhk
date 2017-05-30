if Meteor.isClient

    Template.menu.helpers
        menus: -> _.map petas, (menu) -> menu.toUpperCase()

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

    # generated with update.sh
    Template.bengkalis_apl.onRendered -> makeMap "bengkalis_apl", "F_Prbhn"
    Template.bengkalis_hl.onRendered -> makeMap "bengkalis_hl", "F_Prbhn"
    Template.bengkalis_hp.onRendered -> makeMap "bengkalis_hp", "F_Prbhn"
    Template.bengkalis_hpk.onRendered -> makeMap "bengkalis_hpk", "F_Prbhn"
    Template.bengkalis_hpt.onRendered -> makeMap "bengkalis_hpt", "F_Prbhn"
    Template.bengkalis_ksa.onRendered -> makeMap "bengkalis_ksa", "F_Prbhn"
    Template.dumai_apl.onRendered -> makeMap "dumai_apl", "F_Prbhn"
    Template.dumai_hp.onRendered -> makeMap "dumai_hp", "F_Prbhn"
    Template.dumai_hpk.onRendered -> makeMap "dumai_hpk", "F_Prbhn"
    Template.dumai_hpt.onRendered -> makeMap "dumai_hpt", "F_Prbhn"
    Template.dumai_ksa.onRendered -> makeMap "dumai_ksa", "F_Prbhn"
    Template.hutan_desa.onRendered -> makeMap "hutan_desa", "F_Prbhn"
    Template.inhil_apl.onRendered -> makeMap "inhil_apl", "F_Prbhn"
    Template.inhil_hl.onRendered -> makeMap "inhil_hl", "F_Prbhn"
    Template.inhil_hp.onRendered -> makeMap "inhil_hp", "F_Prbhn"
    Template.inhil_hpk.onRendered -> makeMap "inhil_hpk", "F_Prbhn"
    Template.inhil_hpt.onRendered -> makeMap "inhil_hpt", "F_Prbhn"
    Template.inhil_ksa.onRendered -> makeMap "inhil_ksa", "F_Prbhn"
    Template.inhu_apl.onRendered -> makeMap "inhu_apl", "F_Prbhn"
    Template.inhu_hl.onRendered -> makeMap "inhu_hl", "F_Prbhn"
    Template.inhu_hp.onRendered -> makeMap "inhu_hp", "F_Prbhn"
    Template.inhu_hpk.onRendered -> makeMap "inhu_hpk", "F_Prbhn"
    Template.inhu_hpt.onRendered -> makeMap "inhu_hpt", "F_Prbhn"
    Template.inhu_ksa.onRendered -> makeMap "inhu_ksa", "F_Prbhn"
    Template.iuphhk_ha.onRendered -> makeMap "iuphhk_ha", "F_Prbhn"
    Template.iuphhk_ht.onRendered -> makeMap "iuphhk_ht", "F_Prbhn"
    Template.iuphhk_re.onRendered -> makeMap "iuphhk_re", "F_Prbhn"
    Template.kampar_apl.onRendered -> makeMap "kampar_apl", "F_Prbhn"
    Template.kampar_hl.onRendered -> makeMap "kampar_hl", "F_Prbhn"
    Template.kampar_hp.onRendered -> makeMap "kampar_hp", "F_Prbhn"
    Template.kampar_hpk.onRendered -> makeMap "kampar_hpk", "F_Prbhn"
    Template.kampar_hpt.onRendered -> makeMap "kampar_hpt", "F_Prbhn"
    Template.kampar_ksa.onRendered -> makeMap "kampar_ksa", "F_Prbhn"
    Template.kuansing_apl.onRendered -> makeMap "kuansing_apl", "F_Prbhn"
    Template.kuansing_hl.onRendered -> makeMap "kuansing_hl", "F_Prbhn"
    Template.kuansing_hp.onRendered -> makeMap "kuansing_hp", "F_Prbhn"
    Template.kuansing_hpk.onRendered -> makeMap "kuansing_hpk", "F_Prbhn"
    Template.kuansing_hpt.onRendered -> makeMap "kuansing_hpt", "F_Prbhn"
    Template.kuansing_ksa.onRendered -> makeMap "kuansing_ksa", "F_Prbhn"
    Template.meranti_apl.onRendered -> makeMap "meranti_apl", "F_Prbhn"
    Template.meranti_hl.onRendered -> makeMap "meranti_hl", "F_Prbhn"
    Template.meranti_hp.onRendered -> makeMap "meranti_hp", "F_Prbhn"
    Template.meranti_hpk.onRendered -> makeMap "meranti_hpk", "F_Prbhn"
    Template.meranti_hpt.onRendered -> makeMap "meranti_hpt", "F_Prbhn"
    Template.meranti_ksa.onRendered -> makeMap "meranti_ksa", "F_Prbhn"
    Template.pekanbaru_apl.onRendered -> makeMap "pekanbaru_apl", "F_Prbhn"
    Template.pekanbaru_hp.onRendered -> makeMap "pekanbaru_hp", "F_Prbhn"
    Template.pekanbaru_hpk.onRendered -> makeMap "pekanbaru_hpk", "F_Prbhn"
    Template.pekanbaru_hpt.onRendered -> makeMap "pekanbaru_hpt", "F_Prbhn"
    Template.pekanbaru_ksa.onRendered -> makeMap "pekanbaru_ksa", "F_Prbhn"
    Template.pelalawan_apl.onRendered -> makeMap "pelalawan_apl", "F_Prbhn"
    Template.pelalawan_hl.onRendered -> makeMap "pelalawan_hl", "F_Prbhn"
    Template.pelalawan_hp.onRendered -> makeMap "pelalawan_hp", "F_Prbhn"
    Template.pelalawan_hpk.onRendered -> makeMap "pelalawan_hpk", "F_Prbhn"
    Template.pelalawan_hpt.onRendered -> makeMap "pelalawan_hpt", "F_Prbhn"
    Template.pelalawan_ksa.onRendered -> makeMap "pelalawan_ksa", "F_Prbhn"
    Template.rohil_apl.onRendered -> makeMap "rohil_apl", "F_Prbhn"
    Template.rohil_hl.onRendered -> makeMap "rohil_hl", "F_Prbhn"
    Template.rohil_hp.onRendered -> makeMap "rohil_hp", "F_Prbhn"
    Template.rohil_hpk.onRendered -> makeMap "rohil_hpk", "F_Prbhn"
    Template.rohil_hpt.onRendered -> makeMap "rohil_hpt", "F_Prbhn"
    Template.rohil_ksa.onRendered -> makeMap "rohil_ksa", "F_Prbhn"
    Template.rohul_apl.onRendered -> makeMap "rohul_apl", "F_Prbhn"
    Template.rohul_hl.onRendered -> makeMap "rohul_hl", "F_Prbhn"
    Template.rohul_hp.onRendered -> makeMap "rohul_hp", "F_Prbhn"
    Template.rohul_hpk.onRendered -> makeMap "rohul_hpk", "F_Prbhn"
    Template.rohul_hpt.onRendered -> makeMap "rohul_hpt", "F_Prbhn"
    Template.rohul_ksa.onRendered -> makeMap "rohul_ksa", "F_Prbhn"
    Template.siak_apl.onRendered -> makeMap "siak_apl", "F_Prbhn"
    Template.siak_hl.onRendered -> makeMap "siak_hl", "F_Prbhn"
    Template.siak_hp.onRendered -> makeMap "siak_hp", "F_Prbhn"
    Template.siak_hpk.onRendered -> makeMap "siak_hpk", "F_Prbhn"
    Template.siak_hpt.onRendered -> makeMap "siak_hpt", "F_Prbhn"
    Template.siak_ksa.onRendered -> makeMap "siak_ksa", "F_Prbhn"
