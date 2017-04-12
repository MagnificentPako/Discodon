require! {
    "mastodon-api"
    readline
    dotenv
}

dotenv.config!

r1 = readline.createInterface {
    input: process.stdin
    output: process.stdout
}

clientId = ""
clientSecret = ""
baseUrl = process.env["API_BASE"]

mastodon-api.createOAuthApp(baseUrl + "/api/v1/apps").catch( (err) -> console.log err )
.then ( (res) ->
    console.log 'Please save \'id\', \'client_id\' and \'client_secret\' in your program and use it from now on!'
    console.log res

    clientId := res.client_id
    clientSecret := res.client_secret

    mastodon-api.getAuthorizationUrl clientId, clientSecret, baseUrl )
.then ( (url) ->
    console.log 'This is the authorization URL. Open it in your browser and authorize with your account!'
    console.log url
    new Promise (resolve) ->
        r1.question 'Please enter the code from the website: ' (code) ->
            resolve code
            r1.close!)
.then ( (code) ->
    mastodon-api.getAccessToken clientId, clientSecret, code, baseUrl)
.catch ( (err) -> console.log err )
.then ( (accessToken) ->
    console.log "This is the access token. Save it!\n" + accessToken)