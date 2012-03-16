class Reportings::PlansController < ApplicationController
  # GET /reportings/plans
  # GET /reportings/plans.json
  def index
    @company = current_user.companies.find(params[:company_id])
    @reportings_plans = @company.plans.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportings_plans }
    end
  end

  # GET /reportings/plans/1
  # GET /reportings/plans/1.json
  def show
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reportings_plan }
    end
  end

  # GET /reportings/plans/new
  # GET /reportings/plans/new.json
  def new
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.new
    @lines = @reportings_plan.lines
    @line_values = []
    @lines.each do |line|
      @line_values<<@reportings_plan.values.build(:line_id=>line.id)
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reportings_plan }
    end
  end

  # GET /reportings/plans/1/edit
  def edit
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.find(params[:id])
    @lines = @reportings_plan.lines
    existing_line_values = @reportings_plan.values
    existing_line_ids = existing_line_values.map {|rec| rec.line_id}
    @line_values = existing_line_values
    @lines.each do |line|
      if !existing_line_ids.include?(line.id)
         @line_values<<@reportings_plan.values.build(:line_id=>line.id)
      end
    end
  end

  # POST /reportings/plans
  # POST /reportings/plans.json
  def create
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.new(params[:reportings_plan])
    @reportings_plan.period = Date.civil(params[:reportings_plan][:period][:year].to_i, params[:reportings_plan][:period][:month].to_i, params[:reportings_plan][:period][:day].to_i)
    respond_to do |format|
      if @reportings_plan.valid? &&  @reportings_plan.save_and_update_parents
        format.html { redirect_to company_reportings_plan_path(params[:company_id],@reportings_plan), notice: 'Plan was successfully created.' }
        format.json { render json: @reportings_plan, status: :created, location: @reportings_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @reportings_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportings/plans/1
  # PUT /reportings/plans/1.json
  def update
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.find(params[:id])
    @reportings_plan.period = Date.civil(params[:reportings_plan][:period][:year].to_i, params[:reportings_plan][:period][:month].to_i, params[:reportings_plan][:period][:day].to_i)
    params[:reportings_plan][:period]=@reportings_plan.period
    respond_to do |format|
      if @reportings_plan.valid? && @reportings_plan.update_attributes_and_update_parents(params[:reportings_plan])
        format.html { redirect_to company_reportings_plan_path(params[:company_id],@reportings_plan), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reportings_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportings/plans/1
  # DELETE /reportings/plans/1.json
  def destroy
    @company = current_user.companies.find(params[:company_id])
    @reportings_plan = @company.plans.find(params[:id])
    @reportings_plan.destroy

    respond_to do |format|
      format.html { redirect_to company_reportings_plans_url }
      format.json { head :no_content }
    end
  end
end
