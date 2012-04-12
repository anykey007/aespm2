class ReportingForms::B1LinesController < ApplicationController
  # GET /reporting_forms/b1_lines
  # GET /reporting_forms/b1_lines.json
  def index
    @lines = ReportingForms::B1Line.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /reporting_forms/b1_lines/1
  # GET /reporting_forms/b1_lines/1.json
  def show
    @line = ReportingForms::B1Line.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/b1_lines/new
  # GET /reporting_forms/b1_lines/new.json
  def new
    @line = ReportingForms::B1Line.new
    @lines =[]
    @lines = ReportingForms::B1Line.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/b1_lines/1/edit
  def edit
    @line = ReportingForms::B1Line.find(params[:id])
    @lines = ReportingForms::B1Line.without_line(params[:id])
  end

  # POST /reporting_forms/b1_lines
  # POST /reporting_forms/b1_lines.json
  def create
    @line = ReportingForms::B1Line.new(params[:reporting_forms_b1_line])

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Line was successfully created.' }
        format.json { render json: @line, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reporting_forms/b1_lines/1
  # PUT /reporting_forms/b1_lines/1.json
  def update
    @line = ReportingForms::B1Line.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:reporting_forms_b1_line])
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporting_forms/b1_lines/1
  # DELETE /reporting_forms/b1_lines/1.json
  def destroy
    @line = ReportingForms::B1Line.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_b1_lines_url }
      format.json { head :no_content }
    end
  end
end
