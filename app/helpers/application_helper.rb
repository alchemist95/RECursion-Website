module ApplicationHelper

	def sortable(column, title = nil)
		title ||= column.titleize
		direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
		link_to title, :sort => column, :direction => direction
	end

	def addcustomjs(_files)
		content_for(:head_js) { javascript_include_tag(_files) }
	end

end
