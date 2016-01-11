// This, and nothing else, is sent to the TVApplicationControllerContext.

App.onLaunch = function(options) {
    // Load our main engine.
    this.options = options;
    evaluateScripts([`${options.BASEURL}engine.js`],function(success) {
                    if (!success) {
                        var alert = createAlert("Evaluate Scripts Error",
                                                "Couldn't evaluate built-in scripts.");
                    navigationDocument.presentModal(alert);
                    throw("Couldn't evaluate built-in scripts.");
                    } else {
                    new SimplePage('http://www.aisb.org/~ddj/tvml/index.tvml').load();
                    }
                    }
                    );
    // If we got here, the right JS stuff should be loaded.
    console.log("This do anything useful?");
}

App.onExit = function() {
    
}

