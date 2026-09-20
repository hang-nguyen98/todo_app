module TodosHelper

	def owner?(todo)
		logged_in? and current_user.id == todo.user_id
	end
end
