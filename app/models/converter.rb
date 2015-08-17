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
        name = card["name"]
        puts name
        name.match(/(\[)(\d+\.?\d?)(\/)(\d\.?\d?)(\])(.+)/)
        row << $6
        row << $2
        row << $4
        json["lists"].each do |list|
          if list["id"] == card["idList"]
            row << list["name"]
          end
        end
        csv << row
      end
    end
    csv_string
  end

  def json
    JSON(@file)
  end

end


#csv_string = CSV.generate do |csv|
#  file = File.open("trello.board.json").read
#
#puts csv_string
