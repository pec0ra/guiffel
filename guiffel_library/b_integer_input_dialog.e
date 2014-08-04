note
	description: "A modal with an integer field"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B_INTEGER_INPUT_DIALOG

inherit
	B_INPUT_DIALOG
		redefine
			user_create_interface_objects,
			user_initialization
		end

create
	make_with_text


feature {NONE} -- Initialization

	user_create_interface_objects
			-- Create any auxilliary objects needed for INPUT_DIALOG.
			-- Initialization for these objects must be performed in `user_initialization'.
		do
				create int_field
		end

	user_initialization
			-- Perform any initialization on objects created by `user_create_interface_objects'
			-- and from within current class itself.
		do
				input_box.extend (int_field)
		end

feature -- Access

	int_field: EV_SPIN_BUTTON

end
