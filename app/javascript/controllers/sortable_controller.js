import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".handle",
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    // ドラッグが終わったら、並び替わった要素内のすべての「hidden_field」を上から順に取得
    const inputs = this.element.querySelectorAll(".position-input")
    
    // 上から順番に 1, 2, 3... と数値を上書きしていく
    inputs.forEach((input, index) => {
      input.value = index + 1
    })
    
    console.log("フォーム内の並び順番号を更新しました！")
  }
}