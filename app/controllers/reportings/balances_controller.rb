# encoding: utf-8
class Reportings::BalancesController < ApplicationController
#  prawnto :prawn => { :top_margin => 75 }
  respond_to :html, :xml, :json, :pdf

  # GET /reportings/balances
  # GET /reportings/balances.json
  def index
    @company = current_user.companies.find(params[:company_id])
    @reportings = @company.balances.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportings }
    end
  end

  # GET /reportings/balances/1
  # GET /reportings/balances/1.json
  def show

    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
#      format.pdf do
#        render :pdf => "assignment.pdf",
#               :layout => false
#      end
    end
  end

  def download_pdf
    output = BalancesReport.new
    output.set_rep(params[:company_id], params[:id])
    output= output.to_pdf
    send_data output, :type => 'application/pdf', :filename => "Баланс.pdf"
  end

  # GET /reportings/balances/new
  # GET /reportings/balances/new.json
  def new
    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.new
    @report.period = DateTime.current
    @lines = @report.lines
    @line_values = []
    @lines.each do |line|
      @line_values<<@report.values.build(:line_id=>line.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reportings/balances/1/edit
  def edit
    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.find(params[:id])
    @lines = @report.lines
    existing_line_values = @report.values
    existing_line_ids = existing_line_values.map { |rec| rec.line_id }
    @line_values = existing_line_values
    @lines.each do |line|
      if !existing_line_ids.include?(line.id)
        @line_values<<@report.values.build(:line_id=>line.id)
      end
    end
  end

  # POST /reportings/balances
  # POST /reportings/balances.json
  def create
    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.new(params[:reportings_balance])
    @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
    respond_to do |format|
      if @report.valid? && @report.save_and_update_parents
        format.html { redirect_to company_reportings_balance_path(params[:company_id], @report), notice: 'Balance was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportings/balances/1
  # PUT /reportings/balances/1.json
  def update
    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.find(params[:id])
    @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
    params[:reportings_balance][:period]=@report.period
    respond_to do |format|
      if @report.valid? && @report.update_attributes_and_update_parents(params[:reportings_balance])
        format.html { redirect_to company_reportings_balance_path(params[:company_id], @report), notice: 'Balance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportings/balances/1
  # DELETE /reportings/balances/1.json
  def destroy
    @company = current_user.companies.find(params[:company_id])
    @report = @company.balances.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to company_reportings_balances_url }
      format.json { head :no_content }
    end
  end
end

