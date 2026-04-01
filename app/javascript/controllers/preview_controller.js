import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview" 画像ファイル選択時のプレビュー表示
export default class extends Controller {
  static targets = ["input", "image"]

  update() {
    const file = this.inputTarget.files[0]
    if (file) {
      // 選択したファイルのURLを一時的に生成しimgタグにセット
      this.imageTarget.src = URL.createObjectURL(file)
      this.imageTarget.classList.remove("hidden")
    }
  }
}
