_ = require 'underscore'

# Base Controller class
class Controller
  constructor: (@req, @res) ->
    @name = @constructor.name.replace('Controller', '').toLowerCase()
    @alerts = @req.session.messages.alerts
    @notices = @req.session.messages.notices

  # shorthand function to render a view passing useful parameters
  render: (view, args = {}) =>
    @res.render "#{@name}/#{view}", args

  redirect_to: (url) =>
    @res.redirect url

  # class function that can be used during @setup as a middleware
  # (like in authentication controller)
  @ensure_authenticated: (req, res, next) ->
    if req.isAuthenticated()
      next()
    else
      res.redirect '/login'

module.exports = Controller