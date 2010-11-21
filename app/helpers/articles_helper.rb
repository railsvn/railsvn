module ArticlesHelper
  def render_article(article)
    if article.source_format == 'html'
      render_html(article.body)
    elsif article.source_format == 'markdown'
      render_markdown(article.body)
    else
      render_plain(article.body)
    end
  end

  def render_plain(text)
    simple_format(auto_link(h(text)))
  end

  def render_markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end

  def render_html(text)
    text
  end
end
