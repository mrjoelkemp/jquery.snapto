class SnapHelper
	
	directionalSnap: (obj_being_snapped, obj_snapped_to, direction, duration = 0) ->
	# Purpose: 	Snaps the first object to the second object in the direction specified
	# Precond:	direction = a string with a value (left, right, top, bottom)
	#			duration  = the snapping animation duration. Used with Jquery animate()
		# Compute detailed positions
		obj1_pos = @computeDetailedPosition(obj_being_snapped)
		obj2_pos = @computeDetailedPosition(obj_snapped_to)
		
		# Find points of interest
		
		# Move first input to second input using snap time duration with animate()
	
	computeDetailedPosition: (obj) ->
	# Purpose: 	Computes the 4 corner points of the passed object
	# Returns:	An object containing the labeled corner points where each point is an object containing an x and y position
	# Notes:	Labels include "top_right", "top_left", "bottom_left", and "bottom_right"
	#			In an attempt to avoid adding additional data to the passed obj
		
		# Cache useful attributes
		pos 	= obj.position()
		width 	= parseFloat(obj.width())
		height	= parseFloat(obj.height())
		
		top 	= parseFloat(pos.top)
		left 	= parseFloat(pos.left)
		right 	= left + width		# Top-right
		bottom 	= top  + height		# Bottom-left
		
		# Compute the detailed coordinates
		# Each coordinate is an object with an x and y component {x: , y]
		top_left 	= "x": left, 	"y": top
		top_right 	= "x": right, 	"y": top
		bottom_left = "x": left, 	"y": bottom
		bottom_right= "x": right, 	"y": bottom
		
		details = 
			"top_left" 		: top_left
			"top_right"		: top_right
			"bottom_left"	: bottom_left
			"bottom_right"	: bottom_right
			 
		return details