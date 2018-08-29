class Tracker < ActiveRecord::Base
	belongs_to :IotDatum
	belongs_to :charts
end
