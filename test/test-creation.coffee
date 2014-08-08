expect = require 'expect.js'
assert = require('yeoman-generator').assert
test   = require('yeoman-generator').test
tmp    = require 'tmp'
fs     = require 'fs-extra'
path   = require 'path'

appDir = path.join path.dirname(__dirname), 'lib', 'generators', 'website'

describe 'generator-dart', ->
  commonFiles = ['.gitignore', 'README.md', 'LICENSE']

  describe 'website', ->
    [app, dir] = [null, '']

    beforeEach (done) ->
      tmp.dir { unsafeCleanup: true }, (err, d) ->
        dir = d
        process.chdir dir
        app = test.createGenerator 'dart:website', [appDir], [], {prompt: false, skipInstall: true}
        app.run {}, ->
          done()

    it 'should create basic files', ->
      files = [
        'pubspec.yaml', 'web/foo.dart'
        'web/foo.html', 'web/foo.css'
      ].concat commonFiles
      expectedFiles = (path.join(dir, f) for f in files)
      assert.file(expectedFiles)

    it 'should write app name to pubspec.yaml', ->
      data = fs.readFileSync path.join(dir, 'pubspec.yaml'), 'utf-8'
      expect(data).to.contain path.basename(dir)
      expect(data).to.contain path.basename('0.1.0')
