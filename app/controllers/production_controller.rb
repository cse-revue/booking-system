class ProductionController < ApplicationController

  def production_params
    params.require(:production).permit(:pretitle, :title, :webname, :ticket_cc_email, :contact_email, :theatre_id)
  end

  def do_create
    prod = Production.create production_params
    redirect_to "/production/#{prod.webname}"
  end

  def create
    render layout: 'admin'
  end

  def index
    @productions = Production.all
  end
  
  def info
    @production = Production.find_by webname: params[:webname]
    render layout: 'admin'
  end

  def manage
    @production = Production.find_by webname: params[:webname]
    render layout: 'admin'
  end

  def modify
  end

  def delete
  end

  def view
  end
end
