module HomeHelper

	def get_stats(users,todos)
		phrase = "We have #{users} users and #{todos} todos in total.".html_safe
	end
end
