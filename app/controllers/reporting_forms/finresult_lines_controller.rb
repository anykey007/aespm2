class ReportingForms::FinresultLinesController < ApplicationController
  before_filter :authenticate_admin
  def index
    @lines = ReportingForms::FinresultLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def show
    @line = ReportingForms::FinresultLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  def new
    @line = ReportingForms::FinresultLine.new
    @lines =[]
    @lines =  ReportingForms::FinresultLine.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  def edit
    @line = ReportingForms::FinresultLine.find(params[:id])
    @lines =  ReportingForms::FinresultLine.without_line(params[:id])
  end

  def create
    @line = ReportingForms::FinresultLine.new(params[:reporting_forms_finresult_line])

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

  def update
     @line = ReportingForms::FinresultLine.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:reporting_forms_finresult_line])
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line = ReportingForms::FinresultLine.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_balance_lines_url }
      format.json { head :no_content }
    end
  end
end

