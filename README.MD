# How to run this crap?
First of all you have to register your app in your Mastodon account, so go ahead and modify `.env` so it contains the base path of your favourite instance. After that you should build the source. Call `yarn` (or anything else you use to manage your dependencies) and `make` and let it do all the work for you. Then you should run `dist/register_app.js` in order to get all the stuff you need. Save everything in your `.env` after you're done.

Getting the Discord part set up is much easier. head over to the [Discord Developers](https://discordapp.com/developers "Discord Developers") and create a new app. Bind a bot user to this app and get the token, which you then save in your `.dotenv`.

Now you are done with the setup. Just run `npm run bot` and it should fire up.