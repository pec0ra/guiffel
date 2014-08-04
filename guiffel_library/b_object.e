note
	description: "Summary description for {B_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	B_OBJECT

inherit
	B_CONSTANTS

	ANY


feature -- Access

	view: B_VIEW
			-- The view
		once
			create Result.make
		end
end
