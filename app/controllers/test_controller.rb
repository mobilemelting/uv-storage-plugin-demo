class TestController < ApplicationController
  
  def test
    @photo = Photo.last
    
    if request.post?
      p = Photo.new
      p.photo = params[:file]
      p.title = "efwfwf ewf fwef"
      p.save!
      
      #@file = Uv::Storage::File.new(params[:file])
      #@result = @file.save
    else
      render
    end
  end
  
end
