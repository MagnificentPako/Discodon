require! {
    "mastodon-api"
    dotenv
}

dotenv.config!

M = new mastodon-api do
    access_token: process.env["CLIENT_TOKEN"]
    api_url: process.env["API_BASE"] + "/api/v1/"

module.exports = (_msg, _err) ->    
    M.stream "streaming/user"
    .on "message", (msg) ->
        _msg msg
    .on "error", (err) ->
        _err err