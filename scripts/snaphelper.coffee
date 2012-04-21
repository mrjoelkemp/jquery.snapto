class SnapHelper
	
	directionalSnap: (obj_being_snapped, obj_snapped_to, direction, duration = 0) ->
	# Purpose: 	Snaps the first object to the second object in the direction specified
	# Precond:	direction = a string with a value (left, right, top, bottom)
	#			duration  = the snapping animation duration. Used with Jquery animate()
	
	# Algorithm:
	#	compute detailed positions
	#	find points of interest
	#	Move first input to second input using snap time duration with animate()
	
	computeDetailedPosition: (obj) ->
		details = {}
		
		return details