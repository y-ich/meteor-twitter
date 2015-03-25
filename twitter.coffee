twitter = Npm.require 'twitter'

class TwitterStream
    constructor: (@stream) ->

    on: (event, cb) ->
        @stream.on event, Meteor.bindEnvironment cb

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

    stream: ->
        args = Array.prototype.slice.call arguments
        cb = args[args.length - 1]
        console.assert typeof cb is 'function'
        args[args.length - 1] = (stream) ->
            cb.call this, new TwitterStream stream
        @twitter.stream.apply @twitter, args
