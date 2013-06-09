;(function ($) {
  'use strict';

  // Purpose:  Snaps the calling object to the second object in the direction specified
  // Precond:  direction = a string with a value (left, right, top, bottom)
  //           duration  = the snapping animation duration. Used with Jquery animate()
  $.fn.snapTo = function ($neighbor, direction, duration) {
    // Convert to a jquery object if necessary
    if (! ($neighbor instanceof $)) $neighbor = $($neighbor);

    if (typeof direction !== 'string') throw 'Direction must be left, right, top, or bottom';

    if (duration !== undefined && isNaN(duration)) throw 'Duration must be a number';

    duration = duration === undefined ? 1900 : duration;

    this.supportedDirections = ['left', 'right', 'up', 'down'];

    direction = direction.toLowerCase();

    if (this.supportedDirections.indexOf(direction) === -1) throw 'Unsupported direction';

    this.detailedPosition = computeDetailedPosition($(this));

    var otherPosition = computeDetailedPosition($neighbor),
        snapPoints    = getSnappablePoints.call(this, otherPosition, direction),
        offset        = getSnapPointsOffset(snapPoints);

    moveByOffset.call(this, offset, duration);
  };

  var
      // Computes the 4 corner points of the passed object,
      //  where each point is an object with x and y attributes
      computeDetailedPosition = function ($obj) {
        var
            pos     = $obj.position(),
            width   = parseFloat($obj.width()),
            height  = parseFloat($obj.height()),
            top     = parseFloat(pos.top),
            left    = parseFloat(pos.left),
            right   = left + width,
            bottom  = top + height;

        return {
          topLeft: {
            x: left,
            y: top
          },
          topRight: {
            x: right,
            y: top
          },
          bottomLeft: {
            x: left,
            y: bottom
          },
          bottomRight: {
            x: right,
            y: bottom
          }
        };
      },

      // Purpose: Determines the points that we should snap to on the neighbor in the passed direction
      // Returns: A 4-element list containing the points of interest from both pieces.
      getSnappablePoints = function (neighborPosition, direction) {
        var pos = this.detailedPosition,
            np = neighborPosition;

        switch (direction) {

          // If you're my right neighbor
          // Then my right side must snap to your left side
          case 'right':
            return [pos.topRight, pos.bottomRight, np.topLeft, np.bottomLeft];

          // If you're my left neighbor
          // Then my left side must snap to your right side
          case 'left':
            return [pos.topLeft, pos.bottomLeft, np.topRight, np.bottomRight];

          // If you're my top neighbor
          // Then my top side must snap to your bottom side
          case 'up':
            return [pos.topLeft, pos.topRight, np.bottomLeft, np.bottomRight];

          // If you're my bottom neighbor
          // Then my bottom side must snap to your top side
          case 'down':
            return [pos.bottomLeft, pos.bottomRight, np.topLeft, np.topRight];
        }
      },

      // Purpose: Computes the distance between the snap points
      getSnapPointsOffset = function (snapPoints) {
        var p1 = snapPoints[0],
            p2 = snapPoints[1],
            p3 = snapPoints[2],
            p4 = snapPoints[3];

        // Distance from neighborto us
        return {
          left: p4.x - p2.x,
          top:  p3.y - p1.y
        };
      },

      // Moves this by the offsets to simulate a snap
      moveByOffset = function (offset, duration) {
        var pos = this.position();

        this.animate({
          left: pos.left + offset.left,
          top: pos.top + offset.top
        }, duration);
      };
})(window.jQuery);