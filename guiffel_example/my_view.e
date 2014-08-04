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
			make
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
			main_window.set_size (600, 700)

			-- You can access the menu items
			main_window.new_menu.select_actions.extend (agent alert ("You clicked on the %"New%" menu"))


			main_text_field := new_text ("Thank you for using Guiffel. %NThis text has been added from MY_VIEW and is accessible as main_text_field.", main_container)

			add_empty_cell (main_container, 20)

			some_checkbox_list := new_checkbox_list (["One", "Two", "Three"], Void) -- If you don't want the widget to be automatically added pass Void as container

			some_checkbox_list.check_buttons.item ("Two").select_actions.extend (agent alert("You selected Two"))

			button_container := new_horizontal_box (main_container, [
				some_checkbox_list,
				new_vertical_box (Void, [
					new_button ("Button 1", [agent on_button_1_click], Void),
					new_button ("Button 2", [agent alert("The first action of button 2"), agent alert("The second action of button 2")], Void)
				])
			])

			add_empty_cell (main_container, 20)
			my_combo_list := new_combo_list (["Element 1", "Element 2", "Element 3"], main_container)

			my_combo_list.select_actions.extend (agent on_combo_change)
		end

feature -- Access

	main_text_field: EV_LABEL
			-- Some text field

	some_checkbox_list: B_CHECKABLE_LIST

	button_container: EV_HORIZONTAL_BOX
			-- Some button container

	my_combo_list: EV_COMBO_BOX
			-- Some combo box

feature {NONE} -- Implementation

	on_button_1_click
			-- When the button 1 is clicked
		local
			s: STRING
			first: BOOLEAN
		do
			first := True
			if some_checkbox_list.selected_buttons.count /= 0 then
				s := "You selected :%N"
				across
					some_checkbox_list.selected_buttons as selected
				loop
					if first then
						s := s + selected.item
						first := False
					else
						s := s + ", " + selected.item
					end
				end
			else
				s := "No item is selected"
			end
			alert (s)
		end

	on_combo_change
			-- When the combo is changed
		do
			alert ("This is the action when you select " + my_combo_list.selected_item.text)
		end

end
