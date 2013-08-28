connect = Npm.require 'connect'
app = connect()
app.use (req, res, next) ->
  url = Npm.require('url').parse request.url
  Locale.lastQS = url.search
  next()


Meteor.publish 'localeTranslationCollection', (opts) ->
  locale = delete opts.locale
  return Locale.listLocale locale


