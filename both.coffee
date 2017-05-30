Router.configure
    layoutTemplate: 'layout'

Router.route '/',
    action: -> this.render 'home'

makeBoth = (i) ->
    Router.route '/' + i.toUpperCase().replace('_', '%20'),
        action: -> this.render i

makeBoth i for i in petas
