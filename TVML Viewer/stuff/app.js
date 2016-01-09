

App.onLaunch = function(options) {
    // Load our main engine.
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

}

App.onExit = function() {
    
}