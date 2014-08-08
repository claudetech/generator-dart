expect = require 'expect.js'
assert = require('yeoman-generator').assert
test   = require('yeoman-generator').test
tmp    = require 'tmp'
fs     = require 'fs-extra'
path   = require 'path'

tmpDir = process.env['TMPDIR'] ? '/tmp/generator-dart-test'
appDir = path.join path.dirname(__dirname), 'lib', 'generators', 'website'

APP_NAME = 'foo'

before (done) ->
  if fs.existsSync tmpDir
    fs.removeSync tmpDir
  fs.mkdirSync tmpDir
  done()

after ->
  fs.removeSync tmpDir

describe 'generator-dart', ->
  commonFiles = ['.gitignore', 'README.md', 'LICENSE']

  describe 'website', ->
    app = null

    beforeEach ->
      app = test.createGenerator 'dart:website', [appDir], [], {prompt: false, skipInstall: true}

    it 'should create basic files', (done) ->
      files = [
        'pubspec.yaml', 'web/foo.dart'
        'web/foo.html', 'web/foo.css'
      ].concat commonFiles

      tmp.dir { unsafeCleanup: true }, (err, dir) ->
        process.chdir dir
        app.run {}, ->
          expectedFiles = (path.join(dir, f) for f in files)
          assert.file(expectedFiles)
          done()
