Router.configure
    layoutTemplate: 'layout'

Router.route '/',
    action: -> this.render 'home'

makeBoth = (i) ->
    Router.route '/' + i,
        action: -> this.render i

makeBoth i for i in petas

bengkalis = _.filter petas, (peta) -> peta.includes 'bengkalis'
dumai = _.filter petas, (peta) -> peta.includes 'dumai'
inhil = _.filter petas, (peta) -> peta.includes 'inhil'
inhu = _.filter petas, (peta) -> peta.includes 'inhu'
kampar = _.filter petas, (peta) -> peta.includes 'kampar'
kuansing = _.filter petas, (peta) -> peta.includes 'kuansing'
meranti = _.filter petas, (peta) -> peta.includes 'meranti'
pekanbaru = _.filter petas, (peta) -> peta.includes 'pekanbaru'
pelalawan = _.filter petas, (peta) -> peta.includes 'pelalawan'
rohil = _.filter petas, (peta) -> peta.includes 'rohil'
rohul = _.filter petas, (peta) -> peta.includes 'rohul'
siak = _.filter petas, (peta) -> peta.includes 'siak'

apl = _.filter petas, (peta) -> peta.includes 'apl'
hl = _.filter petas, (peta) -> peta.includes 'hl'
hp = _.filter petas, (peta) -> peta.includes 'hp'
hpt = _.filter petas, (peta) -> peta.includes 'hpt'
ksa = _.filter petas, (peta) -> peta.includes 'ksa'

