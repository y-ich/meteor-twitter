###
###

client = new Twitter
    consumer_key: process.env['CONSUMER_KEY']
    consumer_secret: process.env['CONSUMER_SECRET']
    access_token_key: process.env['ACCESS_TOKEN']
    access_token_secret: process.env['ACCESS_TOKEN_SECRET']

Tinytest.add 'get', (test) ->
    try
        response = client.get 'statuses/user_timeline', screen_name: 'nodejs'
        test.instanceOf response, Array
    catch e
        console.log e
    return

Tinytest.add 'post', (test) ->
    try
        response = client.post 'statuses/update', status: 'I Love Twitter'
        test.instanceOf response, Array
    catch e
        test.equal e.toString(), 'Error: Status is a duplicate.'
    return
