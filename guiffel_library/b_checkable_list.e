note
	description: "Summary description for {B_CHECKEBLE_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B_CHECKABLE_LIST

inherit

	EV_VERTICAL_BOX

	B_OBJECT
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make_from_string_array,
	make_from_tuple

feature {NONE} -- Initialization

	make_from_string_array (a_string_array: ARRAY [STRING])
			-- Create one check button for each element of `a_string_array'
		require
			a_string_array.count > 0
		local
			check_button: EV_CHECK_BUTTON
		do
			default_create
			create check_buttons.make (a_string_array.count)
			create selected_buttons.make (0)
			across
				a_string_array as label
			loop
				create check_button.make_with_text ( label.item )
				add_check_button (label.item, check_button)
			end
		end

	make_from_tuple (a_string_tuple: TUPLE)
			-- Create one check button for each element of `a_string_tuple'
		require
			a_string_tuple.count > 0
		local
			text_array: ARRAY [STRING]
			i: INTEGER
		do
			create text_array.make_empty
			from
				i := 1
			until
				i > a_string_tuple.count
			loop
				if attached {STRING} a_string_tuple.item (i) as text then
					text_array.force (text, i)
				end
				i := i + 1
			end
			make_from_string_array (text_array)
		end


feature -- Access

	button (a_key:STRING): EV_CHECK_BUTTON
			-- Return the button stored with `a_key' as text
		require
			not a_key.is_empty
		do
			if attached {EV_CHECK_BUTTON} check_buttons.item (a_key) as check_button then
				Result := check_button
			end
		end

	check_buttons: HASH_TABLE [EV_CHECK_BUTTON, STRING]
			-- The button mapped to a key

	selected_buttons: ARRAYED_LIST [STRING]
			-- The selected buttons

feature -- Basic operations

	add_check_button (a_key: STRING; a_check_button: EV_CHECK_BUTTON)
			-- add a check button to the list
		require
			not a_key.is_empty
			a_check_button /= Void
		do
			a_check_button.select_actions.extend (agent on_checked (a_check_button))
			check_buttons.force (a_check_button, a_key)
			extend (a_check_button)
		end

feature {NONE} -- Implementation

	on_checked (a_button: EV_CHECK_BUTTON)
			-- When a button is checked
		require
			a_button /= Void
			check_buttons.has_item (a_button)
		do
			from
				check_buttons.start
			until
				check_buttons.after
			loop
				if check_buttons.item_for_iteration = a_button then
					selected_buttons.extend (check_buttons.key_for_iteration)
					check_buttons.item_for_iteration.select_actions.wipe_out
					check_buttons.item_for_iteration.select_actions.extend (agent on_unchecked (check_buttons.item_for_iteration))
				end
				check_buttons.forth
			end
		end

	on_unchecked (a_button: EV_CHECK_BUTTON)
			-- When a button is unchecked
		require
			a_button /= Void
			check_buttons.has_item (a_button)
		do
			from
				check_buttons.start
			until
				check_buttons.after
			loop
				if check_buttons.item_for_iteration = a_button then
					selected_buttons.prune_all (check_buttons.key_for_iteration)
					check_buttons.item_for_iteration.select_actions.wipe_out
					check_buttons.item_for_iteration.select_actions.extend (agent on_checked (check_buttons.item_for_iteration))
				end
				check_buttons.forth
			end

		end
end
