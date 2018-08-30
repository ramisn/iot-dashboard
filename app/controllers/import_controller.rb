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
	    if IotDatum.import(params[:file])
	    		redirect_to root_url, notice: 'Data imported.'
	    else
	    		redirect_to import_index_path, notice: 'Part Code Already Assigned for a Device'
	    end
	end
end