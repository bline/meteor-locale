
share.LocaleTranslationCollection = LocaleTranslationCollection = new Meteor.Collection 'localeTranslationCollection'

class Locale
  autoadd: true
  defaultLocale: 'dev'
  defaultSection: 'App'
  defaultValue: '[UNSET]'
  get: (locale, section, key) ->
    section = @defaultSection if !section
    locale = @defaultLocale if !section
    existing = LocaleTranslationCollection.findOne
      locale: locale
      section: section
      key: key
    if existing
      return existing.value
    else if @autoadd
      LocaleTranslationCollection.insert
        locale: locale
        section: section
        key: key
        value: @defaultValue
    return @defaultValue
  listSection: (locale, section) ->
    return LocaleTranslationCollection.find
      locale: locale
      section: section
  listLocale: (locale) ->
    return LocaleTranslationCollection.find
      locale: locale
  detectLanguage: ->
    detectedLng = undefined
    qsParm = {}
    query = window.location.search.substring 1
    parms = query.split /[&;]/
    for i in [0 .. parms.length - 1]
      pos = parms[i].indexOf '='
      if pos > 0
        key = parms[i].substring 0, pos
        val = parms[i].substring pos + 1
        qsParm[key] = val
    if qsParm[o.detectLngQS]
      detectedLng = qsParm[o.detectLngQS]

share.Locale = Locale

