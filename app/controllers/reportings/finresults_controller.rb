class Reportings::FinresultsController < ApplicationController
    # GET /reportings/labors
    # GET /reportings/labors.json
    def index
      @company = current_user.companies.find(params[:company_id])
      @reportings = @company.finresults.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @reportings }
      end
    end

    # GET /reportings/labors/1
    # GET /reportings/labors/1.json
    def show
      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @report }
      end
    end

    # GET /reportings/labors/new
    # GET /reportings/labors/new.json
    def new

      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.new
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

    # GET /reportings/labors/1/edit
    def edit
      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.find(params[:id])
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

    # POST /reportings/labors
    # POST /reportings/labors.json
    def create

      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.new(params[:reportings_finresult])
      @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
      respond_to do |format|
        if @report.valid? && @report.save_and_update_parents
          format.html { redirect_to company_reportings_finresult_path(params[:company_id],@report), notice: 'Balance was successfully created.' }
          format.json { render json: @report, status: :created, location: @report }
        else
          format.html { render action: "new" }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /reportings/labors/1
    # PUT /reportings/labors/1.json
    def update
      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.find(params[:id])
      @report.period = Date.civil(params[:period][:year].to_i, params[:period][:month].to_i, params[:period][:day].to_i)
      params[:reportings_finresult][:period]=@report.period
      respond_to do |format|
        if @report.valid? && @report.update_attributes_and_update_parents(params[:reportings_finresult])
          format.html { redirect_to company_reportings_finresult_path(params[:company_id],@report), notice: 'Labor was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /reportings/labors/1
    # DELETE /reportings/labors/1.json
    def destroy
      @company = current_user.companies.find(params[:company_id])
      @report = @company.finresults.find(params[:id])
      @report.destroy

      respond_to do |format|
        format.html { redirect_to company_reportings_finresults_url }
        format.json { head :no_content }
      end
    end
  end

