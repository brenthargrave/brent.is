Time.zone = "Eastern Time (US & Canada)"

activate :dotenv

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
  activate :imageoptim do |options|
    options.manifest = true
    options.skip_missing_workers = true
  end
  activate :asset_hash do |opts|
    opts.exts += %w(.asc)
  end
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
  def author
    "Brent Hargrave"
  end
  def site_domain
    "brent.is"
  end
  def site_url
    "http://#{site_domain}"
  end
end

ignore "/tumbling.html"

page "writing/feed.xml", layout: false

