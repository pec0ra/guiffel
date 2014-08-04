note
	description: "Summary description for {B_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B_VIEW

inherit
	B_CONSTANTS
	B_OBJECT

create
	make,
	make_with_menu_bar

feature {NONE} -- Initialiazation
	make
			-- Creates the view and shows the window with `a_title' as a title
		do
			initialize
			main_window.main_container.set_border_width (15)
			main_window.show
		end

	make_with_menu_bar
			-- Creates the view and shows the window with a menu bar and `a_title' as a title
		do
			main_window.add_menu
			make
		end

	initialize
			-- Initialize
		do
			main_container := main_window.main_container
		end

feature -- Access

	main_window: B_MAIN_WINDOW
			-- The main window
		once
			create Result
		end

	main_container: EV_VERTICAL_BOX
			-- Shortcut to `main_window.main_container'


feature -- Main window edition

	set_title (a_title: STRING)
			-- Set the title of the main window as `a_title'
		require
			not a_title.is_empty
		do
			main_window.set_title (a_title)
		ensure
			main_window.title = a_title
		end

	add_widget (a_widget: EV_WIDGET; a_container: EV_BOX)
			-- Add `a_widget' to `a_container'
		require
			a_widget /= Void
		do
			a_container.extend (a_widget)
			a_container.disable_item_expand (a_widget)
		ensure
			a_container.has (a_widget)
		end

	remove_widget (a_widget: EV_WIDGET; a_container: EV_BOX)
			-- Remove widget from `a_container'
		do
			a_container.prune (a_widget)
		ensure
			not a_container.has (a_widget)
		end

	new_text (a_text: STRING; a_container: detachable EV_BOX): EV_LABEL
			-- Return a text field containing `a_text'
			-- Add it to `a_container' if not Void
		do
			create Result.make_with_text (a_text)

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	add_text (a_text: STRING; a_container: EV_BOX)
			-- add a text field containing `a_text' to `a_container'
		require
			a_container /= Void
			a_text /= Void and then not a_text.is_empty
		local
			text: EV_LABEL
		do
			create text.make_with_text (a_text)
			add_widget (text, a_container)
		end

	new_text_input (a_container: detachable EV_BOX): EV_TEXT_FIELD
			-- Return a text input
			-- Add it to `a_container' if not Void
		do
			create Result
			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end

		end

	new_integer_input (a_min, a_max: INTEGER; a_container: detachable EV_BOX): EV_SPIN_BUTTON
			-- Return an integer input with range from `a_min' to `a_max'
			-- Add it to `a_container' if not Void
		require
			a_min <= a_max
		do
			create Result.make_with_value_range (create {INTEGER_INTERVAL}.make (a_min, a_max))

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end

		end

	new_button (a_text: STRING; actions: TUPLE; a_container: detachable EV_BOX): EV_BUTTON
			-- Return a button with `a_text', assign each action from `actions' as click action to it
			-- Add it to `a_container' if not Void
		local
			i: INTEGER
		do
			create Result.make_with_text (a_text)

			from
				i := 1
			until
				i > actions.count
			loop
				if attached {PROCEDURE [ANY, TUPLE]} actions.item (i) as action then
					Result.select_actions.extend (action)
				end
				i := i + 1
			end

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	new_radio (a_text: STRING; actions: TUPLE; a_container: detachable EV_BOX): EV_RADIO_BUTTON
			-- Return a radio button with `a_text' as label, assign each action from `actions' as selec action to it
			-- Add it to `a_container' if not Void
		local
			i: INTEGER
		do
			create Result.make_with_text (a_text)

			from
				i := 1
			until
				i > actions.count
			loop
				if attached {PROCEDURE [ANY, TUPLE [EV_RADIO_BUTTON]]} actions.item (i) as action then
					Result.select_actions.extend (agent action.call ([Result]))
				elseif attached {PROCEDURE [ANY, TUPLE]} actions.item (i) as action then
					Result.select_actions.extend (action)
				end
				i := i + 1
			end

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	new_checkbox_list (texts: TUPLE; a_container: detachable EV_BOX): B_CHECKABLE_LIST
			-- Return a checkbox list with one button for each element of `texts'
			-- Add it to `a_container' if not Void
		do
			create Result.make_from_tuple (texts)

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	new_combo_list (texts: TUPLE; a_container: detachable EV_BOX): EV_COMBO_BOX
			-- Return a choosing list with one item for each element of `texts'
			-- Add it to `a_container' if not Void
		local
			text_array: ARRAY [STRING]
			i: INTEGER
		do
			create text_array.make_empty
			from
				i := 1
			until
				i > texts.count
			loop
				if attached {STRING} texts.item (i) as text then
					text_array.force (text, i)
				end
				i := i + 1
			end
			create Result.make_with_strings (text_array)

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end


	new_picture (a_path: STRING; a_width, a_height: INTEGER; a_container: detachable EV_BOX): EV_PIXMAP
			-- Return a text field containing `a_text'
			-- Set width and height as `width' and `height' if they are not -1
			-- Add it to `a_container' if not Void
		require
			a_path /= Void and then not a_path.is_empty
			a_width >= 1 or a_width = -1
			a_height >= 1 or a_width = -1
		do
			create Result
			Result.set_with_named_file (a_path)

			if a_width /= -1 and a_height /= -1 then
				Result.stretch (a_width, a_height)
			end

			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	new_path_input (a_container: detachable EV_BOX): TUPLE [path_field: EV_TEXT_FIELD; browse_button: EV_BUTTON]
			-- Return a tuple from a text fiel which shows the path and a button which let choose a path
			-- Add it to `a_container' if not Void
		local
			path_field: EV_TEXT_FIELD
			browse_button: EV_BUTTON
			box: EV_HORIZONTAL_BOX
		do
			create path_field.default_create
			create browse_button.make_with_text_and_action (Button_browse_item, agent browse (path_field))

			box := new_horizontal_box (a_container, [path_field, browse_button])

			Result := [path_field, browse_button]
		end

	new_vertical_box (a_container: detachable EV_BOX; a_widget_tuple: TUPLE): EV_VERTICAL_BOX
			-- Return a vertical box, add each widget from a_widget_tuple in it
			-- Add it to `a_container' if not Void
		local
			i: INTEGER
		do
			create Result
			from
				i := 1
			until
				i > a_widget_tuple.count
			loop
				if attached {EV_WIDGET} a_widget_tuple.item (i) as widget then
					add_widget (widget, Result)
				end
				i := i + 1
			end
			Result.set_padding (10)
			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end
		end

	new_horizontal_box (a_container: detachable EV_BOX; a_widget_tuple: TUPLE): EV_HORIZONTAL_BOX
			-- Return a horizontal box, add each widget from a_widget_tuple in it
			-- Add it to `a_container' if not Void
		local
			i: INTEGER
		do
			create Result
			from
				i := 1
			until
				i > a_widget_tuple.count
			loop
				if attached {EV_WIDGET} a_widget_tuple.item (i) as widget then
					Result.extend (widget)
				end
				i := i + 1
			end
			Result.set_padding (10)
			if attached {EV_BOX} a_container as c then
				add_widget (Result, c)
			end

		ensure
			main_window.main_container.has (Result)
		end

	empty_cell (a_height: INTEGER): EV_CELL
			-- Return an empty cell with height of `a_height'
		require
			a_height >= 0
		do
			create Result
			Result.set_minimum_height (a_height)
		end

	add_empty_cell (a_container: EV_BOX; a_height: INTEGER)
			-- Add an empty cell with with height of `a_height'
		require
			a_height >= 0
		do
			add_widget (empty_cell(a_height), a_container)
		end



feature -- Modal operation

	confirm (text: STRING): BOOLEAN
			-- Ask the user to confirm `text'
		local
			modal: EV_CONFIRMATION_DIALOG
		do
			create modal.make_with_text (text)
			modal.show_modal_to_window (main_window)
			if modal.selected_button /= Void and then modal.selected_button ~ (create {EV_DIALOG_CONSTANTS}).ev_ok then
				Result := True
			else
				Result := False
			end
		end

	alert (a_text: STRING)
			-- Shows a modal with `a_text'
		local
			modal: B_MESSAGE_DIALOG
		do
			create modal.make_with_text (a_text)
			modal.show_modal_to_window (main_window)
		end

	request_bounded_value (text: STRING; min: INTEGER; max: INTEGER): INTEGER
			-- Ask the user to enter a value between `min' and `max' with a print of the form ' `text' '
		local
			modal: B_INTEGER_INPUT_DIALOG
		do
			create modal.make_with_text (text)
			modal.int_field.value_range.adapt (create {INTEGER_INTERVAL}.make (min, max))
			modal.show_modal_to_window (main_window)
			if modal.selected_button ~ "Ok" then
				if attached {INTEGER} modal.int_field.value as user_input then
					Result := user_input
				else
					Result := request_bounded_value (text, min, max)
				end
			end
		end

	request_text (a_text: STRING; a_capacity: INTEGER): STRING
			-- Ask the user to enter a string of max length `a_capacity' showing him `text'.
			-- Returns empty string if canceled
		local
			modal: B_STRING_INPUT_DIALOG
		do
			create modal.make_with_text (a_text)
			modal.text_field.set_capacity (a_capacity)
			modal.set_title ("Enter value")
			modal.show_modal_to_window (main_window)
			if modal.selected_button ~ "Ok" then
				Result := modal.text_field.text
			else
				Result := ""
			end
		end

	request_string_from_list (a_text: STRING; a_list: TUPLE[]): STRING
			-- Ask the user to select one of the string of `a_list' showing him `text'.
			-- Returns empty string if canceled
		local
			modal: B_INPUT_DIALOG
			list: EV_COMBO_BOX
		do
			create modal.make_with_text (a_text)
			modal.set_title ("Choose value")
			list := new_combo_list (a_list, Void)
			modal.input_box.extend (list)
			modal.show_modal_to_window (main_window)
			if modal.selected_button ~ "Ok" then
				Result := list.selected_item.text
			else
				Result := ""
			end
		end

	force_request_text (a_text: STRING; a_capacity: INTEGER): STRING
			-- Force the user to enter a string of max length `a_capacity' showing him `text'
		local
			modal: B_STRING_INPUT_DIALOG
		do
			create modal.make_with_text (a_text)
			modal.text_field.set_capacity (a_capacity)
			modal.set_title ("Enter value")
			modal.cancel_button.hide
			modal.show_modal_to_window (main_window)
			if modal.selected_button ~ "Ok" then
				if modal.text_field.text.is_empty then
					Result := force_request_text (a_text, a_capacity)
				else
					Result := modal.text_field.text
				end
			else
				Result := force_request_text (a_text, a_capacity)
			end
		end

feature -- Implementation

	browse (a_text_field: EV_TEXT_FIELD)
			-- Open a modal and let the user select a folder
		require
			a_text_field /= Void
		local
			path: STRING
			modal: EV_DIRECTORY_DIALOG
		do
			create modal.make_with_title ("Select folder")
			modal.show_modal_to_window (main_window)
			if modal.selected_button_name ~ Button_ok_item then
				a_text_field.set_text (modal.path.out)
			end
		end
end
