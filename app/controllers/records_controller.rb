class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: %i[show edit update]

  def index
    @record_type = params[:record_type] || "eaten"
    @records = current_user.records.where(record_type: @record_type).order(event_date: :desc)
  end

  def new
    @record = current_user.records.build(record_type: params[:record_type] || "eaten")
    @record.build_tasting if @record.eaten?
  end

  def create
    @record = current_user.records.build(record_params)

    if @record.save
      redirect_to record_path(@record), notice: "#{@record.record_type_i18n}記録が保存されました。"
    else
      flash.now[:alert] = "#{@record.record_type_i18n}記録が保存されませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    # tastingが未入力だった際も、編集時に空のインスタンスを生成してフォームに表示
    @record.build_tasting if @record.eaten? && @record.tasting.nil?
  end

  def update
    if @record.update(record_params)
      redirect_to record_path(@record), notice: "#{@record.record_type_i18n}記録が更新されました。"
    else
      flash.now[:alert] = "#{@record.record_type_i18n}記録が更新されませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:record_type, :image, :event_date, :brand_name, :memo, :recipient_name, tasting_attributes: [ :id, :sweetness, :richness, :melting ])
  end
end
