#Twitter package for Meteor
This package is a synchronous wrapper of [NPM twitter](https://github.com/desmondmorris/node-twitter) for meteor server-side.

## Installation

`meteor add new3rd:twitter`

## Quick Start

You will need valid Twitter developer credentials in the form of a set of consumer and access tokens/keys.  You can get these [here](https://apps.twitter.com/).  Do not forgot to adjust your permissions - most POST request require write permissions.

This package exports global variable Twitter.

```javascript
var client = new Twitter({
  consumer_key: '',
  consumer_secret: '',
  access_token_key: '',
  access_token_secret: ''
});
```

Add your credentials accordingly.  I would use environment variables to keep your private info safe.  So something like:

```javascript
var client = new Twitter({
  consumer_key: process.env.TWITTER_CONSUMER_KEY,
  consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
  access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY,
  access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET,
});
```

You now have the ability to make GET and POST requests against the API via the convenience methods.

```javascript
response = client.get(path, params);
response = client.post(path, params);
client.stream(path, params, callback);
```

## REST API

You simply need to pass the endpoint and parameters to one of convenience methods.  Take a look at the [documentation site](https://dev.twitter.com/rest/public) to reference available endpoints.

Example, lets get a [list of favorites](https://dev.twitter.com/rest/reference/get/favorites/list):

```javascript
response = client.get('favorites/list');
console.log(response);  // The favorites. NOTE: this response is the second argument of NPM twitter callback, not the third one.
```

How about an example that passes parameters?  Let's  [tweet something](https://dev.twitter.com/rest/reference/post/statuses/update):

```javascript
response = client.post('statuses/update', {status: 'I Love Twitter'});
console.log(response);  // Tweet body.
```

## Streaming API

Using the `stream` convenience method, you to open and manipulate data via a stream piped directly from one of the streaming API's. Let's see who is talking about javascript:

```javascript
client.stream('statuses/filter', {track: 'javascript'}, function(stream) {
  stream.on('data', function(tweet) {
    console.log(tweet.text);
    // you can also access Meteor basic functions such as collecion.find here.
  });

  stream.on('error', function(error) {
    throw error;
  });
});
```
