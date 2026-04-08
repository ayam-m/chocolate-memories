module ApplicationHelper
  # 本番はバリアント処理をCloudinaryに任せる(Renderメモリ不足エラー対処のため)
  def switch_image_path(image, width, height)
    # 画像nil時はデフォルト画像を返す
    return "no_image.png" unless image&.attached?
    # 本番：CloudinaryにimageのID, width, heightを伝えURLをもらう
    if Rails.env.production?
      Cloudinary::Utils.cloudinary_url(image.key, width: width, height: height, crop: "limit")
    # 開発：ActiveStorage(vips)にwidth, heightを伝え加工してもらう
    else
      image.variant(resize_to_limit: [ width, height ])
    end
  end
end
