module FriendlyUrlHelper

  def friendly_article_path(article, options = {})
    "#{root_path}#{friendly_article_relative_path(article, options)}"
  end

  def friendly_article_url(article, options = {})
    "#{root_url}#{friendly_article_relative_path(article, options)}"
  end

  private
  def friendly_article_relative_path(article, options = {})
    path = "#{article.created_at.year}/#{article.created_at.month}/#{article.cached_slug}"
    path = "#{path}\##{options[:anchor]}" if options[:anchor].present? 

    path
  end
end
