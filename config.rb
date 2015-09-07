Time.zone = "Eastern Time (US & Canada)"

configure :development do
  set :debug_assets, true
  activate :livereload
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :blog do |blog|
  blog.prefix = 'writing'
  blog.layout = false
  blog.permalink = "/{title}.html"
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end

# enables
# writing/hello-world
# writing/hello-world.html
activate :directory_indexes

