module ApplicationHelper
#  def page_title=(value)
#    @page_title_content = value
#    p @page_title_content
#  end
  
  def page_title(value = false)
    @page_title_content = value if value != false
    @page_title_content || 'Welcome to RailsVN'
  end
end
