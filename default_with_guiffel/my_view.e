note
	description: "Summary description for {MY_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_VIEW

inherit
	B_VIEW
		redefine
			make,
			make_with_menu_bar
		end

create
	make,
	make_with_menu_bar

feature {NONE} -- Initialization

	make
			-- <precursor>
		do
			precursor

			-- Default size is in class B_CONSTANTS, you can resize the main window manually.
			main_window.set_size (default_window_height, default_window_width)

		end

	make_with_menu_bar
			-- <precursor>
		do
			precursor

			-- Give an action to the menu
			main_window.new_menu.select_actions.extend (agent alert ("%"New%" menu action"))
		end

feature -- Access



feature {NONE} -- Implementation



end
