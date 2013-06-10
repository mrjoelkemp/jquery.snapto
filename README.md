Snap To
================

Jquery plugin for snapping an absolutely positioned element to another element in a particular direction (`left`, `right`, `up`, `down`) or to the best possible direction.

### Demo

http://jsfiddle.net/mrjoelkemp/5YuKr/4/

### Usage

```
$(selector).snapTo(neighborSelector, direction, animationDelay);

// Example
$('.obj-being-snapped').snapTo('.another-obj', 'right', 10);
```

* `neighborSelector`: the selector (or jquery object) of the object to snap to.
* `direction`: the direction for snapping
 * If not supplied, then the best direction will be chosen
* `animationDelay`: the millisecond delay in the snap animation. The smaller the animation delay, the faster the snapping. *Defaults to 10 ms*.