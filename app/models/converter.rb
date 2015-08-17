require 'csv'
require 'json'

class Converter < ActiveRecord::Base

  def initialize(file)
    @file = file.open.read
  end

  def convert
    convert_csv
  end

  private

  def convert_csv
    csv_string = CSV.generate do |csv|
      csv << ["Story Name", "Est. Time", "Used Time", "List Name"]
      json["cards"].each do |card|

        row = []
        list_name = ""

        json["lists"].each do |list|
          if list["id"] == card["idList"]
            list_name = list["name"]
          end
        end

        name = card["name"]
        name.match(/(\[?)(\d*\.?\d*)(\/?)(\d*\.?\d*-?)(\]?)(.+)/)
        row << $6.strip
        row << $2.strip
        row << $4.strip
        row << list_name

        csv << row

      end
    end
    csv_string
  end

  def json
    JSON(@file)
  end

end
