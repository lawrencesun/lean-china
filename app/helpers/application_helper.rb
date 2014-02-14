module ApplicationHelper
	def display_date(dt)
		dt.strftime("%d/%m/%Y") 
	end

	def markdown(text)
		renderOptions = {hard_wrap: true, filter_html: true}
    markdownOptions = {autolink: true, fenced_code_blocks: true, no_intra_emphasis: true, strikethrough: true}
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderOptions), markdownOptions)
    markdown.render(text).html_safe
	end
end
