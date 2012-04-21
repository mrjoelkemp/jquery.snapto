class SnapHelper
	
	directionalSnap: (obj_being_snapped, obj_snapped_to, direction, duration = 0) ->
	# Purpose: 	Snaps the first object to the second object in the direction specified
	# Precond:	direction = a string with a value (left, right, top, bottom)
	#			duration  = the snapping animation duration. Used with Jquery animate()
		# Compute detailed positions
		obj1_pos = @computeDetailedPosition(obj_being_snapped)
		obj2_pos = @computeDetailedPosition(obj_snapped_to)
		
		# Find points of interest based on direction
		snap_points = @getSnappablePoints(obj1_pos, obj2_pos)
		
		# Get the distance between the snappable points
		offsets = @getMovementOffset(snap_points[0], snap_points[1], snap_points[2], snap_points[3])
		
		# Snap the objects
		left_offset = offsets.left_offset
		top_offset 	= offsets.top_offset		
		@moveObjectByOffsets(obj_being_snapped, left_offset, top_offset, duration)
		
	getMovementOffset: (cp1, cp2, np1, np2) ->
	# Purpose: 	Computes the component (x and y) distances between the two sets of passed points
	# Returns:	An object with the two float offsets		
		# Distance (top and left) from the neighbor to the piece
		ntop_to_ptop 	= np1.y - cp1.y
		nleft_to_pleft 	= np2.x - cp2.x

		return "top_offset": ntop_to_ptop, "left_offset": nleft_to_pleft
			
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
		
	getSnappablePoints: (being_snapped_details, snapped_to_details, direction) ->
	# Purpose: Determines the points from the two pieces that are important for snapping based on the passed relation
	# Returns: A 4-element list containing the points of interest from both pieces. 
	#				2 points from the object being snapped and 2 points from the object being snapped to.
		bs = being_snapped_details
		st = snapped_to_details

		points = []

		# The orientation of the neighbor about the piece in the original board. 
		#	i.e., was the neighbor to the right, left, top, or bottom of the current piece?
		switch direction

			# If you're my right neighbor
			# Then my right side must snap to your left side
			when "right" 	then points = [bs.top_right, bs.bottom_right, st.top_left, st.bottom_left]

			# If you're my left neighbor
			# Then my left side must snap to your right side
			when "left" 	then points = [bs.top_left, bs.bottom_left, st.top_right, st.bottom_right]

			# If you're my top neighbor
			# Then my top side must snap to your bottom side
			when "top" 		then points = [bs.top_left, bs.top_right, st.bottom_left, st.bottom_right]

			# If you're my bottom neighbor
			# Then my bottom side must snap to your top side
			when "bottom" 	then points = [bs.bottom_left, bs.bottom_right, st.top_left, st.top_right]

		return points
	
	moveObjectByOffsets: (obj, left_offset, top_offset, move_speed = 0) ->
	# Purpose: 	Adds the passed offsets to the object's current position
		new_left = obj.position().left + left_offset 
		new_top  = obj.position().top  + top_offset

		@movePiece(obj, new_left, new_top, move_speed)

	movePiece: (obj, x, y, speed = 1900) ->
	# Purpose:	Animates the passed object to the passed location.
	# Precond:	obj is a jquery object
	# Notes:	uses jquery animate with a predefined duration
	# TODO: This should be a member of a Piece class.
		obj.animate({
			'left' : x,
			'top' : y
			}, speed)		
