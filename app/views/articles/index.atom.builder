atom_feed do |feed|
  feed.title "RailsVN articles"
  feed.updated @articles.first.created_at unless @articles.empty?

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title article.title
      entry.content article.body
      entry.author do |author|
        author.name article.author.display_name
      end
    end
  end
end
