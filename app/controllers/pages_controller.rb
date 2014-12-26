class PagesController < ApplicationController
  def home
    selected_date = Time.new(params[:year],params[:month],params[:day]).to_date
    7.times do
      @rates = Rate.where(date: selected_date)
      break if @rates.any?
      selected_date -= 1.day
    end

  end
end
