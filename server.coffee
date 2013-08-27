
Meteor.publish 'localeTranslationCollection', (opts) ->
  locale = delete opts.locale
  return LocaleTranslationCollection.find
    locale: locale


