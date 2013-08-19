gitHub = require './github'
Q = require 'q'
request = (require 'request')
post = Q.denodeify(request.post)
queryString = require 'querystring'

exports.newSession = (config) ->
  options =
    reload:    config.liveReload.enabled
    optimize:  config.isOptimize ? false
    cachebust: if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''

  (req, res) ->
    req.session.authToken = null
    gitHub.generateAuthSecret()
      .then((secret) ->
        req.session.authSecret = secret
        res.redirect(gitHub.authorizeUri(
          secret: secret
        ))
      )

exports.auth = (config) ->
  (req, res) ->
    secret = req.query.state
    code = req.query.code

    if secret != req.session.authSecret
      res.send(401)
      return

    post(gitHub.tokenUri(code: code))
      .then(([response]) ->
        responseArgs = queryString.parse response.body
        req.session.authToken = responseArgs.access_token
        res.redirect '/'
    )
