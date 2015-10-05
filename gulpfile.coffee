gulp       = require 'gulp'
gutil      = require 'gulp-util'

sourcemaps = require 'gulp-sourcemaps'
coffee     = require 'gulp-coffee'
uglify     = require 'gulp-uglify'
stylus     = require 'gulp-stylus'

# Stylus FW
#koutoSwiss = require 'kouto-swiss'
axis       = require 'axis'
# jeet       = require 'jeet'

# CSS
prefix     = require 'gulp-autoprefixer'
csso       = require 'gulp-csso'

# Images
# imagemin   = require 'imagemin'
# jpegoptim  = require 'imagemin-jpegoptim'
# pngquant   = require 'imagemin-pngquant'
# optipng    = require 'imagemin-optipng'

# Helpers
livereload = require 'gulp-livereload'
# changed    = require 'gulp-changed'

del        = require 'rimraf'


# ENV
production = process.env.NODE_ENV is 'production'

# Pathes
src  = './source'
out  = './assets'

p =
	styles:
		s: src + '/stylus/_main.styl'
		w: src + '/stylus/*'
		d: out + '/css/'
	scripts:
		s: src + '/coffee/main.coffee'
		w: src + '/coffee/**/*.coffee'
		d: out + '/js/'
	images:
		s: src + '/images/**/*.{jpg,png,jpeg}'
		w: src + '/images/**/*.{jpg,png,jpeg}'
		d: out + '/images/'

# Error handler ???
handleError = (err) ->
	gutil.log err
	gutil.beep()
	this.emit 'end'



# ======================================================================================================================= #
# TASKS
# ======================================================================================================================= #

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
		.pipe sourcemaps.write()

	styles = styles
		.pipe prefix
			browsers: ['> 5%', 'last 2 version']
			cascade: true
		.pipe csso() if production

	styles = styles.pipe gulp.dest p.styles.d
	styles = styles.pipe livereload() unless production
	styles

# CLEAN
gulp.task 'clean', ->
	del './**/Thumbs.db', (err) ->
		gutil.log 'Temp files deleted'

# IMAGES
gulp.task 'images', ->
	images = gulp
		.src p.images.s
#		.pipe optipng({optimizationLevel: 3})()
#		.pipe pngquant({quality: '65-80', speed: 4})()
#		.pipe jpegoptim({max: 70})()

	images = images.pipe gulp.dest p.images.d
	images

# WATCH
gulp.task 'watch', ->
	livereload.listen()

	gulp.watch p.scripts.w,   ['scripts']
	gulp.watch p.styles.w,    ['styles']

	.emit 'update'




# ======================================================================================================================= #
# COMMANDS
# ======================================================================================================================= #


gulp.task 'build', ['scripts', 'styles', 'clean']
gulp.task 'default', ['build', 'watch']