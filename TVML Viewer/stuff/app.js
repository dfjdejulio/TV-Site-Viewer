App.onLaunch = function(options) {
    // Load our main engine.
    evaluateScripts([`${options.BASEURL}engine.js`],function(success) {
                    if (!success) {
                    console.log("Couldn't load built-in scripts.");
                    tvjsutil.nslog("Couldn't load built-in scripts.");
                    } else {
                    new SimplePage('index.tvml', options.BASEURL).load();
                    }
                    }
                    );
}

App.onExit = function() {
    
}
