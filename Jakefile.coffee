desc 'Users management tasks'
namespace 'users', ->
  models   = require './app/models'
  Server   = require './lib/server'

  desc 'List all users'
  task 'list', ->
    server   = new Server __dirname, debug: false
    server.init ->
      models.User.find (err, users) ->
        server.stop()
        throw err if err?
        console.log '---'
        console.log user.email for user in users
        console.log '---'

  desc 'Create a new user. E.g. jake users:create[john@mikamai.com,password]'
  task 'create', (email, password) ->
    if email? and password?
      server   = new Server __dirname, debug: false
      server.init ->
        user = new models.User {email, password}
        user.save (err) ->
          server.stop()
          throw err if err?
          console.log "---"
          console.log "User #{user.email} created successfully!"
          console.log "---"
    else
      console.log "Email and password needed. E.g. jake users:create[john@mikamai.com,password]"

  desc 'Removes a user. E.g. jake users:remove[john@mikamai.com]'
  task 'remove', (email) ->
    if email?
      server   = new Server __dirname, debug: false
      server.init ->
        models.User.findOne {email}, (err, user) ->
          throw err if err?
          if user?
            user.remove (err) ->
              throw err if err?
              server.stop()
              console.log "---"
              console.log "User #{email} removed successfully!"
              console.log "---"
          else
            server.stop()
            console.log "Cannot find any user for #{email}"
    else
      console.log "Email needed. E.g. jake users:remove[john@mikamai.com]"