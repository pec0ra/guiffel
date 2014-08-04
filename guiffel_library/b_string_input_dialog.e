note
	description: "Summary description for {B_STRING_INPUT_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B_STRING_INPUT_DIALOG

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
				create text_field
		end

	user_initialization
			-- Perform any initialization on objects created by `user_create_interface_objects'
			-- and from within current class itself.
		do
				input_box.extend (text_field)
		end

feature -- Access

	text_field: EV_TEXT_FIELD

end
