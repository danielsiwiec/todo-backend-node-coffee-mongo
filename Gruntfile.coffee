module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  # grunt.loadNpmTasks 'grunt-nodemon'
  grunt.initConfig
    concurrent:
      dev: ['nodemon', 'watch']
      options:
        logConcurrentOutput: true
    coffeelint:
      app: ['**/*.coffee', '!node_modules/**']
    nodemon:
      dev:
        script: 'server.coffee'
    watch:
      scripts:
        files: ['**/*.coffee', '!node_modules/**']
        tasks: 'coffeelint'

  grunt.registerTask 'default', ['concurrent:dev']
