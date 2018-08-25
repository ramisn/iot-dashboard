require 'csv'

class Measure < ActiveRecord::Base
  belongs_to :IotDatum

	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["Workbench Number"]) || new
      product.attributes = row.to_hash
      product.save!
    end
  end 

  def self.to_csv(options = {})
    desired_columns = ["Workbench number", "Part number", "Target", "Lot Size", "Employee Name", "Employee ID", "Shift", "Device ID", "Count", "Status"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end


