class ChartsController < ApplicationController
  before_action :set_chart, only: [:show, :edit, :update, :destroy]

  # GET /charts
  # GET /charts.json
  def index
    @charts = Chart.all
    @iot_data_for_1 = IotDatum.where("status = ? and count > ? and device_id = ?", 'Processing', 0, 1)
    @iot_data_for_2 = IotDatum.where("status = ? and count > ? and device_id = ?", 'Processing', 0, 2)
    
    @data_for_1 = []
    @data_for_2 = []
    @iot_data_for_1.each do |d|
      @data_for_1 << d.count
      @data_for_1 << d.target
      @data_for_1 << d.device_id
    end
    @iot_data_for_2.each do |f|
      @data_for_2 << f.count
      @data_for_2 << f.target
      @data_for_2 << f.device_id
    end

    @trackers_data_1 = Tracker.where("device_id = ?",1)
    @tracker_data_for_one = []
    @trackers_data_1.each do |one|
      @tracker_data_for_one << one.count
    end
    @trackers_data_2 = Tracker.where("device_id = ?",2)
    @tracker_data_for_two = []
    @trackers_data_1.each do |two|
      @tracker_data_for_two << two.count
    end

    @percentage = ((70.to_f/80.to_f) * 100)
    puts @percentage
    @target = @target.to_f
    @count_actual = @count_actual.to_f
    # @target_all = IotDatum.select('iot_data.*, sum(target)').group('iot_data.id')
    @target_all = IotDatum.all
    @target_all.each {|t| @target += t.target; @count_actual += t.count}
    puts @target
    puts @count_actual

    @percentage = ((@count_actual/@target) * 100)
    puts @percentage.to_f
    # @count_actual = ''
    # # @count_actual_all = IotDatum.select('iot_data.*, sum(count)').group('iot_data.id')
    # puts @target.inspect
    # puts @count_actual.inspect
    # @active_devices = WorkbenchMaster.where("machine_status = ?", 'A')
    # @inactive_devices = WorkbenchMaster.where("machine_status = ?", 'IA')
    # @completed_parts = IotDatum.where("status = ?", 'Process Completed')
    # @processing_parts = IotDatum.where("status = ?", 'Processing')

    # puts @active_devices

  end

  # GET /charts/1
  # GET /charts/1.json
  def show
  end

  # GET /charts/new
  def new
    @chart = Chart.new
  end

  # GET /charts/1/edit
  def edit
  end

  # POST /charts
  # POST /charts.json
  def create
    @chart = Chart.new(chart_params)

    respond_to do |format|
      if @chart.save
        format.html { redirect_to @chart, notice: 'Chart was successfully created.' }
        format.json { render :show, status: :created, location: @chart }
      else
        format.html { render :new }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charts/1
  # PATCH/PUT /charts/1.json
  def update
    respond_to do |format|
      if @chart.update(chart_params)
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @chart }
      else
        format.html { render :edit }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.json
  def destroy
    @chart.destroy
    respond_to do |format|
      format.html { redirect_to charts_url, notice: 'Chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chart_params
      params.require(:chart).permit(:name)
    end
end
