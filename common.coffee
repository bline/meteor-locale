
share.LocaleTranslationCollection = LocaleTranslationCollection = new Meteor.Collection 'localeTranslationCollection'

class Locale
  @autoadd: true
  @lastQS: ''
  @defaultLocale: 'dev'
  @defaultValue: '[UNSET]'
  @setLngQS: 'setLng'

  @_getRecord: (opts) ->
    console.log "_getRecord Opts: ", opts
    cr = key: opts.key

    cr.locale = opts.locale
    cr.locale = UserSession.get 'currentLocale' if not cr.locale and not Meteor.isServer
    cr.locale = Locale.detectLanguage() if not cr.locale
    cr.locale = Locale.defaultLocale if not cr.locale

    # see if there is existing locale with xx_XX
    existing = LocaleTranslationCollection.findOne cr

    # did not find xx_XX locale, try just xx
    if not existing and locale.indexOf('_') > -1
      cr.locale = locale.split(/_/)[0]
      existing = LocaleTranslationCollection.findOne cr

    # not found, should we autoadd?
    if not existing and @autoadd
      cr.value = Locale.defaultValue
      id = LocaleTranslationCollection.insert cr
      existing = LocaleTranslationCollection.findOne _id: id

    console.log "finished with: ", existing
    existing

  @get: (key, opts) ->
    if arguments.length == 1
      if _.isString key
        opts = {}
      else
        opts = key
    else if _.isString opts
      opts = { key: key, locale: opts }

    existing = Locale._getRecord(opts) || {}
    existing.value

  listPrefix: (locale, key) ->
    keyRegEx = "^" + key.replace(/([\\.*-])/, "\\$1", "g") + "\\b"
    return LocaleTranslationCollection.find
      locale: locale
      key: new RegExp keyRegEx

  listLocale: (locale) ->
    return LocaleTranslationCollection.find
      locale: locale

  @detectLanguage: ->
    setLngQS = Locale.setLngQS
    detectedLng = undefined
    qsParm = {}
    query = Meteor.isClient ? window.location.search.substring(1) : Locale.lastQS.substring(1)
    querystring = Npm.require 'querystring'
    parms = querystring.parse query

    if setLngQS in parms
      detectedLng = parms[setLngQS]

    if Meteor.isClient and !detectedLng and navigator?
      detectedLng = (navigator.language) ? navigator.language : navigator.userLanguage

    detectedLng

t = (key, args = {}) ->
  trx = Locale.get key
  for k, v in args
    trx = trx.replace(new RegExp("__" + k + "__"), v, "g")
  trx

share.t = t
share.Locale = Locale

