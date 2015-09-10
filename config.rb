Time.zone = "Eastern Time (US & Canada)"

configure :development do
  set :debug_assets, true
  activate :livereload
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'

activate :blog do |blog|
  blog.prefix = 'writing'
  blog.layout = 'writing'
  "/{title}.html".tap do |format|
    blog.sources = format
    blog.permalink = format
  end
end

activate :inliner
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :gzip
  activate :minify_html
  activate :imageoptim
  activate :asset_hash
  activate :relative_assets
end

# enables
# writing/hello-world
# writing/hello-world.html
activate :directory_indexes

helpers do
  def without_year date
    date.strftime('%b %e')
  end
  def with_year date
    date.strftime('%b %e %Y')
  end
end

ignore "/tumbling.html"

