if Meteor.isServer

    Meteor.methods
        'updatePetas': ->
            shell.exec './update.sh'
