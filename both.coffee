Router.configure
    layoutTemplate: 'layout'

Router.route '/',
    action: -> this.render 'home'

makeBoth = (i) ->
    Router.route '/' + i,
        action: -> this.render i

makeBoth i for i in petas
