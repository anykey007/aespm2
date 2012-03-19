class PerformanceController < ApplicationController

  def index
    @company = current_user.companies.find(params[:company_id])
    @period = DateTime.current
    @period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i) if params[:period]
    @performance = Performance.new(@company.id,@period)
  end
end
