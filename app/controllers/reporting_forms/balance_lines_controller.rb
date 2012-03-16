class ReportingForms::BalanceLinesController < ApplicationController
  before_filter :authenticate_admin
  def index
    @lines = BalanceLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def show
    @line = BalanceLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  def new
    @line = BalanceLine.new
    @lines =[]
    @lines =  BalanceLine.without_line(0)
    logger.debug @lines.inspect
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  def edit
    @line = BalanceLine.find(params[:id])
    @lines =  BalanceLine.without_line(params[:id])
  end

  def create
    @line = BalanceLine.new(params[:balance_line])

    respond_to do |format|
      if @line.save
        format.html { redirect_to [:reporting_forms,@line], notice: 'Line was successfully created.' }
        format.json { render json: @line, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
     @line = BalanceLine.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:balance_line])
        format.html { redirect_to [:reporting_forms,@line], notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line = BalanceLine.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_balance_lines_url }
      format.json { head :no_content }
    end
  end
end
