// Thanks to rayh on github for the sample code,
// found here: https://gist.github.com/rayh/d023aeba28a25ed7f7f2

var nextUrl;
var lastUrl;
var lastDoc;
var lastDelay = null;

function handleDocumentDelay() {
    new SimplePage(nextUrl, lastUrl).replace();
}

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
                case ('replace'):
                    if (href) {
                        new SimplePage(href, url).replace();
                    }
                    break;
                case ('video'): // Play the "href".
                    var address = tvjsutil.urlRelativeTo(ele.getAttribute('href'), url);
                    var video = new MediaItem('video', address);
                    var playlist = new Playlist();
                    playlist.push(video);
                    var  player = new Player();
                    player.playlist = playlist;
                    player.play();
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
    
    function onRandomEvent(event) {
        console.log(event.type);
    }

    function parseDoc(document) {
        var parser = new DOMParser();
        var doc = parser.parseFromString(document, "application/xml");

        // Let people "click" on things.
        doc.addEventListener("select", onSelect.bind(self));
        doc.addEventListener("play", onPlay.bind(self));

        // Do things that depend on the content displaying.
        doc.addEventListener("appear", onAppear.bind(self));

        self.currentdoc = doc;
        
        return doc;
    }
    
    function onPlay(event) {
        // For now, treat Play as Select.  Future expansion goes here.
        onSelect(event);
    }

    function onAppear(event) {
        // This seems to be the best place to handle fake meta-refresh.
        cancelLastDelay();
        var ele = event.target;
        var delay = ele.getAttribute('delay');
        if (delay) {
            console.log('handling appear event with delay');
            console.log({element: ele});
            nextUrl = ele.getAttribute('href');
            lastUrl = url;
            lastDelay = setTimeout(handleDocumentDelay, delay * 1000)
        }
    }
    
    function cancelLastDelay() {
        if (lastDelay) {
            clearTimeout(lastDelay);
            lastDelay = null;
        }
    }
    
    // Not sure how well this will work.  Let's find out!
    self.replace = function() {
        var newDoc = parseDoc(tvjsutil.load(url));
        navigationDocument.replaceDocument(newDoc, lastDoc);
        lastDoc = newDoc;
    }
   
    self.load = function() {
        lastDoc = parseDoc(tvjsutil.load(url));
        navigationDocument.pushDocument(lastDoc);
    }
    
    return self;
}
