require 'csv'
class IotDatum < ActiveRecord::Base

# validates_uniqueness_of :part_number
# validates :part_number, uniqueness: {scope: :workbench_number }
# validates_uniqueness_of :part_number, scope: :workbench_number, conditions: -> { where.not(status: 'Process Completed') && where.not(status: 'Processing')}
# validates :part_number, uniqueness: {scope: :status }
# validates_uniqueness_of :part_number, scope: [:device_id, :status]
	
  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["workbench_number"]) || new
      product.attributes = row.to_hash
      return false unless product.valid?
      product.save!
    end
  end 

  def self.to_csv(options = {})
    desired_columns = ["workbench_number", "part_number", "target", "lot_size", "employee_name", "employee_id", "shift", "device_id", "count", "status"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.to_csvv
    attributes = %w{dates day_name workbench shift actual target progress}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |ds|
        csv << attributes.map{ |attr| ds.send(attr) }
      end
    end
  end
end