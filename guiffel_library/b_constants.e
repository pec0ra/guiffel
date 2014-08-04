note
	description: "Summary description for {B_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	B_CONSTANTS


feature -- Main window constants

	Default_window_width: INTEGER = 600
			-- Default width for the main window

	Default_window_height: INTEGER = 500
			-- Default height for the main window

	Default_window_title: STRING = "Default title, use view.set_window_title to change it"
			-- Title of the window.

	Char_per_line: INTEGER = 15
			-- Number of character per line in the dialogs

feature -- Interface names

	feature -- Access

	Button_ok_item: STRING = "OK"
			-- String for "OK" buttons.

	Button_browse_item: STRING = "Browse"
			-- String for "Browse" buttons

	Menu_file_item: STRING = "&File"
			-- String for menu "File"

	Menu_file_new_item: STRING = "&New%TCtrl+N"
			-- String for menu "File/New"

	Menu_file_open_item: STRING = "&Open...%TCtrl+O"
			-- String for menu "File/Open"

	Menu_file_save_item: STRING = "&Save%TCtrl+S"
			-- String for menu "File/Save"

	Menu_file_saveas_item: STRING = "Save &As..."
			-- String for menu "File/Save As"

	Menu_file_close_item: STRING = "&Close"
			-- String for menu "File/Close"

	Menu_file_exit_item: STRING = "E&xit"
			-- String for menu "File/Exit"

	Menu_help_item: STRING = "&Help"
			-- String for menu "Help"

	Menu_help_contents_item: STRING = "&Contents and Index"
			-- String for menu "Help/Contents and Index"

	Menu_help_about_item: STRING = "&About..."
			-- String for menu "Help/About"

	Label_confirm_close_window: STRING = "You are about to close this window.%NClick OK to proceed."
			-- String for the confirmation dialog box that appears
			-- when the user try to close the first window.

end
