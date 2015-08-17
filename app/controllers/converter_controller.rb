class ConverterController < ApplicationController

  def index
  end

  def upload
    converter = Converter.new(params[:file])
    csv = converter.convert
    send_data csv, type: "text/csv", filename: "trello-stories.csv"
  end


end
