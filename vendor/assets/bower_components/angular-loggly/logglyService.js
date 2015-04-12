angular.module('loggly', []).service(
    'loggly',
    [function() {
        var logger = new LogglyTracker();

        this.setApiKey = function(logglyApiKey) {
            if (!!logger) {
                logger = new LogglyTracker();
            }
            logger.push({ 'logglyKey': logglyApiKey });
        };

        this.log = function(strOrObj) {
            logger.push(strOrObj);
        };

        this.info = function(strOrObj) {
            logger.push({
                logLevel: 'info',
                data: strOrObj
            });
        };

        this.debug = function(strOrObj) {
            logger.push({
                logLevel: 'debug',
                data: strOrObj
            });
        };

        this.error = function(strOrObj) {
            logger.push({
                logLevel: 'error',
                data: strOrObj
            });
        };
    }]
);
