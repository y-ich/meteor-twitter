twitter = Npm.require 'twitter'

class Parser
    constructor: (@stream) ->

    on: (event, listener) ->
        @stream.on event, Meteor.bindEnvironment listener

class Twitter
    constructor: (opts) ->
        @twitter = new twitter opts

    _get: (url, params, calback) =>
        @twitter.get url, params, calback

    get: (url, params) ->
        aux = Meteor.wrapAsync @_get
        aux url, params

    _post: (url, params, calback) =>
        @twitter.post url, params, calback

    post: (url, params) ->
        aux = Meteor.wrapAsync @_post
        aux url, params

    stream: (method, params, callback) ->
        if typeof params is 'function'
            callback = params
            params = {}
        @twitter.stream.call @twitter, method, params, (stream) ->
            callback new Parser stream
            return
        return
