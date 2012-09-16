class ReportingForms::TanimotosController < ApplicationController
  # GET /reporting_forms/tanimotos
  # GET /reporting_forms/tanimotos.json
  def index
    @lines = ReportingForms::Tanimoto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  # GET /reporting_forms/tanimotos/1
  # GET /reporting_forms/tanimotos/1.json
  def show
    @line = ReportingForms::Tanimoto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/tanimotos/new
  # GET /reporting_forms/tanimotos/new.json
  def new
    @line = ReportingForms::Tanimoto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /reporting_forms/tanimotos/1/edit
  def edit
    @line = ReportingForms::Tanimoto.find(params[:id])
  end

  # POST /reporting_forms/tanimotos
  # POST /reporting_forms/tanimotos.json
  def create
    @reporting_forms_tanimoto = ReportingForms::Tanimoto.new(params[:reporting_forms_tanimoto])

    respond_to do |format|
      if @reporting_forms_tanimoto.save
        format.html { redirect_to @reporting_forms_tanimoto, notice: 'Tanimoto was successfully created.' }
        format.json { render json: @reporting_forms_tanimoto, status: :created, location: @reporting_forms_tanimoto }
      else
        format.html { render action: "new" }
        format.json { render json: @reporting_forms_tanimoto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reporting_forms/tanimotos/1
  # PUT /reporting_forms/tanimotos/1.json
  def update
    @reporting_forms_tanimoto = ReportingForms::Tanimoto.find(params[:id])

    respond_to do |format|
      if @reporting_forms_tanimoto.update_attributes(params[:reporting_forms_tanimoto])
        format.html { redirect_to @reporting_forms_tanimoto, notice: 'Tanimoto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reporting_forms_tanimoto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reporting_forms/tanimotos/1
  # DELETE /reporting_forms/tanimotos/1.json
  def destroy
    @reporting_forms_tanimoto = ReportingForms::Tanimoto.find(params[:id])
    @reporting_forms_tanimoto.destroy

    respond_to do |format|
      format.html { redirect_to reporting_forms_tanimotos_url }
      format.json { head :no_content }
    end
  end
end
