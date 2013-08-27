Package.describe({
	summary: "Provides a Locale interface using mongo collection."
});

var both = ['client', 'server']

Package.on_use(function (api) {
	api.use('coffeescript', both);
	api.use('underscore', both);
	api.use('deps', both);
	api.use('session', both);
	api.use('livedata', both);
	api.use('mongo-livedata', both);

	api.add_files('common.coffee', both);
	api.add_files('server.coffee', 'server');
  api.add_files('client.coffee', 'client');

	if (typeof api.export !== 'undefined') {
		api.export(['Locale', 'LocaleTranslationCollection'], both);
	}
});

