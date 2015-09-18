SitemapGenerator::Sitemap.default_host = "http://mizikjams.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.public_path = 'public/sitemaps/'
SitemapGenerator::Sitemap.create do
  add '/'
  add '/browse'
  
    Video.find_each do |video|
        add video_path(video), lastmod: video.updated_at
  end
end
SitemapGenerator::Sitemap.ping_search_engines