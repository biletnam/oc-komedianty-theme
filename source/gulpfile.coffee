gulp       = require 'gulp'
gutil      = require 'gulp-util'

sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
uglify     = require 'gulp-uglify'
stylus     = require 'gulp-stylus'

# Stylus FW
axis       = require 'axis'
# koutoSwiss = require 'kouto-swiss'
# jeet       = require 'jeet'

# CSS
postcss      = require 'gulp-postcss'
autoprefixer = require 'autoprefixer'
csso         = require 'gulp-csso'

# # Semantic
# wui = require './_source/semantic/tasks/watch'
# bui = require './_source/semantic/tasks/build'

# # Images
# imagemin   = require 'imagemin'
# jpegoptim  = require 'imagemin-jpegoptim'
# pngquant   = require 'imagemin-pngquant'
# optipng    = require 'imagemin-optipng'

# Helpers
livereload = require 'gulp-livereload'
wait       = require 'gulp-wait'
del        = require 'del'

# ENV
production = process.env.NODE_ENV is 'production'

# Pathes
src  = '.'
out  = './../assets'

p =
    styles:
        s: src + '/stylus/main.styl'
        w: src + '/stylus/**/*.styl'
        d: out + '/css/'
    scripts:
        s: src + '/coffee/**/*.coffee'
        w: src + '/coffee/**/*.coffee'
        d: out + '/javascript/'
    images:
        s: src + '/images/**/*.{jpg,png,jpeg}'
        w: src + '/images/**/*.{jpg,png,jpeg}'
        d: out + '/images/'

# Error handler ???
handleError = (err) ->
    gutil.log(gutil.colors.red('ERROR!\n'), gutil.colors.bgRed(err.message));
    gutil.beep()
    this.emit 'end'



# ============================================================================#
# TASKS
# =========================================================================== #

# SCRIPTS
gulp.task 'scripts', ->
    scripts = gulp
        .src p.scripts.s
        .pipe sourcemaps.init()
        .pipe coffee
            bare: true
        .on 'error', handleError

    scripts = scripts.pipe uglify() if production
    scripts = scripts.pipe sourcemaps.write() unless production
    scripts = scripts.pipe gulp.dest p.scripts.d
    scripts = scripts.pipe wait(1000)
    scripts = scripts.pipe livereload() unless production
    scripts


# STYLES
gulp.task 'styles', ->
    styles = gulp
        .src p.styles.s
        .pipe sourcemaps.init()
        .pipe stylus
            set: ['include css']
            use: [axis()]
        .on 'error', handleError

    styles = styles.pipe postcss [
        autoprefixer browsers: [ 'last 2 versions' ]
    ]

    styles = styles.pipe sourcemaps.write() unless production
    styles = styles.pipe csso() if production
    styles = styles.pipe gulp.dest p.styles.d
    styles = styles.pipe wait(1000)
    styles = styles.pipe livereload() unless production
    styles

# CLEAN
gulp.task 'clean', ->
    del ['./../**/Thumbs\.db', './../**/\.DS_Store', './../**/\._\.DS_Store'], {force: true}
        .then (paths) ->
            gutil.log 'Files and folders that would be deleted:\n', paths.join('\n')

# # IMAGES
# gulp.task 'images', ->
#   images = gulp
#       .src p.images.s
#
#       .pipe optipng({optimizationLevel: 3})()
#       .pipe pngquant({quality: '65-80', speed: 4})()
#       .pipe jpegoptim({max: 70})()
#
#   images = images.pipe gulp.dest p.images.d
#   images

# WATCH
gulp.task 'watch', ->
    livereload.listen()

    gulp.watch p.scripts.w,   ['scripts']
        .emit 'update'
    gulp.watch p.styles.w,    ['styles']
        .emit 'update'




# ======================================================================================================================= #
# COMMANDS
# ======================================================================================================================= #


gulp.task 'build', ['scripts', 'styles', 'clean']
gulp.task 'default', ['build', 'watch']
