class CityPermitsController < ApplicationController
  before_action :set_city_permit, only: [:show, :edit, :update, :destroy]

  # GET /city_permits
  # GET /city_permits.json
  def index
    @city_permits = CityPermit.all
  end

  # GET /city_permits/1
  # GET /city_permits/1.json
  def show
  end

  # GET /city_permits/new
  def new
    @city_permit = CityPermit.new
  end

  # GET /city_permits/1/edit
  def edit
  end

  # POST /city_permits
  # POST /city_permits.json
  def create
    @city_permit = CityPermit.new(city_permit_params)

    respond_to do |format|
      if @city_permit.save
        format.html { redirect_to @city_permit, notice: 'City permit was successfully created.' }
        format.json { render :show, status: :created, location: @city_permit }
      else
        format.html { render :new }
        format.json { render json: @city_permit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_permits/1
  # PATCH/PUT /city_permits/1.json
  def update
    respond_to do |format|
      if @city_permit.update(city_permit_params)
        format.html { redirect_to @city_permit, notice: 'City permit was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_permit }
      else
        format.html { render :edit }
        format.json { render json: @city_permit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_permits/1
  # DELETE /city_permits/1.json
  def destroy
    @city_permit.destroy
    respond_to do |format|
      format.html { redirect_to city_permits_url, notice: 'City permit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_permit
      @city_permit = CityPermit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_permit_params
      params.require(:city_permit).permit(:plan_number, :property_address, :review_status, :review_status_changed_date)
    end
end
