# encoding: utf-8
class Reportings::B1sController < ApplicationController
  # GET /reportings/b1s
  # GET /reportings/b1s.json
  def index
    @company = current_user.companies.find(params[:company_id])
    @reportings = @company.b1s.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportings }
    end
  end

  # GET /reportings/b1s/1
  # GET /reportings/b1s/1.json
  def show
     @company = current_user.companies.find(params[:company_id])
    @report = @company.b1s.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end

  end

  # GET /reportings/b1s/new
  # GET /reportings/b1s/new.json
  def new
    @company = current_user.companies.find(params[:company_id])
    @report = @company.b1s.new
    @report.period = DateTime.current
    @part1_lines = @report.part1_lines
    @part2_lines = @report.part2_lines
    @part1_line_values = []
    @part2_line_values = []
    @part1_lines.each do |line|
      @part1_line_values<<@report.values.build(:line_id=>line.id)
    end
    @part2_lines.each do |line|
      @part2_line_values<<@report.values.build(:line_id=>line.id)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reportings/b1s/1/edit
  def edit
    @company = current_user.companies.find(params[:company_id])
    @report = @company.b1s.find(params[:id])
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

  # POST /reportings/b1s
  # POST /reportings/b1s.json
  def create

     @company = current_user.companies.find(params[:company_id])
    @report = @company.b1s.new(params[:reportings_b1])
    @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
    respond_to do |format|
      if @report.valid? && @report.save_and_update_parents
        format.html { redirect_to company_reportings_b1_path(params[:company_id], @report), notice: 'B1 was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportings/b1s/1
  # PUT /reportings/b1s/1.json
  def update
    @reportings_b1 = Reportings::B1.find(params[:id])

    respond_to do |format|
      if @reportings_b1.update_attributes(params[:reportings_b1])
        format.html { redirect_to @reportings_b1, notice: 'B1 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reportings_b1.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportings/b1s/1
  # DELETE /reportings/b1s/1.json
  def destroy
    @reportings_b1 = Reportings::B1.find(params[:id])
    @reportings_b1.destroy

    respond_to do |format|
      format.html { redirect_to reportings_b1s_url }
      format.json { head :no_content }
    end
  end
end
