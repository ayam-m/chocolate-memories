class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = Record.all
  end

  def new
    @record = Record.new(record_type: params[:record_type] || :eaten)
    @record.build_tasting if @record.eaten?
  end

  def create
    p "届いたパラメータ: #{params[:record][:record_type]}"
    @record = current_user.records.build(record_params)

    if @record.save
      redirect_to record_path(@record), notice: "#{@record.record_type}記録が保存されました。"
    else
      flash.now[:alert] = "記録が保存されませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @record = Record.find(params[:id])
  end

  private

  def record_params
    params.require(:record).permit(:record_type, :image, :event_date, :brand_name, :memo, :recipient_name, tasting_attributes: [ :id, :sweetness, :richness, :melting ])
  end
end
