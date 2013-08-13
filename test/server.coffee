request = require 'request'
Q = require 'q'

server = require '../server'

exports.config = config =
  server:
    port: 4000
    base: ""
    views:
      compileWith: "jade"
      extension: "jade"
      path: "/home/michael/dev/github-org-dash/views"
  watch:
    compiledDir: "/home/michael/dev/github-org-dash/public"
  liveReload:
    enabled: false

serverStartedDeferred = Q.defer()
server.startServer(config, serverStartedDeferred.resolve)

exports.start = serverStartedDeferred.promise
