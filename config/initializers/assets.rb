#ActionController::Base.asset_path = Proc.new { |source|
#  case source
#  when /\.css$/
#    source.gsub('stylesheets', 'stylesheets/compiled')
#  else
#    source
#  end
#}
