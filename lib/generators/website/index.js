var yeoman = require('yeoman-generator'),
    path = require('path'),
    util = require(path.join(path.dirname(path.dirname(__dirname)), 'util'));

module.exports = yeoman.generators.Base.extend({
  constructor: function (args, options) {
    yeoman.generators.Base.call(this, args, options);
  },

  promptTask: function () {
    util.promptBaseInfo.call(this);
  },

  copyFiles: function () {
    util.copyCommonFiles.call(this);
    this.sourceRoot(path.join(__dirname, 'template'));
    this.directory('.', '.');
    this.template('pubspec.yaml', 'pubspec.yaml');
  },

  installDeps: function () {
    if (!this.options.skipInstall) {
      this.spawnCommand('pub', ['get']);
    }
  }
});
