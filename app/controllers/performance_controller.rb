#encoding: utf-8
class PerformanceController < ApplicationController

  def index
    @company = current_user.companies.find(params[:company_id])
    @period = DateTime.current
    @period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i) if params[:period]
    @performance = Performance.new(@company.id, @period)
  end

  def charts
    @company = current_user.companies.find(params[:company_id])
    @kvartal1 = 1
    @kvartal1 = params[:kvartal1].to_i
    @period = Date.civil(-1.year.from_now.year, 3.to_i, 25.to_i)
    @period = Date.civil(params[:period][:year].to_i, @kvartal1*3, 25.to_i) if params[:period]
    @kvartal2 = 1
    @kvartal2 = params[:kvartal2].to_i
    @period2 = Date.civil(DateTime.current.year, 3.to_i, 25.to_i)
    @period2 = Date.civil(params[:period2][:year].to_i, @kvartal2*3, 25.to_i) if params[:period2]

    @performances = @company.performances(@period, @period2)  if params[:period] && params[:period2]
    @x_axis = x_axis(@period, @period2) if params[:period] && params[:period2]
  end

  def x_axis(start_period, end_period)
    x_list = []
    while start_period <= end_period
      kvartal = "рік, #{start_period.month.to_i/3} квартал".to_s
      x_list<<(start_period.year.to_s+kvartal)
      start_period+=3.month
    end
    x_list
  end
end

