class PerformanceController < ApplicationController

  def index
    @company = current_user.companies.find(params[:company_id])
    @period = DateTime.current
    @period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i) if params[:period]
    @performance = Performance.new(@company.id, @period)
  end

  def charts
    @company = current_user.companies.find(params[:company_id])
    @period = Date.civil(-1.year.from_now.year, 3.to_i, 25.to_i)
    @period = Date.civil(params[:period][:year].to_i, 3.to_i, 25.to_i) if params[:period]
    @period2 = Date.civil(DateTime.current.year, 3.to_i, 25.to_i)
    @period2 = Date.civil(params[:period2][:year].to_i, 3.to_i, 25.to_i) if params[:period2]

#    logger.debug '-'*20
#    logger.debug @period.inspect
#
#    logger.debug '-'*20
#    logger.debug @period2.inspect
#    logger.debug '-'*20


    @performances = @company.performances(@period, @period2)
#
    logger.debug '-'*50
    logger.debug @performances.map{|rec| [rec.average_number_of_staff ,  DateTime.parse( rec.period.strftime("%Y/%m/%d")).to_i*1000]}


  end
end
