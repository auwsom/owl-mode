OWL : Outliner with Wiki Linking
================================

I love outlining. I love wiki. What do you get when you create a mutant cross-breed of the two?

A *fucking power tool*, that's what.

What?
-----

This is a quick proof of concept based on the [Concord outliner](https://github.com/scripting/concord). 

It combines the goodness of outlining from Concord with some compelling ideas of wiki (channeled through my [SdiDesk](http://thoughtstorms.info/view/sdidesk) experience).

Initial features of this demo :
* unlike the original Concord Hello example, you can create a collection of named outlines (or "pages" in Wiki terminology).
* a navbar where you can type the name of any page and click the Go! button to go there. Also supports forward and backward arrows.
* easy link-making. I've gone for a slightly different approach here that I hope speaks to both outliner and wiki tropes. To turn 
any piece of text into a link, select it, and click the "Link" button on the navbar. What this will do is make that text into a 
link to an outline of the _same name_. It's Wiki's [concrete names](http://thoughtstorms.info/view/concretepagenames) policy in 
action. (I know! I know! You think this is the dumbest idea you've ever heard. You want to be able to have a distinction between 
the "real name" and the "display name". Trust me :-) )


Quick Start 
-----------

    git clone https://github.com/interstar/OWL.git owl
    cd owl
    firefox index.html
    
You should now have a copy of OWL running in your browser.

Other Issues
------------
WARNING : As with the other Concord examples, your outlines are stored locally in the browser. There's no way to export yet. 

To create a page / outline that doesn't exist yet, just make and follow a link to it, or type the name into the navbar and click Go.

Some of the additional code is written in CoffeeScript which is compiled to Javascript. I've included the compiled javascript files in git so you can install and run the code without having CoffeeScript installed. But you'll need CoffeeScript if you want to edit and recompile these files.

Forked Concord
--------------
I was really trying hard to avoid forking the Concord library for this.

But I couldn't make it work without patching a small change into concord.js , basically to allow me to write my own handler for 
when the user clicks on links.

The patch is recorded in the file called concord.js.diff and is this : 

    @@ -1156,7 +1156,12 @@ function ConcordEvents(root, editor, op, concordInstance) {
     		if(target.is("a")){
     			if(target.attr("href")){
     				event.preventDefault();
    -				window.open(target.attr("href"));
    +				if (concordInstance.prefs()["hasspeciallinkhandler"]==true) {
    +                    lh = concordInstance.prefs()["speciallinkhandler"];
    +                    lh(target.attr("href"));
    +			    } else {
    +				    window.open(target.attr("href"));
    +				    }
     				}
     			return;
     			}

I'd like to find a way to avoid having to do this. When I do, I'll revert to using the default concord as a submodule. 


Credits
-------
* Dave Winer for getting outlining into the browser (at last) and having the generosity to open-source the core.
* War Cunningham for wiki fact and philosophy. 

