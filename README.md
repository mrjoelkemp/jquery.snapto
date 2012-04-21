Helper for directional snap with Jquery objects
================

Purpose: 

This helper is used to do better than the general snap functionality of Jquery draggables. 

We want a particular object to snap only to an object in a particular direction. For example, if you have multiple canvas objects that are used to piece together a still image or video, you'll want a piece not to snap to any other piece (using Jquery draggable's outer, inner, or both snapModes) but to snap to a particular piece in a specific direction.

In other words, this helper allows you to join two particular sides between two objects.