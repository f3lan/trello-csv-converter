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
        name = card["name"]
        puts name
        name.match(/(\[)(\d+\.?\d?)(\/)(\d?\.?\d?-?)(\])(.+)/)
        puts $6
        puts $2
        puts $4
        row << $6.strip
        row << $2.strip
        row << $4.strip
        json["lists"].each do |list|
          if list["id"] == card["idList"]
            list_name = list["name"]
            puts list_name
          end
        end
        if list_name != "Impendence" || list_name != "Technical Debts"
          row << list_name
          csv << row
        end
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
