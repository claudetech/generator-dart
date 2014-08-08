var path = require('path'),
    _    = require('underscore');

exports.copyCommonFiles = function () {
  this.sourceRoot(path.join(__dirname, 'templates/common'));
  this.copy('gitignore', '.gitignore');
  this.template('README.md', 'README.md');
  this.template('LICENSE', 'LICENSE');
};

exports.promptBaseInfo = function (app) {
  this.project = {
    name:        this.appname,
    description: '',
    version:     '0.1.0',
    author:      '',
    email:       '',
  };
  if (this.options.prompt === false) {
    return;
  }
  var done = this.async();
  this.prompt([{
    type    : 'input',
    name    : 'name',
    message : 'Your project name',
    default : this.appname
  }, {
    type    : 'input',
    name    : 'description',
    message : 'Your project description'
  }, {
    type    : 'input',
    name    : 'version',
    message : 'Your project version',
    default : '0.1.0'
  }, {
    type    : 'input',
    name    : 'author',
    message : 'Your name'
  }, {
    type    : 'input',
    name    : 'email',
    message : 'Your email'
  }], function (answers) {
    _.extend(this.project, answers);
    done();
  }.bind(this));
};
