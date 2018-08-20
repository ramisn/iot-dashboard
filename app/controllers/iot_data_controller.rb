class IotDataController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_iot_datum, only: [:show, :edit, :update, :destroy]

  # GET /iot_data
  # GET /iot_data.json
  def index
    @iot_data = IotDatum.all
    device_id = params[:device_id] if params[:device_id]
    count = params[:count] if params[:count]
    # # @bot_details = BotDetail.where("vcv_no = ? and vcv_date_time like ?", params[:vcv_no],"%#{vcv_date}%") if params[:vcv_no] && params[:vcv_date_time]
    # @iot_datas = IotDatum.where("device_id = ?", params[:vcv_no]) if params[:vcv_no]
    @iot_data = IotDatum.where("device_id = ? and count = ?", params[:device_id],params[:count]) if params[:device_id] && params[:count]

  end

  # GET /iot_data/1
  # GET /iot_data/1.json
  def show
  end

  # GET /iot_data/new
  def new
    @iot_datum = IotDatum.new
  end

  # GET /iot_data/1/edit
  def edit
  end

  # POST /iot_data
  # POST /iot_data.json
  def create
    @iot_datum = IotDatum.new(iot_datum_params)

    respond_to do |format|
      if @iot_datum.save
        format.html { redirect_to @iot_datum, notice: 'Iot datum was successfully created.' }
        format.json { render :show, status: :created, location: @iot_datum }
      else
        format.html { render :new }
        format.json { render json: @iot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /iot_data/1
  # PATCH/PUT /iot_data/1.json
  def update
    respond_to do |format|
      if @iot_datum.update(iot_datum_params)
        format.html { redirect_to @iot_datum, notice: 'Iot datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @iot_datum }
      else
        format.html { render :edit }
        format.json { render json: @iot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /iot_data/1
  # DELETE /iot_data/1.json
  def destroy
    @iot_datum.destroy
    respond_to do |format|
      format.html { redirect_to iot_data_url, notice: 'Iot datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iot_datum
      @iot_datum = IotDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def iot_datum_params
      params.require(:iot_datum).permit(:workbench_number, :part_number, :target, :lot_size, :employee_name, :employee_id, :shift, :device_id, :count)
    end
end
