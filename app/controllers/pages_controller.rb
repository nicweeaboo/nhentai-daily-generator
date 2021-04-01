require 'open-uri'
class PagesController < ApplicationController
  def home
    @doujinshi = Doujinshi.new(Time.now.strftime("%m%d%y").to_i)
    if @doujinshi.client.code == '200'
      unless File.exists?("public/covers/#{@doujinshi.id}.png")
        open("public/covers/#{@doujinshi.id}.jpg", 'wb') {|file| file << open(@doujinshi.cover).read}
      end
 

    end

    
    
  end
end
