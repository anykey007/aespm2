class ReportingForms::PlanLinesController < ApplicationController
  def index
    @lines = PlanLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def show
    @line = PlanLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  def new
    @line = PlanLine.new
    @lines =  PlanLine.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  def edit
    @line = PlanLine.find(params[:id])
    @lines =  PlanLine.without_line(params[:id])
  end

  def create
    @line = PlanLine.new(params[:plan_line])

    respond_to do |format|
      if @line.save
        format.html { redirect_to [:reporting_forms,@line], notice: 'Line was successfully created.' }
        format.json { render json: @line, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
     @line = PlanLine.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:plan_line])
        format.html { redirect_to [:reporting_forms,@line], notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line = PlanLine.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_plan_lines_url }
      format.json { head :no_content }
    end
  end
end
