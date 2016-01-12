var startPage = `<?xml version="1.0" encoding="UTF-8"?>
<document>
<formTemplate>
<banner>
<title>Starting Address</title>
<description>Enter the full URL of a TVML file to load.</description>
</banner>
<textField keyboardType="url" id="addressbar" />
<footer>
<button navtype="go">
<text>Submit</text>
</button>
</footer>
</formTemplate>
</document>`;

App.onLaunch = function(options) {
    // Load our main engine.
    evaluateScripts([`${options.BASEURL}engine.js`],function(success) {
                    if (!success) {
                    console.log("Couldn't load built-in scripts.");
                    } else {
                    // XMLHttpRequest can't handle file:// URLs, so...
                    var loader = new SimplePage(`${options.BASEURL}start.tvml`);
                    loader.loadLiteral(startPage);
                    }
                    }
                    );
}

App.onExit = function() {
    
}

