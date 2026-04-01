class Record < ApplicationRecord
  belongs_to :user
  belongs_to :brand, optional: true
  has_one_attached :image, dependent: :destroy
  has_one :tasting, dependent: :destroy
  enum :record_type, { eaten: 0, gifted: 1 }
  validates :record_type, presence: true
  validates :event_date, presence: true
  # 画像タイプ・サイズをバリデーション(active_storage_validations gem使用)
  ACCEPTED_CONTENT_TYPES = %w[image/png image/jpeg image/gif].freeze
  validates :image, content_type: ACCEPTED_CONTENT_TYPES,
                     size: { less_than_or_equal_to: 5.megabytes, message: "画像は5MB以下で登録してください" }
  # 新規作成時にevent_dateのデフォルト値を今日に設定
  after_initialize :set_default_event_date, if: :new_record?

  # ブランド名としてbrand_nameを仮想属性とし、保存前にブランドを検索または作成して関連付ける
  attr_accessor :brand_name
  before_validation :set_brand_by_name

  # tasting_attributes=メソッドが作成される
  accepts_nested_attributes_for :tasting, allow_destroy: true

  private

  def set_brand_by_name
    if brand_name.present?
      self.brand = Brand.find_or_create_by(name: brand_name)
    end
  end

  def set_default_event_date
    self.event_date ||= Date.current
  end
end
