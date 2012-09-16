#encoding: utf-8
class Reportings::TanimotosController < ApplicationController
  # GET /reportings/tanimotos
  # GET /reportings/tanimotos.json
  def tanimotos_by_company
    @company = current_user.companies.find(params[:other_company_id])    
    @reportings_tanimotos = @company.tanimotos rescue []
  end

  def compare
    @company = current_user.companies.find(params[:company_id])
    @other_companies = current_user.companies
    @other_companies = @other_companies - [@company]
    @report = @company.tanimotos.find(params[:id])
    @reportings_tanimotos = @other_companies.first.tanimotos

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  def show_compared
    @company = current_user.companies.find(params[:company_id])
    @other_company = current_user.companies.find(params[:compare][:company_id])
    @report = @company.tanimotos.find(params[:id])
    @other_report = @other_company.tanimotos.find(params[:compare][:report_id])
    @k = @report.compare_tanimoto(@other_report)

    respond_to do |format|
      format.html { redirect_to compare_company_reportings_tanimoto_path(params[:company_id],@report), notice: "Коефіцієнт = #{@k}" }
      format.json { render json: @report }
    end
  end

  def index
    @company = current_user.companies.find(params[:company_id])
    @reportings_tanimotos = @company.tanimotos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportings_tanimotos }
    end
  end

  # GET /reportings/tanimotos/1
  # GET /reportings/tanimotos/1.json
  def show
    @company = current_user.companies.find(params[:company_id])
    @report = @company.tanimotos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reportings/tanimotos/new
  # GET /reportings/tanimotos/new.json
  def new
    @company = current_user.companies.find(params[:company_id])
    @report = @company.tanimotos.new
    @report.period = DateTime.current
    @lines = @report.lines

    @line_values = []
    @lines.each do |line|
      @line_values<<@report.values.build(:line_id=>line.id)
    end
    logger.debug '-'*80
    logger.debug @line_values.inspect
    logger.debug '-'*80
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reportings/tanimotos/1/edit
  def edit
    @company = current_user.companies.find(params[:company_id])
    @report = @company.tanimotos.find(params[:id])
    @lines = @report.lines
    existing_line_values = @report.values
    existing_line_ids = existing_line_values.map {|rec| rec.line_id}
    @line_values = existing_line_values
    @lines.each do |line|
      if !existing_line_ids.include?(line.id)
         @line_values<<@report.values.build(:line_id=>line.id)
      end
    end
  end

  # POST /reportings/tanimotos
  # POST /reportings/tanimotos.json
  def create
    @company = current_user.companies.find(params[:company_id])
    @report = @company.tanimotos.new(params[:reportings_tanimoto])
    @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
    respond_to do |format|
      if @report.valid? &&  @report.save
        format.html { redirect_to company_reportings_tanimoto_path(params[:company_id],@report), notice: 'Plan was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportings/tanimotos/1
  # PUT /reportings/tanimotos/1.json
  def update
    @company = current_user.companies.find(params[:company_id])
    @report = @company.tanimotos.find(params[:id])
    @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
    params[:reportings_tanimoto][:period]=@report.period
    respond_to do |format|
      if @report.valid? && @report.update_attributes(params[:reportings_tanimoto])
        format.html { redirect_to company_reportings_tanimoto_path(params[:company_id],@report), notice: 'Tanimoto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportings/tanimotos/1
  # DELETE /reportings/tanimotos/1.json
  def destroy
    @reportings_tanimoto = Reportings::Tanimoto.find(params[:id])
    @reportings_tanimoto.destroy

    respond_to do |format|
      format.html { redirect_to reportings_tanimotos_url }
      format.json { head :no_content }
    end
  end
end
