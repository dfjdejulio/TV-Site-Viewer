App.onLaunch = function(options) {
    App.savedOptions = options;
    // Load our main engine.
    evaluateScripts([`${options.JSDIRURL}engine.js`],function(success) {
                    if (!success) {
                    console.log("Couldn't load built-in scripts.");
                    tvjsutil.nslog("Couldn't load built-in scripts.");
                    } else {
                    new SimplePage(options.STARTURL, options.BASEURL).load();
                    }
                    }
                    );
}

App.onExit = function() {
    
}
