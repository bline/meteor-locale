#Meteor.subscribe 'localeTranslationCollection'


Deps.autorun ->

  curLng = UserSession.get 'currentLocale'
  if not curLng
    detectedLng = Locale.detectLanguage()
    if detectedLng
      curLng = detectedLng
      UserSession.set "currentLocale", detectedLng

  Meteor.subscribe "localeTranslationCollection",
    locale: curLng

Handlebars.registerHelper 't', (i18n_key) ->
  locale = UserSession.get 'currentLocale'
  res = Locale.get locale, i18n_key
  console.log "Translate " + i18n_key + " -> " + res
  res

