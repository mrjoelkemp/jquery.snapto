Snap To
================

Jquery plugin for snapping an absolutely positioned element to another element in a particular direction (`left`, `right`, `up`, `down`).

### Demo

http://jsfiddle.net/mrjoelkemp/5YuKr/1/

### Usage

```
$(selector).snapTo(neighborSelector, direction, animationDelay);

// Example
$('.obj-being-snapped').snapTo('.another-obj', 'right', 10);
```

* `neighborSelector`: the selector (or jquery object) of the object to snap to.
* `direction`: the direction for snapping
 * Supported directions
* `animationDelay`: the millisecond delay in the snap animation. The smaller the animation delay, the faster the snapping