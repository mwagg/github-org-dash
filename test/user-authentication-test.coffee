server = require './server'
{ expect } = require 'chai'

describe 'user authentication', ->
  before (done) ->
    server.start.then(-> done())

  describe 'when first requesting the dashboard', ->
    it 'does something', ->
      expect(true).to.equal(true)
