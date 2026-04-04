class Tasting < ApplicationRecord
  belongs_to :record

  # showページの味覚評価をtextで表示
  SWEETNESS_OPTS = {
    1 => "甘い",
    2 => "やや甘い",
    3 => "普通",
    4 => "ややビター",
    5 => "ビター"
  }.freeze

  RICHNESS_OPTS = {
    1 => "濃厚",
    2 => "やや濃厚",
    3 => "普通",
    4 => "ややあっさり",
    5 => "あっさり"
  }.freeze

  MELTING_OPTS = {
    1 => "なめらか",
    2 => "ややなめらか",
    3 => "普通",
    4 => "やや固い",
    5 => "固い"
  }.freeze
end
