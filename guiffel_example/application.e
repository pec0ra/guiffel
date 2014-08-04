note
	description	: "Root class for this application."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date: 2013/12/19 16:45:40 $"
	revision	: "1.0.0"

class
	APPLICATION

inherit
	EV_APPLICATION

	MY_OBJECT
		undefine
			default_create,
			copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			default_create
			prepare
			launch
		end

	prepare
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			-- The first call to view will open the main window
			view.main_window.set_title ("Guiffel examples")

		end

feature {NONE} -- Implementation

	main_text_field: EV_LABEL

end -- class APPLICATION