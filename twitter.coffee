_Twitter = Npm.require 'twitter'

class Parser
    constructor: (@stream) ->

    on: (event, listener) ->
        @stream.on event, Meteor.bindEnvironment listener
        return

class Twitter
    constructor: (opts) ->
        @client = new _Twitter opts

    _request: (method, url, params, callback) ->
        if typeof params is 'function'
            callback = params
            params = {}
        @client[method] url, params, (error, data, response) ->
            if error?
                [{ code, message}] = error
                callback new Error(message), null
            else
                callback null, data
            return
        return

    _get: (url, params, callback) ->
        @_request 'get', url, params, callback
        return

    get: (url, params) ->
        Meteor.wrapAsync(@_get, this) url, params

    _post: (url, params, callback) ->
        @_request 'post', url, params, callback
        return

    post: (url, params) ->
        Meteor.wrapAsync(@_post, this) url, params

    stream: (method, params, callback) ->
        if typeof params is 'function'
            callback = params
            params = {}
        @client.stream.call @client, method, params, (stream) ->
            callback new Parser stream
            return
        return
