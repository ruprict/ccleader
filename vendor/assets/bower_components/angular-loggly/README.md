# angular-loggly

AngularJS loggly service. Interfaces with [Loggly](http://loggly.com/).

[Loggly's javascript](https://github.com/loggly/loggly-jslogger) is included in this package. The version used is [8836624f7f78a90bccc881324c1106a2d2f52be9](https://github.com/loggly/loggly-jslogger/commit/8836624f7f78a90bccc881324c1106a2d2f52be9).

## Copyright and License

The angular-loggly library is licensed under the [MIT License](./LICENSE).

Copyright (C) 2014, Rudolf Olah

# Usage

Include the loggly script and the angular-logger service:

    <script type="text/javascript" src="/angular-loggly/loggly-jslogger/src/loggly.tracker.js"></script>
    <script type="text/javascript" src="/loggerService.js"></script>

You can also use the minified version of the script:

    <script type="text/javascript" src="/loggerService.min.js"></script>

In your angularjs code:

    function(loggly) {
        loggly.setApiKey('my-long-api-key-pasted-here');
        loggly.log('hello world');
        loggly.log({ message: 'awesome stuff' });
    }

## Logging Levels

You can use the following convenience functions to log at different
logging levels:

- `loggly.info`
- `loggly.debug`
- `loggly.error`

These are all just wrappers around the `loggly.log` function:

    loggly.info('no problems here!');
    // is the same as:
    loggly.log({
        logLevel: 'info',
        data: 'no problems here!'
    });

    loggly.error('uh oh, problem');
    // is the same as:
    loggly.log({
        logLevel: 'error',
        data: 'uh oh, problem'
    });
