#Meteor.subscribe 'localeTranslationCollection'

Deps.autorun ->
  if Meteor.isClient
    Meteor.subscribe "localeTranslationCollection",
      locale: Session.get "currentLocale"
