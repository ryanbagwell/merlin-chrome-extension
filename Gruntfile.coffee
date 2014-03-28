path = require 'path'

module.exports = (grunt) ->
  _ = grunt.util._

  # Used instead of "ext" to accommodate filenames with dots. Lots of
  # talk all over GitHub, including here: https://github.com/gruntjs/grunt/pull/750
  coffeeRename = (dest, src) -> path.join dest, "#{ src.replace /\.(lit)?coffee$/, '.compiled.js' }"

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'app/static/coffee'
          src: ['**/*.?(lit)coffee']
          dest: 'app/static/js/'
          rename: coffeeRename
        ]

    less:
      compile:
        files: [
          expand: true
          cwd: 'app/static/less'
          src: ['*.less']
          dest: 'app/static/css'
          ext: '.css'
        ]

    watch:
      options:
        atBegin: true
      coffee:
        files: ['app/static/coffee/*.?(lit)coffee']
        tasks: ['coffee']
      less:
        files: ['app/static/less/**/*.less']
        tasks: ['less']


  # Load grunt plugins
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'


  # Define tasks.
  grunt.registerTask 'compile', ['less', 'coffee']