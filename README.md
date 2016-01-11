# TVML Viewer

Some apps require a lot of rich, custom behavior.  Other apps are almost purely
contnet-based, and rely only on a small set of standard behaviors.

This viewer attempts to implement enough standard behaviors, via custom
tags and attributes, for content-based apps to be implemented *entirley* as
sets of static TVML and asset files.  The idea is, you create an "index.tvml",
and put everything it links to or references in the same basic area, point
this app at that area, and you're off and running.