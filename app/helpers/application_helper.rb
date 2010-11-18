module ApplicationHelper
  def page_title(value = false)
    @page_title_content = value if value != false
    @page_title_content || 'Welcome to RailsVN'
  end

  def code_syntax(html)
    html.gsub(/<pre><code lang="(.*?)">(.*?)<\/code><\/pre>/m) do |a|
      lang = $1
      code = CGI.unescapeHTML($2)
      CodeRay.scan(code, :ruby).div(:css => :class)
    end
  end
end
