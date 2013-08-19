crypto = require 'crypto'
Q = require 'q'
randomBytes = Q.denodeify(crypto.randomBytes)
config = require '../github-conf'

exports.clientId = config.clientId
exports.clientSecret = config.clientSecret

exports.tokenUri = ({ code })->
  "https://github.com/login/oauth/access_token?client_id=#{config.clientId}&client_secret=#{config.clientSecret}&code=#{code}"

exports.authorizeUri = ({ secret }) ->
  "https://github.com/login/oauth/authorize?client_id=#{config.clientId}&state=#{secret}"

exports.generateAuthSecret = ->
  randomBytes(48).then((buf) -> buf.toString('hex'))
