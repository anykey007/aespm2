class Reportings::BalancesController < ApplicationController
  # GET /reportings/balances
  # GET /reportings/balances.json
  def index
    @company = Company.find(params[:company_id])
    @reportings_balances = @company.balances.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportings_balances }
    end
  end

  # GET /reportings/balances/1
  # GET /reportings/balances/1.json
  def show

    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.find(params[:id])
#    @reportings_balance = Reportings::Balance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reportings_balance }
    end
  end

  # GET /reportings/balances/new
  # GET /reportings/balances/new.json
  def new
    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.new
    @lines = @reportings_balance.lines
    @line_values = []
    @lines.each do |line|
      @line_values<<@reportings_balance.values.build(:line_id=>line.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reportings_balance }
    end
  end

  # GET /reportings/balances/1/edit
  def edit
    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.find(params[:id])
    @lines = @reportings_balance.lines
    existing_line_values = @reportings_balance.values
    existing_line_ids = existing_line_values.map {|rec| rec.line_id}
    @line_values = existing_line_values
    @lines.each do |line|
      if !existing_line_ids.include?(line.id)
         @line_values<<@reportings_balance.values.build(:line_id=>line.id)
      end
    end
  end

  # POST /reportings/balances
  # POST /reportings/balances.json
  def create
    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.new(params[:reportings_balance])
    @reportings_balance.period = Date.civil(params[:reportings_balance][:period][:year].to_i, params[:reportings_balance][:period][:month].to_i, params[:reportings_balance][:period][:day].to_i)
    respond_to do |format|
      if @reportings_balance.save && @reportings_balance.update_parent_in_values && @reportings_balance.update_total_values
        format.html { redirect_to company_reportings_balance_path(params[:company_id],@reportings_balance), notice: 'Balance was successfully created.' }
        format.json { render json: @reportings_balance, status: :created, location: @reportings_balance }
      else
        format.html { render action: "new" }
        format.json { render json: @reportings_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportings/balances/1
  # PUT /reportings/balances/1.json
  def update
    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.find(params[:id])
    @reportings_balance.period = Date.civil(params[:reportings_balance][:period][:year].to_i, params[:reportings_balance][:period][:month].to_i, params[:reportings_balance][:period][:day].to_i)
    params[:reportings_balance][:period]=@reportings_balance.period
    respond_to do |format|
      if @reportings_balance.update_attributes(params[:reportings_balance]) && @reportings_balance.update_parent_in_values && @reportings_balance.update_total_values
        format.html { redirect_to company_reportings_balance_path(params[:company_id],@reportings_balance), notice: 'Balance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reportings_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportings/balances/1
  # DELETE /reportings/balances/1.json
  def destroy
    @company = Company.find(params[:company_id])
    @reportings_balance = @company.balances.find(params[:id])
    @reportings_balance.destroy

    respond_to do |format|
      format.html { redirect_to company_reportings_balances_url }
      format.json { head :no_content }
    end
  end
end
