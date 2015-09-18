class SitemapsController < ApplicationController
  def sitemap
    redirect_to "https://s3.amazonaws.com/#{ ENV['AWS_BUCKET'] }/sitemaps/sitemap.xml.gz"
  end
end