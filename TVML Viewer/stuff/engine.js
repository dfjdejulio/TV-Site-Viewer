// Thanks to rayh on github for the sample code,
// found here: https://gist.github.com/rayh/d023aeba28a25ed7f7f2

var SimplePage = function(url) {
    var self = this;

    function onSelect(event) {
        var ele = event.target
        var href = ele.getAttribute("href")

        if(href) {
            new SimplePage(href).load();
        }
    }

    function pushDoc(document) {
        var parser = new DOMParser();
        var doc = parser.parseFromString(document, "application/xml");

        doc.addEventListener("select", onSelect.bind(self));

        navigationDocument.pushDocument(doc);
    }

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