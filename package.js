Package.describe({
  name: 'new3rs:twitter',
  version: '0.0.4',
  // Brief, one-line summary of the package.
  summary: 'a synchronous wrapper of NPM twitter',
  // URL to the Git repository containing the source code for this package.
  git: 'git@github.com:y-ich/meteor-twitter.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Npm.depends({
  "twitter": "1.2.5"
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.4.2');
  api.use('coffeescript')
  api.addFiles('twitter.coffee', 'server');
  api.export('Twitter', 'server');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('tinytest');
  api.use('new3rs:twitter');
  api.addFiles('twitter-tests.coffee', 'server');
});
