# Should save to an environment variable
path_to_controllers = '../src/app/http/controllers/'

should = require 'should'
home = require path_to_controllers + 'home'

describe 'Home', () ->

  it 'Send message', (done) ->
    home.send 'This is a very original message.', (err) ->
      should.not.exist err
      done()

  it 'Send message missing argument message', (done) ->
    home.send (err) ->
      should.exist err
      done()
