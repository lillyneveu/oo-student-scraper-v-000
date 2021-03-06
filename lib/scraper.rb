require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = Nokogiri::HTML(open("./fixtures/student-site/index.html"))

    profiles_array = []

    profiles.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card").each do |i|

      profiles_hash = {
      :name => i.css("a div.card-text-container h4.student-name").text,
      :location => i.css("a div.card-text-container p.student-location").text,
      :profile_url => "./fixtures/student-site/" + i.css("a").attribute("href").text

      }
        profiles_array << profiles_hash
         end
       end
      profiles_array
    end

  def self.scrape_profile_page(profile_url)
  #  binding.pry
      info = Nokogiri::HTML(open(profile_url))


      details_hash = {}
        info.css("div.social-icon-container a").each do |link|
          url = link.attribute("href").text
            if url.match("twitter")
              details_hash[:twitter] = url
            elsif url.match("linkedin")
              details_hash[:linkedin] = url
            elsif url.match("github")
              details_hash[:github] = url
            else
              details_hash[:blog] = url
            end
          end

          details_hash[:profile_quote] = info.css("div.vitals-text-container div.profile-quote").text
          details_hash[:bio] = info.css("div.description-holder p").text

          details_hash
  end

end
