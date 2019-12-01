require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  index_page = Nokogiri::HTML (open(index_url))
 
  students = []
    index_page.css("div.roster-cards-container").each do |card|
     card.css(".student-card a").each do |student|
     name = student.css(".student-name").text
     location = student.css(".student-location").text
     profile_url = student.attributes["href"].value
   #binding.pry
    student_hash = {
        :name => name,
        :location => location,
        :profile_url => profile_url
       
    }
   students << student_hash
   end
   end 
   students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML (open(profile_url))
    student_hash = { }
    profile_page.css(".social-icon-container a").each do |profile|
     link = profile.attributes["href"].value
     if link.include?("twitter")
       student_hash[:twitter] = link
       elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else 
        student_hash[:blog] = link
       
  
     
     #blog 
     #profile
     #bio
      
    end
  end
   student_hash[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student_hash[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

  
  
  
  student_hash
 end
end

