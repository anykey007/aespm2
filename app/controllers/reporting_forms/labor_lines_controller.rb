class ReportingForms::LaborLinesController < ApplicationController
    before_filter :authenticate_admin
  # GET /reporting_forms/labor_lines
  # GET /reporting_forms/labor_lines.json
  def index
    @lines = ReportingForms::LaborLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /reporting_forms/labor_lines/1
  # GET /reporting_forms/labor_lines/1.json
  def show
    @line = ReportingForms::LaborLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/labor_lines/new
  # GET /reporting_forms/labor_lines/new.json
  def new
    @line = ReportingForms::LaborLine.new
    @lines =[]
    @lines =  ReportingForms::LaborLine.without_line(0)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/labor_lines/1/edit
  def edit
    @line = ReportingForms::LaborLine.find(params[:id])
    @lines =  ReportingForms::LaborLine.without_line(params[:id])
  end

  # POST /reporting_forms/labor_lines
  # POST /reporting_forms/labor_lines.json
  def create
    @line = ReportingForms::LaborLine.new(params[:reporting_forms_labor_line])

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Labor line was successfully created.' }
        format.json { render json: @line, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reporting_forms/labor_lines/1
  # PUT /reporting_forms/labor_lines/1.json
  def update
    @line = ReportingForms::LaborLine.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:reporting_forms_labor_line])
        format.html { redirect_to @line, notice: 'Labor line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporting_forms/labor_lines/1
  # DELETE /reporting_forms/labor_lines/1.json
  def destroy
    @line = ReportingForms::LaborLine.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_labor_lines_url }
      format.json { head :no_content }
    end
  end
end
