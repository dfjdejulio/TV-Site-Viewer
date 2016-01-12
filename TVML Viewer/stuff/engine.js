// Thanks to rayh on github for the sample code,
// found here: https://gist.github.com/rayh/d023aeba28a25ed7f7f2

var SimplePage = function(url) {
    var self = this;

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
                    new SimplePage(ele.ownerDocument.getElementById('addressbar').textContent).load();
                    break;
				default:
                    console.log({message: 'unknown navtype on element',
                                element: ele});
            }
        } else {
            // In the absence of a navtype, fetch the href and go.
            if(href) {
                thispage = new SimplePage(href).load();
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
    
    self.loadLiteral = pushDoc;

    self.load = function() {
        var templateXHR = new XMLHttpRequest();
        templateXHR.responseType = "document";
        templateXHR.addEventListener("load", function() {
                                     pushDoc(templateXHR.responseText);
                                     }, false);
        templateXHR.open("GET", url, true);
        templateXHR.send();
        return templateXHR;
    }
    
    return self;
}
