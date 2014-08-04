note
	description: "Summary description for {MY_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MY_OBJECT

inherit
	B_OBJECT
		redefine
			view
		end

feature -- Access

	view: MY_VIEW  -- For a customized view
			-- The view
		once
			create Result.make_with_menu_bar
		end

end
