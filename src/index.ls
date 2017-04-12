require! {
    eris
    "./masto_main"
    chalk
    "js-logging"
    fs
    dotenv
    "node-emoji"
    he
}

dotenv.config!

log = js-logging.colorConsole do
    format: "${timestamp} <${title}> ${message}"
    dateformat: "default"

log.info "Starting bot..."

var channels

channels = require "../channels.json" || []


bot = new eris process.env["BOT_TOKEN"]
bot.on "ready" ->
    log.notice chalk.bold(bot.user.username) + " logged in!"

update = ->
    fs.writeFileSync "channels.json" JSON.stringify(channels)

broadcast = (msg) ->
    channels.forEach (ch) ->
        bot.createMessage ch, msg

masto_main  (msg) ->
    log.notice "Broadcasting a toot..."
    broadcast do
        embed:
            author:
                name: node-emoji.emojify msg.data.account.display_name
                icon_url: msg.data.account.avatar
                url: msg.data.account.url
            description: he.decode (node-emoji.emojify (msg.data.content.replace /(<([^>]+)>)/ig ""))
,           (err) ->
    console.log err

bot.on "messageCreate" (msg) ->
    if msg.content is "!masto-enable"
        if channels.indexOf(msg.channel.id) == -1
            log.notice "Enabled Toots for channel " + chalk.bold msg.channel.id
            channels.push msg.channel.id
            update!
        else
            log.warning "Channel already added!"
    else if msg.content is "!masto-disable"
        if channels.indexOf(msg.channel.id) != -1
            channels := channels.filter (val) -> val != msg.channel.id
            update!
            log.notice "Disabled Toots for channel " + chalk.bold msg.channel.id
        else
            log.warning "Channel not enabled!"

bot.connect!