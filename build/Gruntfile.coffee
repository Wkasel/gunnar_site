module.exports = (grunt) ->
  grunt.config.init 
    pkg: grunt.file.readJSON("package.json")
    meta:
      version: "<%= pkg.version %>"
      banner: "/* Gunnar Peterson Site - v<%= pkg.version %>"+
        "* generated: <%= grunt.template.today(\"yyyy-mm-dd - HH:mm:ss.sss\") %>*/\n\n\n"
    js: 
      files:
        dependencies: [
          #<bootstrap>
          "../vendor/bootstrap/js/transition.js", "../vendor/bootstrap/js/alert.js", "../vendor/bootstrap/js/button.js"
          "../vendor/bootstrap/js/carousel.js", "../vendor/bootstrap/js/collapse.js", "../vendor/bootstrap/js/dropdown.js"
          "../vendor/bootstrap/js/modal.js", "../vendor/bootstrap/js/tooltip.js", "../vendor/bootstrap/js/popover.js"
          "../vendor/bootstrap/js/scrollspy.js", "../vendor/bootstrap/js/tab.js", "../vendor/bootstrap/js/affix.js"
          #</bootstrap>
        ],
        app: [
          "../js/src/custom.js"
        ]
    coffee:
      options:
        bare: true
      compile:
        files:
          "../js/src/custom.js": ["../js/coffee/*.coffee"]
    less:
      compile:
        options:
          compress: true
        files:
          "../css/app.css":"../css/less/app.less"
    watch:
      scripts:
        files: [
          "<%= js.files.dependencies %>", #dependencies
          "../css/less/*.less", "../vendors/bootstrap/*.less", #less
          "../js/coffee/*.coffee", #coffee
          "../templates/jade/*.jade", "../templates/jade/**/*.jade","../templates/jade/**/**/*.jade"   #jade
        ]
        tasks: 'default'
    concat:
      options:
        banner: "<%= meta.banner %>"
      dist:
        src: ["<%= js.files.dependencies %>", "<%= js.files.app %>"]
        dest: "../js/application.js"
    jade:
      compile:
        options:
          data:
            version: "<%= pkg.version %>"
            debug: true
            timestamp: "<%= new Date().getTime() %>"
          pretty: true
        files:
          "../index.html": ["../templates/jade/index.jade"]

    # handlebars:
    #       compile:
    #         options:
    #           namespace: "app.templates"
    #           wrapped: true
    #           processName: (filename) ->
    #             filename.substring 23, filename.length - 11 # removes the string ".handlebars" -- if the name changes from /templates, update this
    # 
    #         files:
    #           "../templates/templates.js": ["../../templates/static/*.handlebars", "../../templates/static/**/*.handlebars"]
    
      
  grunt.loadNpmTasks "grunt-contrib"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.registerTask "default", ["coffee","less",'jade', "concat"]
  