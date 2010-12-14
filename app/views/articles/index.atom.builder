atom_feed do |feed|
  feed.title "RailsVN articles"
  feed.updated @articles.first.created_at unless @articles.empty?

  @articles.each do |article|
    feed.entry(article, :url => friendly_article_path(article)) do |entry|
      entry.title article.title
      entry.content render_article(article), :type => 'html'
      entry.author do |author|
        author.name article.author.display_name
      end
    end
  end
end
