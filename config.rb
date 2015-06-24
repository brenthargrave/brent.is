
configure :development do
  set :debug_assets, true
  activate :livereload
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'


# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  # Enable cache buster
  activate :asset_hash do |opts|
    opts.exts += %w(.ico)
  end
end

