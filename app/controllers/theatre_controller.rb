class TheatreController < ApplicationController
  def map
      @theatre = Theatre.find_by webname: params[:webname]
  end
end
