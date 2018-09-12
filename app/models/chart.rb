class Chart < ActiveRecord::Base
	belongs_to :IotDatum
	belongs_to :WorkbenchMaster
end
