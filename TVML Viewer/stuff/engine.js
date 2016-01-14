// Thanks to rayh on github for the sample code,
// found here: https://gist.github.com/rayh/d023aeba28a25ed7f7f2

var SimplePage = function(relUrl, base) {
    var self = this;
    var url = tvjsutil.urlRelativeTo(relUrl, base);

    function onSelect(event) {
        var ele = event.target
        var href = ele.getAttribute("href")

        // What do it do?
        if (ele.hasAttribute('navtype')) {
            // We'll use "navtype" for a few special operations.
            switch (ele.getAttribute('navtype')) {
                case ('back'): // Go "back" one document, shrinking the stack.
                    navigationDocument.popDocument()
                    break;
                case ('top'): // Restart, shrinking the stack.
                    navigationDocument.popToRootDocument()
                    break;
                case ('go'): // Go to the location in the "addressbar".
                    var addressbar = ele.ownerDocument.getElementById('addressbar');
                    var address = addressbar.getFeature('Keyboard').text;
                    new SimplePage(address, url).load();
                    break;
				default:
                    console.log({message: 'unknown navtype on element',
                                element: ele});
                    tvjsutil.nslogWithObject('unknown navtype on element ', ele);
            }
        } else {
            // In the absence of a navtype, fetch the href and go.
            if(href) {
                new SimplePage(href, url).load();
            }
        }
    }
    
    function pushDoc(document) {
        var parser = new DOMParser();
        var doc = parser.parseFromString(document, "application/xml");

        doc.addEventListener("select", onSelect.bind(self));
        // Other interesting events: "play", "highlight", "holdselect",
        // or for text fields, "change".

        currentdoc = doc;
        
        navigationDocument.pushDocument(doc);
    }
   
    self.load = function() {
        pushDoc(tvjsutil.load(url))
    }
    
    return self;
}
