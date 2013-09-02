gitHub = require '../lib/github'

index = (config) ->
  options =
    reload:    config.liveReload.enabled
    optimize:  config.isOptimize ? false
    cachebust: if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''

  # In the event plain html pages are being used, need to
  # switch to different page for optimized view
  name = if config.isOptimize and config.server.views.html
    "index-optimize"
  else
    "index"

  (req, res) ->
    if !req.session.authToken
      res.redirect('/session/new')
      return

    gitHub.issues(token: req.session.authToken)
      .then(([response]) ->
        res.send 200, response.body
      )

exports.index = index
