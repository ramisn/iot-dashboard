class ImportController < ApplicationController

	def index
		@data = IotDatum.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @data.to_csv }
      # format.xls 
    end
	end

	def import
	    IotDatum.import(params[:file])
	    redirect_to root_url, notice: 'Data imported.'
	end
end