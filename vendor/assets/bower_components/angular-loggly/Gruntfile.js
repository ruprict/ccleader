module.exports = function(grunt) {
    grunt.initConfig({
        uglify: {
            options: {
                mangle: false
            },
            logglyService: {
                files: {
                    'logglyService.min.js': [
                        'loggly-jslogger/src/loggly.tracker.js',
                        'logglyService.js'
                    ]
                }
            }
        }
    });
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.registerTask('default', ['uglify']);
};
